# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmpcsef_97y.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcsef_97y.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055918c375e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055918c372c87
2  libc.so.6 0x00007f14cd44d4d0
3  libc.so.6 0x00007f14cd4a790c
4  libc.so.6 0x00007f14cd44d3a0 gsignal + 32
5  libc.so.6 0x00007f14cd43457a abort + 38
6  llc       0x000055918a94546f
7  llc       0x000055918c2a0269
8  llc       0x000055918c08a53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055918c186c8d
10 llc       0x000055918c18f4e2
11 llc       0x000055918c190b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055918c0ad1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055918c0af76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055918c0b1904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055918c09ece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055918b2088c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055918b7eafe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055918b7eb2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: add_nxv1i64_allonesmask
