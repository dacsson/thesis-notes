# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpactw3rcy.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpactw3rcy.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055ec084f9e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055ec084f6c87
2  libc.so.6 0x00007f0a8b34f4d0
3  libc.so.6 0x00007f0a8b3a990c
4  libc.so.6 0x00007f0a8b34f3a0 gsignal + 32
5  libc.so.6 0x00007f0a8b33657a abort + 38
6  llc       0x000055ec06ac946f
7  llc       0x000055ec08424269
8  llc       0x000055ec06df3208
9  llc       0x000055ec0814375f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055ec082fc34d
11 llc       0x000055ec083c97a0
12 llc       0x000055ec082fcd4a
13 llc       0x000055ec082fd2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055ec08231188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055ec0823376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055ec08235904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055ec08222ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055ec0738c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055ec0796efe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055ec0796f2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16mf8_and11bits
