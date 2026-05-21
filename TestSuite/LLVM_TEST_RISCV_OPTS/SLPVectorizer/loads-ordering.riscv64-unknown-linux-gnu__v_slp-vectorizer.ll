; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/loads-ordering.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define fastcc void @rephase(ptr %phases_in, ptr %157, i64 %158) {
entry:
  %ind.end11 = getelementptr i8, ptr %157, i64 %158
  %186 = load double, ptr %157, align 8
  %imag.247 = getelementptr i8, ptr %ind.end11, i64 408
  %mul35.248 = fmul double %186, 0.000000e+00
  store double %mul35.248, ptr %imag.247, align 8
  %arrayidx23.1.249 = getelementptr i8, ptr %ind.end11, i64 416
  %mul.1.250 = fmul double %186, 0.000000e+00
  store double %mul.1.250, ptr %arrayidx23.1.249, align 8
  %imag.1.251 = getelementptr i8, ptr %ind.end11, i64 424
  %187 = load double, ptr %imag.1.251, align 8
  %mul35.1.252 = fmul double %186, %187
  store double %mul35.1.252, ptr %imag.1.251, align 8
  %arrayidx23.2.253 = getelementptr i8, ptr %ind.end11, i64 432
  %188 = load double, ptr %arrayidx23.2.253, align 8
  %mul.2.254 = fmul double %186, %188
  store double %mul.2.254, ptr %arrayidx23.2.253, align 8
  store double %186, ptr %phases_in, align 8
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp2zpdoaci.ll'
source_filename = "/tmp/tmp2zpdoaci.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define fastcc void @rephase(ptr %phases_in, ptr %0, i64 %1) #0 {
entry:
  %ind.end11 = getelementptr i8, ptr %0, i64 %1
  %2 = load double, ptr %0, align 8
  %imag.247 = getelementptr i8, ptr %ind.end11, i64 408
  %imag.1.251 = getelementptr i8, ptr %ind.end11, i64 424
  %3 = load <2 x double>, ptr %imag.1.251, align 8
  %4 = insertelement <4 x double> poison, double %2, i32 0
  %5 = shufflevector <4 x double> %4, <4 x double> poison, <4 x i32> zeroinitializer
  %6 = shufflevector <2 x double> %3, <2 x double> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %7 = shufflevector <4 x double> <double 0.000000e+00, double 0.000000e+00, double poison, double poison>, <4 x double> %6, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  %8 = fmul <4 x double> %5, %7
  store <4 x double> %8, ptr %imag.247, align 8
  store double %2, ptr %phases_in, align 8
  ret void
}

attributes #0 = { "target-features"="+v" }
