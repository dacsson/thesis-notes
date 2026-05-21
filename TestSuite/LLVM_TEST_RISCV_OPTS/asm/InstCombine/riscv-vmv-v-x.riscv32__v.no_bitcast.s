# FAILED (src): LLVM ERROR: Unimplemented RISCVTargetLowering::LowerOperation Case
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v /tmp/tmprrr27x38.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmprrr27x38.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@target_vl_one'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000557eb39b1e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x0000557eb39aec87
2  libc.so.6 0x00007f7bf9a4d4d0
3  libc.so.6 0x00007f7bf9aa790c
4  libc.so.6 0x00007f7bf9a4d3a0 gsignal + 32
5  libc.so.6 0x00007f7bf9a3457a abort + 38
6  llc       0x0000557eb1f8146f
7  llc       0x0000557eb38dc269
8  llc       0x0000557eb22ab208
9  llc       0x0000557eb35fb75f llvm::TargetLowering::LowerOperationWrapper(llvm::SDNode*, llvm::SmallVectorImpl<llvm::SDValue>&, llvm::SelectionDAG&) const + 31
10 llc       0x0000557eb37b434d
11 llc       0x0000557eb385ee0b
12 llc       0x0000557eb37b4d1e
13 llc       0x0000557eb37b52af llvm::SelectionDAG::LegalizeTypes() + 1135
14 llc       0x0000557eb36e9188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
15 llc       0x0000557eb36eb76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
16 llc       0x0000557eb36ed904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
17 llc       0x0000557eb36dace9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
18 llc       0x0000557eb28448c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
19 llc       0x0000557eb2e26fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
20 llc       0x0000557eb2e272c3 llvm::FPPa
# Source: InstCombine/riscv-vmv-v-x.riscv32__v.ll
# Function: no_bitcast
