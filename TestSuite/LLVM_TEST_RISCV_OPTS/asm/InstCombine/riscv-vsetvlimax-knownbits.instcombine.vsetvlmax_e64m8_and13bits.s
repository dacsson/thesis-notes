# FAILED (src): LLVM ERROR: Cannot select: 0x563755d15e40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpo0j9yuxa.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpo0j9yuxa.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005637372a1e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000056373729ec87
2  libc.so.6 0x00007fa21a94f4d0
3  libc.so.6 0x00007fa21a9a990c
4  libc.so.6 0x00007fa21a94f3a0 gsignal + 32
5  libc.so.6 0x00007fa21a93657a abort + 38
6  llc       0x000056373587146f
7  llc       0x0000563736fd086d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x0000563736fd2d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x0000563735ae235e
10 llc       0x0000563736fcb119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x0000563736fd930e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x0000563736fdb76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x0000563736fdd904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x0000563736fcace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x00005637361348c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x0000563736716fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000056373
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e64m8_and13bits
