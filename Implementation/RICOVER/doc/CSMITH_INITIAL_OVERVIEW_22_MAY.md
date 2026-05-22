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
