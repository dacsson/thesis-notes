# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpzg9qah1r.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpzg9qah1r.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000562beb5efe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000562beb5ecc87
2  libc.so.6 0x00007f6802c4d4d0
3  libc.so.6 0x00007f6802ca790c
4  libc.so.6 0x00007f6802c4d3a0 gsignal + 32
5  libc.so.6 0x00007f6802c3457a abort + 38
6  llc       0x0000562be9bbf46f
7  llc       0x0000562beb51a269
8  llc       0x0000562be9ee9208
9  llc       0x0000562beb23975f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000562beb3f234d
11 llc       0x0000562beb4bf7a0
12 llc       0x0000562beb3f2d4a
13 llc       0x0000562beb3f32af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000562beb327188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000562beb32976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000562beb32b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000562beb318ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000562bea4828c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000562beaa64fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000562beaa652c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvli_and17_i64
