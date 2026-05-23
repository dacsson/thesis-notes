Current RICOVER opcode support

  Fully supported opcodes (operand emission + IR/fallback rules):
  - I-type: addi, addiw, andi, ori, xori, slti, sltiu
  - Shifts: slli, srli, srai (+ W variants via IR)
  - R-type: add, sub, and, or, xor, slt, sltu, sll, srl, sra, addw, subw, sllw, srlw, sraw
  - Load/Store: lb, lbu, lh, lhu, lw, lwu, ld, sb, sh, sw, sd
  - Branch: beq, bne, blt, bge, bltu, bgeu + pseudos (beqz, bnez, etc.)
  - Jump: jalr, ret
  - Upper imm: lui (via IR)
  - Pseudo: li, mv, nop, zext.b
  - Compressed: c.li, c.add, c.mv, c.sub, etc.
  - AMO: amoadd, amoswap, etc.

  NOT supported: call, jal (as call), sext.w, seqz, snez, sgtz, neg, not, jr, csrr, cpop, ctzw, any V-extension, any F/D-extension

  Best LLVM test candidates (src != tgt, 0 unsupported opcodes)

  ┌───────┬────────────────────────┬───────────────────────────────────────────────────────────────────────────┐
  │ # ops │      Optimization      │                                   File                                    │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 11    │ LoopIdiom byte compare │ LoopIdiom/byte-compare-index...compare_bytes_cleanup_block.s (3 variants) │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 9     │ GEP split              │ SeparateConstOffsetFromGEP/split-gep...test_inbounds2.s                   │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 7     │ Loop strength reduce   │ LoopStrengthReduce/lsr-cost-compare...test1.s                             │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 6     │ Loop rotate            │ LoopRotate/invalid-cost...valid.s                                         │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 6     │ Loop idiom memset      │ LoopIdiom/memset-pattern...CHECK-INTRIN.s                                 │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 5     │ SeparateConstOffset    │ split-gep...test1.s                                                       │
  ├───────┼────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 4     │ Loop unroll            │ LoopUnroll/unroll-Os.riscv64_loop-unroll.s                                │
  └───────┴────────────────────────┴───────────────────────────────────────────────────────────────────────────┘

  These all use only supported opcodes and have different src vs tgt (real optimizations). The LoopUnroll one is especially nice — src has a 4-iteration loop, tgt is fully unrolled to 4 straight sw
  instructions.

  To run these e2e, two issues remain

  1. Z3 errors from broken IR variants: The output .smt2 includes all 739 IR-derived rules (including many broken ones with unknown constant unit). Z3 reports errors but continues — this may affect solving. You
   may need to filter the emitted rules to only include ones actually used by the program.
  2. Z3 timeouts on loops: The LoopUnroll and branching tests involve loops, which are hard for CHC solvers. The straight-line split-gep test might be easier to solve but also timed out — possibly because of
  the spurious errors polluting the solver state.

  If you want to add 1 new pseudo-instruction for maximum coverage

  Adding sext.w (which is just addiw rd, rs, 0) would unlock ~130 more files, including many interesting SeparateConstOffsetFromGEP, SimplifyCFG, and LoopIdiom tests. It's a one-line pseudo expansion.

  Want me to focus on fixing the Z3 errors (filtering unused IR rules) or adding sext.w support first?
