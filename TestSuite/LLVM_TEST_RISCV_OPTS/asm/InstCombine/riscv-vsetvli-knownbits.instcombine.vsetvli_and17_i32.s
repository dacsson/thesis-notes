# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp0ov5yaem.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp0ov5yaem.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000564bb87abe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000564bb87a8c87
2  libc.so.6 0x00007fee9c34f4d0
3  libc.so.6 0x00007fee9c3a990c
4  libc.so.6 0x00007fee9c34f3a0 gsignal + 32
5  libc.so.6 0x00007fee9c33657a abort + 38
6  llc       0x0000564bb6d7b46f
7  llc       0x0000564bb86d6269
8  llc       0x0000564bb70a5208
9  llc       0x0000564bb83f575f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000564bb85ae34d
11 llc       0x0000564bb867b7a0
12 llc       0x0000564bb85aed4a
13 llc       0x0000564bb85af2af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000564bb84e3188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000564bb84e576f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000564bb84e7904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000564bb84d4ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000564bb763e8c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000564bb7c20fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000564bb7c212c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvli_and17_i32
