# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp1ad2jsbm.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp1ad2jsbm.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000559192243e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000559192240c87
2  libc.so.6 0x00007f3bee64d4d0
3  libc.so.6 0x00007f3bee6a790c
4  libc.so.6 0x00007f3bee64d3a0 gsignal + 32
5  libc.so.6 0x00007f3bee63457a abort + 38
6  llc       0x000055919081346f
7  llc       0x000055919216e269
8  llc       0x0000559191f5853d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000559192054c8d
10 llc       0x000055919205d4e2
11 llc       0x000055919205eb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000559191f7b1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000559191f7d76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000559191f7f904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000559191f6cce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005591910d68c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005591916b8fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005591916b92c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: ashr_nxv1i64_allonesmask
