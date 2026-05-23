# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp6vnnt63e.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6vnnt63e.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055eb5c03be29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055eb5c038c87
2  libc.so.6 0x00007f9d4c34f4d0
3  libc.so.6 0x00007f9d4c3a990c
4  libc.so.6 0x00007f9d4c34f3a0 gsignal + 32
5  libc.so.6 0x00007f9d4c33657a abort + 38
6  llc       0x000055eb5a60b46f
7  llc       0x000055eb5bf66269
8  llc       0x000055eb5a935208
9  llc       0x000055eb5bc8575f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055eb5be3e34d
11 llc       0x000055eb5bf0b7a0
12 llc       0x000055eb5be3ed4a
13 llc       0x000055eb5be3f2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055eb5bd73188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055eb5bd7576f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055eb5bd77904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055eb5bd64ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055eb5aece8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055eb5b4b0fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055eb5b4b12c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32mf4_and9bits
