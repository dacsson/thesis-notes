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
```

## Options

| Flag | Default | Description |
|------|---------|-------------|
| `-n` | 1 | Number of csmith programs to generate |
| `--passes` | (all defaults) | Custom opt pass pipelines (space-separated) |
| `-o` | `/tmp/ricover_csmith_e2e` | Output directory |
| `--llc-opt` | 1 | LLC optimization level for both sides (0/1/2) |
| `--z3-timeout` | 60 | Z3 solver timeout in seconds |
| `--max-instrs` | 200 | Skip functions with more than N base instructions |
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

## Design Notes

- Uses `-Xclang -disable-O0-optnone` so that `opt` passes actually fire on O0 IR (otherwise clang marks all functions with the `optnone` attribute)
- Uses `--no-global-variables` in csmith to avoid `%hi/%lo` relocations that RICOVER can't handle
- Strips `static` from csmith output so functions are externally visible
- Imports `split_into_functions`, `has_relocation`, `generate_ricover_file` from `riscv_opt_diff.py`
