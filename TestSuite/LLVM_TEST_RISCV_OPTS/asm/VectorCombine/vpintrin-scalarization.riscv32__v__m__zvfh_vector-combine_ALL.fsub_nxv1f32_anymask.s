# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmpo_uygrek.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpo_uygrek.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005564d7417e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005564d7414c87
2  libc.so.6 0x00007f82380204d0
3  libc.so.6 0x00007f823807a90c
4  libc.so.6 0x00007f82380203a0 gsignal + 32
5  libc.so.6 0x00007f823800757a abort + 38
6  llc       0x00005564d59e746f
7  llc       0x00005564d7342269
8  llc       0x00005564d712c53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005564d7228c8d
10 llc       0x00005564d72314e2
11 llc       0x00005564d7232b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005564d714f1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005564d715176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005564d7153904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005564d7140ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005564d62aa8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005564d688cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005564d688d2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: fsub_nxv1f32_anymask
