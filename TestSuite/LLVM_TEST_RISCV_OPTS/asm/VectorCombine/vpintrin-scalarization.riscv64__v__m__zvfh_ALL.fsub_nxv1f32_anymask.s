# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpo_e0pr3e.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpo_e0pr3e.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000557ff430de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000557ff430ac87
2  libc.so.6 0x00007f9200d4f4d0
3  libc.so.6 0x00007f9200da990c
4  libc.so.6 0x00007f9200d4f3a0 gsignal + 32
5  libc.so.6 0x00007f9200d3657a abort + 38
6  llc       0x0000557ff28dd46f
7  llc       0x0000557ff4238269
8  llc       0x0000557ff402253d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000557ff411ec8d
10 llc       0x0000557ff41274e2
11 llc       0x0000557ff4128b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000557ff40451f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000557ff404776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000557ff4049904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000557ff4036ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000557ff31a08c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000557ff3782fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000557ff37832c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: fsub_nxv1f32_anymask
