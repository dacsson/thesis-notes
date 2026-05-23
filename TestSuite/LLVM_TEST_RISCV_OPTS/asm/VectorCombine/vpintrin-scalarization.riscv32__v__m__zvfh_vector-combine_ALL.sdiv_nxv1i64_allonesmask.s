# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmp01sylfe4.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp01sylfe4.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055641af0ae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055641af07c87
2  libc.so.6 0x00007f913ff4f4d0
3  libc.so.6 0x00007f913ffa990c
4  libc.so.6 0x00007f913ff4f3a0 gsignal + 32
5  libc.so.6 0x00007f913ff3657a abort + 38
6  llc       0x00005564194da46f
7  llc       0x000055641ae35269
8  llc       0x000055641ac1f53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055641ad1bc8d
10 llc       0x000055641ad244e2
11 llc       0x000055641ad25b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055641ac421f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055641ac4476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055641ac46904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055641ac33ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000556419d9d8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055641a37ffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055641a3802c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: sdiv_nxv1i64_allonesmask
