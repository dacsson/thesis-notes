; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/remarks_cmp_sel_min_max.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -pass-remarks-output= -S
; Original: RUN: opt < %s -passes=slp-vectorizer -S -mtriple=riscv64-unknown-linux -mattr=+v -pass-remarks-output=%t | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @min_double(ptr noalias nocapture %A, ptr noalias nocapture %B) {
entry:
  %arrayidx = getelementptr inbounds double, ptr %B, i64 10
  %0 = load double, ptr %arrayidx, align 8
  %tobool = fcmp olt double %0, 0.000000e+00
  %cond = select i1 %tobool, double %0, double 0.000000e+00
  store double %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %B, i64 11
  %1 = load double, ptr %arrayidx2, align 8
  %tobool3 = fcmp olt double %1, 0.000000e+00
  %cond7 = select i1 %tobool3, double %1, double 0.000000e+00
  %arrayidx8 = getelementptr inbounds double, ptr %A, i64 1
  store double %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

define i32 @min_float(ptr noalias nocapture %A, ptr noalias nocapture %B) {
entry:
  %arrayidx = getelementptr inbounds float, ptr %B, i64 10
  %0 = load float, ptr %arrayidx, align 8
  %tobool = fcmp ule float %0, 0.000000e+00
  %cond = select i1 %tobool, float %0, float 0.000000e+00
  store float %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds float, ptr %B, i64 11
  %1 = load float, ptr %arrayidx2, align 8
  %tobool3 = fcmp ule float %1, 0.000000e+00
  %cond7 = select i1 %tobool3, float %1, float 0.000000e+00
  %arrayidx8 = getelementptr inbounds float, ptr %A, i64 1
  store float %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

define i32 @max_double(ptr noalias nocapture %A, ptr noalias nocapture %B) {
entry:
  %arrayidx = getelementptr inbounds double, ptr %B, i64 10
  %0 = load double, ptr %arrayidx, align 8
  %tobool = fcmp ogt double %0, 0.000000e+00
  %cond = select i1 %tobool, double %0, double 0.000000e+00
  store double %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %B, i64 11
  %1 = load double, ptr %arrayidx2, align 8
  %tobool3 = fcmp ogt double %1, 0.000000e+00
  %cond7 = select i1 %tobool3, double %1, double 0.000000e+00
  %arrayidx8 = getelementptr inbounds double, ptr %A, i64 1
  store double %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

define i32 @max_float(ptr noalias nocapture %A, ptr noalias nocapture %B) {
entry:
  %arrayidx = getelementptr inbounds float, ptr %B, i64 10
  %0 = load float, ptr %arrayidx, align 8
  %tobool = fcmp uge float %0, 0.000000e+00
  %cond = select i1 %tobool, float %0, float 0.000000e+00
  store float %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds float, ptr %B, i64 11
  %1 = load float, ptr %arrayidx2, align 8
  %tobool3 = fcmp uge float %1, 0.000000e+00
  %cond7 = select i1 %tobool3, float %1, float 0.000000e+00
  %arrayidx8 = getelementptr inbounds float, ptr %A, i64 1
  store float %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpitq_p8v0.ll'
source_filename = "/tmp/tmpitq_p8v0.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define i32 @min_double(ptr noalias captures(none) %A, ptr noalias captures(none) %B) #0 {
entry:
  %arrayidx = getelementptr inbounds double, ptr %B, i64 10
  %0 = load <2 x double>, ptr %arrayidx, align 8
  %1 = fcmp olt <2 x double> %0, zeroinitializer
  %2 = select <2 x i1> %1, <2 x double> %0, <2 x double> zeroinitializer
  store <2 x double> %2, ptr %A, align 8
  ret i32 undef
}

define i32 @min_float(ptr noalias captures(none) %A, ptr noalias captures(none) %B) #0 {
entry:
  %arrayidx = getelementptr inbounds float, ptr %B, i64 10
  %0 = load <2 x float>, ptr %arrayidx, align 8
  %1 = fcmp ule <2 x float> %0, zeroinitializer
  %2 = select <2 x i1> %1, <2 x float> %0, <2 x float> zeroinitializer
  store <2 x float> %2, ptr %A, align 8
  ret i32 undef
}

define i32 @max_double(ptr noalias captures(none) %A, ptr noalias captures(none) %B) #0 {
entry:
  %arrayidx = getelementptr inbounds double, ptr %B, i64 10
  %0 = load <2 x double>, ptr %arrayidx, align 8
  %1 = fcmp ogt <2 x double> %0, zeroinitializer
  %2 = select <2 x i1> %1, <2 x double> %0, <2 x double> zeroinitializer
  store <2 x double> %2, ptr %A, align 8
  ret i32 undef
}

define i32 @max_float(ptr noalias captures(none) %A, ptr noalias captures(none) %B) #0 {
entry:
  %arrayidx = getelementptr inbounds float, ptr %B, i64 10
  %0 = load <2 x float>, ptr %arrayidx, align 8
  %1 = fcmp uge <2 x float> %0, zeroinitializer
  %2 = select <2 x i1> %1, <2 x float> %0, <2 x float> zeroinitializer
  store <2 x float> %2, ptr %A, align 8
  ret i32 undef
}

attributes #0 = { "target-features"="+v" }
