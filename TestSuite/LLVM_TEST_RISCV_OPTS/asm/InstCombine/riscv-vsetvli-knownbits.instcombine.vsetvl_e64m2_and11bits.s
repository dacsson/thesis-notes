# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpckhia1e0.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpckhia1e0.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005594c2f2ae29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005594c2f27c87
2  libc.so.6 0x00007f6eb574f4d0
3  libc.so.6 0x00007f6eb57a990c
4  libc.so.6 0x00007f6eb574f3a0 gsignal + 32
5  libc.so.6 0x00007f6eb573657a abort + 38
6  llc       0x00005594c14fa46f
7  llc       0x00005594c2e55269
8  llc       0x00005594c1824208
9  llc       0x00005594c2b7475f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005594c2d2d34d
11 llc       0x00005594c2dfa7a0
12 llc       0x00005594c2d2dd4a
13 llc       0x00005594c2d2e2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005594c2c62188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005594c2c6476f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005594c2c66904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005594c2c53ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005594c1dbd8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005594c239ffe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005594c23a02c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64m2_and11bits
