# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp3s293qgm.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp3s293qgm.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000560b18308e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000560b18305c87
2  libc.so.6 0x00007f0673e204d0
3  libc.so.6 0x00007f0673e7a90c
4  libc.so.6 0x00007f0673e203a0 gsignal + 32
5  libc.so.6 0x00007f0673e0757a abort + 38
6  llc       0x0000560b168d846f
7  llc       0x0000560b18233269
8  llc       0x0000560b1801d53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000560b18119c8d
10 llc       0x0000560b181224e2
11 llc       0x0000560b18123b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000560b180401f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000560b1804276f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000560b18044904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000560b18031ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000560b1719b8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000560b1777dfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000560b1777e2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: fadd_nxv1f16_allonesmask
