[[Translation Validation for LLVM’s AArch64 Backend]]

## Gist
- formally verifies translations between LLVM IR and AArch64 (64-bit ARM) code.
- is a checking validator that enforces numerous ABI rules
- extended Alive2 (which they reuse as a verification backend) to deal with unstructured mixes of pointers and integers that are typical of assembly code