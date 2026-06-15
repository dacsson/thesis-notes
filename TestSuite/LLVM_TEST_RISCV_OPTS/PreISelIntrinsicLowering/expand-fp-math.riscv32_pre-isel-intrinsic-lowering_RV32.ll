; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/PreISelIntrinsicLowering/RISCV/expand-fp-math.ll
; Variant: riscv32_pre-isel-intrinsic-lowering_RV32
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=pre-isel-intrinsic-lowering -mtriple=riscv32 -S
; Original: RUN: opt -passes=pre-isel-intrinsic-lowering -mtriple=riscv32 -S < %s | FileCheck %s --check-prefix=RV32

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

; ModuleID = '/tmp/tmp3562frsc.ll'
source_filename = "/tmp/tmp3562frsc.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define <vscale x 4 x float> @scalable_vec_sin(<vscale x 4 x float> %input) {
  %1 = call i32 @llvm.vscale.i32()
  %2 = mul nuw i32 %1, 4
  br label %3

3:                                                ; preds = %3, %0
  %4 = phi i32 [ 0, %0 ], [ %9, %3 ]
  %5 = phi <vscale x 4 x float> [ %input, %0 ], [ %8, %3 ]
  %6 = extractelement <vscale x 4 x float> %5, i32 %4
  %7 = call float @llvm.sin.f32(float %6)
  %8 = insertelement <vscale x 4 x float> %5, float %7, i32 %4
  %9 = add i32 %4, 1
  %10 = icmp eq i32 %9, %2
  br i1 %10, label %11, label %3

11:                                               ; preds = %3
  ret <vscale x 4 x float> %8
}

define <vscale x 4 x float> @scalable_vec_exp(<vscale x 4 x float> %input) {
  %1 = call i32 @llvm.vscale.i32()
  %2 = mul nuw i32 %1, 4
  br label %3

3:                                                ; preds = %3, %0
  %4 = phi i32 [ 0, %0 ], [ %9, %3 ]
  %5 = phi <vscale x 4 x float> [ %input, %0 ], [ %8, %3 ]
  %6 = extractelement <vscale x 4 x float> %5, i32 %4
  %7 = call float @llvm.exp.f32(float %6)
  %8 = insertelement <vscale x 4 x float> %5, float %7, i32 %4
  %9 = add i32 %4, 1
  %10 = icmp eq i32 %9, %2
  br i1 %10, label %11, label %3

11:                                               ; preds = %3
  ret <vscale x 4 x float> %8
}

define <vscale x 4 x float> @scalable_vec_log(<vscale x 4 x float> %input) {
  %1 = call i32 @llvm.vscale.i32()
  %2 = mul nuw i32 %1, 4
  br label %3

3:                                                ; preds = %3, %0
  %4 = phi i32 [ 0, %0 ], [ %9, %3 ]
  %5 = phi <vscale x 4 x float> [ %input, %0 ], [ %8, %3 ]
  %6 = extractelement <vscale x 4 x float> %5, i32 %4
  %7 = call float @llvm.log.f32(float %6)
  %8 = insertelement <vscale x 4 x float> %5, float %7, i32 %4
  %9 = add i32 %4, 1
  %10 = icmp eq i32 %9, %2
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
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.log.f32(float) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sin.f32(float) #0

attributes #0 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
