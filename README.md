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
## Reading list
- [ ] Islaris: Verification of Machine Code Against Authoritative ISA Semantics
- [ ] [H. B. Enderton. A Mathematical Introduction to Logic. Undergraduate Texts in Mathematics. Academic Press, second edition edition, 2000.](https://sistemas.fciencias.unam.mx/~lokylog/images/Notas/la_aldea_de_la_logica/Libros_notas_varios/L_03_ENDERTON_A%20Mathematical%20Introduction%20to%20Logic,%20Second%202Ed.pdf)
- [ ] Bjorner et al. [Horn Clause Solvers for Program Verification](https://link.springer.com/chapter/10.1007%2F978-3-319-23534-9_2)
	- [ ] [paper](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/nbjorner-yurifest.pdf)
- [ ] [Analysis and Transformation of CHC for Verification, De Angelis et al. ](https://arxiv.org/pdf/2108.00739)
- [ ] A. Komuravelli, N. Bjørner, A. Gurfinkel, K. L. McMillan:Compositional Verification of Procedural Programs using Horn Clauses over Integers and Arrays. FMCAD 2015
- [ ] A. Gurfinkel and J. Navas. [Automatic Program Verification with Seahorn](https://arieg.bitbucket.io/pdf/seahorn_marktoberdorf_2018.pdf)
- [ ] A. Gurfinkel. [IC3, PDR, and Friends](https://arieg.bitbucket.io/pdf/gurfinkel_ssft15.pdf)
- [ ] [Understanding IC3, Aaron R. Bradley](https://theory.stanford.edu/~arbrad/papers/Understanding_IC3.pdf)
- [ ] Handbook of SAT
- [x] Verifying Optimizations using SMTSolvers
- [ ] Formal Verification of SSA-Based Optimizations for LLVM
- [ ] Compiler Optimization Testing Based on Optimization-Guided Equivalence Transformations
## Existing configurations

| Target   | Approach                                                         | Semantic modeling     | Host                        | Used in | Cons                                                                                                                                                                                            |
| -------- | ---------------------------------------------------------------- | --------------------- | --------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LLVM-IR  | Formal semantics + proving, modeling semantics, interpreter-like | Formal, full modeling | Theorem Prover (i.e. Coq)   | Vellvm  | - Uses inline assertions (pasted into \*.ll file as comments) for testing<br>- Libs cannot be used<br>- Cannot straight up run llvm test suite in it (presumably)<br>- No concurrency analyzing |
| LLVM-IR  | Eq. checking via SMT                                             | Symbolic, partial     | SMT (+ Symbolic execution?) | Alive2  | - Provides model (counter-example) but no fix proposal<br>- Some problems with memory model                                                                                                     |
| Assembly | Lift (AArch64) ASM to LLVM-IR                                    | Partial               | LLVM-IR (Alive2)            | arm-tv  | - Relies on Alive2<br>- Performance and result is tied to how well the lifting goes<br>- Reuses LLVM-IR instead of focusing on asm                                                              |
| Assembly |                                                                  | Formal                | ThProver                    | x       |                                                                                                                                                                                                 |
| Assembly |                                                                  | Partial               | SMT                         | x       |                                                                                                                                                                                                 |

## Thesis name

For now: "Формальная проверка корректности оптимизаций RISC-V программ"
