; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/vector-interleave2-splat.ll
; Variant: riscv32_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv32 -mattr=+v -passes=vector-combine -S
; Original: RUN: opt -S -mtriple=riscv32 -mattr=+v %s -passes=vector-combine | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @interleave2_const_splat_nxv16i32(ptr %dst) {
  %interleave2 = call <vscale x 16 x i32> @llvm.vector.interleave2.nxv16i32(<vscale x 8 x i32> splat (i32 666), <vscale x 8 x i32> splat (i32 777))
  call void @llvm.vp.store.nxv16i32.p0(<vscale x 16 x i32> %interleave2, ptr %dst, <vscale x 16 x i1> splat (i1 true), i32 88)
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpj7wwv_54.ll'
source_filename = "/tmp/tmpj7wwv_54.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define void @interleave2_const_splat_nxv16i32(ptr %dst) #0 {
  call void @llvm.vp.store.nxv16i32.p0(<vscale x 16 x i32> bitcast (<vscale x 8 x i64> splat (i64 3337189589658) to <vscale x 16 x i32>), ptr %dst, <vscale x 16 x i1> splat (i1 true), i32 88)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 16 x i32> @llvm.vector.interleave2.nxv16i32(<vscale x 8 x i32>, <vscale x 8 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv16i32.p0(<vscale x 16 x i32>, ptr captures(none), <vscale x 16 x i1>, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) "target-features"="+v" }
