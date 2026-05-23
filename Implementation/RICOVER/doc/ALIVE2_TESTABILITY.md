# RICOVER vs Alive2 Bug Corpus — Testability Analysis

This document assesses which of the 47 LLVM optimization bugs found by Alive2 (PLDI 2021,
bugs #1–47) are reproducible with RICOVER in its current state, and what additions are
needed to unlock further coverage.

---

## RICOVER capabilities summary (as of analysis date)

**Supported:**
- Scalar integer arithmetic: `add`, `sub`, `and`, `or`, `xor`, shifts (`sll`/`srl`/`sra`
  and immediate variants), set-less-than (`slt`/`sltu`)
- Immediate-operand variants: `addi`, `addiw`, `andi`, `ori`, `xori`, `slti`, `sltiu`,
  `slli`, `srli`, `srai`
- Sign / zero extension (`sign_extend`, `zero_extend` from IR; `lb`/`lbu`, `lh`/`lhu`,
  `lw`/`lwu` from assembly)
- Loads and stores at all widths (1, 2, 4, 8 bytes): `lb`/`lbu`, `lh`/`lhu`, `lw`/`lwu`,
  `ld`, `sb`, `sh`, `sw`, `sd`
- Pseudo-instructions: `li` (= `addi rd, zero, imm`), `zext.b`
- Straight-line function bodies ending in `ret`

**Not supported (current blockers):**
- Branch instructions (beq, bne, blt, bge, …) — no conditional control flow
- Multiply / divide / remainder (`mul`, `div`, `rem`, …)
- Floating-point operations and intrinsics
- SIMD / vector operations
- GEP / pointer arithmetic semantics
- Undef and poison value semantics
- Overflow intrinsics (`uadd.with.overflow`, `umul.with.overflow`, …)
- Libcalls (memcpy, memset, …)
- Memory alignment tracking
- Loops (back-edges in CFG)

---

## Tier 1 — Testable today (no code changes)

These bugs involve only scalar integer operations that compile to straight-line RV64 code
using RICOVER-supported instructions.  All that is needed is to write the `.s` test files.

### Bug #1 — Incorrect fold of `x & (-1 u>> y) s>= x` → always-true
**PR:** [PR39861](https://llvm.org/PR39861)

**Optimization claim:** `(x & (-1 u>> y)) s>= x` is always true.

**Why it is wrong:** For `x = 0x8000…0` (INT_MIN), `(-1 u>> 0) = -1`, so `x & -1 = x`,
and `x s>= x` is true. But for e.g. `x = 2`, `y = 1`: `(-1 u>> 1) = 0x7fff…f`,
`2 & 0x7fff…f = 2`, `2 s>= 2` is true — actually the fold breaks for
x with high bit set and large shift.

**Assembly shape:**
```asm
# src — computes the comparison correctly
li   t0, -1
srl  t0, t0, a1        # t0 = -1 u>> y
and  t0, a0, t0        # t0 = x & (-1 u>> y)
slt  a0, a0, t0        # a0 = (x <s t0)  →  flip to get sge:
xori a0, a0, 1         # a0 = (t0 s>= x)
ret

# tgt — buggy: always returns 1
li  a0, 1
ret
```

**Instructions used:** `li`, `srl`, `and`, `slt`, `xori` — all supported today.

**RICOVER output expected:** SAT (counterexample where the two functions differ on `a0`).

---

### Bug #2 — Incorrect instcombine fold for `icmp sgt`
**PR:** [PR42198](https://llvm.org/PR42198)

**Optimization claim:** Some `icmp sgt` expression is folded to a wrong constant or
simpler comparison (exact form requires checking the PR, but the class is a scalar signed
greater-than comparison that gets incorrectly simplified).

**Assembly shape:** Comparison result returned in `a0` via `slt` (with operand swap for
sgt).  If the fold produces a wrong constant, tgt reduces to `li a0, 0` or `li a0, 1`.

**Instructions used:** `slt`, `li`/`addi` — both supported today.

**RICOVER output expected:** SAT.

---

### Bug #16 — InstCombine incorrectly shrinks size of store
**PR:** [PR44306](https://llvm.org/PR44306)

**Optimization claim:** A `store i64 %v, i64* %p` can be replaced by a narrower store
(e.g. `store i32 (trunc %v), i32* %p`).

**Why it is wrong:** The upper 4 bytes of the 8-byte slot are not written, so memory
observable by the caller is different.

**Assembly shape:**
```asm
# src — stores full 64-bit value
sd  a1, 0(a0)
ret

# tgt — buggy: only stores 32-bit value (upper bytes unwritten)
sw  a1, 0(a0)
ret
```

**Instructions used:** `sd`, `sw` — both supported today.

**RICOVER output expected:** SAT (memory differs at bytes 4–7 of the target address for
any initial value where the high 32 bits of `a1` are non-zero).

---

## Tier 2 — Testable with one small addition

### Bug #39 — `mul foo, const` → `shl foo, log2(const)` with undef propagation
**PR:** [PR47133](https://llvm.org/PR47133)

**The bug (undef aspect, untestable):** `mul foo, undef → shl foo, undef`, i.e. undef
propagation through mul is incorrect.  RICOVER does not model undef so this specific
aspect cannot be tested.

**The base transform (testable once `mul` is added):** `mul x, 4 → shl x, 2` for
constant power-of-two multipliers.  This is a correct optimization, but writing a test
that validates the correctness (UNSAT case) is valuable as a positive regression test,
and if the shift amount were wrong it would show as a register divergence.

**Addition needed:** One fallback CHC rule for `mul rd, rs1, rs2` in `asm_emit.rs`:
```
(rule (forall (...) (=> (and (instr_mul) ...) (prog ...))))
```
Estimated effort: ~10 lines in the existing `match` arm in `instruction_to_chc()`.

---

## Blocked bugs — classification

| Blocker | Count | Bug numbers |
|---------|-------|-------------|
| **Undef / poison semantics** | ~20 | #3, #4, #5, #7, #13, #14, #18, #28, #29, #30, #32, #36, #39, #40, #42, #44, #47 |
| **Vectors** | ~11 | #10, #11, #13, #14, #15, #22, #30, #32, #35, #38 |
| **GEP / pointer arithmetic** | ~9 | #6, #8, #17, #20, #21, #25, #27, #28, #47 |
| **Floating-point** | ~5 | #26, #31, #33, #40, #45 |
| **Loops / back-edges** | ~4 | #41, #44, #46, #47 |
| **Libcalls / alignment** | ~4 | #12, #19, #23, #24 |
| **Overflow intrinsics** | ~3 | #7, #34, #43 |
| **Architecture-specific (x86)** | 1 | #37 |
| **Global / DSE** | 2 | #9, #24 |

Notes:
- Many bugs fall into multiple categories (e.g. vectors + undef).
- The dominant blocker is **undef/poison semantics** (~40% of the 47 bugs). The Alive2
  paper's central contribution was finding bugs in LLVM's undef/poison reasoning, which
  is structurally outside RICOVER's current semantic model.
- The second-largest blocker is **vectors** (~25%), which would require a fundamentally
  different state representation (arrays-of-bitvectors or widened register files).

---

## Roadmap for expanding coverage

| Priority | Addition | Bugs unlocked | Estimated effort |
|----------|----------|---------------|-----------------|
| **P1** | Write `.s` test files for bugs #1, #2, #16 | 3 | 1–2 hours |
| **P2** | Add `mul`/`mulw` fallback rules | Bug #39 (base transform only) | ~10 lines |
| **P3** | Branch instruction support (beq/bne/blt/bge/bltu/bgeu) + conditional path merging in CHC | Several scalar comparison bugs, parts of #34 | Significant — needs CFG modeling |
| **P4** | Undef / poison modeling (add a `poison` bit to the state) | Up to ~20 more bugs | Very significant — changes state representation |
| **P5** | Vector state (widened registers or array-of-BV) | ~11 more bugs | Major redesign |

P1 requires no code changes at all and delivers the first concrete bug reproductions.
P2 is a trivial code change.
P3–P5 are research-level additions.
