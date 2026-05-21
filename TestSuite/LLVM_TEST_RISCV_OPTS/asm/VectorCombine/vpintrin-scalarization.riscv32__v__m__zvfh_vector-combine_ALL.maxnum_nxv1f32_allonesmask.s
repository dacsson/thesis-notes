# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmpq1zbiz26.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpq1zbiz26.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055ea970b9e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055ea970b6c87
2  libc.so.6 0x00007f1359c4d4d0
3  libc.so.6 0x00007f1359ca790c
4  libc.so.6 0x00007f1359c4d3a0 gsignal + 32
5  libc.so.6 0x00007f1359c3457a abort + 38
6  llc       0x000055ea9568946f
7  llc       0x000055ea96fe4269
8  llc       0x000055ea96dce53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055ea96ecac8d
10 llc       0x000055ea96ed34e2
11 llc       0x000055ea96ed4b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055ea96df11f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055ea96df376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055ea96df5904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055ea96de2ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055ea95f4c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055ea9652efe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055ea9652f2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: maxnum_nxv1f32_allonesmask
