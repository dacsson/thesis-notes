# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmpl3uhgxcq.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpl3uhgxcq.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000559bd5860e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000559bd585dc87
2  libc.so.6 0x00007f497d84d4d0
3  libc.so.6 0x00007f497d8a790c
4  libc.so.6 0x00007f497d84d3a0 gsignal + 32
5  libc.so.6 0x00007f497d83457a abort + 38
6  llc       0x0000559bd3e3046f
7  llc       0x0000559bd578b269
8  llc       0x0000559bd557553d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x0000559bd5671c8d
10 llc       0x0000559bd567a4e2
11 llc       0x0000559bd567bb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x0000559bd55981f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x0000559bd559a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x0000559bd559c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x0000559bd5589ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x0000559bd46f38c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x0000559bd4cd5fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x0000559bd4cd62c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: add_nxv1i64_allonesmask
