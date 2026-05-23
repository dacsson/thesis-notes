# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpb471a1a2.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpb471a1a2.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005577f1407e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005577f1404c87
2  libc.so.6 0x00007f538204d4d0
3  libc.so.6 0x00007f53820a790c
4  libc.so.6 0x00007f538204d3a0 gsignal + 32
5  libc.so.6 0x00007f538203457a abort + 38
6  llc       0x00005577ef9d746f
7  llc       0x00005577f1332269
8  llc       0x00005577efd01208
9  llc       0x00005577f105175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005577f120a34d
11 llc       0x00005577f12d77a0
12 llc       0x00005577f120ad4a
13 llc       0x00005577f120b2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005577f113f188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005577f114176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005577f1143904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005577f1130ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005577f029a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005577f087cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005577f087d2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32mf4_and10bits
