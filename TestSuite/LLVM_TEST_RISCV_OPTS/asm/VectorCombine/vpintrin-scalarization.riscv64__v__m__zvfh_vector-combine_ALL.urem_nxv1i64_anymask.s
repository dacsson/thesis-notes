# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpnii8c7ib.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpnii8c7ib.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a6e501ae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a6e5017c87
2  libc.so.6 0x00007fb93664d4d0
3  libc.so.6 0x00007fb9366a790c
4  libc.so.6 0x00007fb93664d3a0 gsignal + 32
5  libc.so.6 0x00007fb93663457a abort + 38
6  llc       0x000055a6e35ea46f
7  llc       0x000055a6e4f45269
8  llc       0x000055a6e4d2f53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055a6e4e2bc8d
10 llc       0x000055a6e4e344e2
11 llc       0x000055a6e4e35b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055a6e4d521f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055a6e4d5476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055a6e4d56904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055a6e4d43ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055a6e3ead8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055a6e448ffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055a6e44902c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: urem_nxv1i64_anymask
