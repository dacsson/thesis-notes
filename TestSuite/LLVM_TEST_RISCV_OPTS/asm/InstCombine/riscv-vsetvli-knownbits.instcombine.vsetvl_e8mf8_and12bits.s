# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp5g42b2q9.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp5g42b2q9.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005591620e1e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005591620dec87
2  libc.so.6 0x00007fd3ba14f4d0
3  libc.so.6 0x00007fd3ba1a990c
4  libc.so.6 0x00007fd3ba14f3a0 gsignal + 32
5  libc.so.6 0x00007fd3ba13657a abort + 38
6  llc       0x00005591606b146f
7  llc       0x000055916200c269
8  llc       0x00005591609db208
9  llc       0x0000559161d2b75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000559161ee434d
11 llc       0x0000559161fb17a0
12 llc       0x0000559161ee4d4a
13 llc       0x0000559161ee52af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000559161e19188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000559161e1b76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000559161e1d904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000559161e0ace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000559160f748c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000559161556fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005591615572c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e8mf8_and12bits
