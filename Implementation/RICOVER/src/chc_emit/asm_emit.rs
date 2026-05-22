use std::collections::HashMap;
use std::fmt::Write;

use anyhow::{Result, anyhow};

use super::STATE_TYPES;
use super::ir_emit::InlinedSemantics;
use crate::asm_parse::{
    AsmFunction, AsmInstruction, BasicBlock, Operand, Terminator, build_cfg, reg_index,
};
#[cfg(test)]
use std::collections::HashSet;
#[cfg(test)]
use crate::asm_parse::{is_branch, is_unconditional_jump};

// =========================================================================
// Assembly-level CHC emission
// =========================================================================
//
// This section translates parsed assembly functions into CHC rules in
// Z3 fixedpoint (uZ / Spacer) format:
//   (declare-rel name (types...))
//   (rule (forall ((x T) ...) (=> (and ...) (name ...))))
//   (query bad)
//
// The pipeline:
//   1. IR-derived instruction rules (from emit_execute_chc, preferred)
//      + fallback hand-written rules for opcodes not yet in the IR
//   2. emit_program_rule()          -- chain instruction relations for one function
//   3. emit_equivalence_query()     -- full .smt2 file: stdlib + instructions + programs + query

/// Map an assembly opcode to the IR-derived rule name, if the IR covers it.
///
/// The IR transpiler produces rules named after Sail variants (e.g. "addi", "load").
/// Assembly opcodes may differ (e.g. "ld" maps to IR "load" when only one LOAD variant exists).
/// Returns None when the opcode has no IR coverage and needs a hand-written fallback.
#[cfg(test)]
pub(crate) fn ir_rule_for_opcode<'a>(
    asm_opcode: &str,
    ir_names: &'a HashSet<String>,
) -> Option<&'a str> {
    // Direct match: asm opcode == IR variant name (most common with full IR)
    if let Some(name) = ir_names.get(asm_opcode) {
        return Some(name.as_str());
    }

    // Per-width/sign specialized LOAD/STORE rules generated from the full IR.
    // AMO rule names already match their asm-level names (amoadd_4, amoswap_8, etc.)
    // so they go through the direct-match path above.
    let mapped = match asm_opcode {
        "lb" => "load_1_s",
        "lbu" => "load_1_u",
        "lh" => "load_2_s",
        "lhu" => "load_2_u",
        "lw" => "load_4_s",
        "lwu" => "load_4_u",
        "ld" => "load_8_s",
        "sb" => "store_1",
        "sh" => "store_2",
        "sw" => "store_4",
        "sd" => "store_8",
        "rem" => "rem_s",
        "remu" => "rem_u",
        "remw" => "remw_s",
        "remuw" => "remw_u",
        "div" => "div_s",
        "divu" => "div_u",
        "divw" => "divw_s",
        "divuw" => "divw_u",
        _ => return None,
    };
    if ir_names.contains(mapped) {
        Some(mapped)
    } else {
        None
    }
}

/// Collect the set of distinct opcodes used across assembly functions.
///
/// Branch instructions are excluded — they are handled structurally
/// (ite merge) and don't need their own CHC relation.
#[cfg(test)]
#[allow(dead_code)]
pub(crate) fn collect_needed_opcodes(progs: &[&AsmFunction]) -> HashSet<String> {
    let mut opcodes = HashSet::new();
    for prog in progs {
        for instr in &prog.instructions {
            if is_branch(&instr.opcode) || is_unconditional_jump(&instr.opcode) {
                continue;
            }
            // Use the post-translation opcode so pseudo-instructions
            // (li -> addi, zext.b -> andi) don't register as missing.
            let resolved = instruction_to_chc(instr)
                .map(|(op, _)| op)
                .unwrap_or_else(|_| instr.opcode.clone());
            opcodes.insert(resolved);
        }
    }
    opcodes
}

/// Emit a state variable binding for use in `forall`.
/// E.g. emit_state_binding("regs3", "mem3", "pc3")
fn emit_state_binding(out: &mut String, regs: &str, mem: &str, pc: &str) -> std::fmt::Result {
    write!(
        out,
        "({regs} (Array (_ BitVec 5) (_ BitVec 64))) ({mem} (Array (_ BitVec 64) (_ BitVec 8))) ({pc} (_ BitVec 64))"
    )
}

/// Convert a signed immediate value to a 20-bit bitvector literal in SMT-LIB2.
///
/// Used for `lui` which takes a 20-bit immediate (the upper 20 bits placed at [31:12]).
pub(crate) fn imm_to_bv20(val: i64) -> String {
    let unsigned = if val < 0 {
        ((1i64 << 20) + val) as u64
    } else {
        val as u64
    };
    format!("(_ bv{} 20)", unsigned)
}

/// Convert a signed immediate value to a 12-bit bitvector literal in SMT-LIB2.
///
/// Negative values are represented as two's complement:
///   -32 -> (_ bv4064 12)   (0xFE0)
///   -20 -> (_ bv4076 12)   (0xFEC)
///    24 -> (_ bv24 12)
pub(crate) fn imm_to_bv12(val: i64) -> String {
    let unsigned = if val < 0 {
        ((1i64 << 12) + val) as u64
    } else {
        val as u64
    };
    format!("(_ bv{} 12)", unsigned)
}

/// Convert a register name to its SMT-LIB2 bitvector index.
/// E.g. "sp" -> "reg_sp", "a0" -> "reg_a0", "t3" -> "(_ bv28 5)"
///
/// Uses symbolic constants for common registers (defined in stdlib) for readability,
/// falls back to literal bitvector for less common ones.
pub(crate) fn reg_to_smt(name: &str) -> Result<String> {
    let idx = reg_index(name)?;
    Ok(match name {
        "zero" => "reg_zero".to_string(),
        "ra" => "reg_ra".to_string(),
        "sp" => "reg_sp".to_string(),
        "s0" | "fp" => "reg_s0".to_string(),
        "a0" => "reg_a0".to_string(),
        _ => format!("(_ bv{} 5)", idx),
    })
}

/// IMPORTANT: Deprecated except for `ret` fallback
/// Emit hand-written CHC rules for opcodes not covered by IR-derived rules.
///
/// These are fallback definitions -- when the Isla IR covers an opcode, the
/// IR-derived rule takes precedence and the fallback is not emitted.
/// As the IR subset grows, fewer fallbacks are needed.
///
/// Each instruction is a relation with signature:
///   (declare-rel opcode (Regs_in Mem_in PC_in  Regs_out Mem_out PC_out  operands...))
///   (rule (forall (...) (=> (and constraints...) (opcode ...))))
#[cfg(test)]
#[allow(dead_code)]
pub(crate) fn emit_fallback_rules(needed: &HashSet<String>, out: &mut String) -> Result<()> {
    if needed.is_empty() {
        return Ok(());
    }
    writeln!(
        out,
        ";; Hand-written fallback rules for opcodes not yet in the IR:"
    )?;
    writeln!(out, ";; {:?}", needed)?;
    writeln!(out)?;

    for opcode in needed {
        emit_one_fallback_rule(opcode, out)?;
    }

    Ok(())
}

/// Emit a single hand-written fallback rule.
#[cfg(test)]
#[allow(dead_code)]
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and (= regs1 (set_reg regs0 rd")?;
            writeln!(
                out,
                "                               (bvadd (get_reg regs0 rs1)"
            )?;
            writeln!(
                out,
                "                                      ((_ sign_extend 52) imm))))"
            )?;
            writeln!(out, "             (= mem1 mem0)")?;
            writeln!(out, "             (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (addi regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))"
            )?;
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and")?;
            writeln!(out, "          (= regs1")?;
            writeln!(out, "             (set_reg regs0 rd")?;
            writeln!(out, "               ((_ sign_extend 32)")?;
            writeln!(out, "                 ((_ extract 31 0)")?;
            writeln!(out, "                   (bvadd (get_reg regs0 rs1)")?;
            writeln!(
                out,
                "                          ((_ sign_extend 52) imm))))))"
            )?;
            writeln!(out, "          (= mem1 mem0)")?;
            writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (addiw regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))"
            )?;
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and")?;
            writeln!(out, "          (= regs1 regs0)")?;
            writeln!(out, "          (= mem1 (write_mem_word mem0")?;
            writeln!(
                out,
                "                                  (bvadd (get_reg regs0 base)"
            )?;
            writeln!(
                out,
                "                                         ((_ sign_extend 52) imm))"
            )?;
            writeln!(
                out,
                "                                  (get_reg regs0 rs2)))"
            )?;
            writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (sw regs0 mem0 pc0 regs1 mem1 pc1 imm base rs2))))"
            )?;
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and")?;
            writeln!(out, "          (= regs1 (set_reg regs0 rd")?;
            writeln!(out, "                            (read_mem_word mem0")?;
            writeln!(
                out,
                "                                           (bvadd (get_reg regs0 base)"
            )?;
            writeln!(
                out,
                "                                                  ((_ sign_extend 52) imm)))))"
            )?;
            writeln!(out, "          (= mem1 mem0)")?;
            writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (lw regs0 mem0 pc0 regs1 mem1 pc1 imm base rd))))"
            )?;
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and")?;
            writeln!(out, "          (= regs1 regs0)")?;
            writeln!(out, "          (= mem1 (write_mem_dword mem0")?;
            writeln!(
                out,
                "                                   (bvadd (get_reg regs0 base)"
            )?;
            writeln!(
                out,
                "                                          ((_ sign_extend 52) imm))"
            )?;
            writeln!(
                out,
                "                                   (get_reg regs0 rs2)))"
            )?;
            writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (sd regs0 mem0 pc0 regs1 mem1 pc1 imm base rs2))))"
            )?;
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and")?;
            writeln!(out, "          (= regs1 (set_reg regs0 rd")?;
            writeln!(out, "                            (read_mem_dword mem0")?;
            writeln!(
                out,
                "                                            (bvadd (get_reg regs0 base)"
            )?;
            writeln!(
                out,
                "                                                   ((_ sign_extend 52) imm)))))"
            )?;
            writeln!(out, "          (= mem1 mem0)")?;
            writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (ld regs0 mem0 pc0 regs1 mem1 pc1 imm base rd))))"
            )?;
            writeln!(out)?;
        }

        "jalr" => {
            // --- JALR: rd = pc+4, pc = (rs1 + sign_extend(imm)) & ~1 ---
            writeln!(out, "(declare-rel jalr")?;
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
            writeln!(
                out,
                "           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))"
            )?;
            writeln!(out, "    (=> (and")?;
            writeln!(
                out,
                "          (= regs1 (set_reg regs0 rd (bvadd pc0 (_ bv4 64))))"
            )?;
            writeln!(out, "          (= mem1 mem0)")?;
            writeln!(out, "          (= pc1 (concat ((_ extract 63 1)")?;
            writeln!(
                out,
                "                           (bvadd (get_reg regs0 rs1) ((_ sign_extend 52) imm)))"
            )?;
            writeln!(out, "                         (_ bv0 1))))")?;
            writeln!(
                out,
                "        (jalr regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))"
            )?;
            writeln!(out)?;
        }

        "mv" => {
            // --- MV: addi rd, rs1, 0 ---
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
            writeln!(out, "    (=> (and (= regs1 (set_reg regs0 rd")?;
            writeln!(
                out,
                "                               (bvadd (get_reg regs0 rs1)"
            )?;
            writeln!(
                out,
                "                                      ((_ sign_extend 52) 0))))"
            )?;
            writeln!(out, "             (= mem1 mem0)")?;
            writeln!(out, "             (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(
                out,
                "        (addi regs0 mem0 pc0 regs1 mem1 pc1 rs1 rd))))"
            )?;
            writeln!(out)?;
        }

        "lui" => {
            // --- LUI: rd = sign_extend_64(imm[19:0] << 12) ---
            writeln!(out, "(declare-rel lui")?;
            writeln!(out, "  ({STATE_TYPES}")?;
            writeln!(out, "   {STATE_TYPES}")?;
            writeln!(out, "   (_ BitVec 20) (_ BitVec 5)))")?;
            writeln!(out)?;
            writeln!(out, "(rule")?;
            writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
            writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
            writeln!(out, "           (pc0 (_ BitVec 64))")?;
            writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
            writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
            writeln!(out, "           (pc1 (_ BitVec 64))")?;
            writeln!(out, "           (imm (_ BitVec 20)) (rd (_ BitVec 5)))")?;
            writeln!(out, "    (=> (and")?;
            writeln!(out, "          (= regs1 (set_reg regs0 rd")?;
            writeln!(out, "                     ((_ sign_extend 32) (concat imm (_ bv0 12)))))")?;
            writeln!(out, "          (= mem1 mem0)")?;
            writeln!(out, "          (= pc1 (bvadd pc0 (_ bv4 64))))")?;
            writeln!(out, "        (lui regs0 mem0 pc0 regs1 mem1 pc1 imm rd))))")?;
            writeln!(out)?;
        }

        _ => return Err(anyhow!("no fallback rule for opcode: {}", opcode)),
    }

    Ok(())
}

/// Expand a compressed (C_*) instruction to its standard-width equivalent.
///
/// Returns None for non-compressed instructions. The expansion synthesizes
/// an AsmInstruction with the standard opcode and operand layout so that
/// the regular instruction_to_chc handlers process it.
fn expand_compressed(instr: &AsmInstruction) -> Option<AsmInstruction> {
    let op = instr.opcode.as_str();
    let ops = &instr.operands;

    match op {
        // Load: same operand format as standard lw/ld
        "c.lw" | "c.lwsp" => Some(AsmInstruction {
            opcode: "lw".into(),
            operands: ops.clone(),
        }),
        "c.ld" | "c.ldsp" => Some(AsmInstruction {
            opcode: "ld".into(),
            operands: ops.clone(),
        }),
        "c.lh" => Some(AsmInstruction {
            opcode: "lh".into(),
            operands: ops.clone(),
        }),
        "c.lhu" => Some(AsmInstruction {
            opcode: "lhu".into(),
            operands: ops.clone(),
        }),
        "c.lbu" => Some(AsmInstruction {
            opcode: "lbu".into(),
            operands: ops.clone(),
        }),

        // Store: same operand format as standard sw/sd
        "c.sw" | "c.swsp" => Some(AsmInstruction {
            opcode: "sw".into(),
            operands: ops.clone(),
        }),
        "c.sd" | "c.sdsp" => Some(AsmInstruction {
            opcode: "sd".into(),
            operands: ops.clone(),
        }),
        "c.sh" => Some(AsmInstruction {
            opcode: "sh".into(),
            operands: ops.clone(),
        }),
        "c.sb" => Some(AsmInstruction {
            opcode: "sb".into(),
            operands: ops.clone(),
        }),

        // I-type: c.addi rd, imm → addi rd, rd, imm
        "c.addi" | "c.addiw" | "c.andi" => {
            let base_op = op.strip_prefix("c.").unwrap();
            Some(AsmInstruction {
                opcode: base_op.to_string(),
                operands: vec![ops[0].clone(), ops[0].clone(), ops[1].clone()],
            })
        }

        // c.li rd, imm → addi rd, zero, imm
        "c.li" => Some(AsmInstruction {
            opcode: "addi".to_string(),
            operands: vec![ops[0].clone(), Operand::Reg("zero".into()), ops[1].clone()],
        }),

        // c.lui rd, imm → lui rd, imm (not yet modeled, but expand for correctness)
        "c.lui" => Some(AsmInstruction {
            opcode: "lui".to_string(),
            operands: ops.clone(),
        }),

        // c.addi16sp sp, imm → addi sp, sp, imm
        "c.addi16sp" => {
            let imm = ops.iter().find(|o| matches!(o, Operand::Imm(_)))?.clone();
            Some(AsmInstruction {
                opcode: "addi".to_string(),
                operands: vec![Operand::Reg("sp".into()), Operand::Reg("sp".into()), imm],
            })
        }

        // c.addi4spn rd, sp, imm → addi rd, sp, imm
        "c.addi4spn" => {
            let imm = ops.iter().find(|o| matches!(o, Operand::Imm(_)))?.clone();
            Some(AsmInstruction {
                opcode: "addi".to_string(),
                operands: vec![ops[0].clone(), Operand::Reg("sp".into()), imm],
            })
        }

        // c.add rd, rs2 → add rd, rd, rs2
        "c.add" => Some(AsmInstruction {
            opcode: "add".to_string(),
            operands: vec![ops[0].clone(), ops[0].clone(), ops[1].clone()],
        }),

        // c.mv rd, rs2 → add rd, zero, rs2
        "c.mv" => Some(AsmInstruction {
            opcode: "add".to_string(),
            operands: vec![ops[0].clone(), Operand::Reg("zero".into()), ops[1].clone()],
        }),

        // R-type: c.sub/c.xor/c.or/c.and/c.addw/c.subw rd, rs2 → base rd, rd, rs2
        "c.sub" | "c.xor" | "c.or" | "c.and" | "c.addw" | "c.subw" => {
            let base_op = op.strip_prefix("c.").unwrap();
            Some(AsmInstruction {
                opcode: base_op.to_string(),
                operands: vec![ops[0].clone(), ops[0].clone(), ops[1].clone()],
            })
        }

        // Shift: c.slli/c.srli/c.srai rd, shamt → base rd, rd, shamt
        "c.slli" | "c.srli" | "c.srai" => {
            let base_op = op.strip_prefix("c.").unwrap();
            Some(AsmInstruction {
                opcode: base_op.to_string(),
                operands: vec![ops[0].clone(), ops[0].clone(), ops[1].clone()],
            })
        }

        _ => None,
    }
}

/// Normalize an AMO opcode: strip ordering suffixes and extract byte width.
///
/// "amoadd.w.aqrl" → Some(("amoadd", "4"))
/// "amoswap.d"     → Some(("amoswap", "8"))
fn normalize_amo_opcode(op: &str) -> Option<(String, &'static str)> {
    let rest = op.strip_prefix("amo")?;
    let mut parts = rest.split('.');
    let operation = parts.next()?;
    let width_str = parts.next()?;
    let width = match width_str {
        "w" => "4",
        "d" => "8",
        _ => return None,
    };
    Some((format!("amo{}", operation), width))
}

/// Translate a single assembly instruction into its CHC relation call arguments.
///
/// Returns (opcode, instruction-specific SMT operands).
/// The caller provides state variable names (regsN, memN, pcN).
///
/// Operand mapping by instruction class:
///   addi/addiw rd, rs1, imm   -> (opcode ... imm_bv rs1_bv rd_bv)
///   sw/sd      rs2, off(base) -> (opcode ... off_bv base_bv rs2_bv)
///   lw/ld      rd, off(base)  -> (opcode ... off_bv base_bv rd_bv)
///   ret                       -> (ret    ...)
pub(crate) fn instruction_to_chc(instr: &AsmInstruction) -> Result<(String, Vec<String>)> {
    // Expand compressed instructions to standard equivalents first
    if let Some(expanded) = expand_compressed(instr) {
        return instruction_to_chc(&expanded);
    }

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
        "add" | "sub" | "and" | "or" | "xor" | "slt" | "sltu" | "sll" | "srl" | "sra" | "addw"
        | "subw" | "sllw" | "srlw" | "sraw"
        | "mul" | "mulh" | "mulhsu" | "mulhu" | "mulw"
        | "rem" | "remu" | "remw" | "remuw" | "div" | "divu" | "divw" | "divuw" => {
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

        // U-type: lui rd, imm -- rd = sign_extend_64(imm[19:0] << 12)
        "lui" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("lui: expected register for rd")),
            };
            let imm = match &instr.operands[1] {
                Operand::Imm(n) => imm_to_bv20(*n),
                _ => return Err(anyhow!("lui: expected immediate")),
            };
            Ok(("lui".to_string(), vec![imm, rd]))
        }

        // Pseudo: snez rd, rs -- sltu rd, zero, rs (rd = (rs != 0) ? 1 : 0)
        "snez" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("snez: expected register for rd")),
            };
            let rs = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("snez: expected register for rs")),
            };
            // sltu operand order: (rs2, rs1, rd)
            Ok(("sltu".to_string(), vec![rs, "reg_zero".to_string(), rd]))
        }

        // Pseudo: li rd, imm -- when imm fits in a signed 12-bit range,
        // GAS expands to addi rd, zero, imm. Wider immediates expand to
        // lui+addi, which we don't model yet.
        "li" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("li: expected register for rd")),
            };
            let imm = match &instr.operands[1] {
                Operand::Imm(n) if (-2048..2048).contains(n) => imm_to_bv12(*n),
                Operand::Imm(n) => {
                    return Err(anyhow!("li: immediate {} doesn't fit in 12 bits", n));
                }
                _ => return Err(anyhow!("li: expected immediate")),
            };
            Ok(("addi".to_string(), vec![imm, "reg_zero".to_string(), rd]))
        }

        // Pseudo (Zbb): zext.b rd, rs1 -- andi rd, rs1, 0xff
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

        // ret = jalr x0, 0(ra)
        "ret" => Ok((
            "jalr".to_string(),
            vec![
                "(_ bv0 12)".to_string(),
                "reg_ra".to_string(),
                "reg_zero".to_string(),
            ],
        )),

        // mv = addi rd, rs1, 0
        "mv" => {
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("mv: expected register for rd")),
            };
            let rs1 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("mv: expected register for rs1")),
            };
            Ok(("addi".to_string(), vec![imm_to_bv12(0), rs1, rd]))
        }

        // AMO: amoadd.w rd, rs2, (rs1) → amoadd_4 rs2 rs1 rd
        _ if op.starts_with("amo") => {
            let (base_op, width) = normalize_amo_opcode(op)
                .ok_or_else(|| anyhow!("{}: cannot parse AMO opcode", op))?;
            let rd = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rd", op)),
            };
            let rs2 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs2", op)),
            };
            let rs1 = match &instr.operands[2] {
                Operand::MemRef { offset: _, base } => reg_to_smt(base)?,
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected memref or register for rs1", op)),
            };
            Ok((format!("{}_{}", base_op, width), vec![rs2, rs1, rd]))
        }

        _ => Err(anyhow!("unsupported instruction: {}", op)),
    }
}

// =========================================================================
// Branch handling
// =========================================================================

/// Build the SMT-LIB2 condition expression for a branch instruction.
///
/// The condition is true when the branch is **taken** (i.e. jump to target).
/// State variables are read from the state at `state_idx`.
fn branch_condition(instr: &AsmInstruction, state_idx: usize) -> Result<String> {
    let op = instr.opcode.as_str();
    let s = state_idx;

    // Expand pseudo-branches to their base form with explicit zero operand
    let (cmp_op, rs1_smt, rs2_smt) = match op {
        // B-type: op rs1, rs2, label
        "beq" | "bne" | "blt" | "bge" | "bltu" | "bgeu" => {
            let rs1 = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs1", op)),
            };
            let rs2 = match &instr.operands[1] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("{}: expected register for rs2", op)),
            };
            (op, rs1, rs2)
        }
        // Pseudo: beqz rs, label → beq rs, zero
        "beqz" => {
            let rs = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("beqz: expected register")),
            };
            ("beq", rs, "reg_zero".to_string())
        }
        "bnez" => {
            let rs = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("bnez: expected register")),
            };
            ("bne", rs, "reg_zero".to_string())
        }
        // bltz rs → blt rs, zero
        "bltz" => {
            let rs = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("bltz: expected register")),
            };
            ("blt", rs, "reg_zero".to_string())
        }
        // bgez rs → bge rs, zero
        "bgez" => {
            let rs = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("bgez: expected register")),
            };
            ("bge", rs, "reg_zero".to_string())
        }
        // blez rs → bge zero, rs
        "blez" => {
            let rs = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("blez: expected register")),
            };
            ("bge", "reg_zero".to_string(), rs)
        }
        // bgtz rs → blt zero, rs
        "bgtz" => {
            let rs = match &instr.operands[0] {
                Operand::Reg(r) => reg_to_smt(r)?,
                _ => return Err(anyhow!("bgtz: expected register")),
            };
            ("blt", "reg_zero".to_string(), rs)
        }
        _ => return Err(anyhow!("{}: not a branch instruction", op)),
    };

    let r1 = format!("(get_reg regs{s} {rs1_smt})");
    let r2 = format!("(get_reg regs{s} {rs2_smt})");

    Ok(match cmp_op {
        "beq" => format!("(= {} {})", r1, r2),
        "bne" => format!("(not (= {} {}))", r1, r2),
        "blt" => format!("(bvslt {} {})", r1, r2),
        "bge" => format!("(bvsge {} {})", r1, r2),
        "bltu" => format!("(bvult {} {})", r1, r2),
        "bgeu" => format!("(bvuge {} {})", r1, r2),
        _ => unreachable!(),
    })
}

// =========================================================================
// Per-block CHC emission
// =========================================================================

/// Emit the body rule for a single basic block.
///
/// Declares `<func_name>_bb<N>` and emits a rule chaining its data
/// instructions with state threading.
#[cfg(test)]
fn emit_block_body_rule(
    func_name: &str,
    block: &BasicBlock,
    func: &AsmFunction,
    ir_names: &HashSet<String>,
    out: &mut String,
) -> Result<()> {
    let bb_name = format!("{}_bb{}", func_name, block.id);
    let n_instrs = block.instr_range.len();

    writeln!(out, "(declare-rel {bb_name}")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}))")?;
    writeln!(out)?;

    writeln!(out, "(rule")?;
    write!(out, "  (forall (")?;
    for i in 0..=n_instrs {
        if i > 0 {
            write!(out, "\n           ")?;
        }
        emit_state_binding(
            out,
            &format!("regs{i}"),
            &format!("mem{i}"),
            &format!("pc{i}"),
        )?;
    }
    writeln!(out, ")")?;

    writeln!(out, "    (=> (and")?;

    if n_instrs == 0 {
        writeln!(out, "          (= regs0 regs0) ; empty block")?;
    } else {
        for (local_idx, global_idx) in block.instr_range.clone().enumerate() {
            let instr = &func.instructions[global_idx];
            let (opcode, operands) = instruction_to_chc(instr)?;
            let rule_name = ir_rule_for_opcode(&opcode, ir_names)
                .map(|s| s.to_string())
                .unwrap_or(opcode);
            let si = local_idx;
            let so = local_idx + 1;
            let state_args = format!("regs{si} mem{si} pc{si} regs{so} mem{so} pc{so}");

            writeln!(out, "          ; {}", format_asm_instr(instr))?;
            if operands.is_empty() {
                writeln!(out, "          ({rule_name} {state_args})")?;
            } else {
                writeln!(
                    out,
                    "          ({rule_name} {state_args} {})",
                    operands.join(" ")
                )?;
            }
        }
    }

    writeln!(out, "        )")?;
    writeln!(
        out,
        "        ({bb_name} regs0 mem0 pc0 regs{n_instrs} mem{n_instrs} pc{n_instrs}))))"
    )?;
    writeln!(out)?;

    Ok(())
}

/// Emit "from block to exit" composition rules for every block in the CFG.
///
/// - Exit block: `from_bbN(in, out) :- bbN(in, out)`
/// - Fallthrough: `from_bbN(in, out) :- bbN(in, mid) ∧ from_bbM(mid, out)`
/// - Branch: two rules — taken and fallthrough path — with the branch
///   condition as guard
///
/// The entry block (bb0) uses `func_name` as its relation name instead of
/// `func_name_from_bb0`.
fn emit_composition_rules(
    func_name: &str,
    cfg: &[BasicBlock],
    func: &AsmFunction,
    out: &mut String,
) -> Result<()> {
    // Declare all composition relations up front (Z3 requires declare-rel
    // before first use, so forward references must be pre-declared).
    for block in cfg {
        let from_name = if block.id == 0 {
            func_name.to_string()
        } else {
            format!("{}_from_bb{}", func_name, block.id)
        };
        writeln!(out, "(declare-rel {from_name}")?;
        writeln!(out, "  ({STATE_TYPES}")?;
        writeln!(out, "   {STATE_TYPES}))")?;
    }
    writeln!(out)?;

    // Emit rules
    for block in cfg {
        let from_name = if block.id == 0 {
            func_name.to_string()
        } else {
            format!("{}_from_bb{}", func_name, block.id)
        };
        let bb_name = format!("{}_bb{}", func_name, block.id);

        match &block.terminator {
            Terminator::Exit => {
                writeln!(out, "(rule")?;
                writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc0 (_ BitVec 64))")?;
                writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc1 (_ BitVec 64)))")?;
                writeln!(out, "    (=> ({bb_name} regs0 mem0 pc0 regs1 mem1 pc1)")?;
                writeln!(out, "        ({from_name} regs0 mem0 pc0 regs1 mem1 pc1))))")?;
            }

            Terminator::Fallthrough(next_id) => {
                let next_from = if *next_id == 0 {
                    func_name.to_string()
                } else {
                    format!("{}_from_bb{}", func_name, next_id)
                };

                writeln!(out, "(rule")?;
                writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc0 (_ BitVec 64))")?;
                writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc1 (_ BitVec 64))")?;
                writeln!(out, "           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem2 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc2 (_ BitVec 64)))")?;
                writeln!(out, "    (=> (and ({bb_name} regs0 mem0 pc0 regs1 mem1 pc1)")?;
                writeln!(out, "             ({next_from} regs1 mem1 pc1 regs2 mem2 pc2))")?;
                writeln!(out, "        ({from_name} regs0 mem0 pc0 regs2 mem2 pc2))))")?;
            }

            Terminator::Branch {
                branch_instr_idx,
                taken_block,
                fallthrough_block,
            } => {
                let taken_from = if *taken_block == 0 {
                    func_name.to_string()
                } else {
                    format!("{}_from_bb{}", func_name, taken_block)
                };
                let fall_from = if *fallthrough_block == 0 {
                    func_name.to_string()
                } else {
                    format!("{}_from_bb{}", func_name, fallthrough_block)
                };

                let branch_instr = &func.instructions[*branch_instr_idx];
                // The branch condition reads from the block's output state (regs1),
                // which is the state after the block body executes.
                let cond = branch_condition(branch_instr, 1)?;

                // Taken path
                writeln!(out, "; taken: {} → bb{}", format_asm_instr(branch_instr), taken_block)?;
                writeln!(out, "(rule")?;
                writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc0 (_ BitVec 64))")?;
                writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc1 (_ BitVec 64))")?;
                writeln!(out, "           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem2 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc2 (_ BitVec 64)))")?;
                writeln!(out, "    (=> (and ({bb_name} regs0 mem0 pc0 regs1 mem1 pc1)")?;
                writeln!(out, "             {cond}")?;
                writeln!(out, "             ({taken_from} regs1 mem1 pc1 regs2 mem2 pc2))")?;
                writeln!(out, "        ({from_name} regs0 mem0 pc0 regs2 mem2 pc2))))")?;
                writeln!(out)?;

                // Fallthrough path
                writeln!(out, "; not-taken: fallthrough → bb{}", fallthrough_block)?;
                writeln!(out, "(rule")?;
                writeln!(out, "  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc0 (_ BitVec 64))")?;
                writeln!(out, "           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc1 (_ BitVec 64))")?;
                writeln!(out, "           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))")?;
                writeln!(out, "           (mem2 (Array (_ BitVec 64) (_ BitVec 8)))")?;
                writeln!(out, "           (pc2 (_ BitVec 64)))")?;
                writeln!(out, "    (=> (and ({bb_name} regs0 mem0 pc0 regs1 mem1 pc1)")?;
                writeln!(out, "             (not {cond})")?;
                writeln!(out, "             ({fall_from} regs1 mem1 pc1 regs2 mem2 pc2))")?;
                writeln!(out, "        ({from_name} regs0 mem0 pc0 regs2 mem2 pc2))))")?;
            }
        }
        writeln!(out)?;
    }

    Ok(())
}

/// Emit CHC rules for a complete assembly function using per-block encoding.
///
/// Each basic block gets a body relation `<name>_bb<N>` chaining its data
/// instructions, then composition rules connect blocks from entry to exit.
/// The function summary `<name>(state_in, state_out)` is the entry block's
/// "from here to exit" relation.
#[cfg(test)]
pub(crate) fn emit_program_rule(
    func: &AsmFunction,
    ir_names: &HashSet<String>,
    out: &mut String,
) -> Result<()> {
    let cfg = build_cfg(func)?;

    writeln!(out, ";; ── {} ({} blocks) ──", func.name, cfg.len())?;
    writeln!(out)?;

    // Block body rules
    for block in &cfg {
        emit_block_body_rule(&func.name, block, func, ir_names, out)?;
    }

    // Composition rules (includes function summary declaration)
    emit_composition_rules(&func.name, &cfg, func, out)?;

    Ok(())
}

// =========================================================================
// Inlined emission (no per-instruction CHC relations)
// =========================================================================

/// Look up the InlinedSemantics for an assembly opcode.
///
/// Checks the semantics map (IR-derived) first, using the same opcode→rule
/// name mapping as ir_rule_for_opcode. Returns None if not found.
fn lookup_semantics<'a>(
    asm_opcode: &str,
    semantics: &'a HashMap<String, InlinedSemantics>,
) -> Option<&'a InlinedSemantics> {
    if let Some(sem) = semantics.get(asm_opcode) {
        return Some(sem);
    }
    let mapped = match asm_opcode {
        "lb" => "load_1_s",
        "lbu" => "load_1_u",
        "lh" => "load_2_s",
        "lhu" => "load_2_u",
        "lw" => "load_4_s",
        "lwu" => "load_4_u",
        "ld" => "load_8_s",
        "sb" => "store_1",
        "sh" => "store_2",
        "sw" => "store_4",
        "sd" => "store_8",
        "rem" => "rem_s",
        "remu" => "rem_u",
        "remw" => "remw_s",
        "remuw" => "remw_u",
        "div" => "div_s",
        "divu" => "div_u",
        "divw" => "divw_s",
        "divuw" => "divw_u",
        _ => return None,
    };
    semantics.get(mapped)
}

/// Emit the body rule for a single basic block with inlined instruction semantics.
///
/// Instead of emitting relation calls like `(addi regs0 mem0 pc0 regs1 mem1 pc1 ...)`,
/// this inlines three equality constraints per instruction directly:
///   `(= regs1 (set_reg regs0 ...))  (= mem1 mem0)  (= pc1 (bvadd pc0 (_ bv4 64)))`
fn emit_block_body_rule_inlined(
    func_name: &str,
    block: &BasicBlock,
    func: &AsmFunction,
    semantics: &HashMap<String, InlinedSemantics>,
    out: &mut String,
) -> Result<()> {
    let bb_name = format!("{}_bb{}", func_name, block.id);
    let n_instrs = block.instr_range.len();

    writeln!(out, "(declare-rel {bb_name}")?;
    writeln!(out, "  ({STATE_TYPES}")?;
    writeln!(out, "   {STATE_TYPES}))")?;
    writeln!(out)?;

    writeln!(out, "(rule")?;
    write!(out, "  (forall (")?;
    for i in 0..=n_instrs {
        if i > 0 {
            write!(out, "\n           ")?;
        }
        emit_state_binding(
            out,
            &format!("regs{i}"),
            &format!("mem{i}"),
            &format!("pc{i}"),
        )?;
    }
    writeln!(out, ")")?;

    writeln!(out, "    (=> (and")?;

    if n_instrs == 0 {
        writeln!(out, "          (= regs0 regs0) ; empty block")?;
    } else {
        for (local_idx, global_idx) in block.instr_range.clone().enumerate() {
            let instr = &func.instructions[global_idx];
            let (opcode, operands) = instruction_to_chc(instr)?;

            let sem = lookup_semantics(&opcode, semantics)
                .ok_or_else(|| anyhow!(
                    "no inlined semantics for opcode '{}' (from '{}')",
                    opcode, instr.opcode
                ))?;

            let si = local_idx;
            let so = local_idx + 1;
            let constraints = sem.instantiate(&operands, si, so);

            writeln!(out, "          ; {}", format_asm_instr(instr))?;
            for c in &constraints {
                writeln!(out, "          {}", c)?;
            }
        }
    }

    writeln!(out, "        )")?;
    writeln!(
        out,
        "        ({bb_name} regs0 mem0 pc0 regs{n_instrs} mem{n_instrs} pc{n_instrs}))))"
    )?;
    writeln!(out)?;

    Ok(())
}

/// Emit CHC rules for a complete assembly function with inlined instruction semantics.
///
/// Same block/composition structure as `emit_program_rule`, but instruction
/// semantics are inlined as equality constraints instead of relation calls.
pub(crate) fn emit_program_rule_inlined(
    func: &AsmFunction,
    semantics: &HashMap<String, InlinedSemantics>,
    out: &mut String,
) -> Result<()> {
    let cfg = build_cfg(func)?;

    writeln!(out, ";; ── {} ({} blocks) ──", func.name, cfg.len())?;
    writeln!(out)?;

    for block in &cfg {
        emit_block_body_rule_inlined(&func.name, block, func, semantics, out)?;
    }

    emit_composition_rules(&func.name, &cfg, func, out)?;

    Ok(())
}

/// Format an assembly instruction as a human-readable string (for comments).
fn format_asm_instr(instr: &AsmInstruction) -> String {
    if instr.operands.is_empty() {
        return instr.opcode.clone();
    }
    let ops: Vec<String> = instr
        .operands
        .iter()
        .map(|op| match op {
            Operand::Reg(r) => r.clone(),
            Operand::Imm(n) => n.to_string(),
            Operand::MemRef { offset, base } => format!("{}({})", offset, base),
            Operand::Label(l) => l.clone(),
        })
        .collect();
    format!("{} {}", instr.opcode, ops.join(", "))
}

/// Compute the stack frame size for a function.
///
/// Convention: the first instruction of a stack-allocating function is `addi sp, sp, -N`.
/// Returns N (positive), or 0 if the function doesn't allocate a stack frame.
pub(crate) fn compute_frame_size(func: &AsmFunction) -> u64 {
    if let Some(first) = func.instructions.first() {
        if first.opcode == "addi" {
            if let [Operand::Reg(rd), Operand::Reg(rs1), Operand::Imm(imm)] =
                first.operands.as_slice()
            {
                if rd == "sp" && rs1 == "sp" && *imm < 0 {
                    return (-imm) as u64;
                }
            }
        }
    }
    0
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::asm_parse::{AsmFunction, AsmInstruction, Operand, branch_target};

    #[test]
    fn test_imm_to_bv12() {
        assert_eq!(imm_to_bv12(-32), "(_ bv4064 12)");
        assert_eq!(imm_to_bv12(0), "(_ bv0 12)");
        assert_eq!(imm_to_bv12(24), "(_ bv24 12)");
        assert_eq!(imm_to_bv12(-2048), "(_ bv2048 12)");
        assert_eq!(imm_to_bv12(2047), "(_ bv2047 12)");
    }

    #[test]
    fn test_reg_to_smt() {
        assert_eq!(reg_to_smt("zero").unwrap(), "reg_zero");
        assert_eq!(reg_to_smt("ra").unwrap(), "reg_ra");
        assert_eq!(reg_to_smt("sp").unwrap(), "reg_sp");
        assert_eq!(reg_to_smt("s0").unwrap(), "reg_s0");
        assert_eq!(reg_to_smt("a0").unwrap(), "reg_a0");
        assert_eq!(reg_to_smt("t3").unwrap(), "(_ bv28 5)");
    }

    #[test]
    fn test_compute_frame_size() {
        // Function with `addi sp, sp, -32`
        let func_with_frame = AsmFunction {
            name: "test".to_string(),
            instructions: vec![AsmInstruction {
                opcode: "addi".to_string(),
                operands: vec![
                    Operand::Reg("sp".to_string()),
                    Operand::Reg("sp".to_string()),
                    Operand::Imm(-32),
                ],
            }],
            labels: Default::default(),
        };
        assert_eq!(compute_frame_size(&func_with_frame), 32);

        // Function without stack frame allocation
        let func_no_frame = AsmFunction {
            name: "test".to_string(),
            instructions: vec![AsmInstruction {
                opcode: "li".to_string(),
                operands: vec![Operand::Reg("a0".to_string()), Operand::Imm(42)],
            }],
            labels: Default::default(),
        };
        assert_eq!(compute_frame_size(&func_no_frame), 0);
    }

    #[test]
    fn test_ir_rule_for_opcode() {
        let mut ir_names = HashSet::new();
        ir_names.insert("addi".to_string());
        ir_names.insert("load_4_s".to_string());
        ir_names.insert("amoadd_4".to_string());

        // Direct match
        assert_eq!(ir_rule_for_opcode("addi", &ir_names), Some("addi"));

        // Mapped opcode: lw -> load_4_s
        assert_eq!(ir_rule_for_opcode("lw", &ir_names), Some("load_4_s"));

        // AMO: direct match after normalization in instruction_to_chc
        assert_eq!(ir_rule_for_opcode("amoadd_4", &ir_names), Some("amoadd_4"));

        // No match
        assert_eq!(ir_rule_for_opcode("unknown_op", &ir_names), None);
    }

    #[test]
    fn test_compressed_itype_expansion() {
        // c.addi a0, 3 → addi a0, a0, 3
        let instr = AsmInstruction {
            opcode: "c.addi".into(),
            operands: vec![Operand::Reg("a0".into()), Operand::Imm(3)],
        };
        let (op, args) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "addi");
        assert_eq!(
            args,
            vec![imm_to_bv12(3), "reg_a0".to_string(), "reg_a0".to_string()]
        );

        // c.li a1, 5 → addi a1, zero, 5
        let instr = AsmInstruction {
            opcode: "c.li".into(),
            operands: vec![Operand::Reg("a1".into()), Operand::Imm(5)],
        };
        let (op, args) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "addi");
        assert_eq!(args[1], "reg_zero");

        // c.addiw a0, -1 → addiw a0, a0, -1
        let instr = AsmInstruction {
            opcode: "c.addiw".into(),
            operands: vec![Operand::Reg("a0".into()), Operand::Imm(-1)],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "addiw");

        // c.andi a2, 0xf → andi a2, a2, 0xf
        let instr = AsmInstruction {
            opcode: "c.andi".into(),
            operands: vec![Operand::Reg("a2".into()), Operand::Imm(0xf)],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "andi");
    }

    #[test]
    fn test_compressed_load_store_expansion() {
        // c.lw a0, 0(a1) → lw a0, 0(a1)
        let instr = AsmInstruction {
            opcode: "c.lw".into(),
            operands: vec![
                Operand::Reg("a0".into()),
                Operand::MemRef {
                    offset: 4,
                    base: "a1".into(),
                },
            ],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "lw");

        // c.sdsp a0, 8(sp) → sd a0, 8(sp)
        let instr = AsmInstruction {
            opcode: "c.sdsp".into(),
            operands: vec![
                Operand::Reg("a0".into()),
                Operand::MemRef {
                    offset: 8,
                    base: "sp".into(),
                },
            ],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "sd");
    }

    #[test]
    fn test_compressed_rtype_expansion() {
        // c.add a0, a1 → add a0, a0, a1
        let instr = AsmInstruction {
            opcode: "c.add".into(),
            operands: vec![Operand::Reg("a0".into()), Operand::Reg("a1".into())],
        };
        let (op, args) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "add");
        // R-type: (rs2, rs1, rd) → a1, a0, a0
        assert_eq!(args[0], reg_to_smt("a1").unwrap()); // rs2
        assert_eq!(args[1], "reg_a0"); // rs1 = rd
        assert_eq!(args[2], "reg_a0"); // rd

        // c.mv a1, a0 → add a1, zero, a0
        let instr = AsmInstruction {
            opcode: "c.mv".into(),
            operands: vec![Operand::Reg("a1".into()), Operand::Reg("a0".into())],
        };
        let (op, args) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "add");
        assert_eq!(args[1], "reg_zero"); // rs1 = zero

        // c.sub a0, a1 → sub a0, a0, a1
        let instr = AsmInstruction {
            opcode: "c.sub".into(),
            operands: vec![Operand::Reg("a0".into()), Operand::Reg("a1".into())],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "sub");
    }

    #[test]
    fn test_compressed_shift_expansion() {
        // c.slli a0, 3 → slli a0, a0, 3
        let instr = AsmInstruction {
            opcode: "c.slli".into(),
            operands: vec![Operand::Reg("a0".into()), Operand::Imm(3)],
        };
        let (op, args) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "slli");
        assert_eq!(args[0], "(_ bv3 6)"); // shamt as bv6
        assert_eq!(args[1], "reg_a0"); // rs1 = rd
        assert_eq!(args[2], "reg_a0"); // rd
    }

    #[test]
    fn test_amo_instruction_to_chc() {
        // amoadd.w a0, a1, (a2) → amoadd_4 rs2=a1 rs1=a2 rd=a0
        let instr = AsmInstruction {
            opcode: "amoadd.w".into(),
            operands: vec![
                Operand::Reg("a0".into()),
                Operand::Reg("a1".into()),
                Operand::MemRef {
                    offset: 0,
                    base: "a2".into(),
                },
            ],
        };
        let (op, args) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "amoadd_4");
        assert_eq!(args.len(), 3);

        // amoswap.d.aqrl a3, a4, (a5) → amoswap_8
        let instr = AsmInstruction {
            opcode: "amoswap.d.aqrl".into(),
            operands: vec![
                Operand::Reg("a3".into()),
                Operand::Reg("a4".into()),
                Operand::MemRef {
                    offset: 0,
                    base: "a5".into(),
                },
            ],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "amoswap_8");
    }

    #[test]
    fn test_is_branch() {
        assert!(is_branch("blt"));
        assert!(is_branch("bge"));
        assert!(is_branch("beq"));
        assert!(is_branch("bne"));
        assert!(is_branch("bltu"));
        assert!(is_branch("bgeu"));
        assert!(is_branch("beqz"));
        assert!(is_branch("bnez"));
        assert!(!is_branch("addi"));
        assert!(!is_branch("ret"));
        assert!(!is_branch("lw"));
    }

    #[test]
    fn test_branch_condition_blt() {
        let instr = AsmInstruction {
            opcode: "blt".into(),
            operands: vec![
                Operand::Reg("a3".into()),
                Operand::Reg("a4".into()),
                Operand::Label(".LBB0_2".into()),
            ],
        };
        let cond = branch_condition(&instr, 2).unwrap();
        assert!(cond.contains("bvslt"));
        assert!(cond.contains("regs2"));
    }

    #[test]
    fn test_branch_condition_beq() {
        let instr = AsmInstruction {
            opcode: "beq".into(),
            operands: vec![
                Operand::Reg("a0".into()),
                Operand::Reg("a1".into()),
                Operand::Label(".L1".into()),
            ],
        };
        let cond = branch_condition(&instr, 0).unwrap();
        assert!(cond.starts_with("(= "));
    }

    #[test]
    fn test_branch_condition_bnez() {
        let instr = AsmInstruction {
            opcode: "bnez".into(),
            operands: vec![
                Operand::Reg("a0".into()),
                Operand::Label(".L1".into()),
            ],
        };
        let cond = branch_condition(&instr, 0).unwrap();
        assert!(cond.contains("not"));
        assert!(cond.contains("reg_zero"));
    }

    #[test]
    fn test_branch_target() {
        let instr = AsmInstruction {
            opcode: "blt".into(),
            operands: vec![
                Operand::Reg("a3".into()),
                Operand::Reg("a4".into()),
                Operand::Label(".LBB0_2".into()),
            ],
        };
        assert_eq!(branch_target(&instr).unwrap(), ".LBB0_2");
    }

    #[test]
    fn test_emit_program_rule_with_branch() {
        use std::collections::HashMap;

        let func = AsmFunction {
            name: "test_br".to_string(),
            instructions: vec![
                AsmInstruction {
                    opcode: "addi".into(),
                    operands: vec![
                        Operand::Reg("a0".into()),
                        Operand::Reg("zero".into()),
                        Operand::Imm(1),
                    ],
                },
                AsmInstruction {
                    opcode: "blt".into(),
                    operands: vec![
                        Operand::Reg("a0".into()),
                        Operand::Reg("a1".into()),
                        Operand::Label(".L1".into()),
                    ],
                },
                AsmInstruction {
                    opcode: "addi".into(),
                    operands: vec![
                        Operand::Reg("a0".into()),
                        Operand::Reg("zero".into()),
                        Operand::Imm(2),
                    ],
                },
                // .L1:
                AsmInstruction {
                    opcode: "ret".into(),
                    operands: vec![],
                },
            ],
            labels: HashMap::from([(".L1".to_string(), 3)]),
        };
        let ir_names = HashSet::new();
        let mut out = String::new();
        emit_program_rule(&func, &ir_names, &mut out).unwrap();

        // Per-block encoding: block body relations + composition
        assert!(out.contains("declare-rel test_br_bb0"));
        assert!(out.contains("declare-rel test_br_bb1"));
        assert!(out.contains("declare-rel test_br_bb2"));
        assert!(out.contains("declare-rel test_br\n"), "function summary relation");
        assert!(out.contains("declare-rel test_br_from_bb1"));
        assert!(out.contains("declare-rel test_br_from_bb2"));
        // Branch condition on taken path
        assert!(out.contains("bvslt"));
        // No ite — per-block encoding uses separate rules
        assert!(!out.contains("ite"));
    }
}
