# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpty0eirm5.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpty0eirm5.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055d36121fe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055d36121cc87
2  libc.so.6 0x00007ff56894f4d0
3  libc.so.6 0x00007ff5689a990c
4  libc.so.6 0x00007ff56894f3a0 gsignal + 32
5  libc.so.6 0x00007ff56893657a abort + 38
6  llc       0x000055d35f7ef46f
7  llc       0x000055d36114a269
8  llc       0x000055d35fb19208
9  llc       0x000055d360e6975f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055d36102234d
11 llc       0x000055d3610cce0b
12 llc       0x000055d361022d1e
13 llc       0x000055d3610232af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055d360f57188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055d360f5976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055d360f5b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055d360f48ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055d3600b28c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055d360694fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055d3606952c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: vector_elt_type_legality
