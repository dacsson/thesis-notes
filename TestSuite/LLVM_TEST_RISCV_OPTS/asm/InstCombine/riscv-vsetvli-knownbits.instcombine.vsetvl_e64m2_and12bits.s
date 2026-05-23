# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpf8mtxaer.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpf8mtxaer.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005572717e5e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005572717e2c87
2  libc.so.6 0x00007fb86ef4f4d0
3  libc.so.6 0x00007fb86efa990c
4  libc.so.6 0x00007fb86ef4f3a0 gsignal + 32
5  libc.so.6 0x00007fb86ef3657a abort + 38
6  llc       0x000055726fdb546f
7  llc       0x0000557271710269
8  llc       0x00005572700df208
9  llc       0x000055727142f75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005572715e834d
11 llc       0x00005572716b57a0
12 llc       0x00005572715e8d4a
13 llc       0x00005572715e92af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055727151d188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055727151f76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000557271521904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055727150ece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005572706788c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000557270c5afe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000557270c5b2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64m2_and12bits
