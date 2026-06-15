# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmp6vfpty82.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6vfpty82.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005564fa775e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005564fa772c87
2  libc.so.6 0x00007f6d4d64d4d0
3  libc.so.6 0x00007f6d4d6a790c
4  libc.so.6 0x00007f6d4d64d3a0 gsignal + 32
5  libc.so.6 0x00007f6d4d63457a abort + 38
6  llc       0x00005564f8d4546f
7  llc       0x00005564fa6a0269
8  llc       0x00005564f906f208
9  llc       0x00005564fa3bf75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005564fa57834d
11 llc       0x00005564fa622e0b
12 llc       0x00005564fa578d1e
13 llc       0x00005564fa5792af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005564fa4ad188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005564fa4af76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005564fa4b1904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005564fa49ece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005564f96088c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005564f9beafe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005564f9beb2c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: vl_not_divisible
