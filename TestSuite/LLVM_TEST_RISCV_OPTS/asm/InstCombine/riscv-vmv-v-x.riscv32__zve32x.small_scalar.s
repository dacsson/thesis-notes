# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +zve32x /tmp/tmpaalbbt7o.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpaalbbt7o.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056100892ae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000561008927c87
2  libc.so.6 0x00007f0efb64d4d0
3  libc.so.6 0x00007f0efb6a790c
4  libc.so.6 0x00007f0efb64d3a0 gsignal + 32
5  libc.so.6 0x00007f0efb63457a abort + 38
6  llc       0x0000561006efa46f
7  llc       0x0000561008855269
8  llc       0x0000561007224208
9  llc       0x000056100857475f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000056100872d34d
11 llc       0x00005610087d7e0b
12 llc       0x000056100872dd1e
13 llc       0x000056100872e2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000561008662188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000056100866476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000561008666904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000561008653ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005610077bd8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000561007d9ffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000561007da02c3 llvm:
# Source: InstCombine/riscv-vmv-v-x.riscv32__zve32x.ll
# Function: small_scalar
