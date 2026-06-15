# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmp737q6i1i.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp737q6i1i.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000563ed953fe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000563ed953cc87
2  libc.so.6 0x00007f138234f4d0
3  libc.so.6 0x00007f13823a990c
4  libc.so.6 0x00007f138234f3a0 gsignal + 32
5  libc.so.6 0x00007f138233657a abort + 38
6  llc       0x0000563ed7b0f46f
7  llc       0x0000563ed946a269
8  llc       0x0000563ed7e39208
9  llc       0x0000563ed918975f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000563ed934234d
11 llc       0x0000563ed940f7a0
12 llc       0x0000563ed9342d4a
13 llc       0x0000563ed93432af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000563ed9277188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000563ed927976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000563ed927b904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000563ed9268ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000563ed83d28c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000563ed89b4fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000563ed89b52c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64mf2_and7bits
