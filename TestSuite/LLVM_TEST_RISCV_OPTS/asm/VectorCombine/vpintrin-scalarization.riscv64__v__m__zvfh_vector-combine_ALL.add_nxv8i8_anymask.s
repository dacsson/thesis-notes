# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp1__m5vrm.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp1__m5vrm.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005579aba6ee29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005579aba6bc87
2  libc.so.6 0x00007ff22f44d4d0
3  libc.so.6 0x00007ff22f4a790c
4  libc.so.6 0x00007ff22f44d3a0 gsignal + 32
5  libc.so.6 0x00007ff22f43457a abort + 38
6  llc       0x00005579aa03e46f
7  llc       0x00005579ab999269
8  llc       0x00005579ab78353d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005579ab87fc8d
10 llc       0x00005579ab8884e2
11 llc       0x00005579ab889b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005579ab7a61f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005579ab7a876f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005579ab7aa904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005579ab797ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005579aa9018c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005579aaee3fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005579aaee42c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: add_nxv8i8_anymask
