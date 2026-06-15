# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpwiwfkxup.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpwiwfkxup.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055caec3a1e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055caec39ec87
2  libc.so.6 0x00007f7a3754f4d0
3  libc.so.6 0x00007f7a375a990c
4  libc.so.6 0x00007f7a3754f3a0 gsignal + 32
5  libc.so.6 0x00007f7a3753657a abort + 38
6  llc       0x000055caea97146f
7  llc       0x000055caec2cc269
8  llc       0x000055caec0b653d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055caec1b2c8d
10 llc       0x000055caec1bb4e2
11 llc       0x000055caec1bcb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055caec0d91f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055caec0db76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055caec0dd904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055caec0cace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055caeb2348c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055caeb816fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055caeb8172c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: umax_nxv1i64_anymask
