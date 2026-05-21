# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp502y1yic.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp502y1yic.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056535f4c8e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056535f4c5c87
2  libc.so.6 0x00007fc2d9c4d4d0
3  libc.so.6 0x00007fc2d9ca790c
4  libc.so.6 0x00007fc2d9c4d3a0 gsignal + 32
5  libc.so.6 0x00007fc2d9c3457a abort + 38
6  llc       0x000056535da9846f
7  llc       0x000056535f3f3269
8  llc       0x000056535f1dd53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000056535f2d9c8d
10 llc       0x000056535f2e24e2
11 llc       0x000056535f2e3b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056535f2001f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056535f20276f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056535f204904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056535f1f1ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000056535e35b8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000056535e93dfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000056535e93e2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: sdiv_nxv1i64_allonesmask
