# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp3m18r9du.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp3m18r9du.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000561a94cafe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000561a94cacc87
2  libc.so.6 0x00007f06b47224d0
3  libc.so.6 0x00007f06b477c90c
4  libc.so.6 0x00007f06b47223a0 gsignal + 32
5  libc.so.6 0x00007f06b470957a abort + 38
6  llc       0x0000561a9327f46f
7  llc       0x0000561a94bda269
8  llc       0x0000561a949c453d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000561a94ac0c8d
10 llc       0x0000561a94ac94e2
11 llc       0x0000561a94acab36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000561a949e71f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000561a949e976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000561a949eb904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000561a949d8ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000561a93b428c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000561a94124fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000561a941252c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: shl_nxv1i64_anymask
