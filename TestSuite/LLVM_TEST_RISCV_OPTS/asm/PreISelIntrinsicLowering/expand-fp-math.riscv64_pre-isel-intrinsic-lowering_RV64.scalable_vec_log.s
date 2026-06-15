# FAILED (src): LLVM ERROR: Don't know how to legalize this scalable vector type
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmp7in800ov.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp7in800ov.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@scalable_vec_sin'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005613b66d6e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005613b66d3c87
2  libc.so.6 0x00007f645ee4d4d0
3  libc.so.6 0x00007f645eea790c
4  libc.so.6 0x00007f645ee4d3a0 gsignal + 32
5  libc.so.6 0x00007f645ee3457a abort + 38
6  llc       0x00005613b4ca646f
7  llc       0x00005613b6601228
8  llc       0x00005613b584f0a3 llvm::TargetLoweringBase::getVectorTypeBreakdown(llvm::LLVMContext&, llvm::EVT, llvm::EVT&, unsigned int&, llvm::MVT&) const + 3059
9  llc       0x00005613b6309c9e
10 llc       0x00005613b637896a llvm::SelectionDAGISel::LowerArguments(llvm::Function const&) + 11242
11 llc       0x00005613b6411d4c llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 9196
12 llc       0x00005613b6412904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x00005613b63ffce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x00005613b55698c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x00005613b5b4bfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x00005613b5b4c2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x00005613b5b4b464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x00005613b4d
# Source: PreISelIntrinsicLowering/expand-fp-math.riscv64_pre-isel-intrinsic-lowering_RV64.ll
# Function: scalable_vec_log
