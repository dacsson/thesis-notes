# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpq6gwyklf.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpq6gwyklf.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000558e722e3e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000558e722e0c87
2  libc.so.6 0x00007ff1ab0204d0
3  libc.so.6 0x00007ff1ab07a90c
4  libc.so.6 0x00007ff1ab0203a0 gsignal + 32
5  libc.so.6 0x00007ff1ab00757a abort + 38
6  llc       0x0000558e708b346f
7  llc       0x0000558e7220e269
8  llc       0x0000558e70bdd208
9  llc       0x0000558e71f2d75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000558e720e634d
11 llc       0x0000558e72190e0b
12 llc       0x0000558e720e6d1e
13 llc       0x0000558e720e72af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000558e7201b188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000558e7201d76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000558e7201f904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000558e7200cce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000558e711768c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000558e71758fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000558e717592c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: bitcast_users_type_mismatch
