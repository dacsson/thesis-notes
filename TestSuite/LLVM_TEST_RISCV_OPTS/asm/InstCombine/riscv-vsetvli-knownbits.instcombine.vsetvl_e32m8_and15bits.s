# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp031klkqd.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp031klkqd.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000558d6e1f2e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000558d6e1efc87
2  libc.so.6 0x00007f2e4824d4d0
3  libc.so.6 0x00007f2e482a790c
4  libc.so.6 0x00007f2e4824d3a0 gsignal + 32
5  libc.so.6 0x00007f2e4823457a abort + 38
6  llc       0x0000558d6c7c246f
7  llc       0x0000558d6e11d269
8  llc       0x0000558d6caec208
9  llc       0x0000558d6de3c75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000558d6dff534d
11 llc       0x0000558d6e0c27a0
12 llc       0x0000558d6dff5d4a
13 llc       0x0000558d6dff62af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000558d6df2a188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000558d6df2c76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000558d6df2e904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000558d6df1bce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000558d6d0858c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000558d6d667fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000558d6d6682c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32m8_and15bits
