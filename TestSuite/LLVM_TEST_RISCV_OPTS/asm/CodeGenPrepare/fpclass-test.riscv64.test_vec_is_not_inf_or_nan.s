# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpyxbzgqbu.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpyxbzgqbu.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@test_vec_is_inf_or_nan'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c103fb6e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c103fb3c87
2  libc.so.6 0x00007f4dbc24d4d0
3  libc.so.6 0x00007f4dbc2a790c
4  libc.so.6 0x00007f4dbc24d3a0 gsignal + 32
5  libc.so.6 0x00007f4dbc23457a abort + 38
6  llc       0x000055c10258646f
7  llc       0x000055c103ee1228
8  llc       0x000055c10312f0a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x000055c103be9c9e
10 llc       0x000055c103c5896a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x000055c103cf1d4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x000055c103cf2904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000055c103cdfce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055c102e498c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x000055c10342bfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x000055c10342c2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x000055c10342b464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x00005
# Source: CodeGenPrepare/fpclass-test.riscv64.ll
# Function: test_vec_is_not_inf_or_nan
