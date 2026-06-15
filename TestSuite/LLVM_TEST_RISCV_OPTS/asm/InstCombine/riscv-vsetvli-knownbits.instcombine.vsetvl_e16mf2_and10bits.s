# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpjqzehg8m.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpjqzehg8m.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000556863d8de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000556863d8ac87
2  libc.so.6 0x00007f5c0fd4f4d0
3  libc.so.6 0x00007f5c0fda990c
4  libc.so.6 0x00007f5c0fd4f3a0 gsignal + 32
5  libc.so.6 0x00007f5c0fd3657a abort + 38
6  llc       0x000055686235d46f
7  llc       0x0000556863cb8269
8  llc       0x0000556862687208
9  llc       0x00005568639d775f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000556863b9034d
11 llc       0x0000556863c5d7a0
12 llc       0x0000556863b90d4a
13 llc       0x0000556863b912af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000556863ac5188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000556863ac776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000556863ac9904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000556863ab6ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000556862c208c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000556863202fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005568632032c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16mf2_and10bits
