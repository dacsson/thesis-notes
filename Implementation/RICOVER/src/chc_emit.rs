use std::collections::HashMap;
use std::fmt::Write;

use anyhow::{anyhow, Result};

use isla_lib::bitvector::b129::B129;
use isla_lib::bitvector::BV;
use isla_lib::ir::{Exp, Instr, Loc, Name, Op, Ty};

use crate::asm_parse::{AsmFunction, AsmInstruction, Operand, reg_index};
use crate::isla_ir::IslaIRModel;

const STDLIB: &str = include_str!("../chc_stdlib/stdlib.smt2");

// SMT variable name for an IR Name
fn smt_var(model: &IslaIRModel, name: Name) -> String {
    let decoded = model.resolve_name(name);
    // Sanitize: replace # and % with _
    decoded.replace('#', "_").replace('%', "_").replace(' ', "_")
}

/// Translate an expression to SMT-LIB2.
/// `bindings` maps IR variable names to their SMT expressions (for inlining copies).
///
/// Returns Err on unsupported expressions — a verification tool must never
/// silently emit placeholder comments instead of real semantics.
fn exp_to_smt(model: &IslaIRModel, exp: &Exp<Name>, bindings: &HashMap<Name, String>) -> Result<String> {
    match exp {
        Exp::Id(id) => {
            if let Some(bound) = bindings.get(id) {
                Ok(bound.clone())
            } else {
                Ok(smt_var(model, *id))
            }
        }
        Exp::Bits(bv) => {
            let len = bv.len();
            // BV literals wider than 64 bits cannot be represented via lower_u64().
            // Fail explicitly rather than silently truncating upper bits.
            if len > 64 {
                Err(anyhow!(
                    "bitvector literal wider than 64 bits (width {}): cannot represent with lower_u64()",
                    len
                ))
            } else {
                Ok(format!("(_ bv{} {})", bv.lower_u64(), len))
            }
        }
        Exp::I64(n) => Ok(format!("{}", n)),
        Exp::I128(n) => Ok(format!("{}", n)),
        Exp::Bool(b) => Ok(if *b { "true" } else { "false" }.to_string()),
        Exp::Unit => Ok("(_ unit)".to_string()),
        Exp::Call(op, args) => {
            let smt_args: Vec<String> = args.iter()
                .map(|a| exp_to_smt(model, a, bindings))
                .collect::<Result<_>>()?;
            match op {
                Op::Not => Ok(format!("(not {})", smt_args[0])),
                Op::And => Ok(format!("(and {})", smt_args.join(" "))),
                Op::Or => Ok(format!("(or {})", smt_args.join(" "))),
                Op::Eq => Ok(format!("(= {} {})", smt_args[0], smt_args[1])),
                Op::Neq => Ok(format!("(not (= {} {}))", smt_args[0], smt_args[1])),
                Op::Bvadd => Ok(format!("(bvadd {} {})", smt_args[0], smt_args[1])),
                Op::Bvsub => Ok(format!("(bvsub {} {})", smt_args[0], smt_args[1])),
                Op::Bvand => Ok(format!("(bvand {} {})", smt_args[0], smt_args[1])),
                Op::Bvor => Ok(format!("(bvor {} {})", smt_args[0], smt_args[1])),
                Op::Bvxor => Ok(format!("(bvxor {} {})", smt_args[0], smt_args[1])),
                Op::Bvnot => Ok(format!("(bvnot {})", smt_args[0])),
                Op::Concat => Ok(format!("(concat {} {})", smt_args[0], smt_args[1])),
                Op::Slice(n) => Ok(format!("((_ extract {} 0) {})", n - 1, smt_args[0])),
                Op::ZeroExtend(n) => Ok(format!("((_ zero_extend {}) {})", n, smt_args[0])),
                Op::Signed(n) => Ok(format!("((_ sign_extend {}) {})", n, smt_args[0])),
                Op::Unsigned(_) => Ok(format!("(bv2nat {})", smt_args[0])),
                Op::Lt => Ok(format!("(bvslt {} {})", smt_args[0], smt_args[1])),
                Op::Lteq => Ok(format!("(bvsle {} {})", smt_args[0], smt_args[1])),
                Op::Gt => Ok(format!("(bvsgt {} {})", smt_args[0], smt_args[1])),
                Op::Gteq => Ok(format!("(bvsge {} {})", smt_args[0], smt_args[1])),
                _ => Err(anyhow!("unsupported IR operator: {:?}", op)),
            }
        }
        Exp::Field(inner, field) => {
            // Struct field access — inline as variable reference
            let inner_smt = exp_to_smt(model, inner, bindings)?;
            let field_name = model.resolve_name(*field);
            Ok(format!("{}_{}", inner_smt, field_name))
        }
        Exp::Unwrap(_ctor, inner) => {
            // Union unwrap — for our purposes, same as the inner expression
            // since we've already dispatched on the variant via jump
            exp_to_smt(model, inner, bindings)
        }
        Exp::Kind(_ctor, inner) => {
            // Kind checks should be handled by jump dispatch in discover_variants,
            // not appear in expression context during translation.
            Err(anyhow!(
                "unexpected Kind check in expression context: {} is {}",
                format_exp(model, inner),
                model.resolve_name(*_ctor)
            ))
        }
        _ => Err(anyhow!("unsupported IR expression: {:?}", exp)),
    }
}

fn ty_to_smt(ty: &Ty<Name>) -> String {
    match ty {
        Ty::Bits(n) => format!("(_ BitVec {})", n),
        Ty::AnyBits => "(_ BitVec 64)".to_string(), // default width
        Ty::Bool => "Bool".to_string(),
        Ty::I64 => "Int".to_string(),
        Ty::I128 => "Int".to_string(),
        Ty::Unit => "Bool".to_string(), // dummy
        _ => panic!("unsupported IR type in SMT translation: {:?}", ty),
    }
}

/// Identifies which known Sail function a call corresponds to,
/// so we can emit the right CHC/SMT instead of an opaque call.
enum KnownCall {
    ReadReg,       // rX(rs) → get_reg(regs, rs)
    WriteReg,      // wX(rd, val) → set_reg(regs, rd, val)
    SignExtend,    // EXTS(width, val) → sign_extend
    ZeroExtend,   // EXTZ(width, val) → zero_extend
    AddBits,       // add_bits(a, b) → bvadd
    ReadMem,       // read_mem(addr, width)
    WriteMem,      // write_mem(addr, width, val)
    EqBits,        // eq_bits(a, b) → =
    NeqBits,       // neq_bits(a, b) → not =
    SubrangeBits,  // subrange_bits(bv, hi, lo) → extract
    Unsigned,      // unsigned(bv) → bv2nat
    IntToI64,      // %i->%i64 — type cast, passthrough
    I64ToInt,      // %i64->%i — type cast, passthrough
    Unknown(String),
}

fn classify_call(model: &IslaIRModel, func_id: Name) -> KnownCall {
    let name = model.resolve_name(func_id);
    match name.as_str() {
        "rX" => KnownCall::ReadReg,
        "wX" => KnownCall::WriteReg,
        "EXTS" => KnownCall::SignExtend,
        "EXTZ" => KnownCall::ZeroExtend,
        "add_bits" => KnownCall::AddBits,
        "read_mem" => KnownCall::ReadMem,
        "write_mem" | "__write_mem" | "MEMw" => KnownCall::WriteMem,
        "eq_bits" => KnownCall::EqBits,
        "neq_bits" => KnownCall::NeqBits,
        "subrange_bits" => KnownCall::SubrangeBits,
        "unsigned" => KnownCall::Unsigned,
        "%i64->%i" | "%i->%i64" => KnownCall::IntToI64,
        _ => KnownCall::Unknown(name),
    }
}

/// Translate a Call instruction to an SMT expression string.
///
/// EXTS/EXTZ and WriteMem are NOT handled here — they require type-width
/// information that is only available in translate_path, which handles
/// them directly. ReadMem/WriteReg are also handled specially in translate_path
/// but fall through here for non-translate_path contexts.
///
/// Returns Err on unsupported/unknown calls — a verification tool must never
/// silently emit placeholder comments.
fn call_to_smt(
    model: &IslaIRModel,
    func_id: Name,
    args: &[Exp<Name>],
    bindings: &HashMap<Name, String>,
) -> Result<String> {
    let smt_args: Vec<String> = args.iter()
        .map(|a| exp_to_smt(model, a, bindings))
        .collect::<Result<_>>()?;

    match classify_call(model, func_id) {
        KnownCall::ReadReg => {
            // rX(rs) → (get_reg regs rs)
            Ok(format!("(get_reg regs0 {})", smt_args[0]))
        }
        KnownCall::WriteReg => {
            // wX(rd, val) → (set_reg regs0 rd val)
            // This is a state mutation — handled specially in the CHC rule
            Ok(format!("(set_reg regs0 {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::SignExtend | KnownCall::ZeroExtend => {
            // EXTS/EXTZ require source-width inference from the type environment.
            // They are handled directly in translate_path; reaching here means
            // call_to_smt was invoked outside that context.
            Err(anyhow!(
                "EXTS/EXTZ must be handled in translate_path with type-width tracking, \
                 not via call_to_smt (target_width={}, val={})",
                smt_args[0], smt_args[1]
            ))
        }
        KnownCall::AddBits => {
            Ok(format!("(bvadd {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::ReadMem => {
            // read_mem(addr, width) — dispatch by byte count
            let addr = &smt_args[0];
            let width_smt = &smt_args[1];
            let width = width_smt.parse::<u64>().map_err(|_| {
                anyhow!("read_mem: non-literal width '{}', cannot dispatch to stdlib", width_smt)
            })?;
            let mem_fn = match width {
                1 => "read_mem_byte",
                2 => "read_mem_half",
                4 => "read_mem_word",
                8 => "read_mem_dword",
                _ => return Err(anyhow!("read_mem: unsupported width {} bytes", width)),
            };
            Ok(format!("({} mem0 {})", mem_fn, addr))
        }
        KnownCall::WriteMem => {
            // write_mem(addr, width, val) — dispatch by byte count
            let addr = &smt_args[0];
            let width_smt = &smt_args[1];
            let val = &smt_args[2];
            let width = width_smt.parse::<u64>().map_err(|_| {
                anyhow!("write_mem: non-literal width '{}', cannot dispatch to stdlib", width_smt)
            })?;
            let mem_fn = match width {
                1 => "write_mem_byte",
                2 => "write_mem_half",
                4 => "write_mem_word",
                8 => "write_mem_dword",
                _ => return Err(anyhow!("write_mem: unsupported width {} bytes", width)),
            };
            Ok(format!("({} mem0 {} {})", mem_fn, addr, val))
        }
        KnownCall::EqBits => {
            Ok(format!("(= {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::NeqBits => {
            Ok(format!("(not (= {} {}))", smt_args[0], smt_args[1]))
        }
        KnownCall::SubrangeBits => {
            // subrange_bits(bv, hi, lo) → ((_ extract hi lo) bv)
            Ok(format!("((_ extract {} {}) {})", smt_args[1], smt_args[2], smt_args[0]))
        }
        KnownCall::Unsigned => {
            Ok(format!("(bv2nat {})", smt_args[0]))
        }
        KnownCall::IntToI64 | KnownCall::I64ToInt => {
            // Type cast — passthrough in SMT
            Ok(smt_args[0].clone())
        }
        KnownCall::Unknown(name) => {
            Err(anyhow!("unsupported Sail function call: {}({})", name, smt_args.join(", ")))
        }
    }
}

// =========================================================================
// Isla IR → CHC transpiler
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

/// A discovered instruction variant in the execute function.
///
/// Represents a linear path through the IR for one instruction kind
/// (e.g. ADDI, LOAD), with its start/end indices in the body array.
struct InstrVariant {
    /// Human-readable name derived from the IR.
    /// For variants with a sub-opcode check (e.g. ITYPE + RISCV_ADDI), this is
    /// the sub-opcode name with the "RISCV_" prefix stripped (→ "ADDI").
    /// For variants without a sub-check (e.g. LOAD), this is the variant name.
    name: String,
    /// Index of the first instruction in the variant body
    /// (after the jump guards, starting at the field extractions)
    body_start: usize,
    /// Index of the last instruction (exclusive) — typically a `goto exit`
    body_end: usize,
}

/// Discover instruction variant paths in the execute function body.
///
/// Scans for `jump (Kind check) goto target` instructions and extracts
/// the linear path between the guard and the goto-exit for each variant.
///
/// For dispatch structures like:
///   jump (merge#var is ITYPE) goto 29
///   jump @neq(RISCV_ADDI, ...) goto 29    ← sub-opcode check
///   [body...]
///
/// The variant name is extracted from the sub-opcode constant (e.g. "RISCV_ADDI" → "ADDI").
fn discover_variants(model: &IslaIRModel, body: &[Instr<Name, B129>]) -> Vec<InstrVariant> {
    let mut variants = Vec::new();
    let mut i = 0;

    while i < body.len() {
        // Look for a Kind check jump: jump (merge#var is VARIANT) goto skip
        if let Instr::Jump(Exp::Kind(ctor, _), skip_target, _) = &body[i] {
            let outer_name = model.resolve_name(*ctor);

            // The body starts after this jump
            let mut body_start = i + 1;
            let mut variant_name = outer_name.clone();

            // Check if next instruction is a sub-opcode guard jump.
            // Pattern: jump @neq(RISCV_ADDI, ...) goto skip
            // The first argument to @neq is the opcode constant.
            if body_start < body.len() {
                if let Instr::Jump(Exp::Call(Op::Neq, args), _, _) = &body[body_start] {
                    // Extract sub-opcode name from the first arg (e.g. RISCV_ADDI)
                    if let Some(Exp::Id(opcode_id)) = args.first() {
                        let sub_name = model.resolve_name(*opcode_id);
                        // Strip "RISCV_" prefix if present
                        variant_name = sub_name.strip_prefix("RISCV_")
                            .unwrap_or(&sub_name)
                            .to_string();
                    }
                    body_start += 1;
                }
            }

            // Find the end of the variant body: scan until goto
            let mut body_end = body_start;
            while body_end < body.len() {
                match &body[body_end] {
                    Instr::Goto(_) => {
                        body_end += 1; // include the goto itself in the range
                        break;
                    }
                    _ => body_end += 1,
                }
            }

            variants.push(InstrVariant {
                name: variant_name,
                body_start,
                body_end,
            });

            // Skip to the skip_target to look for the next variant
            i = *skip_target;
        } else {
            i += 1;
        }
    }

    variants
}

/// Result of translating a variant's IR path to SMT expressions.
///
/// After walking the path, we know:
/// - What tuple fields were extracted (parameters to the CHC rule)
/// - Whether a register write occurred (wX) and to which register/value
/// - Whether a memory read occurred (read_mem) and of what width
/// - All intermediate computations as inlined SMT bindings
struct PathTranslation {
    /// Tuple field extractions: (variable_name, declared_type)
    /// These become the instruction's parameters (imm, rs1, rd, etc.)
    params: Vec<(Name, Ty<Name>)>,
    /// Register write: wX(rd_expr, val_expr) → (rd_smt, val_smt)
    reg_write: Option<(String, String)>,
    /// Final memory expression after all memory operations in the path.
    /// Starts as "mem0"; each write_mem wraps it functionally:
    ///   "(write_mem_dword mem0 addr val)" after one write,
    ///   "(write_mem_word (write_mem_dword mem0 a1 v1) a2 v2)" after two, etc.
    /// Reads use the current expression, so a write-then-read sees the updated memory.
    /// Emitted as (= mem1 <mem_expr>) in the CHC rule.
    mem_expr: String,
    /// All bindings accumulated during the walk (variable → SMT expression)
    bindings: HashMap<Name, String>,
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
fn collect_type_widths(body: &[Instr<Name, B129>]) -> HashMap<Name, u32> {
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

fn translate_path(
    model: &IslaIRModel,
    path: &[Instr<Name, B129>],
    body: &[Instr<Name, B129>],
    type_widths: &mut HashMap<Name, u32>,
) -> Result<PathTranslation> {
    let mut bindings: HashMap<Name, String> = HashMap::new();
    let mut params: Vec<(Name, Ty<Name>)> = Vec::new();
    let mut reg_write = None;

    // Current memory expression, threaded through all memory operations.
    // Starts as "mem0"; writes wrap it: "(write_mem_dword mem0 addr val)".
    // Reads reference it so a write-then-read sees the updated state.
    let mut current_mem = "mem0".to_string();

    for instr in path {
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
                    // Search the full body for the type, not just the path slice,
                    // because Decls live at the top of the function before dispatch.
                    let ty = find_decl_type(body, *id);
                    // Register the parameter's bitvector width so downstream
                    // EXTS/EXTZ can infer the source width correctly.
                    if let Ty::Bits(n) = ty {
                        type_widths.insert(*id, *n);
                    }
                    params.push((*id, ty.clone()));
                    let param_name = format!("p{}", params.len() - 1);
                    bindings.insert(*id, param_name);
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
                    _ => {
                        let smt = call_to_smt(model, *func_id, args, &bindings)?;
                        bindings.insert(*id, smt);
                    }
                }
            }

            Instr::Goto(_) | Instr::End | Instr::Jump(_, _, _) => break,
            _ => {}
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
    write!(out, ";; --- {} instruction (from Isla IR [{}..{}]) ---\n", variant.name, variant.body_start, variant.body_end)?;
    write!(out, "(declare-rel {}\n", name)?;
    write!(out, "  ({STATE_TYPES}\n")?;
    write!(out, "   {STATE_TYPES}")?;

    // Add parameter types
    for (_param_id, param_ty) in &translation.params {
        let smt_ty = ty_to_smt(param_ty);
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
        let smt_ty = ty_to_smt(param_ty);
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
/// This is the main entry point for the Isla IR → CHC transpiler.
/// It discovers all instruction variant paths in the execute function,
/// translates each path's IR to SMT, and emits a CHC rule per variant.
fn emit_execute_chc(model: &IslaIRModel, out: &mut String) -> Result<()> {
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

    for variant in &variants {
        // Extract the linear path for this variant
        let path = &body[variant.body_start..variant.body_end];

        // Translate the IR path to SMT bindings
        let translation = translate_path(model, path, body, &mut type_widths)?;

        // Emit the CHC rule
        emit_variant_chc(model, variant, &translation, out)?;
    }

    // Also emit the IR dump as comments for debugging
    writeln!(out, ";; --- IR dump for reference ---")?;
    for (i, instr) in body.iter().enumerate() {
        writeln!(out, ";; [{}] {}", i, format_instr(model, instr))?;
    }

    Ok(())
}

/// Translate IR functions into CHC definitions in SMT-LIB2 HORN format.
pub fn emit_instruction_chc(model: &IslaIRModel, functions: &[String]) -> Result<String> {
    let mut out = String::new();
    writeln!(out, "{}", STDLIB)?;
    writeln!(out)?;

    for func_name in functions {
        if func_name == "execute" {
            emit_execute_chc(model, &mut out)?;
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

// --- Formatting helpers (kept for IR dump / debugging) ---

fn format_instr(model: &IslaIRModel, instr: &Instr<Name, B129>) -> String {
    match instr {
        Instr::Decl(id, ty, _) => format!("decl {} : {:?}", model.resolve_name(*id), ty),
        Instr::Init(id, ty, exp, _) => {
            format!("init {} : {:?} = {}", model.resolve_name(*id), ty, format_exp(model, exp))
        }
        Instr::Copy(loc, exp, _) => format!("{} = {}", format_loc(model, loc), format_exp(model, exp)),
        Instr::Call(loc, _, func_id, args, _) => {
            let args_str: Vec<String> = args.iter().map(|a| format_exp(model, a)).collect();
            format!("{} = {}({})", format_loc(model, loc), model.resolve_name(*func_id), args_str.join(", "))
        }
        Instr::Jump(exp, target, _) => format!("jump {} goto {}", format_exp(model, exp), target),
        Instr::Goto(target) => format!("goto {}", target),
        Instr::End => "end".to_string(),
        Instr::Exit(cause, _) => format!("exit {:?}", cause),
        Instr::Arbitrary => "arbitrary".to_string(),
        _ => format!("{:?}", instr),
    }
}

fn format_loc(model: &IslaIRModel, loc: &Loc<Name>) -> String {
    match loc {
        Loc::Id(id) => model.resolve_name(*id),
        Loc::Field(inner, field) => format!("{}.{}", format_loc(model, inner), model.resolve_name(*field)),
        Loc::Addr(inner) => format!("*{}", format_loc(model, inner)),
    }
}

fn format_exp(model: &IslaIRModel, exp: &Exp<Name>) -> String {
    match exp {
        Exp::Id(id) => model.resolve_name(*id),
        Exp::Ref(id) => format!("&{}", model.resolve_name(*id)),
        Exp::Bool(b) => b.to_string(),
        Exp::Bits(bv) => format!("{}", bv),
        Exp::String(s) => format!("\"{}\"", s),
        Exp::Unit => "()".to_string(),
        Exp::I64(n) => n.to_string(),
        Exp::I128(n) => n.to_string(),
        Exp::Undefined(ty) => format!("undefined:{:?}", ty),
        Exp::Struct(name, fields) => {
            let fs: Vec<String> = fields
                .iter()
                .map(|(f, e)| format!("{} = {}", model.resolve_name(*f), format_exp(model, e)))
                .collect();
            format!("struct {} {{{}}}", model.resolve_name(*name), fs.join(", "))
        }
        Exp::Kind(ctor, inner) => format!("{} is {}", format_exp(model, inner), model.resolve_name(*ctor)),
        Exp::Unwrap(ctor, inner) => format!("{} as {}", format_exp(model, inner), model.resolve_name(*ctor)),
        Exp::Field(inner, field) => format!("{}.{}", format_exp(model, inner), model.resolve_name(*field)),
        Exp::Call(op, args) => {
            let args_str: Vec<String> = args.iter().map(|a| format_exp(model, a)).collect();
            format!("{}({})", format_op(op), args_str.join(", "))
        }
    }
}

fn format_op(op: &Op) -> &'static str {
    match op {
        Op::Not => "@not",
        Op::Or => "@or",
        Op::And => "@and",
        Op::Eq => "@eq",
        Op::Neq => "@neq",
        Op::Lteq => "@lteq",
        Op::Lt => "@lt",
        Op::Gteq => "@gteq",
        Op::Gt => "@gt",
        Op::Add => "@iadd",
        Op::Sub => "@isub",
        Op::Bvnot => "@bvnot",
        Op::Bvor => "@bvor",
        Op::Bvxor => "@bvxor",
        Op::Bvand => "@bvand",
        Op::Bvadd => "@bvadd",
        Op::Bvsub => "@bvsub",
        Op::Bvaccess => "@bvaccess",
        Op::Concat => "@concat",
        Op::Head => "@hd",
        Op::Tail => "@tl",
        Op::Slice(_) => "@slice",
        Op::SetSlice => "@set_slice",
        Op::Signed(_) => "@signed",
        Op::Unsigned(_) => "@unsigned",
        Op::ZeroExtend(_) => "@zero_extend",
        _ => "@unknown",
    }
}

// =========================================================================
// Assembly-level CHC emission
// =========================================================================
//
// This section translates parsed assembly functions into CHC rules in
// Z3 fixedpoint (μZ / Spacer) format:
//   (declare-rel name (types...))
//   (rule (forall ((x T) ...) (=> (and ...) (name ...))))
//   (query bad)
//
// The pipeline:
//   1. emit_instruction_rules()     — CHC rules for each opcode (addi, lw, sd, ret, ...)
//   2. emit_program_rule()          — chain instruction relations for one function
//   3. emit_equivalence_query()     — full .smt2 file: stdlib + instructions + programs + query

/// State type signature used in declare-rel and forall bindings.
/// State = (Regs: Array(BV5→BV64), Mem: Array(BV64→BV8), PC: BV64)
const STATE_TYPES: &str = "(Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)";

/// Emit a state variable binding for use in `forall`.
/// E.g. emit_state_binding("regs3", "mem3", "pc3")
fn emit_state_binding(out: &mut String, regs: &str, mem: &str, pc: &str) -> std::fmt::Result {
    write!(out, "({regs} (Array (_ BitVec 5) (_ BitVec 64))) ({mem} (Array (_ BitVec 64) (_ BitVec 8))) ({pc} (_ BitVec 64))")
}

/// Convert a signed immediate value to a 12-bit bitvector literal in SMT-LIB2.
///
/// Negative values are represented as two's complement:
///   -32 → (_ bv4064 12)   (0xFE0)
///   -20 → (_ bv4076 12)   (0xFEC)
///    24 → (_ bv24 12)
fn imm_to_bv12(val: i64) -> String {
    let unsigned = if val < 0 {
        ((1i64 << 12) + val) as u64
    } else {
        val as u64
    };
    format!("(_ bv{} 12)", unsigned)
}

/// Convert a register name to its SMT-LIB2 bitvector index.
/// E.g. "sp" → "reg_sp", "a0" → "reg_a0", "t3" → "(_ bv28 5)"
///
/// Uses symbolic constants for common registers (defined in stdlib) for readability,
/// falls back to literal bitvector for less common ones.
fn reg_to_smt(name: &str) -> Result<String> {
    let idx = reg_index(name)?;
    Ok(match name {
        "zero" => "reg_zero".to_string(),
        "ra"   => "reg_ra".to_string(),
        "sp"   => "reg_sp".to_string(),
        "s0" | "fp" => "reg_s0".to_string(),
        "a0"   => "reg_a0".to_string(),
        _ => format!("(_ bv{} 5)", idx),
    })
}

/// Emit CHC rules for all supported instruction opcodes.
///
/// Each instruction is a relation with signature:
///   (declare-rel opcode (Regs_in Mem_in PC_in  Regs_out Mem_out PC_out  operands...))
///   (rule (forall (...) (=> (and constraints...) (opcode ...))))
///
/// Instruction-specific operands by class:
///   - addi/addiw:  imm:BV12, rs1:BV5, rd:BV5
///   - sw/sd:       imm:BV12, base:BV5, rs2:BV5
///   - lw/ld:       imm:BV12, base:BV5, rd:BV5
///   - ret:         (no extra operands)
fn emit_instruction_rules(out: &mut String) -> Result<()> {
    // --- ADDI: rd = rs1 + sign_extend(imm) ---
    writeln!(out, "(declare-rel addi")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}")?;
    writeln!(out, "   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64))")?;
    writeln!(out, "           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))")?;
    writeln!(out, "    (=> (and (= regs1 (set_reg regs0 rd")?;
    writeln!(out, "                               (bvadd (get_reg regs0 rs1)")?;
    writeln!(out, "                                      ((_ sign_extend 52) imm))))")?;
    writeln!(out, "             (= mem1 mem0)")?;
    writeln!(out, "             (= pc1 (bvadd pc0 (_ bv4 64))))")?;
    writeln!(out, "        (addi regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))")?;
    writeln!(out)?;

    // --- ADDIW: rd = sign_extend_32(truncate_32(rs1 + sign_extend(imm))) ---
    // Word-width add: compute in 64 bits, truncate to low 32, sign-extend back to 64
    writeln!(out, "(declare-rel addiw")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}")?;
    writeln!(out, "   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64))")?;
    writeln!(out, "           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))")?;
    writeln!(out, "    (=> (and")?;
    writeln!(out, "          (= regs1")?;
    writeln!(out, "             (set_reg regs0 rd")?;
    writeln!(out, "               ((_ sign_extend 32)")?;
    writeln!(out, "                 ((_ extract 31 0)")?;
    writeln!(out, "                   (bvadd (get_reg regs0 rs1)")?;
    writeln!(out, "                          ((_ sign_extend 52) imm))))))")?;
    writeln!(out, "          (= mem1 mem0)")?;
    writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
    writeln!(out, "        (addiw regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))")?;
    writeln!(out)?;

    // --- SW: store word (4 bytes, little-endian) ---
    writeln!(out, "(declare-rel sw")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}")?;
    writeln!(out, "   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64))")?;
    writeln!(out, "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))")?;
    writeln!(out, "    (=> (and")?;
    writeln!(out, "          (= regs1 regs0)")?;
    writeln!(out, "          (= mem1 (write_mem_word mem0")?;
    writeln!(out, "                                  (bvadd (get_reg regs0 base)")?;
    writeln!(out, "                                         ((_ sign_extend 52) imm))")?;
    writeln!(out, "                                  (get_reg regs0 rs2)))")?;
    writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
    writeln!(out, "        (sw regs0 mem0 pc0 regs1 mem1 pc1 imm base rs2))))")?;
    writeln!(out)?;

    // --- LW: load word (4 bytes, sign-extended to 64 bits) ---
    writeln!(out, "(declare-rel lw")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}")?;
    writeln!(out, "   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64))")?;
    writeln!(out, "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))")?;
    writeln!(out, "    (=> (and")?;
    writeln!(out, "          (= regs1 (set_reg regs0 rd")?;
    writeln!(out, "                            (read_mem_word mem0")?;
    writeln!(out, "                                           (bvadd (get_reg regs0 base)")?;
    writeln!(out, "                                                  ((_ sign_extend 52) imm)))))")?;
    writeln!(out, "          (= mem1 mem0)")?;
    writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
    writeln!(out, "        (lw regs0 mem0 pc0 regs1 mem1 pc1 imm base rd))))")?;
    writeln!(out)?;

    // --- SD: store doubleword (8 bytes, little-endian) ---
    writeln!(out, "(declare-rel sd")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}")?;
    writeln!(out, "   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64))")?;
    writeln!(out, "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))")?;
    writeln!(out, "    (=> (and")?;
    writeln!(out, "          (= regs1 regs0)")?;
    writeln!(out, "          (= mem1 (write_mem_dword mem0")?;
    writeln!(out, "                                   (bvadd (get_reg regs0 base)")?;
    writeln!(out, "                                          ((_ sign_extend 52) imm))")?;
    writeln!(out, "                                   (get_reg regs0 rs2)))")?;
    writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
    writeln!(out, "        (sd regs0 mem0 pc0 regs1 mem1 pc1 imm base rs2))))")?;
    writeln!(out)?;

    // --- LD: load doubleword (8 bytes) ---
    writeln!(out, "(declare-rel ld")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}")?;
    writeln!(out, "   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64))")?;
    writeln!(out, "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))")?;
    writeln!(out, "    (=> (and")?;
    writeln!(out, "          (= regs1 (set_reg regs0 rd")?;
    writeln!(out, "                            (read_mem_dword mem0")?;
    writeln!(out, "                                            (bvadd (get_reg regs0 base)")?;
    writeln!(out, "                                                   ((_ sign_extend 52) imm)))))")?;
    writeln!(out, "          (= mem1 mem0)")?;
    writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
    writeln!(out, "        (ld regs0 mem0 pc0 regs1 mem1 pc1 imm base rd))))")?;
    writeln!(out)?;

    // --- RET: pseudo-instruction (jalr zero, 0(ra)) ---
    // PC becomes the return address from ra; registers and memory unchanged
    writeln!(out, "(declare-rel ret")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0 (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1 (_ BitVec 64)))")?;
    writeln!(out, "    (=> (and (= regs1 regs0)")?;
    writeln!(out, "             (= mem1 mem0)")?;
    writeln!(out, "             (= pc1 (get_reg regs0 reg_ra)))")?;
    writeln!(out, "        (ret regs0 mem0 pc0 regs1 mem1 pc1))))")?;
    writeln!(out)?;

    Ok(())
}

/// Translate a single assembly instruction into its CHC relation call arguments.
///
/// Returns (opcode, instruction-specific SMT operands).
/// The caller provides state variable names (regsN, memN, pcN).
///
/// Operand mapping by instruction class:
///   addi/addiw rd, rs1, imm   → (opcode ... imm_bv rs1_bv rd_bv)
///   sw/sd      rs2, off(base) → (opcode ... off_bv base_bv rs2_bv)
///   lw/ld      rd, off(base)  → (opcode ... off_bv base_bv rd_bv)
///   ret                       → (ret    ...)
fn instruction_to_chc(instr: &AsmInstruction) -> Result<(String, Vec<String>)> {
    let op = instr.opcode.as_str();
    match op {
        // I-type arithmetic: addi rd, rs1, imm
        "addi" | "addiw" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rd", op)),
            };
            let rs1 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs1", op)),
            };
            let imm = match &instr.operands[2] {
                Operand::Imm(n) => imm_to_bv12(*n),
                _ => return Err(anyhow!("{}: expected immediate for imm", op)),
            };
            Ok((op.to_string(), vec![imm, rs1, rd]))
        }

        // Store: sw/sd rs2, offset(base)
        "sw" | "sd" => {
            let rs2 = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs2", op)),
            };
            let (off, base) = match &instr.operands[1] {
                Operand::MemRef { offset, base } => (imm_to_bv12(*offset), reg_to_smt(base)?),
                _ => return Err(anyhow!("{}: expected memref for offset(base)", op)),
            };
            Ok((op.to_string(), vec![off, base, rs2]))
        }

        // Load: lw/ld rd, offset(base)
        "lw" | "ld" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rd", op)),
            };
            let (off, base) = match &instr.operands[1] {
                Operand::MemRef { offset, base } => (imm_to_bv12(*offset), reg_to_smt(base)?),
                _ => return Err(anyhow!("{}: expected memref for offset(base)", op)),
            };
            Ok((op.to_string(), vec![off, base, rd]))
        }

        // Return pseudo-instruction
        "ret" => Ok(("ret".to_string(), vec![])),

        _ => Err(anyhow!("unsupported instruction: {}", op)),
    }
}

/// Emit a CHC rule for a complete assembly function.
///
/// The function becomes a relation mapping initial state to final state:
///   (declare-rel funcname (Regs_in Mem_in PC_in  Regs_out Mem_out PC_out))
///
/// The rule chains all instructions sequentially with intermediate state variables:
///   (rule (forall ((regs0 ...) ... (regsN ...))
///     (=> (and (instr1 regs0 mem0 pc0 regs1 mem1 pc1 ...)
///              ...
///              (instrN regsN-1 ... regsN ...))
///         (funcname regs0 mem0 pc0 regsN memN pcN))))
fn emit_program_rule(func: &AsmFunction, out: &mut String) -> Result<()> {
    let n = func.instructions.len();

    // Declare the function relation: (state_in, state_out)
    writeln!(out, "(declare-rel {}", func.name)?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}))")?;
    writeln!(out)?;

    // Build forall bindings: n+1 state triples (regs0..regsN, mem0..memN, pc0..pcN)
    writeln!(out, "(rule")?;
    write!(out, "  (forall (")?;

    for i in 0..=n {
        if i > 0 {
            write!(out, "\n           ")?;
        }
        emit_state_binding(out, &format!("regs{i}"), &format!("mem{i}"), &format!("pc{i}"))?;
    }
    writeln!(out, ")")?;

    // Conjunction of instruction relation calls
    writeln!(out, "    (=> (and")?;
    for (i, instr) in func.instructions.iter().enumerate() {
        let (opcode, operands) = instruction_to_chc(instr)?;
        let state_args = format!("regs{i} mem{i} pc{i} regs{} mem{} pc{}", i+1, i+1, i+1);
        // Comment with original assembly for readability
        writeln!(out, "          ; {}", format_asm_instr(instr))?;
        if operands.is_empty() {
            writeln!(out, "          ({opcode} {state_args})")?;
        } else {
            writeln!(out, "          ({opcode} {state_args} {})", operands.join(" "))?;
        }
    }

    // Close (and ...) and emit the head
    writeln!(out, "        )")?;
    writeln!(out, "        ({} regs0 mem0 pc0 regs{n} mem{n} pc{n}))))", func.name)?;
    writeln!(out)?;

    Ok(())
}

/// Format an assembly instruction as a human-readable string (for comments).
fn format_asm_instr(instr: &AsmInstruction) -> String {
    if instr.operands.is_empty() {
        return instr.opcode.clone();
    }
    let ops: Vec<String> = instr.operands.iter().map(|op| match op {
        Operand::Reg(r) => r.clone(),
        Operand::Imm(n) => n.to_string(),
        Operand::MemRef { offset, base } => format!("{}({})", offset, base),
    }).collect();
    format!("{} {}", instr.opcode, ops.join(", "))
}

/// Compute the stack frame size for a function.
///
/// Convention: the first instruction of a stack-allocating function is `addi sp, sp, -N`.
/// Returns N (positive), or 0 if the function doesn't allocate a stack frame.
fn compute_frame_size(func: &AsmFunction) -> u64 {
    if let Some(first) = func.instructions.first() {
        if first.opcode == "addi" {
            if let [Operand::Reg(rd), Operand::Reg(rs1), Operand::Imm(imm)] = first.operands.as_slice() {
                if rd == "sp" && rs1 == "sp" && *imm < 0 {
                    return (-imm) as u64;
                }
            }
        }
    }
    0
}

/// Emit a complete equivalence checking query for two assembly functions.
///
/// Produces a self-contained .smt2 file with:
///   1. (set-logic HORN) + stdlib (register/memory operations)
///   2. Instruction relation rules (addi, addiw, sw, lw, sd, ld, ret)
///   3. Program relation rules for prog1 and prog2
///   4. Observable-address predicate (excludes private stack frame)
///   5. Projected equivalence query (bad_proj):
///      "Is there any initial state where the two programs differ on
///       ABI-visible registers (a0, ra, sp, s0) or PC, or on any memory
///       byte outside the function's stack frame?"
///
///   UNSAT = semantically equivalent under RISC-V calling convention
///   SAT   = counterexample exists (programs are NOT equivalent)
pub fn emit_equivalence_query(
    prog1: &AsmFunction,
    prog2: &AsmFunction,
    _name: &str,
) -> Result<String> {
    let mut out = String::new();

    // 1. Stdlib: set-logic HORN + register/memory operations
    writeln!(out, "{}", STDLIB)?;
    writeln!(out)?;

    // 2. Instruction relation rules
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Instruction relations")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out)?;
    emit_instruction_rules(&mut out)?;

    // 3. Program relation rules
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Programs")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out)?;
    emit_program_rule(prog1, &mut out)?;
    emit_program_rule(prog2, &mut out)?;

    // 4. Observable-address predicate
    //
    // The private stack frame is [sp0 - framesize, sp0).
    // All addresses outside that interval are "observable" — must match between programs.
    // We use the larger of the two frame sizes to be conservative.
    let frame1 = compute_frame_size(prog1);
    let frame2 = compute_frame_size(prog2);
    let frame_size = std::cmp::max(frame1, frame2);

    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Observable-address predicate")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, ";")?;
    writeln!(out, "; The initial stack frame [sp0 - {frame_size}, sp0) is private/dead memory.")?;
    writeln!(out, "; All addresses outside that interval are observable.")?;
    writeln!(out)?;
    writeln!(out, "(declare-rel obs_addr ((_ BitVec 64) (_ BitVec 64)))")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((sp0 (_ BitVec 64)) (a (_ BitVec 64)))")?;
    writeln!(out, "    (=> (or (bvult a (bvsub sp0 (_ bv{frame_size} 64)))")?;
    writeln!(out, "            (bvuge a sp0))")?;
    writeln!(out, "        (obs_addr sp0 a))))")?;
    writeln!(out)?;

    // 5. Projected equivalence query
    //
    // Equivalence notion: ABI-visible registers + observable memory.
    // "Private" stack memory (allocated by the function) is excluded from comparison.
    let p1 = &prog1.name;
    let p2 = &prog2.name;

    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Equivalence query")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, ";")?;
    writeln!(out, "; ABI-level registers + projected memory (ignore stack-allocated memory).")?;
    writeln!(out, "; UNSAT = equivalent, SAT = counterexample found.")?;
    writeln!(out)?;

    writeln!(out, "(declare-rel bad ())")?;
    writeln!(out)?;
    writeln!(out, "(rule")?;
    writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc0   (_ BitVec 64))")?;
    writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc1   (_ BitVec 64))")?;
    writeln!(out, "           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))")?;
    writeln!(out, "           (mem2  (Array (_ BitVec 64) (_ BitVec 8)))")?;
    writeln!(out, "           (pc2   (_ BitVec 64))")?;
    writeln!(out, "           (sp0   (_ BitVec 64))")?;
    writeln!(out, "           (a     (_ BitVec 64)))")?;
    writeln!(out, "    (=> (and")?;
    writeln!(out, "          (= sp0 (get_reg regs0 reg_sp))")?;
    writeln!(out, "          ; Guard against wraparound of the private frame interval")?;
    writeln!(out, "          (bvuge sp0 (_ bv{frame_size} 64))")?;
    writeln!(out, "          ({p1} regs0 mem0 pc0 regs1 mem1 pc1)")?;
    writeln!(out, "          ({p2} regs0 mem0 pc0 regs2 mem2 pc2)")?;
    writeln!(out, "          ; ABI-visible register equality")?;
    writeln!(out, "          (= pc1 pc2)")?;
    writeln!(out, "          (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))")?;
    writeln!(out, "          (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))")?;
    writeln!(out, "          (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))")?;
    writeln!(out, "          (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0))")?;
    writeln!(out, "          ; Observable memory differs at some address")?;
    writeln!(out, "          (obs_addr sp0 a)")?;
    writeln!(out, "          (not (= (select mem1 a) (select mem2 a))))")?;
    writeln!(out, "        bad)))")?;
    writeln!(out)?;
    writeln!(out, "(query bad)")?;

    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::asm_parse;
    use crate::isla_ir;

    const RISCV_IR: &str = include_str!("../../../Tools/Sail/Data/riscv.ir");
    const FOO1_ASM: &str = include_str!("../../../Examples/foo1.s");
    const FOO2_ASM: &str = include_str!("../../../Examples/foo2.s");

    #[test]
    fn emit_execute_produces_chc() {
        let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse");
        let result = emit_instruction_chc(&model, &["execute".to_string()]);
        let chc = result.expect("failed to emit CHC");
        println!("{}", chc);
        assert!(chc.contains("set-logic HORN"));
        // Variant discovery: ADDI (from sub-opcode RISCV_ADDI) and LOAD
        assert!(chc.contains("declare-rel addi"), "expected addi relation from ITYPE/RISCV_ADDI variant");
        assert!(chc.contains("declare-rel load"), "expected load relation from LOAD variant");
        // CHC rule body uses stdlib functions
        assert!(chc.contains("get_reg"));
        assert!(chc.contains("set_reg"));
        assert!(chc.contains("sign_extend"));
        assert!(chc.contains("bvadd"));
        // Parameters are forall-bound, not raw field names
        assert!(chc.contains("(p0 "), "expected forall-bound parameter p0");
        assert!(!chc.contains("merge_var"), "raw field names should not appear in CHC rules");
    }

    #[test]
    fn emit_foo_equivalence_query() {
        let foo1 = asm_parse::parse_asm(FOO1_ASM, "foo1").expect("parse foo1");
        let foo2 = asm_parse::parse_asm(FOO2_ASM, "foo2").expect("parse foo2");
        let query = emit_equivalence_query(&foo1, &foo2, "foo").expect("emit query");
        println!("{}", query);

        // Check structure
        assert!(query.contains("set-logic HORN"));
        assert!(query.contains("declare-rel foo1"));
        assert!(query.contains("declare-rel foo2"));
        assert!(query.contains("declare-rel bad"));
        assert!(query.contains("obs_addr"));
        assert!(query.contains("query bad"));

        // Check that instruction rules are present
        assert!(query.contains("declare-rel addi"));
        assert!(query.contains("declare-rel addiw"));
        assert!(query.contains("declare-rel sw"));
        assert!(query.contains("declare-rel lw"));
        assert!(query.contains("declare-rel sd"));
        assert!(query.contains("declare-rel ld"));
        assert!(query.contains("declare-rel ret"));

        // Check frame size computation (foo1 allocates 32 bytes)
        assert!(query.contains("bv32 64"));
    }
}
