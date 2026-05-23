# FAILED (src): LLVM ERROR: Cannot select: 0x55e15ae17e50: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpg20o_62q.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpg20o_62q.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055e156b7fe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055e156b7cc87
2  libc.so.6 0x00007f4fb824d4d0
3  libc.so.6 0x00007f4fb82a790c
4  libc.so.6 0x00007f4fb824d3a0 gsignal + 32
5  libc.so.6 0x00007f4fb823457a abort + 38
6  llc       0x000055e15514f46f
7  llc       0x000055e1568ae86d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x000055e1568b0d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x000055e1553c035e
10 llc       0x000055e1568a9119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x000055e1568b730e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x000055e1568b976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x000055e1568bb904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x000055e1568a8ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x000055e155a128c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x000055e155ff4fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000055e15
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e64m2_and12bits
