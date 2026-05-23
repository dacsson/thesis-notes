# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp3k370s2a.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp3k370s2a.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055e2571c2e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055e2571bfc87
2  libc.so.6 0x00007fa70164d4d0
3  libc.so.6 0x00007fa7016a790c
4  libc.so.6 0x00007fa70164d3a0 gsignal + 32
5  libc.so.6 0x00007fa70163457a abort + 38
6  llc       0x000055e25579246f
7  llc       0x000055e2570ed269
8  llc       0x000055e256ed753d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055e256fd3c8d
10 llc       0x000055e256fdc4e2
11 llc       0x000055e256fddb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055e256efa1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055e256efc76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055e256efe904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055e256eebce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055e2560558c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055e256637fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055e2566382c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: add_nxv1i64_anymask
