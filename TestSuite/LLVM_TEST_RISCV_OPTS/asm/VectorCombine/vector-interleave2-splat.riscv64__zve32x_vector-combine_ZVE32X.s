# FAILED (src): LLVM ERROR: Support for VLEN==32 is incomplete.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +zve32x /tmp/tmpd6m1msyl.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpd6m1msyl.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000555f84934e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000555f84931c87
2  libc.so.6 0x00007fc20d24d4d0
3  libc.so.6 0x00007fc20d2a790c
4  libc.so.6 0x00007fc20d24d3a0 gsignal + 32
5  libc.so.6 0x00007fc20d23457a abort + 38
6  llc       0x0000555f82f0446f
7  llc       0x0000555f8485f269
8  llc       0x0000555f83236e93
9  llc       0x0000555f8453a4d6
10 llc       0x0000555f8453d354 llvm::SelectionDAG::Legalize() + 612
11 llc       0x0000555f8466c24d llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 445
12 llc       0x0000555f8466e76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000555f84670904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000555f8465dce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x0000555f837c78c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x0000555f83da9fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x0000555f83daa2c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
18 llc       0x0000555f83da9464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
19 llc       0x0000555f83010afd
20 llc       0x0000555f82f17c8d main + 1181
21 libc.so.6 0x00007fc20d236635
22 libc.so.6 0x0
# Source: VectorCombine/vector-interleave2-splat.riscv64__zve32x_vector-combine_ZVE32X.ll
# Function: interleave2_const_splat_nxv16i32
