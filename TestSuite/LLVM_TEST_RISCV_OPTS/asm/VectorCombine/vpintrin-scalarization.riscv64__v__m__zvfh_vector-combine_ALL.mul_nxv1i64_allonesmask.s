# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp57q3nm0c.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp57q3nm0c.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055d0ff55de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055d0ff55ac87
2  libc.so.6 0x00007f52a06204d0
3  libc.so.6 0x00007f52a067a90c
4  libc.so.6 0x00007f52a06203a0 gsignal + 32
5  libc.so.6 0x00007f52a060757a abort + 38
6  llc       0x000055d0fdb2d46f
7  llc       0x000055d0ff488269
8  llc       0x000055d0ff27253d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055d0ff36ec8d
10 llc       0x000055d0ff3774e2
11 llc       0x000055d0ff378b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055d0ff2951f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055d0ff29776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055d0ff299904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055d0ff286ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055d0fe3f08c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055d0fe9d2fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055d0fe9d32c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: mul_nxv1i64_allonesmask
