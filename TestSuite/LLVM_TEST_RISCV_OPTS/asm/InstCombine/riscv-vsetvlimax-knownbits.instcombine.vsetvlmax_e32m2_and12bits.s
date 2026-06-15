# FAILED (src): LLVM ERROR: Cannot select: 0x55699a5ebe40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp14rdpdq7.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp14rdpdq7.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000556963f6ee29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000556963f6bc87
2  libc.so.6 0x00007ff75ed4f4d0
3  libc.so.6 0x00007ff75eda990c
4  libc.so.6 0x00007ff75ed4f3a0 gsignal + 32
5  libc.so.6 0x00007ff75ed3657a abort + 38
6  llc       0x000055696253e46f
7  llc       0x0000556963c9d86d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x0000556963c9fd99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x00005569627af35e
10 llc       0x0000556963c98119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x0000556963ca630e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x0000556963ca876f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000556963caa904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000556963c97ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x0000556962e018c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x00005569633e3fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000055696
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e32m2_and12bits
