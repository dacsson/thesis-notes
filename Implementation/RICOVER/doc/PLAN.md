────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Forward Plan: Growing IR Coverage Beyond LOAD/STORE                                                                                    │
│                                                                                                                                        │
│ Context                                                                                                                                │
│                                                                                                                                        │
│ LOAD/STORE are now IR-derived end-to-end (8 LOAD + 4 STORE specializations via                                                         │
│ try_specialize_result_variant in src/chc_emit.rs). foo1 vs foo2                                                                        │
│ constant-folding verifies UNSAT using only ADDI/ADDIW/LOAD/STORE from IR — the                                                         │
│ sole remaining hand-written fallback is ret, blocked on JALR which is itself                                                           │
│ blocked on update_elp_state (Zicfilp CFI primitive). We accept that fallback                                                           │
│ for now and instead focus on widening IR coverage so the translator handles                                                            │
│ realistic optimization benchmarks beyond constant folding.                                                                             │
│                                                                                                                                        │
│ The blockers for each remaining instruction family are known (see exploration                                                          │
│ results). This plan sequences them smallest-effort-first, with the PC model                                                            │
│ redesign — the one structural change — scheduled last so earlier phases can                                                            │
│ land without rework.                                                                                                                   │
│                                                                                                                                        │
│ Phases                                                                                                                                 │
│                                                                                                                                        │
│ Phase A — Arithmetic / logic primitives (~2h)                                                                                          │
│                                                                                                                                        │
│ Unlocks: ADD, SUB, AND, OR, XOR, ANDI, ORI, XORI, SLT, SLTU, SLTI, SLTIU.                                                              │
│                                                                                                                                        │
│ Changes in src/chc_emit.rs:                                                                                                            │
│ - Extend KnownCall with AndVec, OrVec, XorVec, SubVec, LtSigned,                                                                       │
│ LtUnsigned, GteSigned (names match Sail IR primitives).                                                                                │
│ - classify_call: map and_vec/or_vec/xor_vec/sub_vec/<_s/<_u/>=_s.                                                                      │
│ - call_to_smt: emit bvand/bvor/bvxor/bvsub/bvslt/bvult/bvsge.                                                                          │
│ - Extend instruction_to_chc opcode classes with the new mnemonics.                                                                     │
│ - Extend ir_rule_for_opcode to route them to the existing RTYPE/ITYPE rules.                                                           │
│                                                                                                                                        │
│ Verification: add tests asserting the new rules appear in translated output                                                            │
│ and run the existing foo equivalence to confirm no regression.                                                                         │
│ 
|  Also add fallthrough cases in `discover_variants` for XORI and SRA 
│
│ Phase B — Shift primitives (~2h)                                                                                                       │
│                                                                                                                                        │
│ Unlocks: SLL, SRL, SRA, SLLI, SRLI, SRAI, SLLW, SRLW, SRAW, SLLIW, SRLIW, SRAIW.                                                       │
│                                                                                                                                        │
│ Changes:                                                                                                                               │
│ - KnownCall::ShiftBitsLeft, ShiftBitsRight, ShiftBitsRightArith.                                                                       │
│ - call_to_smt: emit bvshl/bvlshr/bvashr. Shift amount must be the                                                                      │
│ same width as the shifted value — insert zero-extend on the shamt operand.                                                             │
│ - Resolve log2_xlen at classify time (constant 6 for RV64) so the mask                                                                 │
│ shamt & (xlen-1) folds to ((_ extract 5 0) shamt).                                                                                     │
│                                                                                                                                        │
│ Verification: translate and spot-check generated rules; run existing tests.                                                            │
│                                                                                                                                        │
│ Phase C — AMO + compressed helpers (~2h combined)                                                                                      │
│                                                                                                                                        │
│ Unlocks: 9 AMO* variants and 14 C_* compressed variants.                                                                               │
│                                                                                                                                        │
│ Changes:                                                                                                                               │
│ - Resolve xlen_bytes as constant 8 in call_to_smt so AMO variants type-check.                                                          │
│ - Model creg2reg_idx as (bvadd crd #b01000) — C-regs map to x8..x15.                                                                   │
│ - No new stdlib symbols needed beyond Phases A/B.                                                                                      │
│                                                                                                                                        │
│ Phase D — PC model redesign (~4h, structural)                                                                                          │
│                                                                                                                                        │
│ Unlocks: BEQ, BNE, BLT, BGE, BLTU, BGEU, JAL, JALR (and therefore ret).                                                                │
│                                                                                                                                        │
│ This is the only phase that touches CHC rule shape. Currently                                                                          │
│ emit_variant_chc hard-codes (= pc1 (bvadd pc0 (_ bv4 64))). Control flow                                                               │
│ needs:                                                                                                                                 │
│ - translate_variant to accumulate a symbolic pc_next expression (default                                                               │
│ pc0+4, overridden when the IR writes PC via wPC/set_next_pc).                                                                          │
│ - emit_variant_chc to bind pc1 to that expression instead of the constant.                                                             │
│ - Recognize the Sail IR primitives for next-PC writes (set_next_pc,                                                                    │
│ wX_bits on PC register, or the nextPC global update, whichever the IR                                                                  │
│ actually emits — confirm by grepping snapshot/rv64d.ir for BTYPE/JAL).                                                                 │
│                                                                                                                                        │
│ Once this lands, revisit JALR — if update_elp_state is the only blocker, we                                                            │
│ may be able to classify it as a no-op (Zicfilp is off by default) and get                                                              │
│ ret for free.                                                                                                                          │
│                                                                                                                                        │
│ Explicitly deferred                                                                                                                    │
│                                                                                                                                        │
│ - LOADRES / STORECON (atomic reservations) — needs reservation-set state.                                                              │
│ - LOAD_FP / STORE_FP, all FP arithmetic — needs FP register file + rounding.                                                           │
│ - Vector extensions — out of scope for integer equivalence.                                                                            │
│ - CSR / privileged / mret / sret — out of scope.                                                                                       │
│ - JALR / ret as a hand-written fallback until Phase D resolves the PC model.                                                           │
│                                                                                                                                        │
│ Critical files                                                                                                                         │
│                                                                                                                                        │
│ - src/chc_emit.rs — KnownCall, classify_call, call_to_smt,                                                                             │
│ translate_variant, emit_variant_chc, instruction_to_chc,                                                                               │
│ ir_rule_for_opcode.                                                                                                                    │
│ - chc_stdlib/stdlib.smt2 — only touched if a new memory/register helper is                                                             │
│ needed (Phases A–C should not require changes here).                                                                                   │
│ - snapshot/rv64d.ir — source of truth for IR shape; grep before each phase                                                             │
│ to confirm which primitives the mnemonics actually call.                                                                               │
│                                                                                                                                        │
│ Verification                                                                                                                           │
│                                                                                                                                        │
│ After each phase:                                                                                                                      │
│ 1. cargo test — existing unit tests must stay green.                                                                                   │
│ 2. cargo run -- translate-ir -i snapshot/rv64d.ir -o instructions.smt2 -f execute                                                      │
│ and inspect the new rule names.                                                                                                        │
│ 3. cargo run -- check-equiv --before foo1.s --after foo2.s -f foo -o query.smt2 -ir snapshot/rv64d.ir && z3 query.smt2 — expect UNSAT. │
│ 4. Add a small targeted example per phase (e.g. an AND/OR/XOR equivalence for                                                          │
│ Phase A, a shift equivalence for Phase B) and verify UNSAT.                                                                            │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯