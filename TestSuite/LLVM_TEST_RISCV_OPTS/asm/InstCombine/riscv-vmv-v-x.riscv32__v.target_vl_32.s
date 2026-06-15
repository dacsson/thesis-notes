# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmpaav2iadh.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpaav2iadh.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000561e92a69e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000561e92a66c87
2  libc.so.6 0x00007f9324d4f4d0
3  libc.so.6 0x00007f9324da990c
4  libc.so.6 0x00007f9324d4f3a0 gsignal + 32
5  libc.so.6 0x00007f9324d3657a abort + 38
6  llc       0x0000561e9103946f
7  llc       0x0000561e92994269
8  llc       0x0000561e91363208
9  llc       0x0000561e926b375f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000561e9286c34d
11 llc       0x0000561e92916e0b
12 llc       0x0000561e9286cd1e
13 llc       0x0000561e9286d2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000561e927a1188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000561e927a376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000561e927a5904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000561e92792ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000561e918fc8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000561e91edefe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000561e91edf2c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: target_vl_32
