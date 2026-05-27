# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmp8j5_3831.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp8j5_3831.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000556c50ca7e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000556c50ca4c87
2  libc.so.6 0x00007f4a7fa4d4d0
3  libc.so.6 0x00007f4a7faa790c
4  libc.so.6 0x00007f4a7fa4d3a0 gsignal + 32
5  libc.so.6 0x00007f4a7fa3457a abort + 38
6  llc       0x0000556c4f27746f
7  llc       0x0000556c50bd2269
8  llc       0x0000556c4f5a1208
9  llc       0x0000556c508f175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000556c50aaa34d
11 llc       0x0000556c50b54e0b
12 llc       0x0000556c50aaad1e
13 llc       0x0000556c50aab2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000556c509df188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000556c509e176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000556c509e3904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000556c509d0ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000556c4fb3a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000556c5011cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000556c5011d2c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: bitcast_target_elt_type_too_small
