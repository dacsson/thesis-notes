# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmpnh6lhe3q.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpnh6lhe3q.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005564932efe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005564932ecc87
2  libc.so.6 0x00007faf6884d4d0
3  libc.so.6 0x00007faf688a790c
4  libc.so.6 0x00007faf6884d3a0 gsignal + 32
5  libc.so.6 0x00007faf6883457a abort + 38
6  llc       0x00005564918bf46f
7  llc       0x000055649321a269
8  llc       0x000055649300453d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000556493100c8d
10 llc       0x00005564931094e2
11 llc       0x000055649310ab36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005564930271f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055649302976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055649302b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000556493018ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005564921828c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000556492764fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005564927652c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_ALL.ll
# Function: shl_nxv1i64_anymask
