# FAILED (src): LLVM ERROR: Cannot select: 0x55f91d6a4e40: i64 = RISCVISD::VMV_X_S TargetConstant:i32<1>
In function: vsetvlimax_i32
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpvr6nwbyy.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpvr6nwbyy.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvlimax_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055f8ddaf6e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055f8ddaf3c87
2  libc.so.6 0x00007f569454f4d0
3  libc.so.6 0x00007f56945a990c
4  libc.so.6 0x00007f569454f3a0 gsignal + 32
5  libc.so.6 0x00007f569453657a abort + 38
6  llc       0x000055f8dc0c646f
7  llc       0x000055f8dd82586d llvm::SelectionDAGISel::CannotYetSelect(llvm::SDNode*) + 333
8  llc       0x000055f8dd827d99 llvm::SelectionDAGISel::SelectCodeCommon(llvm::SDNode*, unsigned char const*, unsigned int, unsigned char const*) + 9401
9  llc       0x000055f8dc33735e
10 llc       0x000055f8dd820119 llvm::SelectionDAGISel::DoInstructionSelection() + 473
11 llc       0x000055f8dd82e30e llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 638
12 llc       0x000055f8dd83076f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
13 llc       0x000055f8dd832904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
14 llc       0x000055f8dd81fce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
15 llc       0x000055f8dc9898c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
16 llc       0x000055f8dcf6bfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
17 llc       0x000055f8d
# Source: InstCombine/riscv-vsetvlimax-knownbits.instcombine.ll
# Function: vsetvlmax_e16mf4_and10bits
