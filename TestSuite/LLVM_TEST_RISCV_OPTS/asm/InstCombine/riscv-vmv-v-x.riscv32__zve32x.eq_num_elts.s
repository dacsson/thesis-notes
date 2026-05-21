# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpz7ot_cec.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpz7ot_cec.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c2996f6e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c2996f3c87
2  libc.so.6 0x00007feb3844d4d0
3  libc.so.6 0x00007feb384a790c
4  libc.so.6 0x00007feb3844d3a0 gsignal + 32
5  libc.so.6 0x00007feb3843457a abort + 38
6  llc       0x000055c297cc646f
7  llc       0x000055c299621269
8  llc       0x000055c297ff0208
9  llc       0x000055c29934075f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055c2994f934d
11 llc       0x000055c2995a3e0b
12 llc       0x000055c2994f9d1e
13 llc       0x000055c2994fa2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055c29942e188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055c29943076f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055c299432904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055c29941fce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055c2985898c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055c298b6bfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055c298b6c2c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: eq_num_elts
