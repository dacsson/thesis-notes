# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmp5ux_40eb.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp5ux_40eb.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000559b79dafe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000559b79dacc87
2  libc.so.6 0x00007fcd4524d4d0
3  libc.so.6 0x00007fcd452a790c
4  libc.so.6 0x00007fcd4524d3a0 gsignal + 32
5  libc.so.6 0x00007fcd4523457a abort + 38
6  llc       0x0000559b7837f46f
7  llc       0x0000559b79cda269
8  llc       0x0000559b79ac453d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000559b79bc0c8d
10 llc       0x0000559b79bc94e2
11 llc       0x0000559b79bcab36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000559b79ae71f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000559b79ae976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000559b79aeb904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000559b79ad8ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000559b78c428c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000559b79224fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000559b792252c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: smin_nxv1i64_allonesmask
