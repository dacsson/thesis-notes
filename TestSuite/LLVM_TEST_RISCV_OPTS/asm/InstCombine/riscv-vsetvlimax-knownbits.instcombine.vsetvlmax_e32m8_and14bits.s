# FAILED (src): LLVM ERROR: Cannot select: 0x562ded623e40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpsxdjhz4x.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpsxdjhz4x.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000562dd69e1e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000562dd69dec87
2  libc.so.6 0x00007f44410204d0
3  libc.so.6 0x00007f444107a90c
4  libc.so.6 0x00007f44410203a0 gsignal + 32
5  libc.so.6 0x00007f444100757a abort + 38
6  llc       0x0000562dd4fb146f
7  llc       0x0000562dd671086d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x0000562dd6712d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x0000562dd522235e
10 llc       0x0000562dd670b119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x0000562dd671930e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x0000562dd671b76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000562dd671d904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000562dd670ace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x0000562dd58748c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x0000562dd5e56fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x0000562dd
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e32m8_and14bits
