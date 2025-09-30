## The Gist of It 

It was suggested that we somehow *prove* that a sequence of instructions/program before optimization and after is equivalent.

Now, we can do it by *fuzzing* or *logically* using SMT solvers, maybe there is a combined approach.

But first I need to understand the state of the art for this kind of proves. 

## Materials 

1. [[Compiler Optimization Testing Based on Optimization-Guided Equivalence Transformations]]
2. [[Verifying Optimizations using SMTSolvers]]
3. [[Formal Verification of SSA-Based Optimizations for LLVM]]
	- ["Vellvm - Verifying the LLVM" by Steve Zdancewic | youtube ](https://www.youtube.com/watch?v=q6gSC3OxB_8)
4. [[Finding and Understanding Bugs in C Compilers]]
5. [[Alive2 Bounded Translation Validation for LLVM]]
	- [Alive2: Verifying Existing Optimizations | youtube](https://www.youtube.com/watch?v=paJhdBp_iA4)
6.  [[Translation Validation for LLVM’s AArch64 Backend]]
	- [Formal-Methods-Based Bugfinding for LLVM’s AArch64 Backend](https://blog.regehr.org/archives/2265)
## Tools to review 
- [[Vellvm]]
- YARPGen
- MopFuzzer
- [[CompCert]]
- [[Alive2]]
- [[ARM-TV]]
## Ideas
- Translation of RISC-V asm to \*.smt2 with proof afterwords
- Vellvm, but semantics is RISC-V (using riscv-sail-model) instead of LLVM-IR 
- Something like [[ARM-TV]] but for RISC-V

## Existing configurations

| Target   | Approach                                                         | Semantic modeling     | Host                        | Used in | Cons                                                                                                                                                                                            |
| -------- | ---------------------------------------------------------------- | --------------------- | --------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LLVM-IR  | Formal semantics + proving, modeling semantics, interpreter-like | Formal, full modeling | Theorem Prover (i.e. Coq)   | Vellvm  | - Uses inline assertions (pasted into \*.ll file as comments) for testing<br>- Libs cannot be used<br>- Cannot straight up run llvm test suite in it (presumably)<br>- No concurrency analyzing |
| LLVM-IR  | Eq. checking via SMT                                             | Symbolic, partial     | SMT (+ Symbolic execution?) | Alive2  | - Provides model (counter-example) but no fix proposal<br>- Some problems with memory model                                                                                                     |
| Assembly | Lift (AArch64) ASM to LLVM-IR                                    | Partial               | LLVM-IR (Alive2)            | arm-tv  | - Relies on Alive2<br>- Performance and result is tied to how well the lifting goes<br>- Reuses LLVM-IR instead of focusing on asm                                                              |
| Assembly |                                                                  | Formal                | ThProver                    | x       |                                                                                                                                                                                                 |
| Assembly |                                                                  | Partial               | SMT                         | x       |                                                                                                                                                                                                 |

## Possible configurations

| Target     | Approach | Semantic modeling              | Host                  | Comment                                                                                                                                                             |
| ---------- | -------- | ------------------------------ | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LLVM-IR    |          | Formal, Full semantic modeling | Coq/Lean4/Idris2 etc. | - Huge ammount of work (full LLVM interpreter?)<br>- Maybe instead of inline assertions (tests in Vellvm) do post-pre conditions and then translate to Why3 or smth |
| LLVM-IR    |          | Partial, symbolic              | SMT (i.e. z3)         | - no idea what can be done different from Alive2                                                                                                                    |
| RISC-V asm |          | Formal                         | Coq/Lean4/Idris2 etc. | - RISC-V interpreter is not that hard to implement, if not going into some extensions<br>- Semantics are here: riscv-isa-manual (SAIL model)                        |
| RISC-V asm |          | Perial, symbolic               | SMT (i.e. z3)         | - Maybe focus on a single extension (i.e. Vector)<br>- Can empower auto-vec compiler testing?                                                                       |
