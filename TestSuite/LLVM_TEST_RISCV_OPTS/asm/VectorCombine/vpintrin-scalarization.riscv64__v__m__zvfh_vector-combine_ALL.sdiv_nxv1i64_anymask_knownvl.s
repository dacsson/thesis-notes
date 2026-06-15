# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpjl_zq4o3.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpjl_zq4o3.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000558f164d2e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000558f164cfc87
2  libc.so.6 0x00007f7de024d4d0
3  libc.so.6 0x00007f7de02a790c
4  libc.so.6 0x00007f7de024d3a0 gsignal + 32
5  libc.so.6 0x00007f7de023457a abort + 38
6  llc       0x0000558f14aa246f
7  llc       0x0000558f163fd269
8  llc       0x0000558f161e753d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000558f162e3c8d
10 llc       0x0000558f162ec4e2
11 llc       0x0000558f162edb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000558f1620a1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000558f1620c76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000558f1620e904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000558f161fbce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000558f153658c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000558f15947fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000558f159482c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: sdiv_nxv1i64_anymask_knownvl
