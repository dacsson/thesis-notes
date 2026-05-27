# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpfs4e5r_p.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpfs4e5r_p.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005646ddfd4e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005646ddfd1c87
2  libc.so.6 0x00007f90bd14f4d0
3  libc.so.6 0x00007f90bd1a990c
4  libc.so.6 0x00007f90bd14f3a0 gsignal + 32
5  libc.so.6 0x00007f90bd13657a abort + 38
6  llc       0x00005646dc5a446f
7  llc       0x00005646ddeff269
8  llc       0x00005646dc8ce208
9  llc       0x00005646ddc1e75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005646dddd734d
11 llc       0x00005646ddea47a0
12 llc       0x00005646dddd7d4a
13 llc       0x00005646dddd82af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005646ddd0c188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005646ddd0e76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005646ddd10904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005646ddcfdce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005646dce678c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005646dd449fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005646dd44a2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16mf2_and9bits
