# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmplvl868ua.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmplvl868ua.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000555b90f1ce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000555b90f19c87
2  libc.so.6 0x00007fb3c304d4d0
3  libc.so.6 0x00007fb3c30a790c
4  libc.so.6 0x00007fb3c304d3a0 gsignal + 32
5  libc.so.6 0x00007fb3c303457a abort + 38
6  llc       0x0000555b8f4ec46f
7  llc       0x0000555b90e47269
8  llc       0x0000555b8f816208
9  llc       0x0000555b90b6675f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000555b90d1f34d
11 llc       0x0000555b90dc9e0b
12 llc       0x0000555b90d1fd1e
13 llc       0x0000555b90d202af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000555b90c54188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000555b90c5676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000555b90c58904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000555b90c45ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000555b8fdaf8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000555b90391fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000555b903922c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: negative_scalar
