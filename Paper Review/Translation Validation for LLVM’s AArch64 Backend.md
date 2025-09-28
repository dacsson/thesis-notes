[[Translation Validation for LLVM’s AArch64 Backend.pdf]]

## Why is this interesting?

Something specifically tailored to a certain backend (AArch)
## arm-tv

Essentially they took [[Alive2]] as a backend (for LLVM-IR semantics) and built a tool with AArch64 semantics on top of it. 

How they modeled AArch64 semantics? There is a ARM’s machine-readable architecture (MRA), which specifies the behavior of each instruction using **ASL4** (Architecture Specification Language) *(RISC-V has riscv-sail)* . But the language was too large to operate on so they took some tool that does partial evaluation of ASL4 ([ASLp](https://rina.fyi/slides_2023.pdf)), some instructions they just written by hands. arm-tv assigns a formal semantics to AArch64 code by *lifting* it to LLVM IR. 

Given a function to validate, the top-level steps performed by **arm-tv** are:
1. Invoke LLVM’s AArch64 backend, lowering the function to assembly.
2.  Lift the assembly back to LLVM IR, being careful to preserve refinement. We offer a choice between a hand-written lifter that tends to produce idiomatic LLVM IR and a mechanically generated lifter that makes direct use of ARM’s machine-readable architecture.
3. Run the LLVM middle end optimizer on the lifted IR. Typically, this makes it substantially more compact.
4. Verify that the lifted and optimized LLVM IR refines the original IR using a version of Alive2 that we modified to support an assembly-level memory model.

![[Img/Pasted image 20250928150950.png]]

> Fig. 1. How arm-tv performs translation validation. The top-level correctness property that we check is
that the compiler’s output refines its input. Thin arrows indicate transformations that are intended, by their
respective authors, to be refinements. If each of them is a refinement, then the double arrow at the top must
also be a refinement, since refinement is compositional. If this final refinement relation—which we check
using Alive2—does not hold, then at least one of the three other purported refinements must have been
defective, in which case either we or the LLVM developers have a bug to fix. Section 2.2 explains why the
lifted code is so much longer than both the original and AArch64 functions.