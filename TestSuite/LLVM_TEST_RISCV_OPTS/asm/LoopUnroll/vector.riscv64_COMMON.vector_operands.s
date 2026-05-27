# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpcd4cusjx.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcd4cusjx.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000557a770bce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000557a770b9c87
2  libc.so.6 0x00007fde1434f4d0
3  libc.so.6 0x00007fde143a990c
4  libc.so.6 0x00007fde1434f3a0 gsignal + 32
5  libc.so.6 0x00007fde1433657a abort + 38
6  llc       0x0000557a7568c46f
7  llc       0x0000557a76fe7228
8  llc       0x0000557a76ebfe39
9  llc       0x0000557a76ec02af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x0000557a76df4188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x0000557a76df676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x0000557a76df8904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x0000557a76de5ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x0000557a75f4f8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x0000557a76531fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x0000557a765322c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x0000557a76531464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x0000557a75798afd
19 llc       0x0000557a7569fc8d main + 1181
20 libc.so.6 0x00007fde14338635
21 libc.so.6 0x00007fde143386e9 __libc_st
# Source: LoopUnroll/vector.riscv64_COMMON.ll
# Function: vector_operands
