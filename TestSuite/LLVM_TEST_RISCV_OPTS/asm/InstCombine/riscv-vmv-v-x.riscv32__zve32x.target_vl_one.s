# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpkyinp9j4.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpkyinp9j4.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005608e3157e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005608e3154c87
2  libc.so.6 0x00007f69ec7224d0
3  libc.so.6 0x00007f69ec77c90c
4  libc.so.6 0x00007f69ec7223a0 gsignal + 32
5  libc.so.6 0x00007f69ec70957a abort + 38
6  llc       0x00005608e172746f
7  llc       0x00005608e3082269
8  llc       0x00005608e1a51208
9  llc       0x00005608e2da175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005608e2f5a34d
11 llc       0x00005608e3004e0b
12 llc       0x00005608e2f5ad1e
13 llc       0x00005608e2f5b2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005608e2e8f188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005608e2e9176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005608e2e93904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005608e2e80ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005608e1fea8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005608e25ccfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005608e25cd2c3 llvm::FPPassMan
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: target_vl_one
