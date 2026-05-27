# FAILED (src): LLVM ERROR: Cannot select: 0x55c868eb0dc0: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpfpx_mv4g.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpfpx_mv4g.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c84af84e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c84af81c87
2  libc.so.6 0x00007feff3b4f4d0
3  libc.so.6 0x00007feff3ba990c
4  libc.so.6 0x00007feff3b4f3a0 gsignal + 32
5  libc.so.6 0x00007feff3b3657a abort + 38
6  llc       0x000055c84955446f
7  llc       0x000055c84acb386d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x000055c84acb5d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x000055c8497c535e
10 llc       0x000055c84acae119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x000055c84acbc30e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x000055c84acbe76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x000055c84acc0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x000055c84acadce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x000055c849e178c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x000055c84a3f9fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000055c84
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e16m4_and14bits
