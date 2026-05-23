# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmpiyoam9oh.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpiyoam9oh.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055ff1c65de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055ff1c65ac87
2  libc.so.6 0x00007f355354f4d0
3  libc.so.6 0x00007f35535a990c
4  libc.so.6 0x00007f355354f3a0 gsignal + 32
5  libc.so.6 0x00007f355353657a abort + 38
6  llc       0x000055ff1ac2d46f
7  llc       0x000055ff1c588269
8  llc       0x000055ff1af57208
9  llc       0x000055ff1c2a775f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055ff1c46034d
11 llc       0x000055ff1c50ae0b
12 llc       0x000055ff1c460d1e
13 llc       0x000055ff1c4612af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055ff1c395188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055ff1c39776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055ff1c399904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055ff1c386ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055ff1b4f08c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055ff1bad2fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055ff1bad32c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: vl_non_constant
