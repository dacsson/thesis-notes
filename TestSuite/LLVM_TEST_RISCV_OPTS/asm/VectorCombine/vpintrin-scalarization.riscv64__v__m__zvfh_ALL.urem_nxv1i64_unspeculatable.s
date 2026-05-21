# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp8fvn6glt.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp8fvn6glt.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005558d37ace29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005558d37a9c87
2  libc.so.6 0x00007f3eebc4d4d0
3  libc.so.6 0x00007f3eebca790c
4  libc.so.6 0x00007f3eebc4d3a0 gsignal + 32
5  libc.so.6 0x00007f3eebc3457a abort + 38
6  llc       0x00005558d1d7c46f
7  llc       0x00005558d36d7269
8  llc       0x00005558d34c153d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005558d35bdc8d
10 llc       0x00005558d35c64e2
11 llc       0x00005558d35c7b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005558d34e41f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005558d34e676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005558d34e8904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005558d34d5ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005558d263f8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005558d2c21fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005558d2c222c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: urem_nxv1i64_unspeculatable
