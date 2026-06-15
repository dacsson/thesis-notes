# FAILED (src): LLVM ERROR: Cannot select: 0x561c362c7a40: i64 = bitcast 0x561c362c73b0
  0x561c362c73b0: nxv8i8 = RISCVISD::VMV_V_X_VL undef:nxv8i8, Constant:i64<85>, Constant:i64<4>
In function: bitcast_users_type_mismatch
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +zve32x /tmp/tmpvh4wg3za.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpvh4wg3za.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@bitcast_users_type_mismatch'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000561c210a9e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000561c210a6c87
2  libc.so.6 0x00007f98d684d4d0
3  libc.so.6 0x00007f98d68a790c
4  libc.so.6 0x00007f98d684d3a0 gsignal + 32
5  libc.so.6 0x00007f98d683457a abort + 38
6  llc       0x0000561c1f67946f
7  llc       0x0000561c20dd886d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x0000561c20ddad99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x0000561c1f8ea35e
10 llc       0x0000561c20dd3119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x0000561c20de130e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x0000561c20de376f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000561c20de5904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000561c20dd2ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x0000561c1ff3c8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 l
# Source: InstCombine/riscv-vmv-v-x.riscv64__zve32x.ll
# Function: target_vl_32
