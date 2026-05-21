# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 /tmp/tmpnl75fma2.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpnl75fma2.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000565411873e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000565411870c87
2  libc.so.6 0x00007f6be4f4f4d0
3  libc.so.6 0x00007f6be4fa990c
4  libc.so.6 0x00007f6be4f4f3a0 gsignal + 32
5  libc.so.6 0x00007f6be4f3657a abort + 38
6  llc       0x000056540fe4346f
7  llc       0x000056541179e228
8  llc       0x00005654109ec0a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x00005654114a6c9e
10 llc       0x000056541151596a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x00005654115aed4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x00005654115af904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000056541159cce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x00005654107068c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x0000565410ce8fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x0000565410ce92c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x0000565410ce8464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x000056540ff4fafd
19 llc 
# Source: PreISelIntrinsicLowering/expand-fp-math.riscv32_pre-isel-intrinsic-lowering_RV32.ll
# Function: scalable_vec_sin
