# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpo_x723rw.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpo_x723rw.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055f54a34de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055f54a34ac87
2  libc.so.6 0x00007f4b2c54f4d0
3  libc.so.6 0x00007f4b2c5a990c
4  libc.so.6 0x00007f4b2c54f3a0 gsignal + 32
5  libc.so.6 0x00007f4b2c53657a abort + 38
6  llc       0x000055f54891d46f
7  llc       0x000055f54a278269
8  llc       0x000055f548c47208
9  llc       0x000055f549f9775f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055f54a15034d
11 llc       0x000055f54a21d7a0
12 llc       0x000055f54a150d4a
13 llc       0x000055f54a1512af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055f54a085188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055f54a08776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055f54a089904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055f54a076ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055f5491e08c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055f5497c2fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055f5497c32c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64m1_and10bits
