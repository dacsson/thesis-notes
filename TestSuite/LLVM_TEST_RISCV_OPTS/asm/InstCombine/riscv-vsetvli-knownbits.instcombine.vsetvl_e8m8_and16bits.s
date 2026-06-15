# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp35hkuo_n.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp35hkuo_n.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005610bf37de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005610bf37ac87
2  libc.so.6 0x00007fc2395224d0
3  libc.so.6 0x00007fc23957c90c
4  libc.so.6 0x00007fc2395223a0 gsignal + 32
5  libc.so.6 0x00007fc23950957a abort + 38
6  llc       0x00005610bd94d46f
7  llc       0x00005610bf2a8269
8  llc       0x00005610bdc77208
9  llc       0x00005610befc775f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005610bf18034d
11 llc       0x00005610bf24d7a0
12 llc       0x00005610bf180d4a
13 llc       0x00005610bf1812af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005610bf0b5188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005610bf0b776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005610bf0b9904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005610bf0a6ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005610be2108c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005610be7f2fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005610be7f32c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e8m8_and16bits
