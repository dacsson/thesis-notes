# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpqsvih4ve.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpqsvih4ve.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055fe094d6e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055fe094d3c87
2  libc.so.6 0x00007f8e6ef4f4d0
3  libc.so.6 0x00007f8e6efa990c
4  libc.so.6 0x00007f8e6ef4f3a0 gsignal + 32
5  libc.so.6 0x00007f8e6ef3657a abort + 38
6  llc       0x000055fe07aa646f
7  llc       0x000055fe09401269
8  llc       0x000055fe07dd0208
9  llc       0x000055fe0912075f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055fe092d934d
11 llc       0x000055fe093a67a0
12 llc       0x000055fe092d9d4a
13 llc       0x000055fe092da2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055fe0920e188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055fe0921076f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055fe09212904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055fe091ffce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055fe083698c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055fe0894bfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055fe0894c2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32mf8_and10bits
