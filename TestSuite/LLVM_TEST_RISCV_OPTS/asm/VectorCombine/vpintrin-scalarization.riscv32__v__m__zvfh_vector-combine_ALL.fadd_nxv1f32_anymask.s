# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmporso9ckw.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmporso9ckw.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055627ff64e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055627ff61c87
2  libc.so.6 0x00007f14fd04d4d0
3  libc.so.6 0x00007f14fd0a790c
4  libc.so.6 0x00007f14fd04d3a0 gsignal + 32
5  libc.so.6 0x00007f14fd03457a abort + 38
6  llc       0x000055627e53446f
7  llc       0x000055627fe8f269
8  llc       0x000055627fc7953d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055627fd75c8d
10 llc       0x000055627fd7e4e2
11 llc       0x000055627fd7fb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055627fc9c1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055627fc9e76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055627fca0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055627fc8dce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055627edf78c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055627f3d9fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055627f3da2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: fadd_nxv1f32_anymask
