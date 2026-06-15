# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmpy8510np7.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpy8510np7.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056223b8b7e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056223b8b4c87
2  libc.so.6 0x00007fcd93a204d0
3  libc.so.6 0x00007fcd93a7a90c
4  libc.so.6 0x00007fcd93a203a0 gsignal + 32
5  libc.so.6 0x00007fcd93a0757a abort + 38
6  llc       0x0000562239e8746f
7  llc       0x000056223b7e2269
8  llc       0x000056223a1b1208
9  llc       0x000056223b50175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000056223b6ba34d
11 llc       0x000056223b764e0b
12 llc       0x000056223b6bad1e
13 llc       0x000056223b6bb2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000056223b5ef188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000056223b5f176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000056223b5f3904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000056223b5e0ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000056223a74a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000056223ad2cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000056223ad2d2c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: passthru_non_poison
