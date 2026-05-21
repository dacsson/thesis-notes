# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpoi5kd9bx.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpoi5kd9bx.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a21db2de29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a21db2ac87
2  libc.so.6 0x00007f44825224d0
3  libc.so.6 0x00007f448257c90c
4  libc.so.6 0x00007f44825223a0 gsignal + 32
5  libc.so.6 0x00007f448250957a abort + 38
6  llc       0x000055a21c0fd46f
7  llc       0x000055a21da58269
8  llc       0x000055a21c427208
9  llc       0x000055a21d77775f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055a21d93034d
11 llc       0x000055a21d9fd7a0
12 llc       0x000055a21d930d4a
13 llc       0x000055a21d9312af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055a21d865188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055a21d86776f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055a21d869904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055a21d856ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055a21c9c08c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055a21cfa2fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055a21cfa32c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e8m1_and14bits
