# FAILED (src): LLVM ERROR: Cannot select: 0x56219db81e40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpfz_z8plc.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpfz_z8plc.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000056218cda0e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056218cd9dc87
2  libc.so.6 0x00007f744a64d4d0
3  libc.so.6 0x00007f744a6a790c
4  libc.so.6 0x00007f744a64d3a0 gsignal + 32
5  libc.so.6 0x00007f744a63457a abort + 38
6  llc       0x000056218b37046f
7  llc       0x000056218cacf86d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x000056218cad1d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x000056218b5e135e
10 llc       0x000056218caca119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x000056218cad830e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x000056218cada76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x000056218cadc904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x000056218cac9ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x000056218bc338c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x000056218c215fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000056218
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e16m8_and15bits
