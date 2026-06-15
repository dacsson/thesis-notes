# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp1q_blh3j.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp1q_blh3j.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055ddd24b7e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055ddd24b4c87
2  libc.so.6 0x00007f60dfa4d4d0
3  libc.so.6 0x00007f60dfaa790c
4  libc.so.6 0x00007f60dfa4d3a0 gsignal + 32
5  libc.so.6 0x00007f60dfa3457a abort + 38
6  llc       0x000055ddd0a8746f
7  llc       0x000055ddd23e2269
8  llc       0x000055ddd0db1208
9  llc       0x000055ddd210175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055ddd22ba34d
11 llc       0x000055ddd23877a0
12 llc       0x000055ddd22bad4a
13 llc       0x000055ddd22bb2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055ddd21ef188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055ddd21f176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055ddd21f3904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055ddd21e0ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055ddd134a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055ddd192cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055ddd192d2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_sext
