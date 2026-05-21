# FAILED (src): LLVM ERROR: Cannot select: 0x55aaa114fe90: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpxm0q9owx.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpxm0q9owx.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055aa7cab8e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055aa7cab5c87
2  libc.so.6 0x00007f5cf8f4f4d0
3  libc.so.6 0x00007f5cf8fa990c
4  libc.so.6 0x00007f5cf8f4f3a0 gsignal + 32
5  libc.so.6 0x00007f5cf8f3657a abort + 38
6  llc       0x000055aa7b08846f
7  llc       0x000055aa7c7e786d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x000055aa7c7e9d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x000055aa7b2f935e
10 llc       0x000055aa7c7e2119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x000055aa7c7f030e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x000055aa7c7f276f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x000055aa7c7f4904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x000055aa7c7e1ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x000055aa7b94b8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x000055aa7bf2dfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000055aa7
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_zext
