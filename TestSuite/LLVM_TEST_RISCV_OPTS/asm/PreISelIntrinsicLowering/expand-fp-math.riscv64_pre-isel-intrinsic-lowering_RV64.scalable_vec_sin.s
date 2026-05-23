# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpplo3tjr8.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpplo3tjr8.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000559bcb944e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000559bcb941c87
2  libc.so.6 0x00007f975804d4d0
3  libc.so.6 0x00007f97580a790c
4  libc.so.6 0x00007f975804d3a0 gsignal + 32
5  libc.so.6 0x00007f975803457a abort + 38
6  llc       0x0000559bc9f1446f
7  llc       0x0000559bcb86f228
8  llc       0x0000559bcaabd0a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x0000559bcb577c9e
10 llc       0x0000559bcb5e696a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x0000559bcb67fd4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x0000559bcb680904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x0000559bcb66dce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x0000559bca7d78c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x0000559bcadb9fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x0000559bcadba2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x0000559bcadb9464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x0000559bca020afd
19 llc 
# Source: PreISelIntrinsicLowering/expand-fp-math.riscv64_pre-isel-intrinsic-lowering_RV64.ll
# Function: scalable_vec_sin
