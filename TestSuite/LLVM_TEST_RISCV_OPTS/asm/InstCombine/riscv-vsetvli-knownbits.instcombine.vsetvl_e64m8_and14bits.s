# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp778hso4w.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp778hso4w.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000560dab397e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000560dab394c87
2  libc.so.6 0x00007f53fef4f4d0
3  libc.so.6 0x00007f53fefa990c
4  libc.so.6 0x00007f53fef4f3a0 gsignal + 32
5  libc.so.6 0x00007f53fef3657a abort + 38
6  llc       0x0000560da996746f
7  llc       0x0000560dab2c2269
8  llc       0x0000560da9c91208
9  llc       0x0000560daafe175f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000560dab19a34d
11 llc       0x0000560dab2677a0
12 llc       0x0000560dab19ad4a
13 llc       0x0000560dab19b2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000560dab0cf188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000560dab0d176f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000560dab0d3904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000560dab0c0ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000560daa22a8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000560daa80cfe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000560daa80d2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64m8_and14bits
