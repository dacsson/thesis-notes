# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpkmoyq2jg.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpkmoyq2jg.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000563ffd7dce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000563ffd7d9c87
2  libc.so.6 0x00007f213b84d4d0
3  libc.so.6 0x00007f213b8a790c
4  libc.so.6 0x00007f213b84d3a0 gsignal + 32
5  libc.so.6 0x00007f213b83457a abort + 38
6  llc       0x0000563ffbdac46f
7  llc       0x0000563ffd707269
8  llc       0x0000563ffc0d6208
9  llc       0x0000563ffd42675f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000563ffd5df34d
11 llc       0x0000563ffd6ac7a0
12 llc       0x0000563ffd5dfd4a
13 llc       0x0000563ffd5e02af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000563ffd514188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000563ffd51676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000563ffd518904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000563ffd505ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000563ffc66f8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000563ffcc51fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000563ffcc522c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e8m4_and16bits
