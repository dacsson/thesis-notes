# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpquw2zj0k.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpquw2zj0k.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000559270f74e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000559270f71c87
2  libc.so.6 0x00007f31eb1224d0
3  libc.so.6 0x00007f31eb17c90c
4  libc.so.6 0x00007f31eb1223a0 gsignal + 32
5  libc.so.6 0x00007f31eb10957a abort + 38
6  llc       0x000055926f54446f
7  llc       0x0000559270e9f228
8  llc       0x0000559270d77e39
9  llc       0x0000559270d782af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x0000559270cac188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x0000559270cae76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x0000559270cb0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x0000559270c9dce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055926fe078c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x00005592703e9fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x00005592703ea2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x00005592703e9464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x000055926f650afd
19 llc       0x000055926f557c8d main + 1181
20 libc.so.6 0x00007f31eb10b635
21 libc.so.6 0x00007f31eb10b6e9 __libc_st
# Source: LoopUnroll/invalid-cost.riscv64_loop-unroll.ll
# Function: invalid
