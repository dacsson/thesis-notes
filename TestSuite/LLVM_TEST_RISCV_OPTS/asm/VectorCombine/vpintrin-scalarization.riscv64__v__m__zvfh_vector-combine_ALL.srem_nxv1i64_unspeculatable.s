# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpn6xlfkcy.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpn6xlfkcy.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000563b10540e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000563b1053dc87
2  libc.so.6 0x00007f3e6af4f4d0
3  libc.so.6 0x00007f3e6afa990c
4  libc.so.6 0x00007f3e6af4f3a0 gsignal + 32
5  libc.so.6 0x00007f3e6af3657a abort + 38
6  llc       0x0000563b0eb1046f
7  llc       0x0000563b1046b269
8  llc       0x0000563b1025553d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000563b10351c8d
10 llc       0x0000563b1035a4e2
11 llc       0x0000563b1035bb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000563b102781f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000563b1027a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000563b1027c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000563b10269ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000563b0f3d38c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000563b0f9b5fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000563b0f9b62c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: srem_nxv1i64_unspeculatable
