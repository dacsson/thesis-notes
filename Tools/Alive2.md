https://github.com/AliveToolkit/alive2

## Why is this interesting?

Does exactly what we wanted to do (sort-a)! You feed it pre-opt LLVM-IR and post-opt LLVM-IR and then it emits whether optimization is correct, i.e. (i presume) are they semantically equivalent?
## Gist
- Automatic verification of LLVM optimizations
- Only finds bugs, reports model 
- Zero false-positives claimed
- Takes before and after and checks:
![[Img/Pasted image 20250927200044.png]]
- Also there is direct inclusion in llvm-infra via opt:
![[Img/Pasted image 20250927200150.png]]
![[Pasted image 20250927200215.png]]
- Using obj-to-ir disasm to check backends
- more than 900 issues in the LLVM project’s GitHub issue tracker contain links to our online version of Alive2
## Example
- https://alive2.llvm.org/ce/z/zA5SbP
![[Img/Pasted image 20250927195412.png]]
Integration with `opt` from llvm:
![[Img/Pasted image 20250927200901.png]]