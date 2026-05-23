# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmppfbychzr.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmppfbychzr.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055db333bfe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055db333bcc87
2  libc.so.6 0x00007f63ce14f4d0
3  libc.so.6 0x00007f63ce1a990c
4  libc.so.6 0x00007f63ce14f3a0 gsignal + 32
5  libc.so.6 0x00007f63ce13657a abort + 38
6  llc       0x000055db3198f46f
7  llc       0x000055db332ea269
8  llc       0x000055db31cb9208
9  llc       0x000055db3300975f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055db331c234d
11 llc       0x000055db3326ce0b
12 llc       0x000055db331c2d1e
13 llc       0x000055db331c32af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055db330f7188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055db330f976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055db330fb904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055db330e8ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055db322528c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055db32834fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055db328352c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: vector_elt_type_legality
