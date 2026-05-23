; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/PreISelIntrinsicLowering/RISCV/expand-fp-math.ll
; Variant: riscv64_pre-isel-intrinsic-lowering_RV64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=pre-isel-intrinsic-lowering -mtriple=riscv64 -S
; Original: RUN: opt -passes=pre-isel-intrinsic-lowering -mtriple=riscv64 -S < %s | FileCheck %s --check-prefix=RV64

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <vscale x 4 x float> @scalable_vec_sin(<vscale x 4 x float> %input) {
  %output = call <vscale x 4 x float> @llvm.sin.nxv4f32(<vscale x 4 x float> %input)
  ret <vscale x 4 x float> %output
}

define <vscale x 4 x float> @scalable_vec_exp(<vscale x 4 x float> %input) {
  %output = call <vscale x 4 x float> @llvm.exp.nxv4f32(<vscale x 4 x float> %input)
  ret <vscale x 4 x float> %output
}

define <vscale x 4 x float> @scalable_vec_log(<vscale x 4 x float> %input) {
  %output = call <vscale x 4 x float> @llvm.log.nxv4f32(<vscale x 4 x float> %input)
  ret <vscale x 4 x float> %output
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpu9d318cq.ll'
source_filename = "/tmp/tmpu9d318cq.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <vscale x 4 x float> @scalable_vec_sin(<vscale x 4 x float> %input) {
  %1 = call i64 @llvm.vscale.i64()
  %2 = mul nuw i64 %1, 4
  br label %3

3:                                                ; preds = %3, %0
  %4 = phi i64 [ 0, %0 ], [ %9, %3 ]
  %5 = phi <vscale x 4 x float> [ %input, %0 ], [ %8, %3 ]
  %6 = extractelement <vscale x 4 x float> %5, i64 %4
  %7 = call float @llvm.sin.f32(float %6)
  %8 = insertelement <vscale x 4 x float> %5, float %7, i64 %4
  %9 = add i64 %4, 1
  %10 = icmp eq i64 %9, %2
  br i1 %10, label %11, label %3

11:                                               ; preds = %3
  ret <vscale x 4 x float> %8
}

define <vscale x 4 x float> @scalable_vec_exp(<vscale x 4 x float> %input) {
  %1 = call i64 @llvm.vscale.i64()
  %2 = mul nuw i64 %1, 4
  br label %3

3:                                                ; preds = %3, %0
  %4 = phi i64 [ 0, %0 ], [ %9, %3 ]
  %5 = phi <vscale x 4 x float> [ %input, %0 ], [ %8, %3 ]
  %6 = extractelement <vscale x 4 x float> %5, i64 %4
  %7 = call float @llvm.exp.f32(float %6)
  %8 = insertelement <vscale x 4 x float> %5, float %7, i64 %4
  %9 = add i64 %4, 1
  %10 = icmp eq i64 %9, %2
  br i1 %10, label %11, label %3

11:                                               ; preds = %3
  ret <vscale x 4 x float> %8
}

define <vscale x 4 x float> @scalable_vec_log(<vscale x 4 x float> %input) {
  %1 = call i64 @llvm.vscale.i64()
  %2 = mul nuw i64 %1, 4
  br label %3

3:                                                ; preds = %3, %0
  %4 = phi i64 [ 0, %0 ], [ %9, %3 ]
  %5 = phi <vscale x 4 x float> [ %input, %0 ], [ %8, %3 ]
  %6 = extractelement <vscale x 4 x float> %5, i64 %4
  %7 = call float @llvm.log.f32(float %6)
  %8 = insertelement <vscale x 4 x float> %5, float %7, i64 %4
  %9 = add i64 %4, 1
  %10 = icmp eq i64 %9, %2
  br i1 %10, label %11, label %3

11:                                               ; preds = %3
  ret <vscale x 4 x float> %8
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.exp.nxv4f32(<vscale x 4 x float>) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.log.nxv4f32(<vscale x 4 x float>) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.sin.nxv4f32(<vscale x 4 x float>) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.log.f32(float) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sin.f32(float) #0

attributes #0 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
