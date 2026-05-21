# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp49tq0n71.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp49tq0n71.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055569e590e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055569e58dc87
2  libc.so.6 0x00007f91c434f4d0
3  libc.so.6 0x00007f91c43a990c
4  libc.so.6 0x00007f91c434f3a0 gsignal + 32
5  libc.so.6 0x00007f91c433657a abort + 38
6  llc       0x000055569cb6046f
7  llc       0x000055569e4bb269
8  llc       0x000055569ce8a208
9  llc       0x000055569e1da75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055569e39334d
11 llc       0x000055569e4607a0
12 llc       0x000055569e393d4a
13 llc       0x000055569e3942af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055569e2c8188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055569e2ca76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055569e2cc904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055569e2b9ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055569d4238c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055569da05fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055569da062c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e8mf4_and12bits
