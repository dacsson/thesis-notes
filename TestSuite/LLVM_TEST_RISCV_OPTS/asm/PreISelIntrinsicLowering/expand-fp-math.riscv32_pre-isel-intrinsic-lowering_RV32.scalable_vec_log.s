# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 /tmp/tmpgv4i7bz0.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpgv4i7bz0.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@scalable_vec_sin'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c780feae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c780fe7c87
2  libc.so.6 0x00007ff954c204d0
3  libc.so.6 0x00007ff954c7a90c
4  libc.so.6 0x00007ff954c203a0 gsignal + 32
5  libc.so.6 0x00007ff954c0757a abort + 38
6  llc       0x000055c77f5ba46f
7  llc       0x000055c780f15228
8  llc       0x000055c7801630a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x000055c780c1dc9e
10 llc       0x000055c780c8c96a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x000055c780d25d4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x000055c780d26904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000055c780d13ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055c77fe7d8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x000055c78045ffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x000055c7804602c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x000055c78045f464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x000055c77f6
# Source: PreISelIntrinsicLowering/expand-fp-math.riscv32_pre-isel-intrinsic-lowering_RV32.ll
# Function: scalable_vec_log
