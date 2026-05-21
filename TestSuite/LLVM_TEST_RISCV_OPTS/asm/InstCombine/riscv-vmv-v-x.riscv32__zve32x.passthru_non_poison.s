# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpklfa1vg4.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpklfa1vg4.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055e2f7d1de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055e2f7d1ac87
2  libc.so.6 0x00007f351e14f4d0
3  libc.so.6 0x00007f351e1a990c
4  libc.so.6 0x00007f351e14f3a0 gsignal + 32
5  libc.so.6 0x00007f351e13657a abort + 38
6  llc       0x000055e2f62ed46f
7  llc       0x000055e2f7c48269
8  llc       0x000055e2f6617208
9  llc       0x000055e2f796775f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055e2f7b2034d
11 llc       0x000055e2f7bcae0b
12 llc       0x000055e2f7b20d1e
13 llc       0x000055e2f7b212af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055e2f7a55188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055e2f7a5776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055e2f7a59904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055e2f7a46ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055e2f6bb08c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055e2f7192fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055e2f71932c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: passthru_non_poison
