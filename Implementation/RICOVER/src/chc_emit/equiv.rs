use std::fmt::Write;

use anyhow::Result;

use crate::asm_parse::AsmFunction;
use crate::isla_ir::IslaIRModel;
use super::ir_emit::collect_instruction_semantics;
use super::asm_emit::{emit_program_rule_inlined, compute_frame_size};
use super::STDLIB;

/// Emit a complete equivalence checking query for two assembly functions.
///
/// Produces a self-contained .smt2 file with:
///   1. (set-logic HORN) + stdlib (register/memory operations)
///   2. Program relation rules with inlined instruction semantics
///   3. Observable-address predicate (excludes private stack frame)
///   4. Projected equivalence query:
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

    // 2. Collect inlined instruction semantics from IR and emit program rules.
    // Instead of emitting hundreds of per-instruction CHC relations and calling
    // them from program rules, we inline the three state constraints
    // (regs, mem, pc) directly into each block body rule.
    let semantics = if let Some(m) = model {
        collect_instruction_semantics(m)?
    } else {
        std::collections::HashMap::new()
    };

    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out, "; Programs (instruction semantics inlined)")?;
    writeln!(out, "; {}", "=".repeat(70))?;
    writeln!(out)?;
    emit_program_rule_inlined(prog1, &semantics, &mut out)?;
    emit_program_rule_inlined(prog2, &semantics, &mut out)?;

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
