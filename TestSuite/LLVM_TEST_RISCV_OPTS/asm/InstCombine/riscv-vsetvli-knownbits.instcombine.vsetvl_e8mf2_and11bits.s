# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp6gjksd4v.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6gjksd4v.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056003d586e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056003d583c87
2  libc.so.6 0x00007f513594f4d0
3  libc.so.6 0x00007f51359a990c
4  libc.so.6 0x00007f513594f3a0 gsignal + 32
5  libc.so.6 0x00007f513593657a abort + 38
6  llc       0x000056003bb5646f
7  llc       0x000056003d4b1269
8  llc       0x000056003be80208
9  llc       0x000056003d1d075f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000056003d38934d
11 llc       0x000056003d4567a0
12 llc       0x000056003d389d4a
13 llc       0x000056003d38a2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000056003d2be188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000056003d2c076f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000056003d2c2904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000056003d2afce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000056003c4198c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000056003c9fbfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000056003c9fc2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e8mf2_and11bits
