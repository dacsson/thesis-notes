# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpe7hfwb7r.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpe7hfwb7r.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000564157d8ce29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000564157d89c87
2  libc.so.6 0x00007f34b764d4d0
3  libc.so.6 0x00007f34b76a790c
4  libc.so.6 0x00007f34b764d3a0 gsignal + 32
5  libc.so.6 0x00007f34b763457a abort + 38
6  llc       0x000056415635c46f
7  llc       0x0000564157cb7269
8  llc       0x0000564156686208
9  llc       0x00005641579d675f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000564157b8f34d
11 llc       0x0000564157c5c7a0
12 llc       0x0000564157b8fd4a
13 llc       0x0000564157b902af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000564157ac4188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000564157ac676f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000564157ac8904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000564157ab5ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000564156c1f8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000564157201fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005641572022c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32m2_and12bits
