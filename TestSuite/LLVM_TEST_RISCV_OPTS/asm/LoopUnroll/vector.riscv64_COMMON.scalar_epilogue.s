# FAILED (src): LLVM ERROR: Scalarization of scalable vectors is not supported.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 /tmp/tmpzj4zrujs.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmpzj4zrujs.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@vector_operands'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x0000558310000e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055830fffdc87
2  libc.so.6 0x00007f955774f4d0
3  libc.so.6 0x00007f95577a990c
4  libc.so.6 0x00007f955774f3a0 gsignal + 32
5  libc.so.6 0x00007f955773657a abort + 38
6  llc       0x000055830e5d046f
7  llc       0x000055830ff2b228
8  llc       0x000055830fe03e39
9  llc       0x000055830fe042af llvm::SelectionDAG::LegalizeTypes() + 1135
10 llc       0x000055830fd38188 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 248
11 llc       0x000055830fd3a76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
12 llc       0x000055830fd3c904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
13 llc       0x000055830fd29ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
14 llc       0x000055830ee938c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
15 llc       0x000055830f475fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
16 llc       0x000055830f4762c3 llvm::FPPassManager::runOnModule(llvm::Module&) + 51
17 llc       0x000055830f475464 llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1364
18 llc       0x000055830e6dcafd
19 llc       0x000055830e5e3c8d main + 1181
20 libc.so.6 0x00007f9557738635
21 libc.so.6 0x00007f95577386
# Source: LoopUnroll/vector.riscv64_COMMON.ll
# Function: scalar_epilogue
