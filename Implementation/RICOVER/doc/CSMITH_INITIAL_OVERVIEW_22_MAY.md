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
2. ~~**Add `call` to the `has_relocation` filter**~~ **Done (22 May).** `call` is now filtered in `has_relocation` in `riscv_opt_diff.py`.
3. **For thesis evaluation**: use `--no-arrays --no-structs --no-pointers --no-safe-math --no-global-variables` csmith flags with 300s Z3 timeout. This combination produces a 70% solve rate on small random functions — strong evidence that the approach generalizes beyond handcrafted inputs.
4. **To improve csmith yield further**: (a) try Eldarica as alternative CHC solver; (b) detect stack-only functions and skip observable memory comparison entirely; (c) filter to ≤15 source instructions for reliable solving.

---

## All-passes sweep — 22 May 2026 (post-inlining)

After the "inline instruction rules" optimization (`b59a62a`), re-ran csmith with all 9 default pass pipelines and the simplified csmith flags (now baked into `csmith_ricover_e2e.py`).

### Changes applied before this run

1. **Csmith flags baked into e2e script.** `--no-safe-math --no-arrays --no-structs --no-pointers` added to `generate_csmith()` in `csmith_ricover_e2e.py` (previously only used manually).
2. **`call` added to relocation filter.** `has_relocation()` in `riscv_opt_diff.py` now checks for `call ` instructions, so functions with calls are skipped cleanly instead of erroring inside RICOVER.

### Csmith flag effects on `call` instructions

Even with `--no-safe-math`, csmith functions still call each other in assembly (inter-function calls). The `--no-safe-math` flag removes `safe_*` wrapper calls, but does not eliminate all `call` instructions. Measurements at seed 42:

| Flags | `call` instrs in assembly |
|-------|:-------------------------:|
| `--no-pointers` (with arrays, structs) | 86 |
| `--no-pointers --no-arrays` | 29 |
| `--no-pointers --no-arrays --no-structs` | 15 |

Relaxing `--no-arrays --no-structs` does **not** introduce more calls per se — it makes functions more complex (more memory operations), which increases Z3 array theory complexity and causes more timeouts. The `call` filter handles both cases.

### Results (4 programs completed, 9 pipelines each, 300s Z3 timeout)

| Program | Function | src→tgt instrs | Passes tested | Result |
|---------|----------|:--------------:|:-------------:|--------|
| prog_0 | *(none)* | — | 9 | All functions had relocations |
| prog_1 | func_1 | 15→9 | 9 | **9/9 EQUIV** |
| prog_2 | func_1 | 30→9 | 9 | **9/9 EQUIV** |
| prog_3 | func_16 | 15→9 | 6 | **6/6 EQUIV** (run killed) |

**24/24 tested = EQUIV (unsat), 0 sat, 0 timeouts.** No timeouts is notable — the previous instcombine-only run had 2/10 timeouts. The inlining optimization may have improved Z3 solve times, or these particular functions were easier.

### Why no `sat` results

With the simplified csmith flags, all 9 passes produce the same optimization on these simple functions (constant folding / dead store elimination). The passes don't diverge from each other because the code is too simple for pass-specific transformations (GVN, LICM, loop unroll) to fire differently.

To find `sat` results, options are:
1. **Use known LLVM miscompile reproductions** (Alive2/bugzilla) as inputs — the existing `benchmark/supported/` benchmarks already do this
2. **Mutation testing** — take verified-equivalent pairs, mutate one instruction in the optimized side, confirm RICOVER detects the divergence
3. **Relax csmith flags** (allow arrays/structs) — more complex code, but more Z3 timeouts

### How to reproduce

```bash
cd Scripts
bash run_csmith_all_passes.sh      # all 9 pipelines × 10 programs
bash run_csmith_instcombine.sh     # instcombine only × 20 programs
bash run_csmith_aggressive.sh      # simplifycfg + gvn + dse × 20 programs
bash run_csmith_loops.sh           # loop passes × 20 programs
```

All scripts use `csmith_ricover_e2e.py` with 300s Z3 timeout and max 50 source instructions.

---

## Relaxed flags experiment — 22–23 May 2026

Relaxed csmith flags from `--no-safe-math --no-arrays --no-structs --no-pointers` to `--no-safe-math --no-pointers` (allowing arrays and structs). Goal: produce more complex code where different LLVM passes diverge, increasing the chance of `sat` results.

### Motivation

With simplified flags, all 9 passes produced identical optimizations on simple register-only code — 24/24 EQUIV, no divergence between passes. By allowing arrays and structs, functions have richer memory behaviour (struct field access, array indexing), which:
- Gives DSE, GVN, LICM more to work with (different passes may transform differently)
- Increases Z3 array theory complexity (more timeouts at short timeouts)

### What changed in the scripts

`csmith_ricover_e2e.py` `generate_csmith()`:
```python
# Simplified (previous):
cmd = [..., "--no-safe-math", "--no-arrays", "--no-structs", "--no-pointers"]
# Relaxed (current):
cmd = [..., "--no-safe-math", "--no-pointers"]
```

`riscv_opt_diff.py` `has_relocation()` — added `call` filtering (done earlier, still in effect):
```python
or i.strip().startswith('call ')
```

### Run 1: relaxed flags, 300s timeout, max 50 instructions (1 program completed)

```bash
python3 csmith_ricover_e2e.py -n 10 --z3-timeout 300 --max-instrs 50 \
    -o /tmp/ricover_csmith_relaxed_20260522_222831
```

| Function | src→tgt | Pipeline | Result | Notes |
|----------|:-------:|----------|:------:|-------|
| func_55 | 18→10 | instcombine through loop-unroll (8 passes) | **8/8 EQUIV** | |
| func_136 | 33→15 | instcombine, simplifycfg, gvn, licm, indvars, loop-rotate, loop-unroll | **7/7 TIMEOUT** | 33 src instrs too heavy |
| func_136 | 33→10 | **dse** | **sat** | DSE eliminated a dead store to a struct passed by value |

**The `sat` result (func_136, DSE pass):** The C function takes `struct S0 p_139` by value, modifies `p_139.f0` (a dead store to the local copy), and returns a local constant. DSE correctly eliminates the `p_139.f0 |= ...` dead store. In assembly, however, the base version writes to the struct's memory via `sb a1, 0(a2)` (where `a2` is the caller-provided pointer to the by-value struct copy). This address is outside the function's own stack frame `[sp0 - 64, sp0)`, so RICOVER considers it observable memory and reports a divergence.

**Classification: false positive.** The write is to a by-value struct copy that the caller will never read again. Both versions are semantically equivalent from C's perspective. This is a known limitation: RICOVER's memory observation model treats all memory outside the function's private stack frame as observable, but the RISC-V calling convention places by-value struct copies on the *caller's* stack, making dead stores to them appear as observable side effects.

The sat benchmark is saved at `TestSuite/csmith/func_136_Obase_vs_dse.s` with the C source at `TestSuite/csmith/func_136_dse_sat.c`.

### Run 2: relaxed flags, 60s timeout, max 20 instructions (3 programs, aborted)

```bash
python3 csmith_ricover_e2e.py -n 20 --z3-timeout 60 --max-instrs 20 \
    -o /tmp/ricover_csmith_relaxed_fast_20260522_232216
```

| Result | Count |
|--------|:-----:|
| EQUIV | 18 |
| TIMEOUT | 21 |

60s was insufficient — functions with struct/array memory ops need longer solve times. Over half timed out, including 13-instruction functions. Run aborted.

### Run 3: relaxed flags, 300s timeout, max 20 instructions (10 programs completed)

```bash
python3 csmith_ricover_e2e.py -n 20 --z3-timeout 300 --max-instrs 20 \
    -o /tmp/ricover_csmith_relaxed_300s_20260522_235632
```

| Function | src→tgt | Passes tested | Result |
|----------|:-------:|:-------------:|--------|
| func_11 | 19→9 | 9 | **9/9 EQUIV** |
| func_22 | 12→10 | 9 | **9/9 EQUIV** |
| func_30 | 12→10 | 9 | **9/9 EQUIV** |
| func_47 | 13→10 | 9 | **9/9 EQUIV** |
| func_5 | 16→9 | 4 | **4/4 EQUIV** (run aborted during prog 9) |

**40/40 tested = EQUIV, 0 sat, 0 timeouts.** The 300s timeout solved everything at ≤20 instructions, including the functions that timed out at 60s. All 9 passes produced equivalent results — even with structs and arrays, the code was simple enough that passes didn't diverge.

### Comparison across all runs

| Run | Csmith flags | Timeout | Max instrs | Programs | Tested | EQUIV | SAT | TIMEOUT |
|-----|-------------|:-------:|:----------:|:--------:|:------:|:-----:|:---:|:-------:|
| Simplified, all passes | no-arrays/structs/pointers | 300s | 50 | 4 | 24 | **24** | 0 | 0 |
| Relaxed, all passes | no-pointers only | 300s | 50 | 1 | 16 | 8 | **1** | 7 |
| Relaxed, all passes | no-pointers only | 60s | 20 | 3 | 39 | 18 | 0 | 21 |
| Relaxed, all passes | no-pointers only | 300s | 20 | 10 | 40 | **40** | 0 | 0 |

### Key findings

1. **300s Z3 timeout is essential** for struct/array-bearing code. At 60s, over half of functions time out; at 300s, everything ≤20 instructions solves.
2. **Relaxing `--no-arrays --no-structs` does not produce more `sat` results** on small functions (≤20 instrs). All passes produce identical optimizations. The one `sat` (func_136, 33 instrs) was a false positive from the by-value struct limitation.
3. **The bottleneck for finding real `sat` results is not csmith flags** — it's that LLVM's passes are correct. Real miscompiles are rare and would require either (a) known-buggy LLVM versions, (b) mutation testing, or (c) much larger test volumes.
4. **By-value struct dead stores are a known false-positive class.** Functions that take structs by value and modify fields without returning them will produce `sat` under DSE because the store is to caller-owned memory that RICOVER considers observable.

### How to reproduce end-to-end

**Prerequisites:**
- `~/Tools/csmith/src/csmith` — Csmith random program generator
- `~/Tools/llvm-project/build/bin/{clang,opt,llc}` — RISC-V cross-compiler and opt tools
- `~/Tools/csmith/runtime/` — Csmith headers
- `/usr/riscv64-linux-gnu` — RISC-V sysroot
- Z3 solver on PATH
- RICOVER built (`cargo build` in `Implementation/RICOVER`)

**Step 1: Run the e2e pipeline**

```bash
cd Scripts

# All 9 default passes, 10 programs, 300s Z3 timeout, max 20 src instructions
python3 csmith_ricover_e2e.py \
    -n 10 \
    --z3-timeout 300 \
    --max-instrs 20 \
    -o /tmp/ricover_csmith_run

# Or use one of the shell wrapper scripts:
bash run_csmith_all_passes.sh      # all 9 pipelines × 10 programs
bash run_csmith_instcombine.sh     # instcombine only × 20 programs
bash run_csmith_aggressive.sh      # simplifycfg + gvn + dse × 20 programs
bash run_csmith_loops.sh           # loop passes × 20 programs
```

**Step 2: Check results**

```bash
# Structured JSON results
cat /tmp/ricover_csmith_run/results.json | python3 -m json.tool

# Quick summary from terminal output
grep -E "EQUIV|DIFF|TIMEOUT" /tmp/ricover_csmith_run/*.log
```

**Step 3: Inspect a specific sat result**

```bash
# Look at the ricover-format assembly
cat /tmp/ricover_csmith_run/prog_000/dse/func_136_Obase_vs_dse.s

# Re-run RICOVER + Z3 manually
cd Implementation/RICOVER
cargo run -q -- check-equiv \
    --before /tmp/ricover_csmith_run/prog_000/dse/func_136_Obase_vs_dse.s \
    --after  /tmp/ricover_csmith_run/prog_000/dse/func_136_Obase_vs_dse.s \
    --before-fn src --after-fn tgt \
    -f func_136 --ir snapshot/rv64d.ir \
    -o /tmp/func_136.smt2
z3 -T:300 /tmp/func_136.smt2
```

**Pipeline internals** (what `csmith_ricover_e2e.py` does):

```
csmith --no-safe-math --no-pointers --no-global-variables
  → program.c
  → clang -O0 -Xclang -disable-O0-optnone -emit-llvm -S → base.ll
  → llc -O1 → base.s
  → opt -passes='<pipeline>' -S → opt.ll → llc -O1 → opt.s
  → per-function diff (skip: call, relocations, >max-instrs, identical)
  → generate ricover .s file (src: base, tgt: opt)
  → RICOVER check-equiv → .smt2
  → z3 -T:<timeout> → sat/unsat/timeout
```
