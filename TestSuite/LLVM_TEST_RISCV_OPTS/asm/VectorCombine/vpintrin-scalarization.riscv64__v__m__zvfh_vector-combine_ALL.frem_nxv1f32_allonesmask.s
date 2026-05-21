# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpf7mj7ne1.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpf7mj7ne1.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005576b49cae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005576b49c7c87
2  libc.so.6 0x00007f795fe204d0
3  libc.so.6 0x00007f795fe7a90c
4  libc.so.6 0x00007f795fe203a0 gsignal + 32
5  libc.so.6 0x00007f795fe0757a abort + 38
6  llc       0x00005576b2f9a46f
7  llc       0x00005576b48f5269
8  llc       0x00005576b46df53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005576b47dbc8d
10 llc       0x00005576b47e44e2
11 llc       0x00005576b47e5b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005576b47021f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005576b470476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005576b4706904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005576b46f3ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005576b385d8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005576b3e3ffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005576b3e402c3 llvm::FPPassManager::runOnModule(llvm::Mod
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: frem_nxv1f32_allonesmask
