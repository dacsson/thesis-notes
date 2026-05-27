# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpjj_l3tkt.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpjj_l3tkt.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055d9267b0e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055d9267adc87
2  libc.so.6 0x00007f9f8b04d4d0
3  libc.so.6 0x00007f9f8b0a790c
4  libc.so.6 0x00007f9f8b04d3a0 gsignal + 32
5  libc.so.6 0x00007f9f8b03457a abort + 38
6  llc       0x000055d924d8046f
7  llc       0x000055d9266db269
8  llc       0x000055d9250aa208
9  llc       0x000055d9263fa75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055d9265b334d
11 llc       0x000055d9266807a0
12 llc       0x000055d9265b3d4a
13 llc       0x000055d9265b42af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055d9264e8188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055d9264ea76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055d9264ec904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055d9264d9ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055d9256438c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055d925c25fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055d925c262c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e32m1_and12bits
