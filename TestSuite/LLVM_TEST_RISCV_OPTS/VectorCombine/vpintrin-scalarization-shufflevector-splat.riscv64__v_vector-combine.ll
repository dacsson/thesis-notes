; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/vpintrin-scalarization-shufflevector-splat.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=vector-combine -S
; Original: RUN: opt -S -mtriple=riscv64 -mattr=+v %s -passes=vector-combine | FileCheck %s --check-prefix=CHECK

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


declare <4 x i64> @llvm.vp.add.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32)

define <4 x i64> @add_v4i64_allonesmask(<4 x i64> %x) {
  %1 = shufflevector <4 x i64> %x, <4 x i64> zeroinitializer, <4 x i32> zeroinitializer
  %2 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %1, <4 x i64> zeroinitializer, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, i32 0)
  ret <4 x i64> %2
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_d6yb_os.ll'
source_filename = "/tmp/tmp_d6yb_os.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i64> @llvm.vp.add.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32) #0

define <4 x i64> @add_v4i64_allonesmask(<4 x i64> %x) #1 {
  %1 = shufflevector <4 x i64> %x, <4 x i64> zeroinitializer, <4 x i32> zeroinitializer
  %2 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %1, <4 x i64> zeroinitializer, <4 x i1> splat (i1 true), i32 0)
  ret <4 x i64> %2
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #1 = { "target-features"="+v" }
