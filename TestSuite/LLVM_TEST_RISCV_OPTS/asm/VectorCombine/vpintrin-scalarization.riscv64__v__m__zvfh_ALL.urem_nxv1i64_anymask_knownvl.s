# FAILED (src): LLVM ERROR: Possible incorrect use of EVT::getVectorNumElements() for scalable vector. Scalable flag may be dropped, use EVT::getVectorElementCount() instead
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and instructions to reproduce the bug.
Stack dump:
0.	Program arguments: /home/artjom/Tools/llvm-project/build/bin/llc -mtriple riscv64 -mattr +v,+m,+zvfh /tmp/tmp1j1mn8fq.ll -o - -O0
1.	Running pass 'Function Pass Manager' on module '/tmp/tmp1j1mn8fq.ll'.
2.	Running pass 'RISC-V DAG->DAG Pattern Instruction Selection' on function '@frem_nxv1f32_allonesmask'
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  llc       0x000055c8beaafe29 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 57
1  llc       0x000055c8beaacc87
2  libc.so.6 0x00007f71e63224d0
3  libc.so.6 0x00007f71e637c90c
4  libc.so.6 0x00007f71e63223a0 gsignal + 32
5  libc.so.6 0x00007f71e630957a abort + 38
6  llc       0x000055c8bd07f46f
7  llc       0x000055c8be9da269
8  llc       0x000055c8be7c453d llvm::SelectionDAG::UnrollVectorOp(llvm::SDNode*, unsigned int) + 6541
9  llc       0x000055c8be8c0c8d
10 llc       0x000055c8be8c94e2
11 llc       0x000055c8be8cab36 llvm::SelectionDAG::LegalizeVectors() + 854
12 llc       0x000055c8be7e71f0 llvm::SelectionDAGISel::CodeGenAndEmitDAG() + 352
13 llc       0x000055c8be7e976f llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) + 3599
14 llc       0x000055c8be7eb904 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) + 228
15 llc       0x000055c8be7d8ce9 llvm::SelectionDAGISelLegacy::runOnMachineFunction(llvm::MachineFunction&) + 441
16 llc       0x000055c8bd9428c9 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) + 457
17 llc       0x000055c8bdf24fe1 llvm::FPPassManager::runOnFunction(llvm::Function&) + 1665
18 llc       0x000055c8bdf252c3 llvm::FPPassManager::
# Source: VectorCombine/vpintrin-scalarization.riscv64__v__m__zvfh_ALL.ll
# Function: urem_nxv1i64_anymask_knownvl
