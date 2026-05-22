use std::collections::{HashMap, HashSet};
use std::fmt::Write;

use anyhow::{anyhow, Result};

use crate::isla_ir::IslaIRModel;
use super::smt::ty_to_smt;
use super::variant_discovery::{InstrVariant, discover_variants};
use super::ir_translate::{PathTranslation, translate_variant, collect_globals, collect_type_widths};
use super::format::format_instr;
use super::{STDLIB, STATE_TYPES};

/// Emit a CHC rule for a single instruction variant.
///
/// Produces output like:
///   (declare-rel addi (Regs Mem PC  Regs' Mem' PC'  imm rs1 rd))
///   (rule (forall ((regs0 ...) (mem0 ...) (pc0 ...) ...)
///     (=> (and (= regs1 (set_reg regs0 rd (bvadd (get_reg regs0 rs1) ...)))
///              (= mem1 mem0)
///              (= pc1 (bvadd pc0 (_ bv4 64))))
///         (addi regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))
fn emit_variant_chc(
    _model: &IslaIRModel,
    variant: &InstrVariant,
    translation: &PathTranslation,
    out: &mut String,
) -> Result<()> {
    let name = variant.name.to_lowercase();

    // Build parameter type list for declare-rel
    // State signature: (Regs_in Mem_in PC_in  Regs_out Mem_out PC_out)
    // Plus instruction-specific parameters (imm, rs1, rd, etc.)
    let seg_desc = variant
        .segments
        .iter()
        .map(|(s, e)| format!("[{}..{})", s, e))
        .collect::<Vec<_>>()
        .join("+");
    write!(out, ";; --- {} instruction (from Isla IR {}) ---\n", variant.name, seg_desc)?;
    write!(out, "(declare-rel {}\n", name)?;
    write!(out, "  ({STATE_TYPES}\n")?;
    write!(out, "   {STATE_TYPES}")?;

    // Add parameter types
    for (_param_id, param_ty) in &translation.params {
        let smt_ty = ty_to_smt(param_ty)?;
        write!(out, "\n   {}", smt_ty)?;
    }
    writeln!(out, "))")?;
    writeln!(out)?;

    // Build the rule
    writeln!(out, "(rule")?;
    write!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    write!(out, "\n           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    write!(out, "\n           (pc0 (_ BitVec 64))")?;
    write!(out, "\n           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    write!(out, "\n           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    write!(out, "\n           (pc1 (_ BitVec 64))")?;

    // Parameter bindings in the forall
    for (i, (_param_id, param_ty)) in translation.params.iter().enumerate() {
        let smt_ty = ty_to_smt(param_ty)?;
        write!(out, "\n           (p{} {})", i, smt_ty)?;
    }
    writeln!(out, ")")?;

    // Build constraint body
    // The register write determines the regs1 constraint
    if let Some((rd_smt, val_smt)) = &translation.reg_write {
        writeln!(out, "    (=> (and (= regs1 (set_reg regs0 {} {}))", rd_smt, val_smt)?;
    } else {
        // No register write — registers unchanged
        writeln!(out, "    (=> (and (= regs1 regs0)")?;
    }

    // Memory constraint: mem_expr is the final memory state after all operations.
    // If no writes occurred, mem_expr == "mem0" and this emits (= mem1 mem0).
    // If writes occurred, mem_expr is a nested write expression like
    //   (write_mem_dword mem0 addr val)
    writeln!(out, "             (= mem1 {})", translation.mem_expr)?;
    writeln!(out, "             (= pc1 {}))", translation.pc_expr)?;

    // Head of the rule
    write!(out, "        ({} regs0 mem0 pc0 regs1 mem1 pc1", name)?;
    for i in 0..translation.params.len() {
        write!(out, " p{}", i)?;
    }
    writeln!(out, "))))")?;
    writeln!(out)?;

    Ok(())
}

/// Emit CHC rules for all instruction variants found in the execute function.
///
/// This is the main entry point for the Isla IR -> CHC transpiler.
/// It discovers all instruction variant paths in the execute function,
/// translates each path's IR to SMT, and emits a CHC rule per variant.
///
/// Returns the set of lowercased variant names that were emitted (e.g. {"addi", "load"}).
/// This is used by emit_equivalence_query to decide which opcodes need hand-written fallbacks.
pub(crate) fn emit_execute_chc(model: &IslaIRModel, out: &mut String) -> Result<HashSet<String>> {
    let func = model
        .get_function("execute")
        .ok_or_else(|| anyhow!("'execute' function not found"))?;

    let body = func.body;

    // Discover all variant paths
    let variants = discover_variants(model, body);
    writeln!(out, ";; Found {} instruction variant(s) in execute function", variants.len())?;
    writeln!(out)?;

    // Pre-collect bitvector widths from the full body (Decls live at the top,
    // before variant dispatch, so they aren't inside any variant's path slice).
    let mut type_widths = collect_type_widths(body);
    let globals = collect_globals(model);

    let mut ir_names = HashSet::new();
    let mut skipped: Vec<(String, String)> = Vec::new();

    for variant in &variants {
        let mut initial = globals.clone();
        initial.extend(variant.initial_bindings.iter().map(|(k, v)| (*k, v.clone())));
        // Translate the IR segments to SMT bindings. If translation or emission fails
        // (unsupported type, unsupported op, etc.), skip this variant and keep going —
        // a hand-written fallback will cover it. The transpiler is best-effort:
        // variants we can't handle yet don't block the ones we can.
        let result = translate_variant(model, &variant.segments, body, &mut type_widths, &initial)
            .and_then(|t| {
                // Emit into a staging buffer so a later-stage failure doesn't leave
                // a half-written rule in `out`.
                let mut staging = String::new();
                emit_variant_chc(model, variant, &t, &mut staging)?;
                out.push_str(&staging);
                Ok(())
            });

        match result {
            Ok(()) => { ir_names.insert(variant.name.to_lowercase()); }
            Err(e) => {
                let reason = format!("{e}").lines().next().unwrap_or("").to_string();
                writeln!(out, ";; SKIPPED variant {} — {}", variant.name, reason)?;
                writeln!(out)?;
                skipped.push((variant.name.clone(), reason));
            }
        }
    }

    if !skipped.is_empty() {
        eprintln!(
            "warning: IR transpiler skipped {} of {} variant(s); they will need hand-written fallbacks:",
            skipped.len(),
            variants.len()
        );
        for (name, reason) in &skipped {
            eprintln!("  - {name}: {reason}");
        }
    }

    // Emit the IR dump as comments for debugging — only for small bodies.
    // The full rv64d.ir has hundreds of thousands of instructions; dumping them
    // bloats the output without adding value.
    if body.len() < 1000 {
        writeln!(out, ";; --- IR dump for reference ---")?;
        for (i, instr) in body.iter().enumerate() {
            writeln!(out, ";; [{}] {}", i, format_instr(model, instr))?;
        }
    }

    Ok(ir_names)
}

/// Instruction semantics stored as template strings for direct inlining
/// into program rules, eliminating per-instruction CHC relations.
///
/// Instead of emitting `(declare-rel addi ...)` + `(rule ...)` and calling
/// `(addi regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2)` in the program rule,
/// we substitute concrete operand values into these templates and emit three
/// equality constraints directly: `(= regs1 ...) (= mem1 ...) (= pc1 ...)`.
pub(crate) struct InlinedSemantics {
    /// Expression for regs_out. Contains `regs0` for input state, `p0`..`pN` for params.
    /// E.g. `"(set_reg regs0 p2 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0)))"`.
    /// `"regs0"` when the instruction doesn't write a register.
    pub regs_expr: String,
    /// Expression for mem_out. Contains `mem0`, `regs0`, and `p0`..`pN`.
    pub mem_expr: String,
    /// Expression for pc_out. Contains `pc0` and possibly `regs0`, `p0`..`pN`.
    pub pc_expr: String,
    /// Number of parameters that need substitution (p0..p{n-1}).
    pub n_params: usize,
}

impl InlinedSemantics {
    fn from_translation(t: &PathTranslation) -> Self {
        let regs_expr = match &t.reg_write {
            Some((rd, val)) => format!("(set_reg regs0 {} {})", rd, val),
            None => "regs0".to_string(),
        };
        InlinedSemantics {
            regs_expr,
            mem_expr: t.mem_expr.clone(),
            pc_expr: t.pc_expr.clone(),
            n_params: t.params.len(),
        }
    }

    /// Substitute concrete operand values and state indices into the templates.
    ///
    /// Returns three SMT equality constraints:
    ///   `(= regs{so} <expr>)`, `(= mem{so} <expr>)`, `(= pc{so} <expr>)`
    pub fn instantiate(&self, operands: &[String], si: usize, so: usize) -> [String; 3] {
        let regs_in = format!("regs{}", si);
        let mem_in = format!("mem{}", si);
        let pc_in = format!("pc{}", si);

        let mut exprs = [
            self.regs_expr.clone(),
            self.mem_expr.clone(),
            self.pc_expr.clone(),
        ];

        for expr in &mut exprs {
            *expr = expr.replace("regs0", &regs_in)
                        .replace("mem0", &mem_in)
                        .replace("pc0", &pc_in);
        }

        // Replace parameters in reverse order to avoid p1 matching inside p10
        for i in (0..self.n_params).rev() {
            let from = format!("p{}", i);
            let to = &operands[i];
            for expr in &mut exprs {
                *expr = expr.replace(&from, to);
            }
        }

        [
            format!("(= regs{} {})", so, exprs[0]),
            format!("(= mem{} {})", so, exprs[1]),
            format!("(= pc{} {})", so, exprs[2]),
        ]
    }
}

/// Collect inlined instruction semantics from the IR model's execute function.
///
/// Returns a map from lowercased variant name to its inlined semantics.
/// Used by `emit_equivalence_query` to inline instruction constraints directly
/// into program rules, avoiding per-instruction CHC relations entirely.
pub(crate) fn collect_instruction_semantics(
    model: &IslaIRModel,
) -> Result<HashMap<String, InlinedSemantics>> {
    let func = model
        .get_function("execute")
        .ok_or_else(|| anyhow!("'execute' function not found"))?;

    let body = func.body;
    let variants = discover_variants(model, body);
    let mut type_widths = collect_type_widths(body);
    let globals = collect_globals(model);

    let mut semantics = HashMap::new();
    let mut skipped: Vec<(String, String)> = Vec::new();

    for variant in &variants {
        let mut initial = globals.clone();
        initial.extend(variant.initial_bindings.iter().map(|(k, v)| (*k, v.clone())));

        match translate_variant(model, &variant.segments, body, &mut type_widths, &initial) {
            Ok(t) => {
                let sem = InlinedSemantics::from_translation(&t);
                semantics.insert(variant.name.to_lowercase(), sem);
            }
            Err(e) => {
                let reason = format!("{e}").lines().next().unwrap_or("").to_string();
                skipped.push((variant.name.clone(), reason));
            }
        }
    }

    if !skipped.is_empty() {
        eprintln!(
            "warning: IR transpiler skipped {} of {} variant(s):",
            skipped.len(),
            variants.len()
        );
        for (name, reason) in &skipped {
            eprintln!("  - {name}: {reason}");
        }
    }

    Ok(semantics)
}

/// Translate IR functions into CHC definitions in SMT-LIB2 HORN format.
pub fn emit_instruction_chc(model: &IslaIRModel, functions: &[String]) -> Result<String> {
    let mut out = String::new();
    writeln!(out, "{}", STDLIB)?;
    writeln!(out)?;

    for func_name in functions {
        if func_name == "execute" {
            let _ir_names = emit_execute_chc(model, &mut out)?;
        } else {
            let func = model
                .get_function(func_name)
                .ok_or_else(|| anyhow!("function '{}' not found in IR", func_name))?;

            writeln!(out, ";; === {} ===", func_name)?;
            for (i, instr) in func.body.iter().enumerate() {
                writeln!(out, ";; [{}] {}", i, format_instr(model, instr))?;
            }
            writeln!(out)?;
        }
    }

    Ok(out)
}
