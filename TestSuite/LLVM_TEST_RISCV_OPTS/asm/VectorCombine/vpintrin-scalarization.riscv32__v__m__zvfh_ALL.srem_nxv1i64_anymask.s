# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmptzmmn1jp.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmptzmmn1jp.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000561c69a42e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000561c69a3fc87
2  libc.so.6 0x00007fdaa784d4d0
3  libc.so.6 0x00007fdaa78a790c
4  libc.so.6 0x00007fdaa784d3a0 gsignal + 32
5  libc.so.6 0x00007fdaa783457a abort + 38
6  llc       0x0000561c6801246f
7  llc       0x0000561c6996d269
8  llc       0x0000561c6975753d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000561c69853c8d
10 llc       0x0000561c6985c4e2
11 llc       0x0000561c6985db36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000561c6977a1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000561c6977c76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000561c6977e904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000561c6976bce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000561c688d58c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000561c68eb7fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000561c68eb82c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: srem_nxv1i64_anymask
