# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmp28ivqu3w.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp28ivqu3w.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vector_operands'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000561c7e76ae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000561c7e767c87
2  libc.so.6 0x00007f071804d4d0
3  libc.so.6 0x00007f07180a790c
4  libc.so.6 0x00007f071804d3a0 gsignal + 32
5  libc.so.6 0x00007f071803457a abort + 38
6  llc       0x0000561c7cd3a46f
7  llc       0x0000561c7e695228
8  llc       0x0000561c7e56de39
9  llc       0x0000561c7e56e2af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x0000561c7e4a2188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x0000561c7e4a476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x0000561c7e4a6904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x0000561c7e493ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x0000561c7d5fd8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x0000561c7dbdffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x0000561c7dbe02c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x0000561c7dbdf464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x0000561c7ce46afd
19 llc       0x0000561c7cd4dc8d main + 1181
20 libc.so.6 0x00007f0718036635
21 libc.so.6 0x00007f07180366
# Source: LoopUnroll/vector.riscv64_COMMON.ll
# Function: reverse
