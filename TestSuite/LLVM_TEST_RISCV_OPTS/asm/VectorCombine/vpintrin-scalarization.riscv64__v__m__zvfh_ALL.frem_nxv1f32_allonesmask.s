# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp5hvbpcf9.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp5hvbpcf9.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056307d497e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056307d494c87
2  libc.so.6 0x00007f11b414f4d0
3  libc.so.6 0x00007f11b41a990c
4  libc.so.6 0x00007f11b414f3a0 gsignal + 32
5  libc.so.6 0x00007f11b413657a abort + 38
6  llc       0x000056307ba6746f
7  llc       0x000056307d3c2269
8  llc       0x000056307d1ac53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000056307d2a8c8d
10 llc       0x000056307d2b14e2
11 llc       0x000056307d2b2b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056307d1cf1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056307d1d176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056307d1d3904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056307d1c0ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000056307c32a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000056307c90cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000056307c90d2c3 llvm::FPPassManager::runOnModule(llvm::Mod
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: frem_nxv1f32_allonesmask
