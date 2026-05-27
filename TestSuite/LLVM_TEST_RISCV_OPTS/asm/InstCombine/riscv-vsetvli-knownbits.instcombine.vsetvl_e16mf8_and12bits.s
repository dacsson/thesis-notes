# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpw89qa771.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpw89qa771.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055abfd560e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055abfd55dc87
2  libc.so.6 0x00007f5a089224d0
3  libc.so.6 0x00007f5a0897c90c
4  libc.so.6 0x00007f5a089223a0 gsignal + 32
5  libc.so.6 0x00007f5a0890957a abort + 38
6  llc       0x000055abfbb3046f
7  llc       0x000055abfd48b269
8  llc       0x000055abfbe5a208
9  llc       0x000055abfd1aa75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055abfd36334d
11 llc       0x000055abfd4307a0
12 llc       0x000055abfd363d4a
13 llc       0x000055abfd3642af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055abfd298188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055abfd29a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055abfd29c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055abfd289ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055abfc3f38c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055abfc9d5fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055abfc9d62c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16mf8_and12bits
