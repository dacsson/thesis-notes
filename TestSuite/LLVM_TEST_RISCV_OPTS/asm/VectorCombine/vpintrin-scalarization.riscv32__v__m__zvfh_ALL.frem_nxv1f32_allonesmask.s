# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmpeq0d3n2w.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpeq0d3n2w.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000565269953e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000565269950c87
2  libc.so.6 0x00007f68d044d4d0
3  libc.so.6 0x00007f68d04a790c
4  libc.so.6 0x00007f68d044d3a0 gsignal + 32
5  libc.so.6 0x00007f68d043457a abort + 38
6  llc       0x0000565267f2346f
7  llc       0x000056526987e269
8  llc       0x000056526966853d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000565269764c8d
10 llc       0x000056526976d4e2
11 llc       0x000056526976eb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056526968b1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056526968d76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056526968f904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056526967cce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005652687e68c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000565268dc8fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000565268dc92c3 llvm::FPPassManager::runOnModule(llvm::Mod
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: frem_nxv1f32_allonesmask
