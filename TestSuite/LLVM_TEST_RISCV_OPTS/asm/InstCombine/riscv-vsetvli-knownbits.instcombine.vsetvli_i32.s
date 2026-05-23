# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpcl0aqtre.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcl0aqtre.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a00abd4e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a00abd1c87
2  libc.so.6 0x00007f5e9dc4d4d0
3  libc.so.6 0x00007f5e9dca790c
4  libc.so.6 0x00007f5e9dc4d3a0 gsignal + 32
5  libc.so.6 0x00007f5e9dc3457a abort + 38
6  llc       0x000055a0091a446f
7  llc       0x000055a00aaff269
8  llc       0x000055a0094ce208
9  llc       0x000055a00a81e75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055a00a9d734d
11 llc       0x000055a00aaa47a0
12 llc       0x000055a00a9d7d4a
13 llc       0x000055a00a9d82af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055a00a90c188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055a00a90e76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055a00a910904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055a00a8fdce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055a009a678c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055a00a049fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055a00a04a2c3 llvm::FPPassManager::
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvli_i32
