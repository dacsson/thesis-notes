# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpcywg2u5q.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcywg2u5q.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vector_operands'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000564238c35e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000564238c32c87
2  libc.so.6 0x00007f9a4194f4d0
3  libc.so.6 0x00007f9a419a990c
4  libc.so.6 0x00007f9a4194f3a0 gsignal + 32
5  libc.so.6 0x00007f9a4193657a abort + 38
6  llc       0x000056423720546f
7  llc       0x0000564238b60228
8  llc       0x0000564238a38e39
9  llc       0x0000564238a392af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x000056423896d188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x000056423896f76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x0000564238971904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000056423895ece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x0000564237ac88c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x00005642380aafe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x00005642380ab2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x00005642380aa464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x0000564237311afd
19 llc       0x0000564237218c8d main + 1181
20 libc.so.6 0x00007f9a41938635
21 libc.so.6 0x00007f9a419386
# Source: LoopUnroll/vector.riscv64_COMMON.ll
# Function: saxpy_tripcount1K_av1
