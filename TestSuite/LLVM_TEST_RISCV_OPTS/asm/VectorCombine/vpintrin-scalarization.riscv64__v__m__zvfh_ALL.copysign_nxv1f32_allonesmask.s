# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp8h5lbd0j.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp8h5lbd0j.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055ce7a7c8e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055ce7a7c5c87
2  libc.so.6 0x00007fd738b4f4d0
3  libc.so.6 0x00007fd738ba990c
4  libc.so.6 0x00007fd738b4f3a0 gsignal + 32
5  libc.so.6 0x00007fd738b3657a abort + 38
6  llc       0x000055ce78d9846f
7  llc       0x000055ce7a6f3269
8  llc       0x000055ce7a4dd53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055ce7a5d9c8d
10 llc       0x000055ce7a5e24e2
11 llc       0x000055ce7a5e3b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055ce7a5001f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055ce7a50276f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055ce7a504904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055ce7a4f1ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055ce7965b8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055ce79c3dfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055ce79c3e2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: copysign_nxv1f32_allonesmask
