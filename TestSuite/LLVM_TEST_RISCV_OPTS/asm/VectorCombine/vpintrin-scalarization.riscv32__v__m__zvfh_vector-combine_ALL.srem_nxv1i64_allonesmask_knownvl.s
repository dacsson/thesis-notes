# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmph1s5sysi.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmph1s5sysi.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005645004a5e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005645004a2c87
2  libc.so.6 0x00007fbc7e74f4d0
3  libc.so.6 0x00007fbc7e7a990c
4  libc.so.6 0x00007fbc7e74f3a0 gsignal + 32
5  libc.so.6 0x00007fbc7e73657a abort + 38
6  llc       0x00005644fea7546f
7  llc       0x00005645003d0269
8  llc       0x00005645001ba53d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x00005645002b6c8d
10 llc       0x00005645002bf4e2
11 llc       0x00005645002c0b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x00005645001dd1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x00005645001df76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x00005645001e1904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x00005645001cece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x00005644ff3388c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005644ff91afe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005644ff91b2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: srem_nxv1i64_allonesmask_knownvl
