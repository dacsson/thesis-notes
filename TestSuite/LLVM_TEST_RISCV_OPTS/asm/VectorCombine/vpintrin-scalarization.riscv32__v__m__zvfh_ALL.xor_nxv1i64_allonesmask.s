# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmp2qcfr93a.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp2qcfr93a.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005633f3ea4e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005633f3ea1c87
2  libc.so.6 0x00007f8f3d04d4d0
3  libc.so.6 0x00007f8f3d0a790c
4  libc.so.6 0x00007f8f3d04d3a0 gsignal + 32
5  libc.so.6 0x00007f8f3d03457a abort + 38
6  llc       0x00005633f247446f
7  llc       0x00005633f3dcf269
8  llc       0x00005633f3bb953d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005633f3cb5c8d
10 llc       0x00005633f3cbe4e2
11 llc       0x00005633f3cbfb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005633f3bdc1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005633f3bde76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005633f3be0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005633f3bcdce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005633f2d378c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005633f3319fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005633f331a2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: xor_nxv1i64_allonesmask
