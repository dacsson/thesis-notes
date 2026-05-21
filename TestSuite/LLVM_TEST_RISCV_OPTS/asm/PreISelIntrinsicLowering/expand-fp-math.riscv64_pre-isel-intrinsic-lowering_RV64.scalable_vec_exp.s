# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpk8dap68b.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpk8dap68b.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@scalable_vec_sin'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a73cbd3e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a73cbd0c87
2  libc.so.6 0x00007f4f6b94f4d0
3  libc.so.6 0x00007f4f6b9a990c
4  libc.so.6 0x00007f4f6b94f3a0 gsignal + 32
5  libc.so.6 0x00007f4f6b93657a abort + 38
6  llc       0x000055a73b1a346f
7  llc       0x000055a73cafe228
8  llc       0x000055a73bd4c0a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x000055a73c806c9e
10 llc       0x000055a73c87596a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x000055a73c90ed4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x000055a73c90f904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000055a73c8fcce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055a73ba668c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x000055a73c048fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x000055a73c0492c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x000055a73c048464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x000055a73b2
# Source: PreISelIntrinsicLowering/expand-fp-math.riscv64_pre-isel-intrinsic-lowering_RV64.ll
# Function: scalable_vec_exp
