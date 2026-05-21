# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp_rfu03yg.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp_rfu03yg.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055fd9325ce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055fd93259c87
2  libc.so.6 0x00007f62366204d0
3  libc.so.6 0x00007f623667a90c
4  libc.so.6 0x00007f62366203a0 gsignal + 32
5  libc.so.6 0x00007f623660757a abort + 38
6  llc       0x000055fd9182c46f
7  llc       0x000055fd93187269
8  llc       0x000055fd91b56208
9  llc       0x000055fd92ea675f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055fd9305f34d
11 llc       0x000055fd9312c7a0
12 llc       0x000055fd9305fd4a
13 llc       0x000055fd930602af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055fd92f94188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055fd92f9676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055fd92f98904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055fd92f85ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055fd920ef8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055fd926d1fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055fd926d22c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32mf2_and8bits
