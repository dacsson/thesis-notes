# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpoja7m6w9.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpoja7m6w9.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@test_vec_is_inf_or_nan'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a4b8309e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a4b8306c87
2  libc.so.6 0x00007f0bb1b4f4d0
3  libc.so.6 0x00007f0bb1ba990c
4  libc.so.6 0x00007f0bb1b4f3a0 gsignal + 32
5  libc.so.6 0x00007f0bb1b3657a abort + 38
6  llc       0x000055a4b68d946f
7  llc       0x000055a4b8234228
8  llc       0x000055a4b74820a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x000055a4b7f3cc9e
10 llc       0x000055a4b7fab96a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x000055a4b8044d4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x000055a4b8045904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000055a4b8032ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055a4b719c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x000055a4b777efe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x000055a4b777f2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x000055a4b777e464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x00005
# Source: CodeGenPrepare/fpclass-test.riscv64.ll
# Function: test_vec_is_not_inf
