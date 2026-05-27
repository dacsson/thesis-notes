# FAILED (src): LLVM ERROR: Cannot select: 0x56181f36ce40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpe8xj2w_9.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpe8xj2w_9.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005617f0890e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005617f088dc87
2  libc.so.6 0x00007f018d74f4d0
3  libc.so.6 0x00007f018d7a990c
4  libc.so.6 0x00007f018d74f3a0 gsignal + 32
5  libc.so.6 0x00007f018d73657a abort + 38
6  llc       0x00005617eee6046f
7  llc       0x00005617f05bf86d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x00005617f05c1d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x00005617ef0d135e
10 llc       0x00005617f05ba119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x00005617f05c830e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x00005617f05ca76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x00005617f05cc904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x00005617f05b9ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x00005617ef7238c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x00005617efd05fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x00005617e
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e32mf8_and11bits
