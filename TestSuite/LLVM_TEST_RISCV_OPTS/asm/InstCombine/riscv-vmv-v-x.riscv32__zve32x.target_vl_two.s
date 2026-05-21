# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpl856eqar.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpl856eqar.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055b779f53e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055b779f50c87
2  libc.so.6 0x00007f757b94f4d0
3  libc.so.6 0x00007f757b9a990c
4  libc.so.6 0x00007f757b94f3a0 gsignal + 32
5  libc.so.6 0x00007f757b93657a abort + 38
6  llc       0x000055b77852346f
7  llc       0x000055b779e7e269
8  llc       0x000055b77884d208
9  llc       0x000055b779b9d75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055b779d5634d
11 llc       0x000055b779e00e0b
12 llc       0x000055b779d56d1e
13 llc       0x000055b779d572af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055b779c8b188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055b779c8d76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055b779c8f904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055b779c7cce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055b778de68c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055b7793c8fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055b7793c92c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: target_vl_two
