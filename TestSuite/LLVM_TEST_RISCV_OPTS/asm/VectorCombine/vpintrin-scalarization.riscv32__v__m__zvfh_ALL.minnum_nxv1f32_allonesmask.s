# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmp1bnkhdca.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp1bnkhdca.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056143baf9e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056143baf6c87
2  libc.so.6 0x00007f8e74e4d4d0
3  libc.so.6 0x00007f8e74ea790c
4  libc.so.6 0x00007f8e74e4d3a0 gsignal + 32
5  libc.so.6 0x00007f8e74e3457a abort + 38
6  llc       0x000056143a0c946f
7  llc       0x000056143ba24269
8  llc       0x000056143b80e53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000056143b90ac8d
10 llc       0x000056143b9134e2
11 llc       0x000056143b914b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056143b8311f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056143b83376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056143b835904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056143b822ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000056143a98c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000056143af6efe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000056143af6f2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: minnum_nxv1f32_allonesmask
