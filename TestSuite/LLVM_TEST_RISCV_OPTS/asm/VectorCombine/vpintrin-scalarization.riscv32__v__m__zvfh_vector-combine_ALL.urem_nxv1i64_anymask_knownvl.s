# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv32 -mattr +v,+m,+zvfh /tmp/tmp0n5lt4pe.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp0n5lt4pe.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055a64a3f4e29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055a64a3f1c87
2  libc.so.6 0x00007f49df74f4d0
3  libc.so.6 0x00007f49df7a990c
4  libc.so.6 0x00007f49df74f3a0 gsignal + 32
5  libc.so.6 0x00007f49df73657a abort + 38
6  llc       0x000055a6489c446f
7  llc       0x000055a64a31f269
8  llc       0x000055a64a10953d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055a64a205c8d
10 llc       0x000055a64a20e4e2
11 llc       0x000055a64a20fb36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055a64a12c1f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055a64a12e76f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055a64a130904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055a64a11dce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055a6492878c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055a649869fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055a64986a2c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv32__v__m__zvfh_vector-combine_ALL.ll
# Function: urem_nxv1i64_anymask_knownvl
