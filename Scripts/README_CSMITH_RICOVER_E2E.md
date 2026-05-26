# csmith_ricover_e2e.py

End-to-end pipeline: generate random C programs with csmith, apply specific LLVM IR passes, and verify equivalence using RICOVER + Z3.

## Pipeline

```
csmith --no-global-variables
    |
    v
clang -O0 -Xclang -disable-O0-optnone -emit-llvm -S
    |
    v
base.ll ──────────────────────────┐
    |                             |
    v                             v
llc -O1 → base.s            opt -passes='...' → llc -O1 → pass.s
    |                             |
    └──── per-function diff ──────┘
                |
                v
         RICOVER check-equiv → .smt2
                |
                v
            z3 → sat/unsat
```

Both sides use the same `llc` optimization level, so the **only** difference in the assembly comes from the `opt` pass being tested.

## Usage

```bash
# Single program, single pass
python3 csmith_ricover_e2e.py --passes 'sroa,instcombine<no-verify-fixpoint>'

# 5 programs, all default pipelines
python3 csmith_ricover_e2e.py -n 5

# Custom output dir and timeout
python3 csmith_ricover_e2e.py -n 3 -o /tmp/my_run --z3-timeout 120

# List available default pipelines
python3 csmith_ricover_e2e.py --list-passes

# Reproducible run with csmith seed
python3 csmith_ricover_e2e.py --seed 12345

# Relaxed csmith (allow pointers) with mem ops cutoff
python3 csmith_ricover_e2e.py -n 20 --relaxed --max-mem-ops 15

# Custom Z3 Spacer flags
python3 csmith_ricover_e2e.py -n 5 --z3-flags fp.spacer.global=true
```

## Options

| Flag | Default | Description |
|------|---------|-------------|
| `-n` | 1 | Number of csmith programs to generate |
| `--passes` | (all defaults) | Custom opt pass pipelines (space-separated) |
| `-o` | `/tmp/ricover_csmith_e2e` | Output directory |
| `--llc-opt` | 1 | LLC optimization level for both sides (0/1/2) |
| `--z3-timeout` | 60 | Z3 solver timeout in seconds |
| `--z3-flags` | (none) | Extra Z3/Spacer flags (e.g. `fp.spacer.global=true`) |
| `--max-instrs` | 200 | Skip functions with more than N base instructions |
| `--max-mem-ops` | (none) | Skip functions with more than N memory ops in src |
| `--relaxed` | off | Allow pointers in csmith (keeps `--no-safe-math`) |
| `--include-helpers` | off | Include csmith utility functions (safe_*, crc*, etc.) |
| `--seed` | random | Csmith random seed (for reproducibility) |

## Default Pass Pipelines

Each pipeline includes prerequisite passes (sroa, instcombine, simplifycfg, loop-simplify, lcssa) needed for the target pass to fire on O0 IR.

| Name | Pipeline |
|------|----------|
| instcombine | sroa, instcombine |
| simplifycfg | sroa, instcombine, simplifycfg |
| gvn | prereqs + gvn |
| dse | prereqs + dse (dead store elimination) |
| licm | prereqs + licm (loop-invariant code motion) |
| indvars | prereqs + indvars (induction variable simplification) |
| loop-rotate | prereqs + loop-rotate |
| loop-unroll | prereqs + indvars, loop-rotate, loop-unroll |
| loop-deletion | prereqs + indvars, loop-deletion |

## Filters

The script automatically skips:

- **Csmith helper functions** (`safe_add_func_*`, `crc*`, `platform_*`, `__undefined`) — large, uninteresting for pass testing
- **Functions with relocations** (`%hi`, `%lo`, `%pcrel`, `auipc`) — RICOVER can't handle address computations for globals
- **Oversized functions** (> `--max-instrs`) — Z3 times out on large CHC encodings
- **Identical functions** — pass didn't change anything

## Output Structure

```
/tmp/ricover_csmith_e2e/
  prog_000/
    program.c          # generated csmith source
    base.ll            # LLVM IR (O0, no optnone)
    base.s             # base assembly
    instcombine/
      optimized.ll     # IR after opt pass
      optimized.s      # assembly after opt pass
      func_X_Obase_vs_instcombine.s   # ricover format file
      func_X.smt2      # CHC equivalence query
    licm/
      ...
  prog_001/
    ...
  results.json         # structured results for all functions
```

## Interpreting Results

| Z3 result | Meaning |
|-----------|---------|
| unsat | Pass preserves semantics (verified equivalent) |
| sat | Potential divergence (may be false positive — see below) |
| timeout | Z3 couldn't decide within the timeout |
| error | RICOVER produced invalid SMT (e.g., `unit` constants) |

### Known false positive sources

1. **ABI preconditions**: RICOVER doesn't constrain initial register values to the calling convention. Functions with narrow parameter types (uint8_t, int16_t) may report `sat` because O0 explicitly truncates while the optimized version assumes the ABI guarantee.

2. **SMT output bugs**: Some IR variants produce `unknown constant unit` in the SMT output, causing Z3 to treat affected relations as unconstrained and trivially find `sat`.

## Prerequisites

- `~/Tools/csmith/src/csmith`
- `~/Tools/llvm-project/build/bin/{clang,opt,llc}`
- `~/Tools/csmith/runtime/` (csmith headers)
- RICOVER built (`cargo build` in Implementation/RICOVER)
- Z3 on PATH
- `/usr/riscv64-linux-gnu` sysroot

## Addressing Csmith test suite issues

### Memory operations as the correct complexity metric

The raw instruction count (`--max-instrs`) is a poor predictor of solver difficulty. The actual bottleneck is the number of **memory operations** (loads/stores: `lb/lbu/lh/lhu/lw/lwu/ld/sb/sh/sw/sd`) in the source function, because each one generates an array-theory constraint in the CHC encoding.

Empirical data from a 20-program run (instcombine, `--z3-timeout 300`):

| Memory ops (src) | Tested | Solved | Timeout | Solve rate |
|------------------|--------|--------|---------|------------|
| 3–8              | 4      | 4      | 0       | 100%       |
| 9–11             | 7      | 7      | 0       | 100%       |
| 12               | 1      | 1      | 0       | 100%       |
| 13+              | 5      | 0      | 4       | 0%         |

The practical boundary is **~12 memory operations** in the source function. Pure register functions solve in seconds regardless of instruction count.

The script now reports `mem_ops_src` and `mem_ops_tgt` in `results.json` and in the summary output. The summary includes a "By memory ops" breakdown.

### Store-load forwarding optimization

O0 code produces abundant redundant store-then-reload patterns on the stack:

```asm
sw a0, -20(s0)    ; store a0 to stack slot
lw a0, -20(s0)    ; immediately reload (redundant — value is already in a0)
```

Each memory read generates an `Array(BitVec 64 → BitVec 8)` constraint in the CHC encoding. RICOVER now performs **store-load forwarding** during CHC emission: when a load reads from a stack slot that was just written by a store (same offset, same base register, same width), the load's `read_mem_*` constraint is replaced with a direct register expression. This eliminates the array-theory constraint entirely.

The forwarding is conservative:
- Only same-width pairs (e.g., `sw`/`lw`, `sd`/`ld`)
- Only when the base register and source register are unmodified between store and load
- Store facts are invalidated when any potentially aliasing write occurs

**Results (100 programs, instcombine, `--z3-timeout 300`, with store-load forwarding):**

| Memory ops (src) | Tested | Solved | Timeout | Solve rate |
|------------------|--------|--------|---------|------------|
| 3–5              | 8      | 8      | 0       | 100%       |
| 6–8              | 23     | 23     | 0       | 100%       |
| 9–11             | 22     | 21     | 1       | 95%        |
| 12–14            | 12     | 6      | 6       | 50%        |
| 15–17            | 16     | 4      | 12      | 25%        |
| 18–20            | 9      | 3      | 6       | 33%        |
| 21+              | 16     | 0      | 16      | 0%         |

Total: 126 functions tested, 60 EQUIV, 5 SAT (false positives from ABI precondition), 42 timeout, 19 skipped (unsupported instructions). Median solve time: 63.9s, p90: 212.0s, max: 293.2s.

**Comparison with baseline (no store-load forwarding):**

| Metric | Baseline | With forwarding | Improvement |
|--------|----------|-----------------|-------------|
| Practical boundary | ~12 mem ops | ~15–18 mem ops | +25–50% |
| Solve rate (9–11 ops) | 100% | 95% | ~same |
| Solve rate (12–14 ops) | ~0% | 50% | new capability |
| Solve rate (15–17 ops) | 0% | 25% | new capability |
| Solve rate (18–20 ops) | 0% | 33% | new capability |
| Max solved mem ops | 12 | 20 | +67% |

The optimization extends the solvability boundary from ~12 to ~15–18 memory operations, with some functions up to 20 mem ops now solvable (e.g., `func_48`: 20 mem ops, solved in 293s; `func_21`: 18 mem ops, solved in 275s).

**Relaxed csmith results (20 programs, pointers enabled, `--relaxed`, instcombine, `--z3-timeout 300`, with store-load forwarding):**

| Memory ops (src) | Tested | Solved | Timeout | Solve rate |
|------------------|--------|--------|---------|------------|
| 6–8              | 2      | 2      | 0       | 100%       |
| 9–11             | 5      | 4      | 1       | 80%        |
| 12–14            | 1      | 1      | 0       | 100%       |
| 18–20            | 3      | 0      | 3       | 0%         |
| 21–23            | 1      | 0      | 1       | 0%         |
| 27–35            | 5      | 0      | 5       | 0%         |
| 48–62            | 4      | 2      | 2       | 50%        |
| 96+              | 3      | 0      | 1       | 0%         |

Total: 28 functions tested, 8 EQUIV, 1 SAT (false positive from ABI precondition), 13 timeout, 4 skipped (unsupported instructions), 2 error (`unit` constant). Median solve time: 122.6s, p90: 256.4s, max: 256.4s.

Notable: relaxed csmith with pointers generates much higher raw memory operation counts (48–106 src mem ops common) than strict mode. Store-load forwarding reduces effective target mem ops dramatically (most functions show 4 mem ops in target), but the source-side complexity still drives solver difficulty. Two high-mem-ops functions solved: `func_55` (49 src → 6 tgt, 0.0s) and `func_38` (61 src → 6 tgt, sat/FP). The practical solvability boundary in relaxed mode remains ~12 source mem ops, similar to strict mode.

### Z3 Spacer configuration

Z3 is invoked with `set-logic HORN`, which routes to the Spacer engine automatically. Default Spacer parameters (Z3 4.15.4):

| Parameter | Default | Description |
|-----------|---------|-------------|
| `spacer.global` | false | Global guidance strategy |
| `spacer.mbqi` | true | Model-based quantifier instantiation |
| `spacer.q3` | true | Quantifier handling |
| `spacer.ground_pobs` | true | Ground proof obligations |
| `spacer.ctp` | true | Counterexample-to-proof |
| `spacer.use_array_eq_generalizer` | true | Array equality generalizer |
| `xform.inline_eager` | true | Eagerly inline relations |
| `xform.inline_linear` | true | Inline linear rules |
| `xform.inline_linear_branch` | false | Inline linear branch rules |
| `xform.coalesce_rules` | false | Coalesce rules |
| `xform.array_blast` | false | Array blasting |

Both `csmith_ricover_e2e.py` and `run_bench.py` now accept `--z3-flags` to pass extra Spacer parameters:

```bash
python3 csmith_ricover_e2e.py -n 5 --z3-flags fp.spacer.global=true fp.xform.coalesce_rules=true
python benchmark/run_bench.py bench.s --z3-flags fp.spacer.global=true
```

### Spacer flag experiment results

Tested 7 configurations on Csmith-generated queries (6 queries: 2 fast, 2 borderline, 2 timeout). Use `spacer_flags_experiment.py` to reproduce:

```bash
python3 spacer_flags_experiment.py --from-benchmarks --timeout 300
python3 spacer_flags_experiment.py /path/to/*.smt2 --timeout 300 --configs baseline global coalesce
```

Results on fast queries (5–10 mem ops, baseline ~25–48s):

| Config | Median time | vs baseline |
|--------|-------------|-------------|
| coalesce | 43.3s | −9% |
| inline_branch | 44.7s | −6% |
| baseline | 47.8s | — |
| global | 47.7s | ~0% |
| global+inline | 46.8s | −2% |
| no_array_gen | 49.1s | +3% |
| **array_blast** | **78.1s** | **+63%** |

Results on borderline queries (9–12 mem ops, baseline ~170s):

| Config | Median time | vs baseline |
|--------|-------------|-------------|
| baseline | 170.6s | — |
| global | 170.7s | ~0% |
| inline_branch | 172.0s | +1% |
| global+inline | 174.6s | +2% |
| coalesce | 176.3s | +3% |
| **no_array_gen** | **190.6s** | **+12%** |

Results on relaxed csmith queries (pointers enabled, `--relaxed --max-instrs 500`, 8–17 mem ops, 300s timeout):

| Config | Solved / Total | Median time | Notable |
|--------|----------------|-------------|---------|
| baseline | 5/8 | 117.9s | — |
| global | 5/8 | 118.0s | ~0% |
| no_array_gen | 5/8 | 117.9s | func_28: fastest (83.8s) |
| inline_branch | 5/8 | 118.2s | func_28: +65% slower (146.8s) |
| global+inline | 5/8 | 118.5s | |
| coalesce | 5/8 | 121.0s | func_99: +15% slower (246.9s vs 214.7s) |

No configuration flipped a timeout to a solve. On individual queries, some configs show up to 60% variance in either direction, but no config is consistently better across all queries.

**Conclusions:**
- No configuration solved queries that baseline couldn't — tested across 3 datasets (manual benchmarks, strict csmith, relaxed csmith)
- `coalesce_rules` gives ~9% speedup on simple queries but hurts on harder ones
- `spacer.global` (global guidance) has negligible effect on this CHC structure
- `array_blast` is actively harmful (+63% slower) — blasting arrays into scalars explodes the variable count
- `use_array_eq_generalizer=false` hurts on hard queries (+12%) — the generalizer is doing useful work
- Individual query variance (up to ±60%) exceeds inter-config variance — solver behavior is sensitive to CHC structure, not flag tuning
- The bottleneck is fundamental array-theory complexity, not Spacer heuristic configuration
- The default Z3 configuration is near-optimal for RICOVER's CHC encoding

## Design Notes

- Uses `-Xclang -disable-O0-optnone` so that `opt` passes actually fire on O0 IR (otherwise clang marks all functions with the `optnone` attribute)
- Uses `--no-global-variables` in csmith to avoid `%hi/%lo` relocations that RICOVER can't handle
- Strips `static` from csmith output so functions are externally visible
- Imports `split_into_functions`, `has_relocation`, `generate_ricover_file` from `riscv_opt_diff.py`
