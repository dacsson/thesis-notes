# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpft0zayce.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpft0zayce.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005621317f6e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005621317f3c87
2  libc.so.6 0x00007f1cc7a4d4d0
3  libc.so.6 0x00007f1cc7aa790c
4  libc.so.6 0x00007f1cc7a4d3a0 gsignal + 32
5  libc.so.6 0x00007f1cc7a3457a abort + 38
6  llc       0x000056212fdc646f
7  llc       0x0000562131721269
8  llc       0x00005621300f0208
9  llc       0x000056213144075f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005621315f934d
11 llc       0x00005621316c67a0
12 llc       0x00005621315f9d4a
13 llc       0x00005621315fa2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000056213152e188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000056213153076f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000562131532904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000056213151fce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005621306898c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000562130c6bfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000562130c6c2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16m1_and13bits
