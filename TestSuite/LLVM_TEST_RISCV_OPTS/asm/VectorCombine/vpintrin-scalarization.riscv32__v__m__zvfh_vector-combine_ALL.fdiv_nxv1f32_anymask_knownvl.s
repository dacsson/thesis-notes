# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmpzdtr3rvs.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpzdtr3rvs.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000558d3c699e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000558d3c696c87
2  libc.so.6 0x00007ff0773224d0
3  libc.so.6 0x00007ff07737c90c
4  libc.so.6 0x00007ff0773223a0 gsignal + 32
5  libc.so.6 0x00007ff07730957a abort + 38
6  llc       0x0000558d3ac6946f
7  llc       0x0000558d3c5c4269
8  llc       0x0000558d3c3ae53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000558d3c4aac8d
10 llc       0x0000558d3c4b34e2
11 llc       0x0000558d3c4b4b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000558d3c3d11f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000558d3c3d376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000558d3c3d5904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000558d3c3c2ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000558d3b52c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000558d3bb0efe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000558d3bb0f2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: fdiv_nxv1f32_anymask_knownvl
