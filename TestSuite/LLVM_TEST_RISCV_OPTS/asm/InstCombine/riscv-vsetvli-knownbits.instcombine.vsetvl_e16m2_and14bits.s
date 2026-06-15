# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmprne657kg.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmprne657kg.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000555ac8e3fe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000555ac8e3cc87
2  libc.so.6 0x00007f4f47e4d4d0
3  libc.so.6 0x00007f4f47ea790c
4  libc.so.6 0x00007f4f47e4d3a0 gsignal + 32
5  libc.so.6 0x00007f4f47e3457a abort + 38
6  llc       0x0000555ac740f46f
7  llc       0x0000555ac8d6a269
8  llc       0x0000555ac7739208
9  llc       0x0000555ac8a8975f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000555ac8c4234d
11 llc       0x0000555ac8d0f7a0
12 llc       0x0000555ac8c42d4a
13 llc       0x0000555ac8c432af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000555ac8b77188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000555ac8b7976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000555ac8b7b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000555ac8b68ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000555ac7cd28c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000555ac82b4fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000555ac82b52c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16m2_and14bits
