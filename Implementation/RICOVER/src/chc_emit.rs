use std::collections::{HashMap, HashSet};
use std::fmt::Write;

use anyhow::{anyhow, Result};

use isla_lib::bitvector::b129::B129;
use isla_lib::bitvector::BV;
use isla_lib::ir::{Def, Exp, Instr, Loc, Name, Op, Ty};

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

fn ty_to_smt(ty: &Ty<Name>) -> Result<String> {
    match ty {
        Ty::Bits(n) => Ok(format!("(_ BitVec {})", n)),
        Ty::AnyBits => Ok("(_ BitVec 64)".to_string()), // default width
        Ty::Bool => Ok("Bool".to_string()),
        Ty::I64 => Ok("Int".to_string()),
        Ty::I128 => Ok("Int".to_string()),
        Ty::Unit => Ok("Bool".to_string()), // dummy
        _ => Err(anyhow!("unsupported IR type in SMT translation: {:?}", ty)),
    }
}

/// Identifies which known Sail function a call corresponds to,
/// so we can emit the right CHC/SMT instead of an opaque call.
enum KnownCall {
    ReadReg,       // rX(rs) / rX_bits(rs) → get_reg(regs, rs)
    WriteReg,      // wX(rd, val) / wX_bits(rd, val) → set_reg(regs, rd, val)
    SignExtend,    // EXTS(width, val) / sign_extend(width, val) → SMT sign_extend
    ZeroExtend,    // EXTZ(width, val) / zero_extend(width, val) → SMT zero_extend
    AddBits,       // add_bits(a, b) → bvadd
    SubBits,       // sub_bits(a, b) → bvsub
    AndVec,        // and_vec(a, b) → bvand
    OrVec,         // or_vec(a, b)  → bvor
    XorVec,        // xor_vec(a, b) → bvxor
    SubVec,        // sub_vec(a, b) → bvsub
    LtSigned,      // (operator <_s)(a, b) → bvslt (returns SMT Bool)
    LtUnsigned,    // (operator <_u)(a, b) → bvult (returns SMT Bool)
    BoolToBits,    // bool_to_bits(b) → (ite b (_ bv1 1) (_ bv0 1))
    ShiftBitsLeft,       // shift_bits_left(val, shamt) → bvshl with width-matched shamt
    ShiftBitsRight,      // shift_bits_right(val, shamt) → bvlshr with width-matched shamt
    ShiftBitsRightArith, // shift_bits_right_arith(val, shamt) → bvashr with width-matched shamt
    Concat,        // bitvector_concat(a, b) → (concat a b)
    Zeros,         // zeros(N) → (_ bv0 N)
    Ones,          // ones(N) → (_ bv<2^N-1> N)
    ReadMem,       // read_mem(addr, width)
    WriteMem,      // write_mem(addr, width, val)
    EqBits,        // eq_bits(a, b) → =
    NeqBits,       // neq_bits(a, b) → not =
    SubrangeBits,  // subrange_bits(bv, hi, lo) → extract
    Unsigned,      // unsigned(bv) → bv2nat
    IntToI64,      // %i->%i64 — type cast, passthrough
    I64ToInt,      // %i64->%i — type cast, passthrough
    LTEqInt,       // int <= int
    MultAtom,      // mult_atom(a, b) — integer mul, eagerly evaluated on literals
    SubAtom,       // sub_atom(a, b) — integer sub, eagerly evaluated on literals
    SailAssert,    // sail_assert(cond, msg) — dropped (assertions are elided)
    // vmem_read / vmem_write collapse the full Sail virtual-memory pipeline
    // (address translation, PMP/PMA checks, exception generation, the
    // MemoryAccessType tag, and the aq/rl ordering flags) down to a direct
    // little-endian read/write at `reg[rs1] + offset`. Sound only under the
    // projected-equivalence notion we verify here:
    //   - Both sides run under the same page tables (same binary, same OS),
    //     so identity indexing at the virtual-address level is equivalent to
    //     indexing the physical memory produced by any fixed vaddr→paddr map.
    //   - Fault behaviour is not observed: we follow the Ok arm of the
    //     result union and drop the Err arm. If one side faults and the
    //     other doesn't, we will (incorrectly) report equivalent. Compiler
    //     optimizations on straight-line integer/memory code are required to
    //     preserve faults at the same program points, so this holds in
    //     practice — but it is a trust assumption, not a proof.
    //   - Single-threaded execution: acquire/release flags are ignored, so
    //     this does not model weak-memory orderings (LR/SC, fences).
    // Code that genuinely depends on traps, atomics, privileged CSR ops, or
    // TLB semantics is outside this model — LOADRES/STORECON and friends
    // are (correctly) not routed through these handlers.
    VMemRead,      // vmem_read(rs1, off, width, ...) — load from reg+offset
    VMemWrite,     // vmem_write(rs1, off, width, val, ...) — store at reg+offset
    ExtendValue,   // extend_value(is_unsigned, data) — dispatches to sign/zero extend
    Unknown(String),
}

fn classify_call(model: &IslaIRModel, func_id: Name) -> KnownCall {
    let name = model.resolve_name(func_id);
    match name.as_str() {
        // Register reads: minimal IR uses rX; full IR uses rX_bits (same semantics —
        // returns a BV64 register value).
        "rX" | "rX_bits" => KnownCall::ReadReg,
        "wX" | "wX_bits" => KnownCall::WriteReg,
        // Sign/zero extension: minimal IR uses EXTS/EXTZ (Sail primitives); full IR
        // exposes them as the generic sign_extend/zero_extend Sail library functions.
        "EXTS" | "sign_extend" => KnownCall::SignExtend,
        "EXTZ" | "zero_extend" => KnownCall::ZeroExtend,
        "add_bits" => KnownCall::AddBits,
        "sub_bits" => KnownCall::SubBits,
        "and_vec" => KnownCall::AndVec,
        "or_vec" => KnownCall::OrVec,
        "xor_vec" => KnownCall::XorVec,
        "sub_vec" => KnownCall::SubVec,
        "(operator <_s)" => KnownCall::LtSigned,
        "(operator <_u)" => KnownCall::LtUnsigned,
        "bool_to_bits" => KnownCall::BoolToBits,
        "shift_bits_left" => KnownCall::ShiftBitsLeft,
        "shift_bits_right" => KnownCall::ShiftBitsRight,
        "shift_bits_right_arith" => KnownCall::ShiftBitsRightArith,
        "bitvector_concat" => KnownCall::Concat,
        "zeros" => KnownCall::Zeros,
        "ones" => KnownCall::Ones,
        "read_mem" => KnownCall::ReadMem,
        "write_mem" | "__write_mem" | "MEMw" => KnownCall::WriteMem,
        "eq_bits" => KnownCall::EqBits,
        "neq_bits" => KnownCall::NeqBits,
        "subrange_bits" => KnownCall::SubrangeBits,
        "unsigned" => KnownCall::Unsigned,
        "%i64->%i" | "%i->%i64" => KnownCall::IntToI64,
        "lteq_int" => KnownCall::LTEqInt,
        "mult_atom" => KnownCall::MultAtom,
        "sub_atom" => KnownCall::SubAtom,
        "sail_assert" => KnownCall::SailAssert,
        "vmem_read" => KnownCall::VMemRead,
        "vmem_write" => KnownCall::VMemWrite,
        "extend_value" => KnownCall::ExtendValue,
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
        KnownCall::SubBits => {
            Ok(format!("(bvsub {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::AndVec => {
            Ok(format!("(bvand {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::OrVec => {
            Ok(format!("(bvor {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::XorVec => {
            Ok(format!("(bvxor {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::SubVec => {
            Ok(format!("(bvsub {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::LtSigned => {
            Ok(format!("(bvslt {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::LtUnsigned => {
            Ok(format!("(bvult {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::BoolToBits => {
            // Sail bool_to_bits : bool → bv1
            Ok(format!("(ite {} (_ bv1 1) (_ bv0 1))", smt_args[0]))
        }
        KnownCall::Concat => {
            Ok(format!("(concat {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::Zeros => {
            // zeros(N) — N is an integer literal in the IR. We accept either a
            // raw integer (passed from Exp::I64/I128) or an SMT Int literal.
            let n = smt_args[0].parse::<u32>().map_err(|_| {
                anyhow!("zeros: non-literal width '{}'", smt_args[0])
            })?;
            Ok(format!("(_ bv0 {})", n))
        }
        KnownCall::Ones => {
            let n = smt_args[0].parse::<u32>().map_err(|_| {
                anyhow!("ones: non-literal width '{}'", smt_args[0])
            })?;
            // (_ bv<2^n-1> n) is the all-ones bitvector of width n
            let mask = if n >= 128 { u128::MAX } else { (1u128 << n) - 1 };
            Ok(format!("(_ bv{} {})", mask, n))
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
        KnownCall::LTEqInt => {
            Ok(format!("(<= {} {})", smt_args[0], smt_args[1]))
        }
        KnownCall::MultAtom => {
            // Strictly eager: we only accept integer literals because the
            // result typically feeds subrange_bits' hi/lo indices, which
            // must be SMT literals. Non-literal args indicate an instruction
            // we can't specialize, so fail cleanly and let the variant be skipped.
            match (smt_args[0].parse::<i128>(), smt_args[1].parse::<i128>()) {
                (Ok(a), Ok(b)) => Ok((a * b).to_string()),
                _ => Err(anyhow!(
                    "mult_atom: non-literal args '{}', '{}'", smt_args[0], smt_args[1]
                )),
            }
        }
        KnownCall::SubAtom => {
            match (smt_args[0].parse::<i128>(), smt_args[1].parse::<i128>()) {
                (Ok(a), Ok(b)) => Ok((a - b).to_string()),
                _ => Err(anyhow!(
                    "sub_atom: non-literal args '{}', '{}'", smt_args[0], smt_args[1]
                )),
            }
        }
        KnownCall::SailAssert => {
            // Assertions are dropped — we elide them from the CHC semantics.
            Ok("(_ unit)".to_string())
        }
        KnownCall::VMemRead | KnownCall::VMemWrite | KnownCall::ExtendValue => {
            // Handled directly in translate_variant where current_mem and
            // type_widths are accessible.
            Err(anyhow!(
                "vmem_read/vmem_write/extend_value must be handled in translate_variant"
            ))
        }
        KnownCall::ShiftBitsLeft | KnownCall::ShiftBitsRight | KnownCall::ShiftBitsRightArith => {
            // SMT bvshl/bvlshr/bvashr require both operands at the same width.
            // The IR shift amount is narrower (e.g. bv6) than the value (bv64),
            // so we need type_widths to compute the zero-extend delta.
            Err(anyhow!("shift_bits_* must be handled in translate_variant"))
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
    /// Instruction ranges (half-open [start, end) into the execute body) that
    /// together make up this variant's semantics. A variant with no inner
    /// enum dispatch has a single segment. A sub-dispatched variant (e.g. ADDI
    /// extracted from ITYPE's `@neq(zADDI, iop)` arm) has three segments:
    /// shared prologue, arm-specific body, shared post-amble.
    segments: Vec<(usize, usize)>,
    /// Pre-bound tuple-field values for specialization (e.g. LOAD per width/sign).
    /// Keys are the IR Names of the extracted fields; values are SMT literal strings.
    /// Pre-bound fields are skipped from the CHC parameter list.
    initial_bindings: HashMap<Name, String>,
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
fn discover_variants(model: &IslaIRModel, body: &[Instr<Name, B129>]) -> Vec<InstrVariant> {
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

                for (op_name, jump_idx, target) in &sub_guards {
                    variants.push(InstrVariant {
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
                        variants.push(InstrVariant {
                            name,
                            segments: vec![prologue, (last_target, postamble_start), postamble],
                            initial_bindings: HashMap::new(),
                        });
                    }
                }
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
/// Pre-evaluate top-level `let` bindings whose body reduces to a single
/// integer literal. Sail emits constants like `xlen`, `xlen_bytes`, and
/// `log2_xlen` as `Def::Let` blocks that wrap an `i64` literal in casts and
/// dead `eq_int` branches. Without this pass, references to such constants
/// inside `subrange_bits(... log2_xlen-1, 0)` reach `sub_atom` as opaque
/// `Exp::Id`s and the literal-fold path fails.
///
/// Returns a map from the let-bound name to its SMT literal string ("6"),
/// so it can be merged into `bindings` and resolved via `Exp::Id` lookup.
fn collect_globals(model: &IslaIRModel) -> HashMap<Name, String> {
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

fn translate_variant(
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
/// This is the main entry point for the Isla IR → CHC transpiler.
/// It discovers all instruction variant paths in the execute function,
/// translates each path's IR to SMT, and emits a CHC rule per variant.
///
/// Returns the set of lowercased variant names that were emitted (e.g. {"addi", "load"}).
/// This is used by emit_equivalence_query to decide which opcodes need hand-written fallbacks.
fn emit_execute_chc(model: &IslaIRModel, out: &mut String) -> Result<HashSet<String>> {
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
//   1. IR-derived instruction rules (from emit_execute_chc, preferred)
//      + fallback hand-written rules for opcodes not yet in the IR
//   2. emit_program_rule()          — chain instruction relations for one function
//   3. emit_equivalence_query()     — full .smt2 file: stdlib + instructions + programs + query

/// Map an assembly opcode to the IR-derived rule name, if the IR covers it.
///
/// The IR transpiler produces rules named after Sail variants (e.g. "addi", "load").
/// Assembly opcodes may differ (e.g. "ld" maps to IR "load" when only one LOAD variant exists).
/// Returns None when the opcode has no IR coverage and needs a hand-written fallback.
fn ir_rule_for_opcode<'a>(asm_opcode: &str, ir_names: &'a HashSet<String>) -> Option<&'a str> {
    // Direct match: asm opcode == IR variant name (most common with full IR)
    if let Some(name) = ir_names.get(asm_opcode) {
        return Some(name.as_str());
    }

    // Per-width/sign specialized LOAD/STORE rules generated from the full IR.
    let mapped = match asm_opcode {
        "lb"  => "load_1_s",
        "lbu" => "load_1_u",
        "lh"  => "load_2_s",
        "lhu" => "load_2_u",
        "lw"  => "load_4_s",
        "lwu" => "load_4_u",
        "ld"  => "load_8_s",
        "sb"  => "store_1",
        "sh"  => "store_2",
        "sw"  => "store_4",
        "sd"  => "store_8",
        _ => return None,
    };
    if ir_names.contains(mapped) {
        Some(mapped)
    } else {
        None
    }
}

/// Collect the set of distinct opcodes used across assembly functions.
fn collect_needed_opcodes(progs: &[&AsmFunction]) -> HashSet<String> {
    let mut opcodes = HashSet::new();
    for prog in progs {
        for instr in &prog.instructions {
            // Use the post-translation opcode so pseudo-instructions
            // (li → addi, zext.b → andi) don't register as missing.
            let resolved = instruction_to_chc(instr)
                .map(|(op, _)| op)
                .unwrap_or_else(|_| instr.opcode.clone());
            opcodes.insert(resolved);
        }
    }
    opcodes
}

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

/// Emit hand-written CHC rules for opcodes not covered by IR-derived rules.
///
/// These are fallback definitions — when the Isla IR covers an opcode, the
/// IR-derived rule takes precedence and the fallback is not emitted.
/// As the IR subset grows, fewer fallbacks are needed.
///
/// Each instruction is a relation with signature:
///   (declare-rel opcode (Regs_in Mem_in PC_in  Regs_out Mem_out PC_out  operands...))
///   (rule (forall (...) (=> (and constraints...) (opcode ...))))
fn emit_fallback_rules(needed: &HashSet<String>, out: &mut String) -> Result<()> {
    if needed.is_empty() {
        return Ok(());
    }
    writeln!(out, ";; Hand-written fallback rules for opcodes not yet in the IR:")?;
    writeln!(out, ";; {:?}", needed)?;
    writeln!(out)?;

    for opcode in needed {
        emit_one_fallback_rule(opcode, out)?;
    }

    Ok(())
}

/// Emit a single hand-written fallback rule.
fn emit_one_fallback_rule(opcode: &str, out: &mut String) -> Result<()> {
    match opcode {
    "addi" => {
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
    }

    "addiw" => {
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
    }

    "sw" => {
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
    }

    "lw" => {
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
    }

    "sd" => {
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
    }

    "ld" => {
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
    }

    "ret" => {
    // --- RET: pseudo-instruction (jalr zero, 0(ra)) ---
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
    }

    _ => return Err(anyhow!("no fallback rule for opcode: {}", opcode)),
    }

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
        "addi" | "addiw" | "andi" | "ori" | "xori" | "slti" | "sltiu" => {
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

        // Store: sb/sh/sw/sd rs2, offset(base)
        // IR-derived store_N rules take parameters in the Sail tuple order
        // (imm, rs2, rs1=base), so we must supply operands in that order.
        "sb" | "sh" | "sw" | "sd" => {
            let rs2 = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs2", op)),
            };
            let (off, base) = match &instr.operands[1] {
                Operand::MemRef { offset, base } => (imm_to_bv12(*offset), reg_to_smt(base)?),
                _ => return Err(anyhow!("{}: expected memref for offset(base)", op)),
            };
            Ok((op.to_string(), vec![off, rs2, base]))
        }

        // Load: lb/lbu/lh/lhu/lw/lwu/ld rd, offset(base)
        "lb" | "lbu" | "lh" | "lhu" | "lw" | "lwu" | "ld" => {
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

        // I-type shift-immediate: slli/srli/srai rd, rs1, shamt
        // IR SHIFTIOP tuple is (shamt:bv6, rs1, rd, sop).
        "slli" | "srli" | "srai" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rd", op)),
            };
            let rs1 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs1", op)),
            };
            let shamt = match &instr.operands[2] {
                Operand::Imm(n) if (0..64).contains(n) => format!("(_ bv{} 6)", n),
                Operand::Imm(n) => return Err(anyhow!("{}: shamt {} out of range", op, n)),
                _ => return Err(anyhow!("{}: expected immediate for shamt", op)),
            };
            Ok((op.to_string(), vec![shamt, rs1, rd]))
        }

        // R-type arithmetic: add rd, rs1, rs2
        // IR RTYPE tuple is (rs2, rs1, rd, op), so operands map to (rs2, rs1, rd).
        "add" | "sub" | "and" | "or" | "xor" | "slt" | "sltu" | "sll" | "srl" | "sra" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rd", op)),
            };
            let rs1 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs1", op)),
            };
            let rs2 = match &instr.operands[2] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs2", op)),
            };
            Ok((op.to_string(), vec![rs2, rs1, rd]))
        }

        // Pseudo: li rd, imm — when imm fits in a signed 12-bit range,
        // GAS expands to addi rd, zero, imm. Wider immediates expand to
        // lui+addi, which we don't model yet.
        "li" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("li: expected register for rd")),
            };
            let imm = match &instr.operands[1] {
                Operand::Imm(n) if (-2048..2048).contains(n) => imm_to_bv12(*n),
                Operand::Imm(n) => return Err(anyhow!("li: immediate {} doesn't fit in 12 bits", n)),
                _ => return Err(anyhow!("li: expected immediate")),
            };
            Ok(("addi".to_string(), vec![imm, "reg_zero".to_string(), rd]))
        }

        // Pseudo (Zbb): zext.b rd, rs1 — andi rd, rs1, 0xff
        "zext.b" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("zext.b: expected register for rd")),
            };
            let rs1 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("zext.b: expected register for rs1")),
            };
            Ok(("andi".to_string(), vec![imm_to_bv12(0xff), rs1, rd]))
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
fn emit_program_rule(
    func: &AsmFunction,
    ir_names: &HashSet<String>,
    out: &mut String,
) -> Result<()> {
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
        // Prefer an IR-derived rule name when the IR covers this opcode.
        let rule_name = ir_rule_for_opcode(&opcode, ir_names)
            .map(|s| s.to_string())
            .unwrap_or(opcode);
        let state_args = format!("regs{i} mem{i} pc{i} regs{} mem{} pc{}", i+1, i+1, i+1);
        // Comment with original assembly for readability
        writeln!(out, "          ; {}", format_asm_instr(instr))?;
        if operands.is_empty() {
            writeln!(out, "          ({rule_name} {state_args})")?;
        } else {
            writeln!(out, "          ({rule_name} {state_args} {})", operands.join(" "))?;
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
    model: Option<&IslaIRModel>,
) -> Result<String> {
    let mut out = String::new();

    // 1. Stdlib: set-logic HORN + register/memory operations
    writeln!(out, "{}", STDLIB)?;
    writeln!(out)?;

    // 2a. IR-derived instruction rules (if a model was provided)
    let ir_names: HashSet<String> = if let Some(m) = model {
        writeln!(out, "; {}", "=".repeat(70))?;
        writeln!(out, "; IR-derived instruction rules (from Sail spec via Isla)")?;
        writeln!(out, "; {}", "=".repeat(70))?;
        writeln!(out)?;
        emit_execute_chc(m, &mut out)?
    } else {
        HashSet::new()
    };

    // 2b. Hand-written fallback rules for opcodes not covered by the IR
    let needed = collect_needed_opcodes(&[prog1, prog2]);
    let fallback_needed: HashSet<String> = needed
        .iter()
        .filter(|op| ir_rule_for_opcode(op, &ir_names).is_none())
        .cloned()
        .collect();
    if !fallback_needed.is_empty() {
        let mut sorted: Vec<&String> = fallback_needed.iter().collect();
        sorted.sort();
        eprintln!(
            "warning: falling back to hand-written CHC rules for opcodes not covered by the IR: {}",
            sorted.iter().map(|s| s.as_str()).collect::<Vec<_>>().join(", ")
        );
    }
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Hand-written fallback instruction rules")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out)?;
    emit_fallback_rules(&fallback_needed, &mut out)?;

    // 3. Program relation rules
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Programs")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out)?;
    emit_program_rule(prog1, &ir_names, &mut out)?;
    emit_program_rule(prog2, &ir_names, &mut out)?;

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

    // Emit one rule per discrepancy kind so any observable difference fires
    // `bad`. Conjuncting register equality with memory inequality (the prior
    // shape) silently hid register divergences.
    let reg_diffs = [
        ("a0", "(not (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0)))"),
        ("ra", "(not (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra)))"),
        ("sp", "(not (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp)))"),
        ("s0", "(not (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0)))"),
        ("pc", "(not (= pc1 pc2))"),
    ];
    for (label, diff) in reg_diffs {
        writeln!(out, "; ABI register {label} divergence")?;
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
        writeln!(out, "           (sp0   (_ BitVec 64)))")?;
        writeln!(out, "    (=> (and")?;
        writeln!(out, "          (= sp0 (get_reg regs0 reg_sp))")?;
        writeln!(out, "          (bvuge sp0 (_ bv{frame_size} 64))")?;
        writeln!(out, "          ({p1} regs0 mem0 pc0 regs1 mem1 pc1)")?;
        writeln!(out, "          ({p2} regs0 mem0 pc0 regs2 mem2 pc2)")?;
        writeln!(out, "          {diff})")?;
        writeln!(out, "        bad)))")?;
        writeln!(out)?;
    }

    writeln!(out, "; Observable memory divergence")?;
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
    writeln!(out, "          (bvuge sp0 (_ bv{frame_size} 64))")?;
    writeln!(out, "          ({p1} regs0 mem0 pc0 regs1 mem1 pc1)")?;
    writeln!(out, "          ({p2} regs0 mem0 pc0 regs2 mem2 pc2)")?;
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

    const RISCV_IR: &str = include_str!("../snapshot/rv64d.ir");
    const FOO1_ASM: &str = include_str!("../../../Examples/foo1.s");
    const FOO2_ASM: &str = include_str!("../../../Examples/foo2.s");

    #[test]
    fn emit_execute_produces_chc() {
        let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse");
        let result = emit_instruction_chc(&model, &["execute".to_string()]);
        let chc = result.expect("failed to emit CHC");
        assert!(chc.contains("set-logic HORN"));
        assert!(chc.contains("declare-rel addi"), "expected addi relation from ITYPE/RISCV_ADDI variant");
        // LOAD/STORE are specialized per width (and per sign, for LOAD).
        assert!(chc.contains("declare-rel load_4_s"), "expected specialized load_4_s (lw)");
        assert!(chc.contains("declare-rel load_8_s"), "expected specialized load_8_s (ld)");
        assert!(chc.contains("declare-rel store_4"), "expected specialized store_4 (sw)");
        assert!(chc.contains("declare-rel store_8"), "expected specialized store_8 (sd)");
        // CHC rule body uses stdlib functions
        assert!(chc.contains("get_reg"));
        assert!(chc.contains("set_reg"));
        assert!(chc.contains("sign_extend"));
        assert!(chc.contains("bvadd"));
        // Parameters are forall-bound, not raw field names
        assert!(chc.contains("(p0 "), "expected forall-bound parameter p0");
        // Raw field names may appear in `;; SKIPPED` comments (where they come
        // from the underlying error message), but must never leak into an
        // actual emitted rule.
        let leaks_merge_var = chc
            .lines()
            .filter(|l| !l.trim_start().starts_with(";;"))
            .any(|l| l.contains("merge_var"));
        assert!(!leaks_merge_var, "raw field names should not appear in CHC rules");
    }

    #[test]
    fn emit_foo_equivalence_query() {
        let mut foo1 = asm_parse::parse_asm(FOO1_ASM, "foo").expect("parse foo (before)");
        let mut foo2 = asm_parse::parse_asm(FOO2_ASM, "foo").expect("parse foo (after)");
        // The CLI auto-suffixes the two sides so the emitted rules don't collide.
        foo1.name = "foo1".to_string();
        foo2.name = "foo2".to_string();
        let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse");
        let query = emit_equivalence_query(&foo1, &foo2, "foo", Some(&model)).expect("emit query");
        println!("{}", query);

        // Check structure
        assert!(query.contains("set-logic HORN"));
        assert!(query.contains("declare-rel foo1"));
        assert!(query.contains("declare-rel foo2"));
        assert!(query.contains("declare-rel bad"));
        assert!(query.contains("obs_addr"));
        assert!(query.contains("query bad"));

        // IR-derived rules from the full rv64d.ir: addi, addiw, and the
        // specialized load/store variants needed by foo (lw/sw/ld/sd).
        assert!(query.contains("declare-rel addi"), "addi should come from IR");
        assert!(query.contains("declare-rel addiw"), "addiw should come from IR");
        assert!(query.contains("declare-rel load_4_s"), "lw should map to IR load_4_s");
        assert!(query.contains("declare-rel load_8_s"), "ld should map to IR load_8_s");
        assert!(query.contains("declare-rel store_4"), "sw should map to IR store_4");
        assert!(query.contains("declare-rel store_8"), "sd should map to IR store_8");
        // The asm-level opcode names should not appear as standalone rules —
        // they're mapped to the IR-derived rules, not emitted as fallbacks.
        assert!(!query.contains("declare-rel ld\n"));
        assert!(!query.contains("declare-rel lw\n"));
        assert!(!query.contains("declare-rel sd\n"));
        assert!(!query.contains("declare-rel sw\n"));
        // ret is still a fallback (JALR not yet handled).
        assert!(query.contains("declare-rel ret"));

        // Check frame size computation (foo1 allocates 32 bytes)
        assert!(query.contains("bv32 64"));
    }
}
