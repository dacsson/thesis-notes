# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmp6ks5xsvw.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6ks5xsvw.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vector_operands'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c24d1cee29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c24d1cbc87
2  libc.so.6 0x00007fd9ab54f4d0
3  libc.so.6 0x00007fd9ab5a990c
4  libc.so.6 0x00007fd9ab54f3a0 gsignal + 32
5  libc.so.6 0x00007fd9ab53657a abort + 38
6  llc       0x000055c24b79e46f
7  llc       0x000055c24d0f9228
8  llc       0x000055c24cfd1e39
9  llc       0x000055c24cfd22af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x000055c24cf06188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x000055c24cf0876f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x000055c24cf0a904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000055c24cef7ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055c24c0618c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x000055c24c643fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x000055c24c6442c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x000055c24c643464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x000055c24b8aaafd
19 llc       0x000055c24b7b1c8d main + 1181
20 libc.so.6 0x00007fd9ab538635
21 libc.so.6 0x00007fd9ab5386
# Source: LoopUnroll/vector.riscv64_COMMON.ll
# Function: saxpy_tripcount1K_av0
