# RICOVER — RISC-V Compiler Optimization VERification

## Idea

Compiler optimizations transform programs, but may introduce semantic bugs. We verify that RISC-V assembly before and after optimization is semantically equivalent by:

1. Defining instruction semantics from the official RISC-V Sail specification (via Isla IR)
2. Encoding programs as Constrained Horn Clauses (CHC) with state = (PC, registers, memory)
   - We do not compare "private" memory allocations like stack allocation inside function
3. Asking a CHC solver: "is there any initial state where the two programs produce different results?" — UNSAT means equivalent

## Architecture

```
                     ┌──────────────┐
  riscv.ir ────────→ │  isla_ir.rs  │──→ parsed instruction semantics
  (from Sail/Isla)   └──────────────┘           │
                                                ▼
                                        ┌──────────────┐
                                        │  chc_emit.rs │──→ .smt2 output
                                        └──────────────┘       │
  program.s ─────→ ┌──────────────┐            ▲               ▼
  (RISC-V asm)     │ asm_parse.rs │────────────┘          z3 / eldarica
                   └──────────────┘                    (UNSAT = equivalent)
```

- `src/isla_ir.rs` — loads `.ir` files using isla_lib, extracts execute clause bodies
- `src/asm_parse.rs` — parses RISC-V assembly functions into structured instruction sequences
- `src/chc_emit.rs` — translates both into SMT-LIB2 CHC format (`set-logic HORN`)
- `chc_stdlib/stdlib.smt2` — CHC definitions for state, register ops, memory ops
- `examples/foo_equiv_generated.smt2` — example of generated CHC encoding
- `snapshot/rv64d.ir` - an IslaIR RISC-V model translated from Sail

## Build & run

```bash
cargo build
cargo run -- translate-ir -i snapshot/rv64d.ir -o instructions.smt2 -f execute
cargo run -- check-equiv --before foo1.s --after foo2.s -f foo -o query.smt2 -ir snapshot/rv64d.ir
z3 query.smt2   # UNSAT = equivalent, SAT = counterexample
```

The guid on how to run is in @doc/GUIDE.md

### Benchmarks

There is assembly benchmarks at `doc/benchmark/`, currently supported benchmarks are at `doc/benchmark/supported/`, and unsupported benchmarks are at `doc/benchmark/todo/`. You can run them via:
```bash
cd doc/benchmark/supported/
./run_bench.py <benchmark>.s
```

## Conventions

- Rust edition 2024, modules declared in `lib.rs`, CLI in `main.rs`
- Depends on `isla-lib` for Isla IR parsing
- CHC output is SMT-LIB2 format
- State: `(PC: BV64, Regs: Array(BV5 → BV64), Mem: Array(BV64 → BV8))`
- `.ir` files are generated from sail-riscv by `isla-sail`

## Code rules

- Comment only non-obvious logic; do not comment self-explanatory names or trivial blocks
- No premature abstraction — keep it simple, inline is fine until repetition is proven
- Follow standard Rust guidelines: snake_case for variables/functions, CamelCase for types, idiomatic error handling, etc.
