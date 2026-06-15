; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/interleave-greater-than-slice.ll
; Variant: riscv64-unknown-linux_+v,+zvl128b_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v,+zvl128b -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v,+zvl128b < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %a, float %0) {
entry:
  %1 = load ptr, ptr %a, align 8
  %arrayidx = getelementptr i8, ptr %1, i64 84
  %2 = load float, ptr %arrayidx, align 4
  %3 = tail call float @llvm.fmuladd.f32(float %2, float 0.000000e+00, float 0.000000e+00)
  %arrayidx1 = getelementptr i8, ptr %1, i64 28
  %4 = load float, ptr %arrayidx1, align 4
  %5 = tail call float @llvm.fmuladd.f32(float %4, float 0.000000e+00, float %3)
  %arrayidx2 = getelementptr i8, ptr %1, i64 8
  %6 = load float, ptr %arrayidx2, align 4
  %7 = tail call float @llvm.fmuladd.f32(float %6, float 0.000000e+00, float 0.000000e+00)
  %arrayidx3 = getelementptr i8, ptr %1, i64 68
  %8 = load float, ptr %arrayidx3, align 4
  %9 = tail call float @llvm.fmuladd.f32(float %8, float 0.000000e+00, float %5)
  %arrayidx4 = getelementptr i8, ptr %1, i64 88
  %10 = load float, ptr %arrayidx4, align 4
  %11 = tail call float @llvm.fmuladd.f32(float %10, float 0.000000e+00, float %7)
  %arrayidx5 = getelementptr i8, ptr %1, i64 92
  %12 = load float, ptr %arrayidx5, align 4
  %13 = tail call float @llvm.fmuladd.f32(float %12, float 0.000000e+00, float %11)
  %14 = tail call float @llvm.fmuladd.f32(float %0, float 0.000000e+00, float %9)
  %arrayidx6 = getelementptr i8, ptr %1, i64 96
  %15 = load float, ptr %arrayidx6, align 4
  %16 = tail call float @llvm.fmuladd.f32(float %15, float 0.000000e+00, float %13)
  %arrayidx7 = getelementptr i8, ptr %1, i64 80
  %17 = load float, ptr %arrayidx7, align 4
  %18 = tail call float @llvm.fmuladd.f32(float %0, float %17, float %16)
  %arrayidx8 = getelementptr i8, ptr %1, i64 100
  %19 = load float, ptr %arrayidx8, align 4
  %20 = tail call float @llvm.fmuladd.f32(float %19, float 0.000000e+00, float %14)
  %add = fadd float %18, %20
  store float %add, ptr %a, align 4
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpgf4hs7w4.ll'
source_filename = "/tmp/tmpgf4hs7w4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @test(ptr %a, float %0) #0 {
entry:
  %1 = load ptr, ptr %a, align 8
  %arrayidx = getelementptr i8, ptr %1, i64 84
  %2 = load float, ptr %arrayidx, align 4
  %3 = tail call float @llvm.fmuladd.f32(float %2, float 0.000000e+00, float 0.000000e+00)
  %arrayidx1 = getelementptr i8, ptr %1, i64 28
  %4 = load float, ptr %arrayidx1, align 4
  %5 = tail call float @llvm.fmuladd.f32(float %4, float 0.000000e+00, float %3)
  %arrayidx2 = getelementptr i8, ptr %1, i64 8
  %6 = load float, ptr %arrayidx2, align 4
  %7 = tail call float @llvm.fmuladd.f32(float %6, float 0.000000e+00, float 0.000000e+00)
  %arrayidx3 = getelementptr i8, ptr %1, i64 68
  %8 = load float, ptr %arrayidx3, align 4
  %9 = tail call float @llvm.fmuladd.f32(float %8, float 0.000000e+00, float %5)
  %arrayidx4 = getelementptr i8, ptr %1, i64 88
  %10 = load float, ptr %arrayidx4, align 4
  %11 = tail call float @llvm.fmuladd.f32(float %10, float 0.000000e+00, float %7)
  %arrayidx5 = getelementptr i8, ptr %1, i64 92
  %12 = load float, ptr %arrayidx5, align 4
  %13 = tail call float @llvm.fmuladd.f32(float %12, float 0.000000e+00, float %11)
  %14 = tail call float @llvm.fmuladd.f32(float %0, float 0.000000e+00, float %9)
  %arrayidx6 = getelementptr i8, ptr %1, i64 96
  %15 = load float, ptr %arrayidx6, align 4
  %16 = tail call float @llvm.fmuladd.f32(float %15, float 0.000000e+00, float %13)
  %arrayidx7 = getelementptr i8, ptr %1, i64 80
  %17 = load float, ptr %arrayidx7, align 4
  %18 = tail call float @llvm.fmuladd.f32(float %0, float %17, float %16)
  %arrayidx8 = getelementptr i8, ptr %1, i64 100
  %19 = load float, ptr %arrayidx8, align 4
  %20 = tail call float @llvm.fmuladd.f32(float %19, float 0.000000e+00, float %14)
  %add = fadd float %18, %20
  store float %add, ptr %a, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { "target-features"="+v,+zvl128b" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+zvl128b" }
