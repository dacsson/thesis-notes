# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr v /tmp/tmpadth4ggw.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpadth4ggw.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vsetvli_i32'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000562975695e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000562975692c87
2  libc.so.6 0x00007fc70c44d4d0
3  libc.so.6 0x00007fc70c4a790c
4  libc.so.6 0x00007fc70c44d3a0 gsignal + 32
5  libc.so.6 0x00007fc70c43457a abort + 38
6  llc       0x0000562973c6546f
7  llc       0x00005629755c0269
8  llc       0x0000562973f8f208
9  llc       0x00005629752df75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x000056297549834d
11 llc       0x00005629755657a0
12 llc       0x0000562975498d4a
13 llc       0x00005629754992af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x00005629753cd188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x00005629753cf76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x00005629753d1904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x00005629753bece9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x00005629745288c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000562974b0afe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000562974b0b2c3 llvm::FPPassM
# Source: InstCombine/riscv-vsetvli-knownbits.instcombine.ll
# Function: vsetvl_e16m4_and15bits
