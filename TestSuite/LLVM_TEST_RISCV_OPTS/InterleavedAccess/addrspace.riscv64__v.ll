; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InterleavedAccess/RISCV/addrspace.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -p interleaved-access -S
; Original: RUN: opt < %s -mtriple=riscv64 -mattr=+v -p interleaved-access -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Ensure we don't crash with non-zero address spaces.

define void @load_factor2(ptr addrspace(1) %ptr) {
  %interleaved.vec = load <16 x i32>, ptr addrspace(1) %ptr
  %v0 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor2_vscale(ptr addrspace(1) %ptr) {
  %interleaved.vec = load <vscale x 16 x i32>, ptr addrspace(1) %ptr
  %v = call { <vscale x 8 x i32>, <vscale x 8 x i32> } @llvm.vector.deinterleave2.nxv16i32(<vscale x 16 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %v, 1
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6afhw6qb.ll'
source_filename = "/tmp/tmp6afhw6qb.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_factor2(ptr addrspace(1) %ptr) #0 {
  %1 = call { <8 x i32>, <8 x i32> } @llvm.riscv.seg2.load.mask.v8i32.p1.i64(ptr addrspace(1) %ptr, <8 x i1> splat (i1 true), i64 8)
  %2 = extractvalue { <8 x i32>, <8 x i32> } %1, 1
  %3 = extractvalue { <8 x i32>, <8 x i32> } %1, 0
  ret void
}

define void @load_factor2_vscale(ptr addrspace(1) %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 32 x i8>, 2) @llvm.riscv.vlseg2.mask.triscv.vector.tuple_nxv32i8_2t.p1.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 32 x i8>, 2) poison, ptr addrspace(1) %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 8 x i32> @llvm.riscv.tuple.extract.nxv8i32.triscv.vector.tuple_nxv32i8_2t(target("riscv.vector.tuple", <vscale x 32 x i8>, 2) %1, i32 0)
  %3 = insertvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } poison, <vscale x 8 x i32> %2, 0
  %4 = call <vscale x 8 x i32> @llvm.riscv.tuple.extract.nxv8i32.triscv.vector.tuple_nxv32i8_2t(target("riscv.vector.tuple", <vscale x 32 x i8>, 2) %1, i32 1)
  %5 = insertvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %3, <vscale x 8 x i32> %4, 1
  %t0 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %5, 0
  %t1 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %5, 1
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 8 x i32>, <vscale x 8 x i32> } @llvm.vector.deinterleave2.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <8 x i32>, <8 x i32> } @llvm.riscv.seg2.load.mask.v8i32.p1.i64(ptr addrspace(1) captures(none), <8 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 32 x i8>, 2) @llvm.riscv.vlseg2.mask.triscv.vector.tuple_nxv32i8_2t.p1.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 32 x i8>, 2), ptr addrspace(1) captures(none), <vscale x 8 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i32> @llvm.riscv.tuple.extract.nxv8i32.triscv.vector.tuple_nxv32i8_2t(target("riscv.vector.tuple", <vscale x 32 x i8>, 2), i32 immarg) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
