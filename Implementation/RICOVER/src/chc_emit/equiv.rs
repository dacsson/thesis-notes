use std::collections::HashSet;
use std::fmt::Write;

use anyhow::Result;

use crate::asm_parse::AsmFunction;
use crate::isla_ir::IslaIRModel;
use super::ir_emit::emit_execute_chc;
use super::asm_emit::{collect_needed_opcodes, ir_rule_for_opcode, emit_fallback_rules, emit_program_rule, compute_frame_size};
use super::STDLIB;

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
    // All addresses outside that interval are "observable" -- must match between programs.
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
