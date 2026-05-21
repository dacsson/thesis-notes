# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpgsz5dzao.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpgsz5dzao.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055bbb03a4e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055bbb03a1c87
2  libc.so.6 0x00007ff4936204d0
3  libc.so.6 0x00007ff49367a90c
4  libc.so.6 0x00007ff4936203a0 gsignal + 32
5  libc.so.6 0x00007ff49360757a abort + 38
6  llc       0x000055bbae97446f
7  llc       0x000055bbb02cf269
8  llc       0x000055bbb00b953d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055bbb01b5c8d
10 llc       0x000055bbb01be4e2
11 llc       0x000055bbb01bfb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055bbb00dc1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055bbb00de76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055bbb00e0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055bbb00cdce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055bbaf2378c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055bbaf819fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055bbaf81a2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: srem_nxv1i64_allonesmask
