# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpp84ky14f.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpp84ky14f.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055e525240e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055e52523dc87
2  libc.so.6 0x00007f11fd54f4d0
3  libc.so.6 0x00007f11fd5a990c
4  libc.so.6 0x00007f11fd54f3a0 gsignal + 32
5  libc.so.6 0x00007f11fd53657a abort + 38
6  llc       0x000055e52381046f
7  llc       0x000055e52516b269
8  llc       0x000055e523b3a208
9  llc       0x000055e524e8a75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055e52504334d
11 llc       0x000055e5251107a0
12 llc       0x000055e525043d4a
13 llc       0x000055e5250442af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055e524f78188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055e524f7a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055e524f7c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055e524f69ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055e5240d38c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055e5246b5fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055e5246b62c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvli_zext_i64
