# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmps20k8e_5.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmps20k8e_5.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000562d27362e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000562d2735fc87
2  libc.so.6 0x00007f040c1224d0
3  libc.so.6 0x00007f040c17c90c
4  libc.so.6 0x00007f040c1223a0 gsignal + 32
5  libc.so.6 0x00007f040c10957a abort + 38
6  llc       0x0000562d2593246f
7  llc       0x0000562d2728d269
8  llc       0x0000562d25c5c208
9  llc       0x0000562d26fac75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000562d2716534d
11 llc       0x0000562d272327a0
12 llc       0x0000562d27165d4a
13 llc       0x0000562d271662af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000562d2709a188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000562d2709c76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000562d2709e904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000562d2708bce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000562d261f58c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000562d267d7fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000562d267d82c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64m1_and11bits
