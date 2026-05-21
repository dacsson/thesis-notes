# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmprv1xwlkx.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmprv1xwlkx.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005613f2eb9e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005613f2eb6c87
2  libc.so.6 0x00007f0cb8e4d4d0
3  libc.so.6 0x00007f0cb8ea790c
4  libc.so.6 0x00007f0cb8e4d3a0 gsignal + 32
5  libc.so.6 0x00007f0cb8e3457a abort + 38
6  llc       0x00005613f148946f
7  llc       0x00005613f2de4269
8  llc       0x00005613f17b3208
9  llc       0x00005613f2b0375f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005613f2cbc34d
11 llc       0x00005613f2d897a0
12 llc       0x00005613f2cbcd4a
13 llc       0x00005613f2cbd2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005613f2bf1188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005613f2bf376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005613f2bf5904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005613f2be2ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005613f1d4c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005613f232efe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005613f232f2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32m4_and13bits
