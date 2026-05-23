; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/segmented-loads.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-unknown-linux -mattr=+v -passes=slp-vectorizer -S
; Original: RUN: opt < %s -mtriple=riscv64-unknown-linux -mattr=+v -passes=slp-vectorizer -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@src = common global [8 x double] zeroinitializer, align 64
@dst = common global [4 x double] zeroinitializer, align 64

define void @test() {
  %a0 = load double, ptr @src, align 8
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 1), align 8
  %a2 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 2), align 8
  %a3 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 3), align 8
  %a4 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 4), align 8
  %a5 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 5), align 8
  %a6 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 6), align 8
  %a7 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 7), align 8
  %res1 = fsub fast double %a0, %a1
  %res2 = fsub fast double %a2, %a3
  %res3 = fsub fast double %a4, %a5
  %res4 = fsub fast double %a6, %a7
  store double %res1, ptr @dst, align 8
  store double %res2, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 1), align 8
  store double %res3, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 2), align 8
  store double %res4, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 3), align 8
  ret void
}

; Same as above, but %a7 is also used as a scalar and must be extracted from
; the wide load. (Or in this case, kept as a scalar load).
define double @test_with_extract() {
  %a0 = load double, ptr @src, align 8
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 1), align 8
  %a2 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 2), align 8
  %a3 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 3), align 8
  %a4 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 4), align 8
  %a5 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 5), align 8
  %a6 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 6), align 8
  %a7 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 7), align 8
  %res1 = fsub fast double %a0, %a1
  %res2 = fsub fast double %a2, %a3
  %res3 = fsub fast double %a4, %a5
  %res4 = fsub fast double %a6, %a7
  store double %res1, ptr @dst, align 8
  store double %res2, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 1), align 8
  store double %res3, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 2), align 8
  store double %res4, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 3), align 8
  ret double %a7
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp5nlqt1jw.ll'
source_filename = "/tmp/tmp5nlqt1jw.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

@src = common global [8 x double] zeroinitializer, align 64
@dst = common global [4 x double] zeroinitializer, align 64

define void @test() #0 {
  %1 = load <8 x double>, ptr @src, align 8
  %2 = shufflevector <8 x double> %1, <8 x double> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %3 = shufflevector <8 x double> %1, <8 x double> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %4 = fsub fast <4 x double> %2, %3
  store <4 x double> %4, ptr @dst, align 8
  ret void
}

define double @test_with_extract() #0 {
  %1 = load <8 x double>, ptr @src, align 8
  %a7 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 7), align 8
  %2 = shufflevector <8 x double> %1, <8 x double> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %3 = shufflevector <8 x double> %1, <8 x double> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %4 = fsub fast <4 x double> %2, %3
  store <4 x double> %4, ptr @dst, align 8
  ret double %a7
}

attributes #0 = { "target-features"="+v" }
