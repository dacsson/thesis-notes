# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpcrsun4qc.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcrsun4qc.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000560f5b43ae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000560f5b437c87
2  libc.so.6 0x00007f5bd134f4d0
3  libc.so.6 0x00007f5bd13a990c
4  libc.so.6 0x00007f5bd134f3a0 gsignal + 32
5  libc.so.6 0x00007f5bd133657a abort + 38
6  llc       0x0000560f59a0a46f
7  llc       0x0000560f5b365269
8  llc       0x0000560f59d34208
9  llc       0x0000560f5b08475f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000560f5b23d34d
11 llc       0x0000560f5b30a7a0
12 llc       0x0000560f5b23dd4a
13 llc       0x0000560f5b23e2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000560f5b172188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000560f5b17476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000560f5b176904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000560f5b163ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000560f5a2cd8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000560f5a8affe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000560f5a8b02c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_zext
