# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpcbx15115.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcbx15115.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000558a83194e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000558a83191c87
2  libc.so.6 0x00007ff5b124d4d0
3  libc.so.6 0x00007ff5b12a790c
4  libc.so.6 0x00007ff5b124d3a0 gsignal + 32
5  libc.so.6 0x00007ff5b123457a abort + 38
6  llc       0x0000558a8176446f
7  llc       0x0000558a830bf269
8  llc       0x0000558a81a8e208
9  llc       0x0000558a82dde75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000558a82f9734d
11 llc       0x0000558a830647a0
12 llc       0x0000558a82f97d4a
13 llc       0x0000558a82f982af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000558a82ecc188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000558a82ece76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000558a82ed0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000558a82ebdce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000558a820278c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000558a82609fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000558a8260a2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64mf2_and8bits
