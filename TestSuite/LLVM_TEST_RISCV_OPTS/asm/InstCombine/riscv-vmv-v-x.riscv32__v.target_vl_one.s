# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmp__k2ttc7.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp__k2ttc7.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055e048c80e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055e048c7dc87
2  libc.so.6 0x00007f6ed674f4d0
3  libc.so.6 0x00007f6ed67a990c
4  libc.so.6 0x00007f6ed674f3a0 gsignal + 32
5  libc.so.6 0x00007f6ed673657a abort + 38
6  llc       0x000055e04725046f
7  llc       0x000055e048bab269
8  llc       0x000055e04757a208
9  llc       0x000055e0488ca75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055e048a8334d
11 llc       0x000055e048b2de0b
12 llc       0x000055e048a83d1e
13 llc       0x000055e048a842af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055e0489b8188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055e0489ba76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055e0489bc904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055e0489a9ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055e047b138c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055e0480f5fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055e0480f62c3 llvm::FPPassManager:
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: target_vl_one
