# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpefpglrlo.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpefpglrlo.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055d316871e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055d31686ec87
2  libc.so.6 0x00007f514004d4d0
3  libc.so.6 0x00007f51400a790c
4  libc.so.6 0x00007f514004d3a0 gsignal + 32
5  libc.so.6 0x00007f514003457a abort + 38
6  llc       0x000055d314e4146f
7  llc       0x000055d31679c269
8  llc       0x000055d31516b208
9  llc       0x000055d3164bb75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055d31667434d
11 llc       0x000055d3167417a0
12 llc       0x000055d316674d4a
13 llc       0x000055d3166752af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055d3165a9188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055d3165ab76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055d3165ad904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055d31659ace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055d3157048c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055d315ce6fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055d315ce72c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16m4_and14bits
