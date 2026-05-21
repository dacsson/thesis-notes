# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpve5f8863.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpve5f8863.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a338894e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a338891c87
2  libc.so.6 0x00007fa9b344d4d0
3  libc.so.6 0x00007fa9b34a790c
4  libc.so.6 0x00007fa9b344d3a0 gsignal + 32
5  libc.so.6 0x00007fa9b343457a abort + 38
6  llc       0x000055a336e6446f
7  llc       0x000055a3387bf269
8  llc       0x000055a33718e208
9  llc       0x000055a3384de75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000055a33869734d
11 llc       0x000055a3387647a0
12 llc       0x000055a338697d4a
13 llc       0x000055a3386982af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x000055a3385cc188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x000055a3385ce76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x000055a3385d0904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x000055a3385bdce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x000055a3377278c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x000055a337d09fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x000055a337d0a2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e64mf8_and10bits
