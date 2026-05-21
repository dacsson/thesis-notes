# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp800pkpuh.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp800pkpuh.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000563381351e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056338134ec87
2  libc.so.6 0x00007f633aa4d4d0
3  libc.so.6 0x00007f633aaa790c
4  libc.so.6 0x00007f633aa4d3a0 gsignal + 32
5  libc.so.6 0x00007f633aa3457a abort + 38
6  llc       0x000056337f92146f
7  llc       0x000056338127c269
8  llc       0x000056338106653d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000563381162c8d
10 llc       0x000056338116b4e2
11 llc       0x000056338116cb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005633810891f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056338108b76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056338108d904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056338107ace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005633801e48c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005633807c6fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005633807c72c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: or_nxv1i64_allonesmask
