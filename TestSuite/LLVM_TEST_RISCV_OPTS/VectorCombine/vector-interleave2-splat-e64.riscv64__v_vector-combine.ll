; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/vector-interleave2-splat-e64.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=vector-combine -S
; Original: RUN: opt -S -mtriple=riscv64 -mattr=+v %s -passes=vector-combine | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; We should not form a i128 vector.

define void @interleave2_const_splat_nxv8i64(ptr %dst) {
  %interleave2 = call <vscale x 8 x i64> @llvm.vector.interleave2.nxv8i64(<vscale x 4 x i64> splat (i64 666), <vscale x 4 x i64> splat (i64 777))
  call void @llvm.vp.store.nxv8i64.p0(<vscale x 8 x i64> %interleave2, ptr %dst, <vscale x 8 x i1> splat (i1 true), i32 88)
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp2s5qkl8u.ll'
source_filename = "/tmp/tmp2s5qkl8u.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @interleave2_const_splat_nxv8i64(ptr %dst) #0 {
  %interleave2 = call <vscale x 8 x i64> @llvm.vector.interleave2.nxv8i64(<vscale x 4 x i64> splat (i64 666), <vscale x 4 x i64> splat (i64 777))
  call void @llvm.vp.store.nxv8i64.p0(<vscale x 8 x i64> %interleave2, ptr %dst, <vscale x 8 x i1> splat (i1 true), i32 88)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i64> @llvm.vector.interleave2.nxv8i64(<vscale x 4 x i64>, <vscale x 4 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i64.p0(<vscale x 8 x i64>, ptr captures(none), <vscale x 8 x i1>, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) "target-features"="+v" }
