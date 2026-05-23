# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp6yx85pct.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp6yx85pct.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005630aaec7e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005630aaec4c87
2  libc.so.6 0x00007fa70244d4d0
3  libc.so.6 0x00007fa7024a790c
4  libc.so.6 0x00007fa70244d3a0 gsignal + 32
5  libc.so.6 0x00007fa70243457a abort + 38
6  llc       0x00005630a949746f
7  llc       0x00005630aadf2269
8  llc       0x00005630a97c1208
9  llc       0x00005630aab1175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005630aacca34d
11 llc       0x00005630aad977a0
12 llc       0x00005630aaccad4a
13 llc       0x00005630aaccb2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005630aabff188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005630aac0176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005630aac03904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005630aabf0ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005630a9d5a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005630aa33cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005630aa33d2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvli_sext_i64
