# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmplop5na_o.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmplop5na_o.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005602d8628e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005602d8625c87
2  libc.so.6 0x00007fa51214f4d0
3  libc.so.6 0x00007fa5121a990c
4  libc.so.6 0x00007fa51214f3a0 gsignal + 32
5  libc.so.6 0x00007fa51213657a abort + 38
6  llc       0x00005602d6bf846f
7  llc       0x00005602d8553269
8  llc       0x00005602d833d53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005602d8439c8d
10 llc       0x00005602d84424e2
11 llc       0x00005602d8443b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005602d83601f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005602d836276f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005602d8364904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005602d8351ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005602d74bb8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005602d7a9dfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005602d7a9e2c3 llvm::FPPassManager::runOnModule(llvm::Mod
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: frem_nxv1f32_allonesmask
