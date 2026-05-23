# Project Memory

## Scope reviewed

- Reviewed `Implementation/RICOVER` and its docs:
  - `Implementation/RICOVER/CLAUDE.md`
  - `Implementation/RICOVER/doc/GUIDE.md`
  - `Implementation/RICOVER/src/*.rs`
- Reviewed all Markdown outside `Materials/`, including:
  - `README.md`
  - `Topics/*.md`
  - `Tools/*.md`
  - `Tools/Sail/*.md`
  - `Paper Review/*.md`
  - `Days/*.md`
- Explicitly avoided `Materials/` and PDFs inside it.

## Implementation findings

### Main conclusion

`Implementation/RICOVER` builds, but the documented end-to-end equivalence workflow is not implemented yet.

### Concrete findings

1. `check-equiv` is non-functional.
   - `Implementation/RICOVER/src/asm_parse.rs` has `parse_asm_file()` as `todo!`.
   - `Implementation/RICOVER/src/chc_emit.rs` has `emit_equivalence_query()` as `todo!`.
   - `Implementation/RICOVER/src/main.rs` calls both, so `cargo run -- check-equiv ...` panics at runtime.

2. `translate-ir` only emits real CHC for `execute`.
   - For non-`execute` function names, `emit_instruction_chc()` only dumps IR as comments.
   - This contradicts the guide text claiming repeated `-f` translation of functions such as `rX` / `wX`.

3. `execute` translation is hard-coded and fragile.
   - `Implementation/RICOVER/src/chc_emit.rs` assumes a fixed IR layout and slices instruction ranges directly.
   - It currently emits hand-written CHC only for `addi` and one load form (`load_dw`).
   - This is not a general Sail/Isla-to-CHC pipeline yet.

4. The checked-in dependency setup is machine-specific.
   - `Implementation/RICOVER/Cargo.toml` points `isla-lib` to an absolute local path:
     `/home/safonoff/Uni/Thesis/isla/isla-lib`
   - The project therefore is not portable without local manifest edits.

### What was verified

- `cargo test` passes.
- Existing tests only cover:
  - IR parsing
  - presence of some strings in emitted `execute` CHC
- They do not cover:
  - assembly parsing
  - equivalence-query generation
  - end-to-end solver behavior for before/after programs

## Theory/documentation findings

### Main conclusion

The Markdown corpus has a coherent high-level direction, but the core equivalence definition and CHC explanation are still under-specified or inconsistent in ways that matter for the thesis.

### Concrete findings

1. The current equivalence notion is too strong for optimization validation.
   - `Topics/Proving semantic equivalence of RISC-V programs.md` defines final-state equality over:
     - `pc`
     - full register file
     - full memory
   - The February presentation repeats the same idea.
   - This would reject many valid optimizations that preserve observable behavior but change stack layout, scratch memory, or control-flow shape.

2. SAT/UNSAT meaning is inconsistent across docs.
   - `Implementation/RICOVER/doc/GUIDE.md` says:
     - `unsat` = equivalent
     - `sat` = counterexample
   - But the theory notes and CHC paper notes also state the generic slogan:
     - satisfiable Horn clauses correspond to properties that hold
     - unsatisfiable clauses correspond to violated properties
   - Those statements are not universally wrong, but they are encoding-dependent and currently conflict with the project’s intended query shape.

3. The bridge from Sail semantics to CHC is not fully written down.
   - `Topics/Proving semantic equivalence of RISC-V programs.md` still contains TODOs where the crucial translation argument should be.
   - The worked example stops at instruction sketches and does not fully derive the relational equivalence query.

4. Some Markdown meant to explain the project is still draft-quality.
   - A few paper-review files are skeletal or informal placeholders.
   - They are useful personal notes, but not yet reliable explanatory documentation.

## Project narrative distilled

### Intended thesis/tool direction

Build an automatic checker for semantic equivalence of RISC-V code before and after optimization by:

1. Taking formal ISA semantics from RISC-V Sail
2. Accessing them through Isla IR / `isla-lib`
3. Translating instruction semantics into CHC over machine state
4. Translating the before/after assembly programs into chained instruction transitions
5. Asking a CHC solver whether a divergent final observable state is reachable

### Current implementation reality

The repo currently demonstrates only an early prototype of step 3 for a narrow subset:

- parsing Isla IR works
- a minimal CHC stdlib exists
- hard-coded CHC emission exists for `addi` and one load case
- program parsing and equivalence checking are not implemented

## Important assumptions to revisit

1. What is the actual observational equivalence relation?
   - Exact full-state equality is likely too strict.
   - Need a thesis-quality definition of what parts of state are externally observable.

2. How are termination and traps handled?
   - Notes mention partial equivalence and avoiding full termination obligations.
   - This needs a crisp final statement.

3. What is the intended memory model?
   - Early notes mention memory-model concerns.
   - The current stdlib models byte-addressable memory as arrays, but the thesis argument needs to say what is included and ignored.

4. What instruction subset is the thesis target?
   - The prototype currently only handles a tiny subset.
   - The docs should clearly distinguish prototype scope from long-term scope.

## Recommended next steps

1. Write down the exact equivalence notion for optimized RISC-V functions.
2. Align all docs on query polarity (`sat` vs `unsat`) for this project’s encoding.
3. Finish the theoretical Sail -> CHC explanation in `Topics/Proving semantic equivalence of RISC-V programs.md`.
4. Either implement `check-equiv` or clearly mark it as unimplemented in the guide.
5. Replace the absolute `isla-lib` path with a portable setup.

## Files most worth reopening first next time

- `PROJECT_MEMORY.md`
- `Implementation/RICOVER/doc/GUIDE.md`
- `Implementation/RICOVER/CLAUDE.md`
- `Implementation/RICOVER/src/chc_emit.rs`
- `Implementation/RICOVER/src/asm_parse.rs`
- `Topics/Proving semantic equivalence of RISC-V programs.md`
- `Topics/Constrained Horn Clauses.md`
