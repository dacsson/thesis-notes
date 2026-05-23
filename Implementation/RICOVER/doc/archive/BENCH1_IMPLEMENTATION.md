● All 6 plan steps complete. bench1.s now produces SAT — RICOVER's first end-to-end detection of an LLVM Alive2 miscompile (issue #39208), while foo1/foo2 stays UNSAT.

Summary of changes to src/chc_emit.rs, src/main.rs, src/asm_parse.rs:
- Step 2: collect_globals pre-evaluates Def::Let integer constants (log2_xlen, xlen_bytes, xlen) and merges them into translation bindings.
- Step 3: Added ShiftBitsLeft/Right/RightArith known-calls; explicit handler in translate_variant zero-extends the shift amount to value width before emitting bvshl/bvlshr/bvashr. Added slli/srli/srai (SHIFTIOP, bv6 shamt) and
  sll/srl/sra (RTYPE) to instruction_to_chc.
- Step 4: li (12-bit imm) → addi rd, zero, imm; zext.b → andi rd, rs1, 0xff. collect_needed_opcodes now uses post-translation opcodes so pseudos don't register as missing.
- Step 5: --before-fn / --after-fn CLI overrides for per-side function labels.
- asm_parse fix: strip inline # comment before the next-label check so tgt: # @tgt correctly terminates the prior function.
- Equivalence query fix: the prior bad rule conjuncted register equality with memory inequality, hiding all register divergences. Replaced with one rule per discrepancy kind (a0/ra/sp/s0/pc/memory).