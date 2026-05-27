# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpcdtdghjq.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcdtdghjq.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056061f30ce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056061f309c87
2  libc.so.6 0x00007f9132c4d4d0
3  libc.so.6 0x00007f9132ca790c
4  libc.so.6 0x00007f9132c4d3a0 gsignal + 32
5  libc.so.6 0x00007f9132c3457a abort + 38
6  llc       0x000056061d8dc46f
7  llc       0x000056061f237269
8  llc       0x000056061f02153d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000056061f11dc8d
10 llc       0x000056061f1264e2
11 llc       0x000056061f127b36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000056061f0441f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000056061f04676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000056061f048904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000056061f035ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000056061e19f8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000056061e781fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000056061e7822c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_vector-combine_ALL.ll
# Function: udiv_nxv1i64_anymask
