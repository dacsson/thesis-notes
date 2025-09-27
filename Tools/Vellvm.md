https://github.com/vellvm/vellvm

## Why is this interesting?

Doesn't use SMT solvers, instead models the semantic of LLVM-IR
## Gist
- a Coq-based formal semantics of the LLVM IR.
- built in semantic model of LLVM-IR in Coq
- Tells how to transform our code, unlike Alive2
- Not model checking/SMT
- Essentially an interpreter of LLVM-IR in Coq with proofs

## Framework
![[Img/Pasted image 20250927194350.png]]

![[Img/Pasted image 20250927194453.png]]