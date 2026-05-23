# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmp67n1kx2n.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp67n1kx2n.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056186009de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056186009ac87
2  libc.so.6 0x00007fa59b64d4d0
3  libc.so.6 0x00007fa59b6a790c
4  libc.so.6 0x00007fa59b64d3a0 gsignal + 32
5  libc.so.6 0x00007fa59b63457a abort + 38
6  llc       0x000056185e66d46f
7  llc       0x000056185ffc8269
8  llc       0x000056185fdb253d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000056185feaec8d
10 llc       0x000056185feb74e2
11 llc       0x000056185feb8b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056185fdd51f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056185fdd776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056185fdd9904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056185fdc6ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000056185ef308c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000056185f512fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000056185f5132c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: maxnum_nxv1f32_allonesmask
