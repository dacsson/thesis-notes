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
6.  [[Formal-Methods-Based Bugfinding for LLVM’s AArch64 Backend]]
## Tools to review 
- [[Vellvm]]
- YARPGen
- MopFuzzer
- [[CompCert]]
- [[Alive2]]
## Ideas
- Translation of RISC-V asm to \*.smt2 with proof afterwords
- Vellvm, but semantics is RISC-V (using riscv-sail-model) instead of LLVM-IR 