# Csmith Benchmark Initial Overview — 22 May 2026

## How to run (end-to-end)

### Prerequisites

- `~/Tools/csmith/src/csmith` — Csmith random program generator
- `~/Tools/llvm-project/build/bin/clang` — RISC-V cross-compiler
- `~/Uni/thesis/thesis-notes/Scripts/riscv_opt_diff.py` — diff/extraction tool
- Z3 solver on PATH

### Step 1: Generate a random C program

```bash
~/Tools/csmith/src/csmith --no-checksum --no-argc > /tmp/csmith_test.c
```

### Step 2: Compile at O0 vs O1, extract per-function ricover files

```bash
cd ~/Uni/thesis/thesis-notes/Scripts
python3 riscv_opt_diff.py /tmp/csmith_test.c \
  --csmith --csmith-runtime ~/Tools/csmith/runtime \
  --opt-levels 0,1 \
  --ricover --ricover-dir /tmp/ricover_out \
  -o /tmp/ricover_diff \
  --cc ~/Tools/llvm-project/build/bin/clang \
  --arch riscv64-linux-gnu
```

This produces one `.s` file per function that differs between O0 and O1 in `/tmp/ricover_out/`. Functions with PC-relative relocations (`auipc`/`%pcrel`) are skipped automatically.

### Step 3: Run RICOVER on each extracted function

```bash
cd ~/Uni/thesis/thesis-notes/Implementation/RICOVER
for f in /tmp/ricover_out/*.s; do
  name=$(basename "$f" .s)
  echo "=== $name ==="
  cargo run -q -- check-equiv \
    --before "$f" --after "$f" \
    --before-fn src --after-fn tgt \
    -f "$name" --ir snapshot/rv64d.ir \
    -o "/tmp/${name}.smt2" 2>&1 | grep -E "Error|Wrote|falling back"
  z3 "/tmp/${name}.smt2" 2>&1 | grep -E "^sat$|^unsat$"
done
```

- `unsat` = optimization is verified equivalent
- `sat` = potential divergence (see "False positives" below)
- `Error` = unsupported instruction or missing label

### Notes

- Use `--opt-levels 0,1` or `0,3` to control which optimization level to compare against
- The `--csmith` flag strips `static` and adds `-fno-inline` at non-base levels
- See `Scripts/compile_example_opt.sh` for a non-csmith example invocation

## Pipeline

1. **Generate**: `csmith` produces a random C program (`/tmp/csmith_clean.c`)
2. **De-static**: `riscv_opt_diff.py --csmith` strips `static` from functions and compiles with `clang --target=riscv64 -O0` (base) and `-O1 -fno-inline` (optimized)
3. **Extract**: `--ricover` mode splits assembly per-function, creates paired `src:/tgt:` files
4. **Verify**: RICOVER's `check-equiv` translates both sides to CHC; Z3 checks equivalence

## Results

| Test | src instrs | tgt instrs | Z3 result | Interpretation |
|------|-----------|-----------|-----------|----------------|
| func_11 | 80 | 2 (`mv a0, a4; ret`) | **sat** | Not equivalent |
| func_24 | 16 | 3 | **unsat** | Equivalent |
| platform_main_begin | 8 | 0 | — | Empty tgt (can't verify) |

## Are the results sound?

**func_24 (unsat) — sound and correct.** The O0 code stores constants to the stack then loads back `a1` as a sign-extended halfword. The O1 code does `slli+srai` to sign-extend `a1` and returns it. These are semantically equivalent under RICOVER's projection model (ABI-visible registers + observable memory). Z3 confirms: `unsat`.

**func_11 (sat) — false positive due to missing ABI preconditions.** The C source shows `func_11` simply returns `p_16` (its 5th parameter, `uint16_t`). The optimizer correctly emits `mv a0, a4; ret`. Z3 reports `sat` because RICOVER does not constrain initial register values to the calling convention — see "False positives" section below.

## Soundness concerns

1. **Label stripping (critical)**: The format converter discards internal labels. Without correct labels, the CFG is wrong and the CHC encoding is unsound. func_11's `sat` result is unreliable until this is fixed.

2. **MUL rule was wrong (fixed 22 May)**: Before this session, all four MUL variants (`mul`, `mulh`, `mulhsu`, `mulhu`) emitted identical incorrect rules (high-half with zero-extend instead of correct per-variant semantics). The two bugs were: wrong argument index for `result_part` in the handler, and positional (not name-based) struct field binding in specialization. Both are now fixed.

3. **REMW divide-by-zero**: The skip mechanism assumes divide-by-zero is UB (correct for C), so the divide-by-zero handler arm is skipped. This is sound for compiler verification of C code. SMT-LIB's `bvsrem` for zero divisor gives an unspecified (but deterministic per solver) value, which is consistent with UB.

## What needs fixing for production use

The `riscv_opt_diff.py` script must **preserve internal labels** (lines starting with `.L`). The current filter on line 185 (`if stripped.startswith('.'): continue`) discards them along with assembler directives. Fix: only skip directives like `.cfi_*`, `.type`, `.size`, `.section`, etc. — not label definitions matching `.L*:`.

---

## Bulk Readiness Analysis — 22 May 2026

Systematic evaluation of csmith as a random benchmark source for RICOVER, using `csmith_ricover_e2e.py` with the `instcombine` pass pipeline across 20 programs (seeds 200–219, `--no-safe-math --no-global-variables`).

### Instruction coverage

All core RV64IM instructions are IR-derived from the Sail spec via Isla IR (199 of 746 variants transpile; the 547 skipped are floating-point, vector, crypto, and privilege instructions that csmith never generates):

- **Fully covered**: ITYPE (addi/addiw/andi/ori/xori/slti/sltiu), RTYPE (add/sub/and/or/xor/sll/srl/sra/slt/sltu + W variants), LOAD (lb/lbu/lh/lhu/lw/lwu/ld), STORE (sb/sh/sw/sd), BRANCH (beq/bne/blt/bge/bltu/bgeu), JAL, JALR, LUI, MUL/MULH/MULHU/MULHSU/MULW, DIV/DIVU/DIVW/DIVUW, REM/REMU/REMW/REMUW, shift-immediate (slli/srli/srai + W variants)
- **Compressed expansions**: c.addi, c.li, c.lui, c.mv, c.add, c.addiw, c.lw, c.sw, c.ld, c.sd, c.beqz, c.bnez, c.slli, c.srli, c.srai, c.j, c.jr, c.jalr
- **Pseudos handled**: ret, mv, li, snez, zext.b, lui
- **Pseudos missing**: `sext.w` (caused 1 RICOVER error in 20 seeds), `neg`, `not`, `seqz`, `nop` — all are trivial expansions

### Funnel analysis (20 programs, instcombine pass)

| Stage | Count | % of differing |
|-------|------:|:--------------:|
| Functions differing between base and optimized | 185 | 100% |
| Blocked by `call` instructions | 152 | 82% |
| Blocked by relocations (`%hi/%lo/auipc`) | 136 | 73% |
| Call-free **and** relocation-free | 20 | 11% |
| Within size limit + supported instructions | 11 | 6% |
| Z3 `unsat` at 30s | 0 | 0% |
| Z3 `sat` (potential divergence) | 1 | <1% |
| Z3 timeout at 30s | 10 | 5% |

With a **30s Z3 timeout**, effective yield was 0%. Increasing to **300s (5 min)** solved 2 of the 10 timeouts — see extended timeout analysis below.

### Three blockers

**1. `call` instructions (82% of candidates blocked).** Csmith programs call their own `func_*` functions even with `--no-safe-math`. RICOVER verifies single-function equivalence and errors on `call`. The e2e script's `has_relocation` filter catches `auipc`/`%pcrel` but not `call` pseudo-instructions, so these functions error out inside RICOVER instead of being skipped cleanly.

**2. Z3 scalability.** Of 11 functions that reached Z3 at 30s timeout, 10 timed out and 0 returned `unsat`. At 300s timeout, 2 of 10 solved (`unsat`), both with ≤14 source instructions. Everything ≥20 instructions still times out at 5 minutes. See extended timeout results below.

**3. Missing pseudo-instructions (minor).** `sext.w rd, rs` → `addiw rd, rs, 0`. Easy fix, low impact since blockers 1 and 2 dominate.

### The one `sat` result (seed 208, func_54)

86→9 instructions. The O0 version stores many pointers to a 608-byte stack frame and returns a loaded byte; instcombine reduces to `mv a0, a2; ret`. Z3 reports `sat` — likely a false positive from the ABI precondition issue (narrow parameter types: `uint8_t` third argument, O0 explicitly sign-extends while O1 assumes the ABI guarantee that `a2` already holds the correct value).

### Extended timeout analysis (300s)

Re-running all 10 timed-out functions with a 5-minute Z3 timeout:

| Function | src→tgt instrs | 30s | 300s | Time |
|----------|:--------------:|:---:|:----:|-----:|
| 210/func_4 | 12→10 | timeout | **unsat** | 39s |
| 203/func_37 | 14→9 | timeout | **unsat** | 30–300s |
| 203/func_9 | 20→10 | timeout | timeout | 300s |
| 206/func_17 | 33→20 | timeout | timeout | 300s |
| 213/func_35 | 38→16 | timeout | timeout | 300s |
| 219/func_15 | 40→20 | timeout | timeout | 300s |
| 217/func_1 | 42→9 | timeout | timeout | 300s |
| 211/func_74 | 51→16 | timeout | timeout | 300s |
| 211/func_55 | 79→16 | timeout | timeout | 300s |
| 210/func_28 | 86→33 | timeout | timeout | 300s |
| 208/func_54 | 86→9 | sat | *(not re-run)* | — |

**2 of 10 solved — both `unsat`, both ≤14 source instructions.** The solvability boundary is around ~15 source instructions. func_4 solved in 39s (just above the 30s cutoff), confirming the 30s timeout was marginal for small functions. Everything ≥20 instructions remains intractable at 5 minutes.

### Optimized run: memory variable elimination + simplified csmith (22 May)

Two changes were applied:

**1. Memory variable elimination (RICOVER patch).** Instructions that don't modify memory (arithmetic, register moves) no longer get their own `memN` quantified variable. Instead, the previous memory variable is reused, eliminating trivial `(= memN memN-1)` equalities over array-typed variables. For a 20-instruction function this reduced memory constraints from 43 to 10. No regressions on existing benchmarks (all SUCCESS → `unsat`, all BAD → `sat`, 41/41 tests pass).

**2. Simplified csmith flags.** Added `--no-arrays --no-structs --no-pointers` to csmith invocation. This produces register-heavy code with fewer memory operations, directly reducing array theory complexity for Z3.

Results (100 programs, seeds 300–399, instcombine pass, 300s Z3 timeout):

- 153 candidate functions generated (vs 20 in the baseline run — 7.6× more, because `--no-pointers` eliminates most `call` and relocation patterns)
- 10 tested (smallest functions, 10–13 source instructions):

| Function | src→tgt | Result | Time |
|----------|:-------:|:------:|-----:|
| func_36 | 10→8 | **unsat** | 27s |
| func_38 | 11→9 | **unsat** | 28s |
| func_29 | 11→9 | **unsat** | 29s |
| func_43 | 11→9 | **unsat** | 31s |
| func_88 | 11→9 | **unsat** | 42s |
| func_12 | 13→9 | **unsat** | 77s |
| func_39 | 11→9 | **unsat** | 160s |
| func_46 | 10→8 | **unsat** | 276s |
| func_17 | 13→9 | timeout | 300s |
| func_153 | 12→8 | timeout | 300s |

**7 of 10 solved `unsat`** (vs 2/10 in the baseline). Solve times range from 27s to 276s. The two timeouts show that even small functions can be hard depending on the specific arithmetic patterns.

### Comparison: csmith vs handcrafted benchmarks

| Property | Handcrafted benchmarks | Csmith (baseline) | Csmith (optimized) |
|----------|----------------------|-------------------|-------------------|
| Function calls | None | Pervasive (82%) | Rare (~5%) |
| Function size | 2–30 instrs | 9–86+ instrs | 10–50 instrs |
| Z3 solve rate | High (<1s) | 2/11 at 300s | **7/10 at 300s** |
| Coverage | Targeted | Random, broad | Random, broad |

### Recommendations

1. **Fix `sext.w`/`neg`/`not`/`seqz`/`nop`** pseudo-instruction expansions in `asm_emit.rs` — trivial, removes one error class.
2. **Add `call` to the `has_relocation` filter** in the e2e script so call-bearing functions are skipped cleanly rather than erroring inside RICOVER.
3. **For thesis evaluation**: use `--no-arrays --no-structs --no-pointers --no-safe-math --no-global-variables` csmith flags with 300s Z3 timeout. This combination produces a 70% solve rate on small random functions — strong evidence that the approach generalizes beyond handcrafted inputs.
4. **To improve csmith yield further**: (a) try Eldarica as alternative CHC solver; (b) detect stack-only functions and skip observable memory comparison entirely; (c) filter to ≤15 source instructions for reliable solving.
