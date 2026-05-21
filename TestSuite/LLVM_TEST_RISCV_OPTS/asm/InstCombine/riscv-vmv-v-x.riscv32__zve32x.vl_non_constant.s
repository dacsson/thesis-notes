# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpcs2muscu.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcs2muscu.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000555cb9c5fe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000555cb9c5cc87
2  libc.so.6 0x00007ff410e4d4d0
3  libc.so.6 0x00007ff410ea790c
4  libc.so.6 0x00007ff410e4d3a0 gsignal + 32
5  libc.so.6 0x00007ff410e3457a abort + 38
6  llc       0x0000555cb822f46f
7  llc       0x0000555cb9b8a269
8  llc       0x0000555cb8559208
9  llc       0x0000555cb98a975f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000555cb9a6234d
11 llc       0x0000555cb9b0ce0b
12 llc       0x0000555cb9a62d1e
13 llc       0x0000555cb9a632af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000555cb9997188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000555cb999976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000555cb999b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000555cb9988ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000555cb8af28c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000555cb90d4fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000555cb90d52c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: vl_non_constant
