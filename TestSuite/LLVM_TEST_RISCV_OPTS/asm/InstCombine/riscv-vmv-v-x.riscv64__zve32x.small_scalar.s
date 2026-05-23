# FAILED (src): LLVM ERROR: Cannot select: 0x5621e6a289f0: i64 = bitcast 0x5621e6a28360
  0x5621e6a28360: nxv8i8 = RISCVISD::VMV_V_X_VL undef:nxv8i8, Constant:i64<85>, Constant:i64<4>
In function: bitcast_users_type_mismatch
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +zve32x /tmp/tmpgjtzwmgh.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpgjtzwmgh.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@bitcast_users_type_mismatch'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005621b21cee29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005621b21cbc87
2  libc.so.6 0x00007f2971a4d4d0
3  libc.so.6 0x00007f2971aa790c
4  libc.so.6 0x00007f2971a4d3a0 gsignal + 32
5  libc.so.6 0x00007f2971a3457a abort + 38
6  llc       0x00005621b079e46f
7  llc       0x00005621b1efd86d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x00005621b1effd99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x00005621b0a0f35e
10 llc       0x00005621b1ef8119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x00005621b1f0630e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x00005621b1f0876f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x00005621b1f0a904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x00005621b1ef7ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x00005621b10618c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 l
# Source: InstCombine/riscv-vmv-v-x.riscv64__zve32x.ll
# Function: small_scalar
