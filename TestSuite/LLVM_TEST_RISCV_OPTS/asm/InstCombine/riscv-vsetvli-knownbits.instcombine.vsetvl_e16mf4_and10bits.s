# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpppk58p35.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpppk58p35.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c7edfa2e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c7edf9fc87
2  libc.so.6 0x00007f594c34f4d0
3  libc.so.6 0x00007f594c3a990c
4  libc.so.6 0x00007f594c34f3a0 gsignal + 32
5  libc.so.6 0x00007f594c33657a abort + 38
6  llc       0x000055c7ec57246f
7  llc       0x000055c7edecd269
8  llc       0x000055c7ec89c208
9  llc       0x000055c7edbec75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055c7edda534d
11 llc       0x000055c7ede727a0
12 llc       0x000055c7edda5d4a
13 llc       0x000055c7edda62af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055c7edcda188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055c7edcdc76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055c7edcde904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055c7edccbce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055c7ece358c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055c7ed417fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055c7ed4182c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16mf4_and10bits
