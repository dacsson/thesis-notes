# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmppqx9918c.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmppqx9918c.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000564759bd8e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000564759bd5c87
2  libc.so.6 0x00007f97c524d4d0
3  libc.so.6 0x00007f97c52a790c
4  libc.so.6 0x00007f97c524d3a0 gsignal + 32
5  libc.so.6 0x00007f97c523457a abort + 38
6  llc       0x00005647581a846f
7  llc       0x0000564759b03269
8  llc       0x00005647584d2208
9  llc       0x000056475982275f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005647599db34d
11 llc       0x0000564759a85e0b
12 llc       0x00005647599dbd1e
13 llc       0x00005647599dc2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000564759910188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000056475991276f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000564759914904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000564759901ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000564758a6b8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000056475904dfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000056475904e2c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: small_scalar
