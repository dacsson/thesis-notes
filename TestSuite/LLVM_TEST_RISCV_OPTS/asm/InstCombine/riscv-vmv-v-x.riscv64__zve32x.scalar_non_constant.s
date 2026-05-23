# FAILED (src): LLVM ERROR: Cannot select: 0x556200d83a40: i64 = bitcast 0x556200d833b0
  0x556200d833b0: nxv8i8 = RISCVISD::VMV_V_X_VL undef:nxv8i8, Constant:i64<85>, Constant:i64<4>
In function: bitcast_users_type_mismatch
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +zve32x /tmp/tmp6h8yglr9.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6h8yglr9.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@bitcast_users_type_mismatch'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005561eee95e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005561eee92c87
2  libc.so.6 0x00007f298ac4d4d0
3  libc.so.6 0x00007f298aca790c
4  libc.so.6 0x00007f298ac4d3a0 gsignal + 32
5  libc.so.6 0x00007f298ac3457a abort + 38
6  llc       0x00005561ed46546f
7  llc       0x00005561eebc486d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x00005561eebc6d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x00005561ed6d635e
10 llc       0x00005561eebbf119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x00005561eebcd30e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x00005561eebcf76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x00005561eebd1904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x00005561eebbece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x00005561edd288c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 l
# Source: InstCombine/riscv-vmv-v-x.riscv64__zve32x.ll
# Function: scalar_non_constant
