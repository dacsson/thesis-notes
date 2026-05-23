# FAILED (src): LLVM ERROR: Cannot select: 0x556f0180ce40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: src
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp334hr2t2.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp334hr2t2.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@src'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000556efe002e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000556efdfffc87
2  libc.so.6 0x00007fc49f64d4d0
3  libc.so.6 0x00007fc49f6a790c
4  libc.so.6 0x00007fc49f64d3a0 gsignal + 32
5  libc.so.6 0x00007fc49f63457a abort + 38
6  llc       0x0000556efc5d246f
7  llc       0x0000556efdd3186d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x0000556efdd33d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x0000556efc84335e
10 llc       0x0000556efdd2c119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x0000556efdd3a30e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x0000556efdd3c76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000556efdd3e904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000556efdd2bce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x0000556efce958c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x0000556efd477fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x0000556efd4782c3 llvm::FPPassMa
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlimax_i32
