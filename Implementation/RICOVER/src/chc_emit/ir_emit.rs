use std::collections::HashSet;
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
    // PC always advances by 4
    writeln!(out, "             (= pc1 (bvadd pc0 (_ bv4 64))))")?;

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
