// =========================================================================
// Isla IR → CHC transpiler: variant discovery
// =========================================================================
//
// The execute function in Isla IR is a dispatch over instruction variants.
// Structure:
//   [0]  decl $0 (return variable)
//   [i]  jump (merge#var is VARIANT?) goto skip_target   ← variant check
//   [i+1] optional: jump (sub-opcode check) goto skip    ← sub-variant check
//   [i+2..j] variant body: extract fields, compute, wX(rd, result)
//   [j]  goto exit_label
//   ... next variant ...
//   [exit_label] return = $0
//   [end]
//
// For each variant path we:
//   1. Identify the variant name from the jump condition
//   2. Extract tuple fields (imm, rs, rd) from union unwrap operations
//   3. Walk the path collecting bindings (translate_path)
//   4. Emit a CHC rule with the path's semantics

use std::collections::{HashMap, HashSet};

use isla_lib::bitvector::b129::B129;
use isla_lib::ir::{Def, Exp, Instr, Loc, Name, Op, Ty};

use crate::isla_ir::IslaIRModel;

/// A discovered instruction variant in the execute function.
///
/// Represents a linear path through the IR for one instruction kind
/// (e.g. ADDI, LOAD), with its start/end indices in the body array.
pub(crate) struct InstrVariant {
    /// Human-readable name derived from the IR.
    /// For variants with a sub-opcode check (e.g. ITYPE + RISCV_ADDI), this is
    /// the sub-opcode name with the "RISCV_" prefix stripped (→ "ADDI").
    /// For variants without a sub-check (e.g. LOAD), this is the variant name.
    pub(crate) name: String,
    /// Instruction ranges (half-open [start, end) into the execute body) that
    /// together make up this variant's semantics. A variant with no inner
    /// enum dispatch has a single segment. A sub-dispatched variant (e.g. ADDI
    /// extracted from ITYPE's `@neq(zADDI, iop)` arm) has three segments:
    /// shared prologue, arm-specific body, shared post-amble.
    pub(crate) segments: Vec<(usize, usize)>,
    /// Pre-bound tuple-field values for specialization (e.g. LOAD per width/sign).
    /// Keys are the IR Names of the extracted fields; values are SMT literal strings.
    /// Pre-bound fields are skipped from the CHC parameter list.
    pub(crate) initial_bindings: HashMap<Name, String>,
}

/// Discover instruction variant paths in the execute function body.
///
/// Scans for outer `jump (merge#var is VARIANT) goto skip` instructions. Each
/// match gives a region `[i+1 .. skip)` covering the whole variant. Inside
/// that region we look for inner `jump @neq(RISCV_OPCODE, iop) goto T`
/// sub-opcode guards used to partition enum-dispatched variants like ITYPE:
///
/// ```text
///     jump merge#var is ITYPE goto 383         ; outer
///     <prologue: extract imm, rs1, rd, iop>
///     jump @neq(RISCV_ADDI, iop) goto 309      ; arm 1 guard
///       <ADDI body>
///       goto 378                               ; to post-amble
///     jump @neq(RISCV_SLTI, iop) goto 328      ; arm 2 guard
///       ...
///     378: <shared post-amble: wX_bits(rd, result)>
/// ```
///
/// For each sub-guard `@neq(OP, iop) goto T`, the OP-specific body is
/// `[jump_idx+1 .. T)` (fall-through when iop == OP), bracketed by the shared
/// prologue `[i+1 .. first_guard_idx)` and a shared post-amble that starts at
/// the common `goto` target the arms converge on. We emit one synthetic
/// variant per sub-guard with three segments (prologue, arm, post-amble).
///
/// Variants without sub-guards (LOAD, ADDIW, etc.) get a single segment
/// `[i+1 .. skip)`.
pub(crate) fn discover_variants(model: &IslaIRModel, body: &[Instr<Name, B129>]) -> Vec<InstrVariant> {
    let mut variants = Vec::new();
    let mut i = 0;

    while i < body.len() {
        if let Instr::Jump(Exp::Kind(ctor, _), skip_target, _) = &body[i] {
            let outer_name = model.resolve_name(*ctor);
            let outer_skip = *skip_target;
            let variant_start = i + 1;

            // Safety: malformed IR could have skip_target pointing backwards.
            if outer_skip <= variant_start || outer_skip > body.len() {
                i += 1;
                continue;
            }

            // Collect all @neq sub-opcode guards inside the variant region.
            // Each entry: (short_opcode_name, jump_index, goto_target).
            let mut sub_guards: Vec<(String, usize, usize)> = Vec::new();
            for (offset, instr) in body[variant_start..outer_skip].iter().enumerate() {
                if let Instr::Jump(Exp::Call(Op::Neq, args), target, _) = instr {
                    if let Some(Exp::Id(opcode_id)) = args.first() {
                        let full = model.resolve_name(*opcode_id);
                        let short = full.strip_prefix("RISCV_").unwrap_or(&full).to_string();
                        sub_guards.push((short, variant_start + offset, *target));
                    }
                }
            }

            if sub_guards.is_empty() {
                if let Some(specialized) = try_specialize_result_variant(
                    model, body, variant_start, outer_skip, &outer_name,
                ) {
                    variants.extend(specialized);
                } else {
                    variants.push(InstrVariant {
                        name: outer_name,
                        segments: vec![(variant_start, outer_skip)],
                        initial_bindings: HashMap::new(),
                    });
                }
            } else {
                let prologue = (variant_start, sub_guards[0].1);

                // Find the shared post-amble start. Each arm body typically ends
                // with `goto POST` where POST is the common writeback label.
                // Collect all goto targets from inside arm bodies and pick the
                // smallest one that sits after every arm's end and before the
                // outer variant end.
                let max_arm_end = sub_guards.iter().map(|(_, _, t)| *t).max().unwrap();
                let mut candidates: HashSet<usize> = HashSet::new();
                for (_, jump_idx, target) in &sub_guards {
                    for instr in &body[*jump_idx + 1..*target] {
                        if let Instr::Goto(t) = instr {
                            candidates.insert(*t);
                        }
                    }
                }
                let postamble_start = candidates
                    .into_iter()
                    .filter(|k| *k >= max_arm_end && *k < outer_skip)
                    .min()
                    .unwrap_or(outer_skip);
                let postamble = (postamble_start, outer_skip);

                let mut sub_variants = Vec::new();
                for (op_name, jump_idx, target) in &sub_guards {
                    sub_variants.push(InstrVariant {
                        name: op_name.clone(),
                        segments: vec![prologue, (*jump_idx + 1, *target), postamble],
                        initial_bindings: HashMap::new(),
                    });
                }

                // Fall-through arm: Sail's match-to-IR lowering emits the last
                // enum case without a @neq guard — every preceding guard jumps
                // over its own body, so the trailing arm is reached by simple
                // fall-through. Recover its name by taking the enum's declared
                // constructor list (in source order) and subtracting the cases
                // we've already seen as guards.
                let last_target = sub_guards.last().unwrap().2;
                if last_target < postamble_start {
                    if let Some(name) = recover_fallthrough_arm(model, body, &sub_guards) {
                        sub_variants.push(InstrVariant {
                            name,
                            segments: vec![prologue, (last_target, postamble_start), postamble],
                            initial_bindings: HashMap::new(),
                        });
                    }
                }

                // AMO width specialization: the AMO outer variant has a 7-field
                // tuple (zamoop, aq, rl, rs2, rs1, width, rd). Create per-width
                // copies for the 5 simple AMO operations.
                if outer_name == "AMO" {
                    sub_variants = specialize_amo_width(
                        body, variant_start, outer_skip, sub_variants,
                    );
                }

                variants.extend(sub_variants);
            }

            i = outer_skip;
        } else {
            i += 1;
        }
    }

    variants
}

/// Recover the name of the unguarded fall-through arm for a sub-dispatched
/// outer variant. Sail's match-to-IR lowering always lays out the trailing
/// case as fall-through (no `@neq` guard), so the missing constructor is the
/// one in the iop enum's source-order ctor list that doesn't appear in
/// `sub_guards`.
///
/// Returns None if the iop variable's enum can't be resolved or if the
/// guard set already covers every constructor.
fn recover_fallthrough_arm(
    model: &IslaIRModel,
    body: &[Instr<Name, B129>],
    sub_guards: &[(String, usize, usize)],
) -> Option<String> {
    // The dispatch variable is args[1] of any of the @neq guards
    // (`@neq(OP_CTOR, iop)`). Re-read it from the first guard's instruction.
    let (_, first_jump_idx, _) = sub_guards.first()?;
    let iop_id = match &body[*first_jump_idx] {
        Instr::Jump(Exp::Call(Op::Neq, args), _, _) => match args.get(1)? {
            Exp::Id(id) => *id,
            _ => return None,
        },
        _ => return None,
    };

    // Find the enum type via the variable's Decl.
    let enum_name = body.iter().find_map(|instr| match instr {
        Instr::Decl(id, Ty::Enum(name), _) if *id == iop_id => Some(*name),
        _ => None,
    })?;

    // Look up the enum definition in source order.
    let ctors: Vec<String> = model.defs.iter().find_map(|def| match def {
        Def::Enum(name, ctors) if *name == enum_name => Some(
            ctors.iter().map(|c| model.resolve_name(*c)).collect()
        ),
        _ => None,
    })?;

    // Subtract the constructors that already have explicit @neq guards.
    let seen: HashSet<&str> = sub_guards.iter().map(|(n, _, _)| n.as_str()).collect();
    let mut missing = ctors
        .into_iter()
        .filter(|c| !seen.contains(c.as_str()));
    let first_missing = missing.next()?;
    // If more than one ctor is unaccounted for, the dispatch isn't a simple
    // fall-through chain — bail out rather than guess.
    if missing.next().is_some() {
        return None;
    }
    Some(first_missing)
}

/// If this variant is a LOAD or STORE, expand it into per-width (and per-sign
/// for LOAD) specialized variants. Returns None for other variants.
///
/// LOAD/STORE share one IR body across all byte widths because the Sail
/// definition is polymorphic in `width: i64`. Our stdlib exposes distinct
/// mem_read_N / write_mem_N functions (one per width), so we cannot emit a
/// single rule with a symbolic width. Instead we pre-bind the tuple-field
/// variables for width (and is_unsigned, for LOAD) to concrete SMT literals
/// and generate one rule per combination. LOAD also has a result-union
/// dispatch (`is Ok goto <err_arm>`); the success arm is fall-through, so we
/// split the body into pre-dispatch and Ok-arm segments and drop the Err arm.
fn try_specialize_result_variant(
    model: &IslaIRModel,
    body: &[Instr<Name, B129>],
    variant_start: usize,
    outer_skip: usize,
    outer_name: &str,
) -> Option<Vec<InstrVariant>> {
    if outer_name != "LOAD" && outer_name != "STORE" {
        return None;
    }

    // Collect tuple field extractions in source order. The Sail frontend emits
    // them as a sequential block of `zzN = mergez3var as <VAR>.tuple...K` copies,
    // so the K-th field in the tuple is the K-th such copy in this region.
    // We can't reliably parse K from the field name: for a field of type `i64`
    // the encoded suffix is `...i64<K>`, which would let a trailing-digits parser
    // consume `64K` as one number.
    let mut field_ids: Vec<Name> = Vec::new();
    for instr in &body[variant_start..outer_skip] {
        if let Instr::Copy(Loc::Id(id), Exp::Field(inner, _), _) = instr {
            if matches!(inner.as_ref(), Exp::Unwrap(_, _)) {
                field_ids.push(*id);
            }
        }
    }

    // Find the inner `jump X is Ok... goto <err_arm>` dispatch.
    // Fall-through is the success arm; the Err arm starts at the jump's target.
    let mut ok_jump: Option<(usize, usize)> = None;
    for (offset, instr) in body[variant_start..outer_skip].iter().enumerate() {
        if let Instr::Jump(Exp::Kind(ctor, _), target, _) = instr {
            if model.resolve_name(*ctor).starts_with("Ok") {
                ok_jump = Some((variant_start + offset, *target));
                break;
            }
        }
    }
    let segments: Vec<(usize, usize)> = match ok_jump {
        Some((jump_idx, err_arm_start)) => vec![
            (variant_start, jump_idx),
            (jump_idx + 1, err_arm_start),
        ],
        None => vec![(variant_start, outer_skip)],
    };

    let mut variants = Vec::new();
    let widths = [1u32, 2, 4, 8];

    if outer_name == "LOAD" {
        // Tuple layout (imm:bv12, rs1:bv5, rd:bv5, is_unsigned:bool, width:i64)
        if field_ids.len() < 5 { return None; }
        let is_unsigned_id = field_ids[3];
        let width_id = field_ids[4];
        for &w in &widths {
            for (sign_suffix, is_u) in [("s", "false"), ("u", "true")] {
                let mut initial = HashMap::new();
                initial.insert(width_id, w.to_string());
                initial.insert(is_unsigned_id, is_u.to_string());
                variants.push(InstrVariant {
                    name: format!("load_{}_{}", w, sign_suffix),
                    segments: segments.clone(),
                    initial_bindings: initial,
                });
            }
        }
    } else {
        // STORE tuple layout (imm:bv12, rs2:bv5, rs1:bv5, width:i64)
        // Note the order: the Sail definition is `STORE(imm, rs2, rs1, width)`,
        // so field 1 is the source register and field 2 is the base register.
        if field_ids.len() < 4 { return None; }
        let width_id = field_ids[3];
        for &w in &widths {
            let mut initial = HashMap::new();
            initial.insert(width_id, w.to_string());
            variants.push(InstrVariant {
                name: format!("store_{}", w),
                segments: segments.clone(),
                initial_bindings: initial,
            });
        }
    }

    Some(variants)
}

/// Width-specialize AMO sub-variants.
///
/// AMO tuple layout: (zamoop:enum, aq:bool, rl:bool, rs2:bv5, rs1:bv5, width:i64, rd:bv5).
/// For each of the 5 simple AMO operations (AMOSWAP, AMOADD, AMOXOR, AMOAND,
/// AMOOR), produce two variants: one for width=4 (32-bit) and one for width=8
/// (64-bit), with aq/rl pre-bound to false (ordering ignored).
///
/// The 4 conditional AMOs (AMOMIN, AMOMAX, AMOMINU, AMOMAXU) are passed
/// through unmodified — they'll fail during translation (deferred).
fn specialize_amo_width(
    body: &[Instr<Name, B129>],
    variant_start: usize,
    outer_skip: usize,
    sub_variants: Vec<InstrVariant>,
) -> Vec<InstrVariant> {
    // Collect tuple field IDs from the prologue
    let mut field_ids: Vec<Name> = Vec::new();
    for instr in &body[variant_start..outer_skip] {
        if let Instr::Copy(Loc::Id(id), Exp::Field(inner, _), _) = instr {
            if matches!(inner.as_ref(), Exp::Unwrap(_, _)) {
                field_ids.push(*id);
            }
        }
    }

    // AMO needs at least 7 tuple fields
    if field_ids.len() < 7 {
        return sub_variants;
    }
    let aq_id = field_ids[1];
    let rl_id = field_ids[2];
    let width_id = field_ids[5];

    let simple_amos: HashSet<&str> =
        ["AMOSWAP", "AMOADD", "AMOXOR", "AMOAND", "AMOOR"].into_iter().collect();

    let mut result = Vec::new();
    for variant in sub_variants {
        if simple_amos.contains(variant.name.as_str()) {
            for &w in &[4u32, 8] {
                let mut initial = variant.initial_bindings.clone();
                initial.insert(width_id, w.to_string());
                initial.insert(aq_id, "false".to_string());
                initial.insert(rl_id, "false".to_string());
                result.push(InstrVariant {
                    name: format!("{}_{}", variant.name.to_lowercase(), w),
                    segments: variant.segments.clone(),
                    initial_bindings: initial,
                });
            }
        }
        // AMOMIN/MAX/MINU/MAXU: skip (conditional logic, deferred)
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::isla_ir;

    const RISCV_IR: &str = include_str!("../../snapshot/rv64d.ir");

    #[test]
    fn discover_variants_finds_known_instructions() {
        let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse IR");
        let func = model.get_function("execute").expect("no execute function");
        let variants = discover_variants(&model, func.body);

        let names: Vec<&str> = variants.iter().map(|v| v.name.as_str()).collect();

        // Sub-dispatched ITYPE variants
        assert!(names.contains(&"ADDI"), "ADDI not found in variants");
        assert!(names.contains(&"SLTI"), "SLTI not found in variants");
        assert!(names.contains(&"ANDI"), "ANDI not found in variants");

        // Standalone variant
        assert!(names.contains(&"ADDIW"), "ADDIW not found in variants");

        // LOAD/STORE specialized variants
        assert!(names.contains(&"load_4_s"), "load_4_s not found");
        assert!(names.contains(&"load_8_s"), "load_8_s not found");
        assert!(names.contains(&"store_4"), "store_4 not found");
        assert!(names.contains(&"store_8"), "store_8 not found");

        // AMO width-specialized variants (5 simple ops × 2 widths)
        assert!(names.contains(&"amoswap_4"), "amoswap_4 not found");
        assert!(names.contains(&"amoswap_8"), "amoswap_8 not found");
        assert!(names.contains(&"amoadd_4"), "amoadd_4 not found");
        assert!(names.contains(&"amoadd_8"), "amoadd_8 not found");
        assert!(names.contains(&"amoxor_4"), "amoxor_4 not found");
        assert!(names.contains(&"amoand_4"), "amoand_4 not found");
        assert!(names.contains(&"amoor_4"), "amoor_4 not found");
        // AMOMIN/MAX/MINU/MAXU are NOT width-specialized (deferred)
        assert!(!names.contains(&"amomin_4"), "amomin should not be specialized");
        assert!(!names.contains(&"amomax_4"), "amomax should not be specialized");

        // Should have a reasonable number of variants (not zero, not thousands)
        assert!(variants.len() > 20, "too few variants: {}", variants.len());
        assert!(variants.len() < 1000, "unexpectedly many variants: {}", variants.len());
    }
}
