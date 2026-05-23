# FAILED (src): LLVM ERROR: Cannot select: 0x55c2df66be50: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmptywolw62.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmptywolw62.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c2c6946e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c2c6943c87
2  libc.so.6 0x00007f1d244204d0
3  libc.so.6 0x00007f1d2447a90c
4  libc.so.6 0x00007f1d244203a0 gsignal + 32
5  libc.so.6 0x00007f1d2440757a abort + 38
6  llc       0x000055c2c4f1646f
7  llc       0x000055c2c667586d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x000055c2c6677d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x000055c2c518735e
10 llc       0x000055c2c6670119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x000055c2c667e30e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x000055c2c668076f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x000055c2c6682904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x000055c2c666fce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x000055c2c57d98c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x000055c2c5dbbfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000055c2c
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e32mf4_and9bits
