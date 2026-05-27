# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmpcjongze2.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpcjongze2.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005584097c3e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005584097c0c87
2  libc.so.6 0x00007fc60b0204d0
3  libc.so.6 0x00007fc60b07a90c
4  libc.so.6 0x00007fc60b0203a0 gsignal + 32
5  libc.so.6 0x00007fc60b00757a abort + 38
6  llc       0x0000558407d9346f
7  llc       0x00005584096ee269
8  llc       0x00005584080bd208
9  llc       0x000055840940d75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005584095c634d
11 llc       0x0000558409670e0b
12 llc       0x00005584095c6d1e
13 llc       0x00005584095c72af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005584094fb188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005584094fd76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005584094ff904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005584094ecce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005584086568c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000558408c38fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000558408c392c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: scalar_non_constant
