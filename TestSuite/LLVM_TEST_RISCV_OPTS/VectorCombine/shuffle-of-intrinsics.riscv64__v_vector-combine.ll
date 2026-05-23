; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/shuffle-of-intrinsics.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=vector-combine -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+v -passes=vector-combine -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <8 x i32> @test1(<4 x i32> %0, <4 x i32> %1) {
entry:
  %2 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %0, i1 false)
  %3 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %1, i1 false)
  %4 = shufflevector <4 x i32> %2, <4 x i32> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %4
}

define <8 x i32> @test2(<4 x i32> %0, <4 x i32> %1) {
entry:
  %2 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %0, i1 true)
  %3 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %1, i1 false)
  %4 = shufflevector <4 x i32> %2, <4 x i32> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %4
}

define <8 x i32> @test3(<4 x i32> %0, <4 x i32> %1, <4 x i32> %2, <4 x i32> %3) {
entry:
  %4 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %0, <4 x i32> %1)
  %5 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %2, <4 x i32> %3)
  %6 = shufflevector <4 x i32> %4, <4 x i32> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %6
}

define <8 x i1> @test4(<4 x float> %0, <4 x float> %1) {
entry:
  %2 = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> %0, i32 0)
  %3 = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> %1, i32 0)
  %4 = shufflevector <4 x i1> %2, <4 x i1> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i1> %4
}

define <8 x float> @test5(<4 x float> %0, i32 %1, <4 x float> %2, <4 x i32> %3) {
entry:
  %4 = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %0, i32 %1)
  %5 = call <4 x float> @llvm.powi.v4f32.v4i32(<4 x float> %2, <4 x i32> %3)
  %6 = shufflevector <4 x float> %4, <4 x float> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x float> %6
}

declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i1> @llvm.is.fpclass.v4f32(<4 x float>, i32)
declare <4 x float> @llvm.powi.v4f32.i32(<4 x float>, i32)
declare <4 x float> @llvm.powi.v4f32.v4i32(<4 x float>, <4 x i32>)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpagz965sx.ll'
source_filename = "/tmp/tmpagz965sx.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <8 x i32> @test1(<4 x i32> %0, <4 x i32> %1) #0 {
entry:
  %2 = shufflevector <4 x i32> %0, <4 x i32> %1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %3 = call <8 x i32> @llvm.abs.v8i32(<8 x i32> %2, i1 false)
  ret <8 x i32> %3
}

define <8 x i32> @test2(<4 x i32> %0, <4 x i32> %1) #0 {
entry:
  %2 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %0, i1 true)
  %3 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %1, i1 false)
  %4 = shufflevector <4 x i32> %2, <4 x i32> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %4
}

define <8 x i32> @test3(<4 x i32> %0, <4 x i32> %1, <4 x i32> %2, <4 x i32> %3) #0 {
entry:
  %4 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %0, <4 x i32> %1)
  %5 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %2, <4 x i32> %3)
  %6 = shufflevector <4 x i32> %4, <4 x i32> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %6
}

define <8 x i1> @test4(<4 x float> %0, <4 x float> %1) #0 {
entry:
  %2 = shufflevector <4 x float> %0, <4 x float> %1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %3 = call <8 x i1> @llvm.is.fpclass.v8f32(<8 x float> %2, i32 0)
  ret <8 x i1> %3
}

define <8 x float> @test5(<4 x float> %0, i32 %1, <4 x float> %2, <4 x i32> %3) #0 {
entry:
  %4 = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %0, i32 %1)
  %5 = call <4 x float> @llvm.powi.v4f32.v4i32(<4 x float> %2, <4 x i32> %3)
  %6 = shufflevector <4 x float> %4, <4 x float> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x float> %6
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1 immarg) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i1> @llvm.is.fpclass.v4f32(<4 x float>, i32 immarg) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.powi.v4f32.i32(<4 x float>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.powi.v4f32.v4i32(<4 x float>, <4 x i32>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i32> @llvm.abs.v8i32(<8 x i32>, i1 immarg) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i1> @llvm.is.fpclass.v8f32(<8 x float>, i32 immarg) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
