# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmpvepqjmms.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpvepqjmms.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x00005624efd8be29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x00005624efd88c87
2  libc.so.6 0x00007f6b9ea204d0
3  libc.so.6 0x00007f6b9ea7a90c
4  libc.so.6 0x00007f6b9ea203a0 gsignal + 32
5  libc.so.6 0x00007f6b9ea0757a abort + 38
6  llc       0x00005624ee35b46f
7  llc       0x00005624efcb6269
8  llc       0x00005624ee685208
9  llc       0x00005624ef9d575f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x00005624efb8e34d
11 llc       0x00005624efc38e0b
12 llc       0x00005624efb8ed1e
13 llc       0x00005624efb8f2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005624efac3188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005624efac576f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005624efac7904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005624efab4ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005624eec1e8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x00005624ef200fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x00005624ef2012c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: vl_not_divisible
