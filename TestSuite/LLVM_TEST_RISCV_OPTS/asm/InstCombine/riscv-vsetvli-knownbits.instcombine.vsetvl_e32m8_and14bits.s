# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmps5iq09cr.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmps5iq09cr.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c4e423ce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c4e4239c87
2  libc.so.6 0x00007ff03114f4d0
3  libc.so.6 0x00007ff0311a990c
4  libc.so.6 0x00007ff03114f3a0 gsignal + 32
5  libc.so.6 0x00007ff03113657a abort + 38
6  llc       0x000055c4e280c46f
7  llc       0x000055c4e4167269
8  llc       0x000055c4e2b36208
9  llc       0x000055c4e3e8675f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055c4e403f34d
11 llc       0x000055c4e410c7a0
12 llc       0x000055c4e403fd4a
13 llc       0x000055c4e40402af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055c4e3f74188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055c4e3f7676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055c4e3f78904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055c4e3f65ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055c4e30cf8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055c4e36b1fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055c4e36b22c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32m8_and14bits
