# Csmith Random Benchmarks

Assembly-level equivalence benchmarks generated from random C programs using csmith, verified with RICOVER + Z3.

## How these were created

### 1. Generate random C programs

```bash
~/Tools/csmith/src/csmith \
  --no-checksum --no-argc --no-global-variables \
  --no-safe-math --no-arrays --no-structs --no-pointers \
  --seed <SEED> > program.c
```

Flags rationale:
- `--no-global-variables`: avoids `%hi/%lo` relocations that RICOVER can't handle
- `--no-safe-math`: removes `safe_add_func_*` wrapper calls (RICOVER verifies single functions, can't handle `call`)
- `--no-arrays --no-structs --no-pointers`: produces register-heavy code with fewer memory operations, reducing array theory complexity for Z3

### 2. Compile to LLVM IR and apply passes

```bash
# Compile C to LLVM IR at O0 (with optnone disabled so opt passes fire)
clang --target=riscv64-linux-gnu --sysroot=/usr/riscv64-linux-gnu \
  -march=rv64gc -mabi=lp64d -O0 -Xclang -disable-O0-optnone \
  -fno-discard-value-names -fno-asynchronous-unwind-tables -fno-unwind-tables \
  -I~/Tools/csmith/runtime -emit-llvm -S -o base.ll program.c

# Generate base assembly
llc -mtriple=riscv64-unknown-linux-gnu -mattr=+m,+a,+f,+d,+c -O1 -o base.s base.ll

# Apply instcombine pass and generate optimized assembly
opt -passes='sroa,instcombine<no-verify-fixpoint>' -S base.ll -o opt.ll
llc -mtriple=riscv64-unknown-linux-gnu -mattr=+m,+a,+f,+d,+c -O1 -o opt.s opt.ll
```

Both sides use the same `llc -O1`, so the only difference comes from the `opt` pass.

### 3. Extract per-function diffs

The `Scripts/riscv_opt_diff.py` tool splits assembly into per-function sections and generates RICOVER-format files (paired `src:` / `tgt:` labels) for functions that differ. Functions with `call` instructions or relocations are filtered out.

### 4. Run RICOVER + Z3

```bash
cd Implementation/RICOVER
for f in ../../TestSuite/csmith/func_*_Obase_vs_instcombine.s; do
  name=$(basename "$f" _Obase_vs_instcombine.s)
  echo "=== $name ==="
  cargo run -q -- check-equiv \
    --before "$f" --after "$f" \
    --before-fn src --after-fn tgt \
    -f "$name" --ir snapshot/rv64d.ir \
    -o "/tmp/${name}.smt2" 2>/dev/null
  z3 -T:300 "/tmp/${name}.smt2"
done
```

## Results (22 May 2026)

Seeds 300-399, instcombine pass, 300s Z3 timeout:

| File | src instrs | tgt instrs | Z3 result | Time |
|------|:----------:|:----------:|:---------:|-----:|
| func_36 | 10 | 8 | **unsat** | 27s |
| func_38 | 11 | 9 | **unsat** | 28s |
| func_29 | 11 | 9 | **unsat** | 29s |
| func_43 | 11 | 9 | **unsat** | 31s |
| func_88 | 11 | 9 | **unsat** | 42s |
| func_12 | 13 | 9 | **unsat** | 77s |
| func_39 | 11 | 9 | **unsat** | 160s |
| func_46 | 10 | 8 | **unsat** | 276s |
| func_17 | 13 | 9 | timeout | 300s |
| func_153 | 12 | 8 | timeout | 300s |

7 of 10 verified equivalent. All instruction semantics are IR-derived from the RISC-V Sail specification (no hand-written fallback rules used).

## Automated pipeline

For bulk generation and testing, use the e2e script:

```bash
cd Scripts
python3 csmith_ricover_e2e.py \
  -n 10 \
  --passes 'sroa,instcombine<no-verify-fixpoint>' \
  --z3-timeout 300 \
  --max-instrs 15 \
  -o /tmp/csmith_run
```
