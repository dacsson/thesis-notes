use std::collections::HashMap;

use anyhow::{anyhow, Result};

use isla_lib::bitvector::b129::B129;
use isla_lib::bitvector::BV;
use isla_lib::ir::{Def, Exp, Instr, Loc, Name, Op, Ty};

use crate::isla_ir::IslaIRModel;
use super::smt::exp_to_smt;
use super::known_calls::{KnownCall, classify_call, call_to_smt};
use super::format::format_exp;

/// Result of translating a variant's IR path to SMT expressions.
///
/// After walking the path, we know:
/// - What tuple fields were extracted (parameters to the CHC rule)
/// - Whether a register write occurred (wX) and to which register/value
/// - Whether a memory read occurred (read_mem) and of what width
/// - All intermediate computations as inlined SMT bindings
pub(crate) struct PathTranslation {
    /// Tuple field extractions: (variable_name, declared_type)
    /// These become the instruction's parameters (imm, rs1, rd, etc.)
    pub(crate) params: Vec<(Name, Ty<Name>)>,
    /// Register write: wX(rd_expr, val_expr) → (rd_smt, val_smt)
    pub(crate) reg_write: Option<(String, String)>,
    /// Final memory expression after all memory operations in the path.
    /// Starts as "mem0"; each write_mem wraps it functionally:
    ///   "(write_mem_dword mem0 addr val)" after one write,
    ///   "(write_mem_word (write_mem_dword mem0 a1 v1) a2 v2)" after two, etc.
    /// Reads use the current expression, so a write-then-read sees the updated memory.
    /// Emitted as (= mem1 <mem_expr>) in the CHC rule.
    pub(crate) mem_expr: String,
    /// All bindings accumulated during the walk (variable → SMT expression)
    pub(crate) bindings: HashMap<Name, String>,
}

/// Walk a linear path of IR instructions and produce a PathTranslation.
///
/// The path is a straight-line sequence from field extraction through computation
/// to the final wX (register write) or write_mem (memory store). We process each instruction:
///   - Decl: record the type and bitvector width (for EXTS/EXTZ source-width inference)
///   - Copy from Unwrap: extract tuple field → becomes a CHC parameter
///   - Copy (simple): inline the expression into bindings
///   - Call(rX): register read → (get_reg regs0 param)
///   - Call(EXTS): sign extension → ((_ sign_extend N) val), N = target - source width
///   - Call(EXTZ): zero extension → ((_ zero_extend N) val), same width logic
///   - Call(add_bits): addition → (bvadd a b)
///   - Call(read_mem): memory load → (read_mem_byte/half/word/dword mem0 addr)
///   - Call(write_mem): memory store → recorded for mem1 constraint
///   - Call(wX): register write → recorded as the path's output
/// Pre-collect bitvector widths from all Decl instructions in a function body.
///
/// Variable declarations live at the top of the function (before variant dispatch),
/// so they must be scanned from the full body, not just a variant's path slice.
/// Pre-evaluate top-level `let` bindings whose body reduces to a single
/// integer literal. Sail emits constants like `xlen`, `xlen_bytes`, and
/// `log2_xlen` as `Def::Let` blocks that wrap an `i64` literal in casts and
/// dead `eq_int` branches. Without this pass, references to such constants
/// inside `subrange_bits(... log2_xlen-1, 0)` reach `sub_atom` as opaque
/// `Exp::Id`s and the literal-fold path fails.
///
/// Returns a map from the let-bound name to its SMT literal string ("6"),
/// so it can be merged into `bindings` and resolved via `Exp::Id` lookup.
pub(crate) fn collect_globals(model: &IslaIRModel) -> HashMap<Name, String> {
    let mut globals: HashMap<Name, String> = HashMap::new();
    for def in &model.defs {
        let Def::Let(ids, body) = def else { continue };
        let mut scope: HashMap<Name, i128> = HashMap::new();
        for instr in body {
            match instr {
                Instr::Init(id, _, exp, _) | Instr::Copy(Loc::Id(id), exp, _) => {
                    if let Some(v) = fold_int_exp(exp, &scope) {
                        scope.insert(*id, v);
                    }
                }
                Instr::Call(Loc::Id(id), _, func_id, args, _) => {
                    // Cast helpers (%i64 ↔ %i) are passthroughs; everything else
                    // (eq_int, etc.) is irrelevant to the literal we want.
                    let kind = classify_call(model, *func_id);
                    if matches!(kind, KnownCall::IntToI64 | KnownCall::I64ToInt) {
                        if let Some(v) = args.first().and_then(|a| fold_int_exp(a, &scope)) {
                            scope.insert(*id, v);
                        }
                    }
                }
                _ => {}
            }
        }
        for (id, _) in ids {
            if let Some(v) = scope.get(id) {
                globals.insert(*id, v.to_string());
            }
        }
    }
    globals
}

fn fold_int_exp(exp: &Exp<Name>, scope: &HashMap<Name, i128>) -> Option<i128> {
    match exp {
        Exp::I64(n) => Some(*n as i128),
        Exp::I128(n) => Some(*n),
        Exp::Id(id) => scope.get(id).copied(),
        _ => None,
    }
}

pub(crate) fn collect_type_widths(body: &[Instr<Name, B129>]) -> HashMap<Name, u32> {
    let mut widths = HashMap::new();
    for instr in body {
        match instr {
            Instr::Decl(id, ty, _) => {
                if let Ty::Bits(n) = ty {
                    widths.insert(*id, *n);
                }
            }
            // Init with a bitvector literal reveals the width even without a Bits type
            Instr::Init(id, _, Exp::Bits(bv), _) => { widths.insert(*id, bv.len()); }
            _ => {}
        }
    }
    widths
}

pub(crate) fn translate_variant(
    model: &IslaIRModel,
    segments: &[(usize, usize)],
    body: &[Instr<Name, B129>],
    type_widths: &mut HashMap<Name, u32>,
    initial_bindings: &HashMap<Name, String>,
) -> Result<PathTranslation> {
    let mut bindings: HashMap<Name, String> = initial_bindings.clone();
    let mut params: Vec<(Name, Ty<Name>)> = Vec::new();
    let mut reg_write = None;

    // Current memory expression, threaded through all memory operations.
    // Starts as "mem0"; writes wrap it: "(write_mem_dword mem0 addr val)".
    // Reads reference it so a write-then-read sees the updated state.
    let mut current_mem = "mem0".to_string();

    // Walk each segment in order. Bindings, params, reg_write, and current_mem
    // accumulate across segments so a sub-dispatched variant's prologue,
    // arm body, and shared post-amble all contribute to the same translation.
    for &(start, end) in segments {
        for instr in &body[start..end] {
        match instr {
            Instr::Decl(_, _, _) => {
                // Declarations don't produce constraints — variables are introduced on use.
                // Type widths were already collected above.
            }

            Instr::Init(id, _ty, exp, _) => {
                // Propagate bitvector width through the assignment
                if let Some(w) = infer_bv_width(exp, type_widths) {
                    type_widths.insert(*id, w);
                }
                let smt = exp_to_smt(model, exp, &bindings)?;
                bindings.insert(*id, smt);
            }

            Instr::Copy(Loc::Id(id), exp, _) => {
                // Check if this is a tuple field extraction from a union unwrap.
                // IR pattern: $1 = merge#var as ITYPE.tuple#...0
                // Isla represents this as Exp::Field(Exp::Unwrap(...), field_name)
                // These become the instruction's forall-bound CHC parameters.
                if is_field_of_unwrap(exp) {
                    // Pre-bound via specialization (e.g. LOAD/STORE width & sign).
                    // Already in the bindings map; skip param creation.
                    if bindings.contains_key(id) {
                        // nothing to do — the pre-bound literal will be substituted
                        // on every Exp::Id reference via exp_to_smt's bindings lookup.
                    } else {
                    // Search the full body for the type, not just the path slice,
                    // because Decls live at the top of the function before dispatch.
                    let ty = find_decl_type(body, *id);
                    // Enum-typed fields (e.g. the `iop` tag on ITYPE) are inner
                    // dispatch keys consumed by the `@neq(OPCODE, iop)` guards
                    // at variant discovery. By the time we're translating a
                    // sub-variant, the enum value is already fixed by the arm
                    // selection, so it must not become a CHC parameter — and
                    // nothing else in the arm body references it.
                    if matches!(ty, Ty::Enum(_)) {
                        bindings.insert(*id, "(_ unit)".to_string());
                    } else {
                        // Register the parameter's bitvector width so downstream
                        // EXTS/EXTZ can infer the source width correctly.
                        if let Ty::Bits(n) = ty {
                            type_widths.insert(*id, *n);
                        }
                        params.push((*id, ty.clone()));
                        let param_name = format!("p{}", params.len() - 1);
                        bindings.insert(*id, param_name);
                    }
                    }
                } else {
                    // Propagate bitvector width through the copy
                    if let Some(w) = infer_bv_width(exp, type_widths) {
                        type_widths.insert(*id, w);
                    }
                    let smt = exp_to_smt(model, exp, &bindings)?;
                    bindings.insert(*id, smt);
                }
            }

            Instr::Copy(loc, _exp, _) => {
                // Complex location writes (e.g. struct fields) — skip for now
                let _ = loc;
            }

            Instr::Call(Loc::Id(id), _, func_id, args, _) => {
                let call_kind = classify_call(model, *func_id);
                match call_kind {
                    KnownCall::WriteReg => {
                        // wX(rd, val) — this is the instruction's register output
                        let rd = exp_to_smt(model, &args[0], &bindings)?;
                        let val = exp_to_smt(model, &args[1], &bindings)?;
                        reg_write = Some((rd, val));
                        bindings.insert(*id, "(_ unit)".to_string());
                    }
                    KnownCall::SignExtend | KnownCall::ZeroExtend => {
                        // EXTS(target_width, val) / EXTZ(target_width, val)
                        //
                        // The extension amount = target_width - source_width.
                        // Source width is inferred from the type of the value argument
                        // (tracked in type_widths from Decl instructions).
                        let target_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let target_width = target_smt.parse::<u32>().map_err(|_| {
                            anyhow!("EXTS/EXTZ: non-literal target width '{}'", target_smt)
                        })?;
                        let val_smt = exp_to_smt(model, &args[1], &bindings)?;

                        // Infer source width from the value expression
                        let source_width = infer_bv_width(&args[1], &type_widths)
                            .ok_or_else(|| anyhow!(
                                "EXTS/EXTZ: cannot infer source width for '{}' (val_smt={})",
                                format_exp(model, &args[1]), val_smt
                            ))?;

                        let extend_amount = target_width.saturating_sub(source_width);
                        let op = match call_kind {
                            KnownCall::SignExtend => "sign_extend",
                            _ => "zero_extend",
                        };
                        bindings.insert(*id, format!("((_ {} {}) {})", op, extend_amount, val_smt));
                        // Record the result width so downstream EXTS/EXTZ can use it
                        type_widths.insert(*id, target_width);
                    }
                    KnownCall::ReadMem => {
                        // read_mem(addr, width) — use raw-width stdlib functions
                        // (mem_read_1/2/4/8) that return the actual BV width.
                        // The IR path's EXTS/EXTZ will handle sign/zero extension.
                        // Reads reference current_mem so they see prior writes.
                        let addr_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let width_smt = exp_to_smt(model, &args[1], &bindings)?;
                        let width = width_smt.parse::<u64>().map_err(|_| {
                            anyhow!("read_mem: non-literal width '{}'", width_smt)
                        })?;
                        let (mem_fn, result_bits) = match width {
                            1 => ("mem_read_1", 8u32),
                            2 => ("mem_read_2", 16),
                            4 => ("mem_read_4", 32),
                            8 => ("mem_read_8", 64),
                            _ => return Err(anyhow!("read_mem: unsupported width {} bytes", width)),
                        };
                        bindings.insert(*id, format!("({} {} {})", mem_fn, current_mem, addr_smt));
                        // Record actual result width so EXTS/EXTZ computes correct extension
                        type_widths.insert(*id, result_bits);
                    }
                    KnownCall::WriteMem => {
                        // write_mem(addr, width, val) — wrap current_mem functionally.
                        // After this, current_mem = "(write_mem_X <old_mem> addr val)".
                        // Subsequent reads will see the updated memory.
                        let addr_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let width_smt = exp_to_smt(model, &args[1], &bindings)?;
                        let val_smt = exp_to_smt(model, &args[2], &bindings)?;
                        let width = width_smt.parse::<u64>().map_err(|_| {
                            anyhow!("write_mem: non-literal width '{}'", width_smt)
                        })?;
                        let mem_fn = match width {
                            1 => "write_mem_byte",
                            2 => "write_mem_half",
                            4 => "write_mem_word",
                            8 => "write_mem_dword",
                            _ => return Err(anyhow!("write_mem: unsupported width {} bytes", width)),
                        };
                        current_mem = format!("({} {} {} {})", mem_fn, current_mem, addr_smt, val_smt);
                        bindings.insert(*id, "(_ unit)".to_string());
                    }
                    KnownCall::VMemRead => {
                        // vmem_read(rs1:bv5, offset:bv64, width:i64, access_type, aq, rl, res)
                        // width must be a concrete literal — achieved via LOAD specialization.
                        let rs1_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let offset_smt = exp_to_smt(model, &args[1], &bindings)?;
                        let width_smt = exp_to_smt(model, &args[2], &bindings)?;
                        let width = width_smt.parse::<u64>().map_err(|_| {
                            anyhow!("vmem_read: width not concrete literal '{}' — LOAD must be specialized", width_smt)
                        })?;
                        let (mem_fn, result_bits) = match width {
                            1 => ("mem_read_1", 8u32),
                            2 => ("mem_read_2", 16),
                            4 => ("mem_read_4", 32),
                            8 => ("mem_read_8", 64),
                            _ => return Err(anyhow!("vmem_read: unsupported width {}", width)),
                        };
                        bindings.insert(*id, format!(
                            "({} {} (bvadd (get_reg regs0 {}) {}))",
                            mem_fn, current_mem, rs1_smt, offset_smt
                        ));
                        type_widths.insert(*id, result_bits);
                    }
                    KnownCall::VMemWrite => {
                        // vmem_write(rs1:bv5, offset:bv64, width:i64, val:bv, access_type, aq, rl)
                        let rs1_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let offset_smt = exp_to_smt(model, &args[1], &bindings)?;
                        let width_smt = exp_to_smt(model, &args[2], &bindings)?;
                        let val_smt = exp_to_smt(model, &args[3], &bindings)?;
                        let width = width_smt.parse::<u64>().map_err(|_| {
                            anyhow!("vmem_write: width not concrete literal '{}' — STORE must be specialized", width_smt)
                        })?;
                        let mem_fn = match width {
                            1 => "write_mem_byte",
                            2 => "write_mem_half",
                            4 => "write_mem_word",
                            8 => "write_mem_dword",
                            _ => return Err(anyhow!("vmem_write: unsupported width {}", width)),
                        };
                        // The stdlib write_mem_N functions all take a BV64 value
                        // and internally extract the low bytes. Sail's subrange_bits
                        // pre-truncates to BV(width*8), so zero-extend back to 64
                        // before the call.
                        let val_width = infer_bv_width(&args[3], type_widths)
                            .ok_or_else(|| anyhow!("vmem_write: cannot infer val width"))?;
                        let val_bv64 = if val_width == 64 {
                            val_smt
                        } else {
                            format!("((_ zero_extend {}) {})", 64 - val_width, val_smt)
                        };
                        let addr = format!("(bvadd (get_reg regs0 {}) {})", rs1_smt, offset_smt);
                        current_mem = format!("({} {} {} {})", mem_fn, current_mem, addr, val_bv64);
                        bindings.insert(*id, "(_ unit)".to_string());
                    }
                    KnownCall::SailAssert => {
                        // sail_assert(cond, msg) — elided entirely. The message
                        // arg is a string literal that exp_to_smt cannot translate,
                        // so we must short-circuit before generic arg translation.
                        bindings.insert(*id, "(_ unit)".to_string());
                    }
                    KnownCall::ExtendValue => {
                        // extend_value(is_unsigned:bool, data:bv) — pre-bound is_unsigned
                        // (from LOAD specialization) picks sign vs zero extend.
                        let is_u_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let val_smt = exp_to_smt(model, &args[1], &bindings)?;
                        let is_unsigned = match is_u_smt.as_str() {
                            "true" => true,
                            "false" => false,
                            _ => return Err(anyhow!(
                                "extend_value: is_unsigned not concrete literal '{}' — LOAD must be specialized",
                                is_u_smt
                            )),
                        };
                        let source_width = infer_bv_width(&args[1], type_widths)
                            .ok_or_else(|| anyhow!(
                                "extend_value: cannot infer source width for '{}'",
                                format_exp(model, &args[1])
                            ))?;
                        let ext_amount = 64u32.saturating_sub(source_width);
                        let op = if is_unsigned { "zero_extend" } else { "sign_extend" };
                        bindings.insert(*id, format!("((_ {} {}) {})", op, ext_amount, val_smt));
                        type_widths.insert(*id, 64);
                    }
                    KnownCall::ShiftBitsLeft
                    | KnownCall::ShiftBitsRight
                    | KnownCall::ShiftBitsRightArith => {
                        let val_smt = exp_to_smt(model, &args[0], &bindings)?;
                        let shamt_smt = exp_to_smt(model, &args[1], &bindings)?;
                        let val_w = infer_bv_width(&args[0], type_widths)
                            .ok_or_else(|| anyhow!("shift: cannot infer value width"))?;
                        let shamt_w = infer_bv_width(&args[1], type_widths)
                            .ok_or_else(|| anyhow!("shift: cannot infer shamt width"))?;
                        let shamt_ext = if shamt_w == val_w {
                            shamt_smt
                        } else if shamt_w < val_w {
                            format!("((_ zero_extend {}) {})", val_w - shamt_w, shamt_smt)
                        } else {
                            return Err(anyhow!(
                                "shift: shamt width {} exceeds value width {}",
                                shamt_w,
                                val_w
                            ));
                        };
                        let smt_op = match call_kind {
                            KnownCall::ShiftBitsLeft => "bvshl",
                            KnownCall::ShiftBitsRight => "bvlshr",
                            KnownCall::ShiftBitsRightArith => "bvashr",
                            _ => unreachable!(),
                        };
                        bindings.insert(*id, format!("({} {} {})", smt_op, val_smt, shamt_ext));
                        type_widths.insert(*id, val_w);
                    }
                    _ => {
                        // Some IR calls build union/enum values for arguments we
                        // don't inspect (e.g. `zz = Load<u>(Data)` passed to
                        // vmem_read as access_type). Such constructors aren't
                        // real functions — if the destination is a union-typed
                        // variable, bind it to a placeholder instead of failing.
                        let ty = find_decl_type(body, *id);
                        let is_opaque = matches!(ty, Ty::Union(_) | Ty::Enum(_));
                        match call_to_smt(model, *func_id, args, &bindings) {
                            Ok(smt) => {
                                // Track the result width for calls that produce a
                                // known bitvector width so downstream consumers
                                // (e.g. extend_value, vmem_write zero-extend) can
                                // infer the source width.
                                if let KnownCall::SubrangeBits = call_kind {
                                    // subrange_bits(_, hi, lo) → width = hi - lo + 1.
                                    // Eager-folded literals flow through exp_to_smt,
                                    // so parse them back out of args[1]/args[2].
                                    let hi_smt = exp_to_smt(model, &args[1], &bindings).ok();
                                    let lo_smt = exp_to_smt(model, &args[2], &bindings).ok();
                                    if let (Some(h), Some(l)) = (hi_smt, lo_smt) {
                                        if let (Ok(hi), Ok(lo)) = (h.parse::<i64>(), l.parse::<i64>()) {
                                            if hi >= lo {
                                                type_widths.insert(*id, (hi - lo + 1) as u32);
                                            }
                                        }
                                    }
                                }
                                bindings.insert(*id, smt);
                            }
                            Err(e) if is_opaque => {
                                let _ = e;
                                bindings.insert(*id, "(_ unit)".to_string());
                            }
                            Err(e) => return Err(e),
                        }
                    }
                }
            }

            // Segment boundaries are controlled by the caller. Internal
            // control-flow instructions (gotos, inner jumps, function end)
            // are skipped — they don't contribute to the translation.
            Instr::Goto(_) | Instr::End | Instr::Jump(_, _, _) => {}
            _ => {}
        }
        }
    }

    Ok(PathTranslation {
        params,
        reg_write,
        mem_expr: current_mem,
        bindings,
    })
}

/// Check if an expression is a field access on a union unwrap.
///
/// Matches the IR pattern for tuple field extraction:
///   Exp::Field(Exp::Unwrap(ctor, inner), field)
/// which is how Isla represents `merge#var as ITYPE.tuple#...0`
fn is_field_of_unwrap(exp: &Exp<Name>) -> bool {
    matches!(exp, Exp::Field(inner, _) if matches!(inner.as_ref(), Exp::Unwrap(_, _)))
}

/// Infer the bitvector width of an expression from the type environment.
///
/// Used by EXTS/EXTZ to compute extension amount = target_width - source_width.
/// Returns None if the width cannot be determined statically.
fn infer_bv_width(exp: &Exp<Name>, type_widths: &HashMap<Name, u32>) -> Option<u32> {
    match exp {
        Exp::Id(id) => type_widths.get(id).copied(),
        Exp::Bits(bv) => Some(bv.len()),
        Exp::Call(Op::Slice(n), _) => Some(*n),
        Exp::Call(Op::Concat, args) => {
            // concat(a, b) has width = width(a) + width(b)
            let w1 = infer_bv_width(&args[0], type_widths)?;
            let w2 = infer_bv_width(&args[1], type_widths)?;
            Some(w1 + w2)
        }
        // Union unwrap (`x as Ok...`) doesn't change bit-width — look through it.
        Exp::Unwrap(_, inner) => infer_bv_width(inner, type_widths),
        _ => None,
    }
}

/// Find the declared type for a variable in the path (from a preceding Decl instruction).
fn find_decl_type<'a>(path: &'a [Instr<Name, B129>], target: Name) -> &'a Ty<Name> {
    for instr in path {
        if let Instr::Decl(id, ty, _) = instr {
            if *id == target {
                return ty;
            }
        }
    }
    // Fallback — shouldn't happen in well-formed IR
    &path.iter().find_map(|i| if let Instr::Decl(_, ty, _) = i { Some(ty) } else { None }).unwrap()
}
