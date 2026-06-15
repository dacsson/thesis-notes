# FAILED (src): LLVM ERROR: Cannot select: 0x560a7637fe50: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpzg88dnuu.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpzg88dnuu.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000560a66a3fe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000560a66a3cc87
2  libc.so.6 0x00007f7bb2c1e4d0
3  libc.so.6 0x00007f7bb2c7890c
4  libc.so.6 0x00007f7bb2c1e3a0 gsignal + 32
5  libc.so.6 0x00007f7bb2c0557a abort + 38
6  llc       0x0000560a6500f46f
7  llc       0x0000560a6676e86d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x0000560a66770d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x0000560a6528035e
10 llc       0x0000560a66769119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x0000560a6677730e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x0000560a6677976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000560a6677b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000560a66768ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x0000560a658d28c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x0000560a65eb4fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x0000560a6
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e64m1_and11bits
