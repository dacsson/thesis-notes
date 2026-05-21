# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmp533j9p_8.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp533j9p_8.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055ad8e585e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055ad8e582c87
2  libc.so.6 0x00007fe04ed4f4d0
3  libc.so.6 0x00007fe04eda990c
4  libc.so.6 0x00007fe04ed4f3a0 gsignal + 32
5  libc.so.6 0x00007fe04ed3657a abort + 38
6  llc       0x000055ad8cb5546f
7  llc       0x000055ad8e4b0269
8  llc       0x000055ad8ce7f208
9  llc       0x000055ad8e1cf75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055ad8e38834d
11 llc       0x000055ad8e432e0b
12 llc       0x000055ad8e388d1e
13 llc       0x000055ad8e3892af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055ad8e2bd188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055ad8e2bf76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055ad8e2c1904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055ad8e2aece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055ad8d4188c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055ad8d9fafe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055ad8d9fb2c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: bitcast_target_elt_type_too_large
