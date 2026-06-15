; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/floating-point.ll
; Variant: riscv64_+v,+f_slp-vectorizer_DEFAULT
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=slp-vectorizer -S -mtriple=riscv64 -mattr=+v,+f  | FileCheck %s --check-prefix=DEFAULT

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @fp_add(ptr %dst, ptr %p, ptr %q) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %f0 = load float, ptr %q, align 4
  %pf1 = getelementptr inbounds float, ptr %q, i64 1
  %f1 = load float, ptr %pf1, align 4
  %pf2 = getelementptr inbounds float, ptr %q, i64 2
  %f2 = load float, ptr %pf2, align 4
  %pf3 = getelementptr inbounds float, ptr %q, i64 3
  %f3 = load float, ptr %pf3, align 4

  %a0 = fadd float %e0, %f0
  %a1 = fadd float %e1, %f1
  %a2 = fadd float %e2, %f2
  %a3 = fadd float %e3, %f3

  store float %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds float, ptr %dst, i64 1
  store float %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds float, ptr %dst, i64 2
  store float %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds float, ptr %dst, i64 3
  store float %a3, ptr %pa3, align 4

  ret void
}

define void @fp_sub(ptr %dst, ptr %p) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %a0 = fsub float %e0, 3.0
  %a1 = fsub float %e1, 3.0
  %a2 = fsub float %e2, 3.0
  %a3 = fsub float %e3, 3.0

  store float %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds float, ptr %dst, i64 1
  store float %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds float, ptr %dst, i64 2
  store float %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds float, ptr %dst, i64 3
  store float %a3, ptr %pa3, align 4

  ret void
}

define void @fp_mul(ptr %dst, ptr %p, ptr %q) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %f0 = load float, ptr %q, align 4
  %pf1 = getelementptr inbounds float, ptr %q, i64 1
  %f1 = load float, ptr %pf1, align 4
  %pf2 = getelementptr inbounds float, ptr %q, i64 2
  %f2 = load float, ptr %pf2, align 4
  %pf3 = getelementptr inbounds float, ptr %q, i64 3
  %f3 = load float, ptr %pf3, align 4

  %a0 = fmul float %e0, %f0
  %a1 = fmul float %e1, %f1
  %a2 = fmul float %e2, %f2
  %a3 = fmul float %e3, %f3

  store float %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds float, ptr %dst, i64 1
  store float %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds float, ptr %dst, i64 2
  store float %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds float, ptr %dst, i64 3
  store float %a3, ptr %pa3, align 4

  ret void
}

define void @fp_div(ptr %dst, ptr %p) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %a0 = fdiv float %e0, 10.5
  %a1 = fdiv float %e1, 10.5
  %a2 = fdiv float %e2, 10.5
  %a3 = fdiv float %e3, 10.5

  store float %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds float, ptr %dst, i64 1
  store float %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds float, ptr %dst, i64 2
  store float %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds float, ptr %dst, i64 3
  store float %a3, ptr %pa3, align 4

  ret void
}

declare float @llvm.maxnum.f32(float, float)

define void @fp_max(ptr %dst, ptr %p, ptr %q) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %f0 = load float, ptr %q, align 4
  %pf1 = getelementptr inbounds float, ptr %q, i64 1
  %f1 = load float, ptr %pf1, align 4
  %pf2 = getelementptr inbounds float, ptr %q, i64 2
  %f2 = load float, ptr %pf2, align 4
  %pf3 = getelementptr inbounds float, ptr %q, i64 3
  %f3 = load float, ptr %pf3, align 4

  %a0 = tail call float @llvm.maxnum.f32(float %e0, float %f0)
  %a1 = tail call float @llvm.maxnum.f32(float %e1, float %f1)
  %a2 = tail call float @llvm.maxnum.f32(float %e2, float %f2)
  %a3 = tail call float @llvm.maxnum.f32(float %e3, float %f3)

  store float %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds float, ptr %dst, i64 1
  store float %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds float, ptr %dst, i64 2
  store float %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds float, ptr %dst, i64 3
  store float %a3, ptr %pa3, align 4

  ret void
}

declare float @llvm.minnum.f32(float, float)

define void @fp_min(ptr %dst, ptr %p) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %a0 = tail call float @llvm.minnum.f32(float %e0, float 1.25)
  %a1 = tail call float @llvm.minnum.f32(float %e1, float 1.25)
  %a2 = tail call float @llvm.minnum.f32(float %e2, float 1.25)
  %a3 = tail call float @llvm.minnum.f32(float %e3, float 1.25)

  store float %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds float, ptr %dst, i64 1
  store float %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds float, ptr %dst, i64 2
  store float %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds float, ptr %dst, i64 3
  store float %a3, ptr %pa3, align 4

  ret void
}

declare i32 @llvm.fptosi.sat.i32.f32(float)

define void @fp_convert(ptr %dst, ptr %p) {
entry:
  %e0 = load float, ptr %p, align 4
  %pe1 = getelementptr inbounds float, ptr %p, i64 1
  %e1 = load float, ptr %pe1, align 4
  %pe2 = getelementptr inbounds float, ptr %p, i64 2
  %e2 = load float, ptr %pe2, align 4
  %pe3 = getelementptr inbounds float, ptr %p, i64 3
  %e3 = load float, ptr %pe3, align 4

  %a0 = tail call i32 @llvm.fptosi.sat.i32.f32(float %e0)
  %a1 = tail call i32 @llvm.fptosi.sat.i32.f32(float %e1)
  %a2 = tail call i32 @llvm.fptosi.sat.i32.f32(float %e2)
  %a3 = tail call i32 @llvm.fptosi.sat.i32.f32(float %e3)

  store i32 %a0, ptr %dst, align 4
  %pa1 = getelementptr inbounds i32, ptr %dst, i64 1
  store i32 %a1, ptr %pa1, align 4
  %pa2 = getelementptr inbounds i32, ptr %dst, i64 2
  store i32 %a2, ptr %pa2, align 4
  %pa3 = getelementptr inbounds i32, ptr %dst, i64 3
  store i32 %a3, ptr %pa3, align 4

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpq1jmrvve.ll'
source_filename = "/tmp/tmpq1jmrvve.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @fp_add(ptr %dst, ptr %p, ptr %q) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = load <4 x float>, ptr %q, align 4
  %2 = fadd <4 x float> %0, %1
  store <4 x float> %2, ptr %dst, align 4
  ret void
}

define void @fp_sub(ptr %dst, ptr %p) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = fsub <4 x float> %0, splat (float 3.000000e+00)
  store <4 x float> %1, ptr %dst, align 4
  ret void
}

define void @fp_mul(ptr %dst, ptr %p, ptr %q) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = load <4 x float>, ptr %q, align 4
  %2 = fmul <4 x float> %0, %1
  store <4 x float> %2, ptr %dst, align 4
  ret void
}

define void @fp_div(ptr %dst, ptr %p) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = fdiv <4 x float> %0, splat (float 1.050000e+01)
  store <4 x float> %1, ptr %dst, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maxnum.f32(float, float) #1

define void @fp_max(ptr %dst, ptr %p, ptr %q) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = load <4 x float>, ptr %q, align 4
  %2 = call <4 x float> @llvm.maxnum.v4f32(<4 x float> %0, <4 x float> %1)
  store <4 x float> %2, ptr %dst, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #1

define void @fp_min(ptr %dst, ptr %p) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = call <4 x float> @llvm.minnum.v4f32(<4 x float> %0, <4 x float> splat (float 1.250000e+00))
  store <4 x float> %1, ptr %dst, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.fptosi.sat.i32.f32(float) #1

define void @fp_convert(ptr %dst, ptr %p) #0 {
entry:
  %0 = load <4 x float>, ptr %p, align 4
  %1 = call <4 x i32> @llvm.fptosi.sat.v4i32.v4f32(<4 x float> %0)
  store <4 x i32> %1, ptr %dst, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.maxnum.v4f32(<4 x float>, <4 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.minnum.v4f32(<4 x float>, <4 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.fptosi.sat.v4i32.v4f32(<4 x float>) #2

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
