# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp7oozt3pn.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp7oozt3pn.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000560809d30e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000560809d2dc87
2  libc.so.6 0x00007f2248a1e4d0
3  libc.so.6 0x00007f2248a7890c
4  libc.so.6 0x00007f2248a1e3a0 gsignal + 32
5  libc.so.6 0x00007f2248a0557a abort + 38
6  llc       0x000056080830046f
7  llc       0x0000560809c5b269
8  llc       0x0000560809a4553d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000560809b41c8d
10 llc       0x0000560809b4a4e2
11 llc       0x0000560809b4bb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000560809a681f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000560809a6a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000560809a6c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000560809a59ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000560808bc38c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x00005608091a5fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x00005608091a62c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: udiv_nxv1i64_allonesmask
