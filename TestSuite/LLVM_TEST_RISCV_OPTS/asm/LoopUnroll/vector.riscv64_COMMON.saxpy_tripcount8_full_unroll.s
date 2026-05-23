# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmp6za2r253.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6za2r253.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vector_operands'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005636fd07be29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005636fd078c87
2  libc.so.6 0x00007f5f6af4f4d0
3  libc.so.6 0x00007f5f6afa990c
4  libc.so.6 0x00007f5f6af4f3a0 gsignal + 32
5  libc.so.6 0x00007f5f6af3657a abort + 38
6  llc       0x00005636fb64b46f
7  llc       0x00005636fcfa6228
8  llc       0x00005636fce7ee39
9  llc       0x00005636fce7f2af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x00005636fcdb3188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x00005636fcdb576f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x00005636fcdb7904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x00005636fcda4ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x00005636fbf0e8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x00005636fc4f0fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x00005636fc4f12c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x00005636fc4f0464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x00005636fb757afd
19 llc       0x00005636fb65ec8d main + 1181
20 libc.so.6 0x00007f5f6af38635
21 libc.so.6 0x00007f5f6af386
# Source: LoopUnroll/vector.riscv64_COMMON.ll
# Function: saxpy_tripcount8_full_unroll
