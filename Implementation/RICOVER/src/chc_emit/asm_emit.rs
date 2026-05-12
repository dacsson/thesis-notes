use std::collections::HashSet;
use std::fmt::Write;

use anyhow::{Result, anyhow};

use super::STATE_TYPES;
use crate::asm_parse::{AsmFunction, AsmInstruction, Operand, reg_index};

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
        _ => return None,
    };
    if ir_names.contains(mapped) {
        Some(mapped)
    } else {
        None
    }
}

/// Collect the set of distinct opcodes used across assembly functions.
pub(crate) fn collect_needed_opcodes(progs: &[&AsmFunction]) -> HashSet<String> {
    let mut opcodes = HashSet::new();
    for prog in progs {
        for instr in &prog.instructions {
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
        "c.lw" | "c.lwsp" => Some(AsmInstruction { opcode: "lw".into(), operands: ops.clone() }),
        "c.ld" | "c.ldsp" => Some(AsmInstruction { opcode: "ld".into(), operands: ops.clone() }),
        "c.lh" => Some(AsmInstruction { opcode: "lh".into(), operands: ops.clone() }),
        "c.lhu" => Some(AsmInstruction { opcode: "lhu".into(), operands: ops.clone() }),
        "c.lbu" => Some(AsmInstruction { opcode: "lbu".into(), operands: ops.clone() }),

        // Store: same operand format as standard sw/sd
        "c.sw" | "c.swsp" => Some(AsmInstruction { opcode: "sw".into(), operands: ops.clone() }),
        "c.sd" | "c.sdsp" => Some(AsmInstruction { opcode: "sd".into(), operands: ops.clone() }),
        "c.sh" => Some(AsmInstruction { opcode: "sh".into(), operands: ops.clone() }),
        "c.sb" => Some(AsmInstruction { opcode: "sb".into(), operands: ops.clone() }),

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
        "add" | "sub" | "and" | "or" | "xor" | "slt" | "sltu" | "sll" | "srl" | "sra"
        | "addw" | "subw" | "sllw" | "srlw" | "sraw" => {
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

        // Return pseudo-instruction
        "ret" => Ok(("ret".to_string(), vec![])),

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
pub(crate) fn emit_program_rule(
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
        emit_state_binding(
            out,
            &format!("regs{i}"),
            &format!("mem{i}"),
            &format!("pc{i}"),
        )?;
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
        let state_args = format!(
            "regs{i} mem{i} pc{i} regs{} mem{} pc{}",
            i + 1,
            i + 1,
            i + 1
        );
        // Comment with original assembly for readability
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

    // Close (and ...) and emit the head
    writeln!(out, "        )")?;
    writeln!(
        out,
        "        ({} regs0 mem0 pc0 regs{n} mem{n} pc{n}))))",
        func.name
    )?;
    writeln!(out)?;

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
    use crate::asm_parse::{AsmFunction, AsmInstruction, Operand};

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
        };
        assert_eq!(compute_frame_size(&func_with_frame), 32);

        // Function without stack frame allocation
        let func_no_frame = AsmFunction {
            name: "test".to_string(),
            instructions: vec![AsmInstruction {
                opcode: "li".to_string(),
                operands: vec![Operand::Reg("a0".to_string()), Operand::Imm(42)],
            }],
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
        assert_eq!(args, vec![imm_to_bv12(3), "reg_a0".to_string(), "reg_a0".to_string()]);

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
                Operand::MemRef { offset: 4, base: "a1".into() },
            ],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "lw");

        // c.sdsp a0, 8(sp) → sd a0, 8(sp)
        let instr = AsmInstruction {
            opcode: "c.sdsp".into(),
            operands: vec![
                Operand::Reg("a0".into()),
                Operand::MemRef { offset: 8, base: "sp".into() },
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
                Operand::MemRef { offset: 0, base: "a2".into() },
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
                Operand::MemRef { offset: 0, base: "a5".into() },
            ],
        };
        let (op, _) = instruction_to_chc(&instr).unwrap();
        assert_eq!(op, "amoswap_8");
    }
}
