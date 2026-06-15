# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpnvr2e1zk.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpnvr2e1zk.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056443e5f0e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056443e5edc87
2  libc.so.6 0x00007f30b644d4d0
3  libc.so.6 0x00007f30b64a790c
4  libc.so.6 0x00007f30b644d3a0 gsignal + 32
5  libc.so.6 0x00007f30b643457a abort + 38
6  llc       0x000056443cbc046f
7  llc       0x000056443e51b269
8  llc       0x000056443e30553d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000056443e401c8d
10 llc       0x000056443e40a4e2
11 llc       0x000056443e40bb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056443e3281f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056443e32a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056443e32c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056443e319ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000056443d4838c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000056443da65fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000056443da662c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: fdiv_nxv1f32_allonesmask_knownvl
