; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/fround.ll
; Variant: riscv64_+v,+zvbb_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v,+zvbb -S
; Original: RUN: opt < %s -passes=slp-vectorizer -S -mtriple=riscv64 -mattr=+v,+zvbb | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <4 x float> @rint_v4f32(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a
  %vecext = extractelement <4 x float> %0, i64 0
  %1 = call float @llvm.rint.f32(float %vecext)
  %vecins = insertelement <4 x float> undef, float %1, i64 0
  %vecext.1 = extractelement <4 x float> %0, i64 1
  %2 = call float @llvm.rint.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i64 1
  %vecext.2 = extractelement <4 x float> %0, i64 2
  %3 = call float @llvm.rint.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i64 2
  %vecext.3 = extractelement <4 x float> %0, i64 3
  %4 = call float @llvm.rint.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i64 3
  ret <4 x float> %vecins.3
}

define <2 x i32> @lrint_v2i32f32(ptr %a) {
entry:
  %0 = load <2 x float>, ptr %a
  %vecext = extractelement <2 x float> %0, i32 0
  %1 = call i32 @llvm.lrint.i32.f32(float %vecext)
  %vecins = insertelement <2 x i32> undef, i32 %1, i32 0
  %vecext.1 = extractelement <2 x float> %0, i32 1
  %2 = call i32 @llvm.lrint.i32.f32(float %vecext.1)
  %vecins.1 = insertelement <2 x i32> %vecins, i32 %2, i32 1
  ret <2 x i32> %vecins.1
}

define <4 x i32> @lrint_v4i32f32(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = call i32 @llvm.lrint.i32.f32(float %vecext)
  %vecins = insertelement <4 x i32> undef, i32 %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = call i32 @llvm.lrint.i32.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x i32> %vecins, i32 %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = call i32 @llvm.lrint.i32.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x i32> %vecins.1, i32 %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = call i32 @llvm.lrint.i32.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x i32> %vecins.2, i32 %4, i32 3
  ret <4 x i32> %vecins.3
}

define <8 x i32> @lrint_v8i32f32(ptr %a) {
entry:
  %0 = load <8 x float>, ptr %a
  %vecext = extractelement <8 x float> %0, i32 0
  %1 = call i32 @llvm.lrint.i32.f32(float %vecext)
  %vecins = insertelement <8 x i32> undef, i32 %1, i32 0
  %vecext.1 = extractelement <8 x float> %0, i32 1
  %2 = call i32 @llvm.lrint.i32.f32(float %vecext.1)
  %vecins.1 = insertelement <8 x i32> %vecins, i32 %2, i32 1
  %vecext.2 = extractelement <8 x float> %0, i32 2
  %3 = call i32 @llvm.lrint.i32.f32(float %vecext.2)
  %vecins.2 = insertelement <8 x i32> %vecins.1, i32 %3, i32 2
  %vecext.3 = extractelement <8 x float> %0, i32 3
  %4 = call i32 @llvm.lrint.i32.f32(float %vecext.3)
  %vecins.3 = insertelement <8 x i32> %vecins.2, i32 %4, i32 3
  %vecext.4 = extractelement <8 x float> %0, i32 4
  %5 = call i32 @llvm.lrint.i32.f32(float %vecext.4)
  %vecins.4 = insertelement <8 x i32> %vecins.3, i32 %5, i32 4
  %vecext.5 = extractelement <8 x float> %0, i32 5
  %6 = call i32 @llvm.lrint.i32.f32(float %vecext.5)
  %vecins.5 = insertelement <8 x i32> %vecins.4, i32 %6, i32 5
  %vecext.6 = extractelement <8 x float> %0, i32 6
  %7 = call i32 @llvm.lrint.i32.f32(float %vecext.6)
  %vecins.6 = insertelement <8 x i32> %vecins.5, i32 %7, i32 6
  %vecext.7 = extractelement <8 x float> %0, i32 7
  %8 = call i32 @llvm.lrint.i32.f32(float %vecext.7)
  %vecins.7 = insertelement <8 x i32> %vecins.6, i32 %8, i32 7
  ret <8 x i32> %vecins.7
}

define <2 x i64> @lrint_v2i64f32(ptr %a) {
entry:
  %0 = load <2 x float>, ptr %a
  %vecext = extractelement <2 x float> %0, i64 0
  %1 = call i64 @llvm.lrint.i64.f32(float %vecext)
  %vecins = insertelement <2 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <2 x float> %0, i64 1
  %2 = call i64 @llvm.lrint.i64.f32(float %vecext.1)
  %vecins.1 = insertelement <2 x i64> %vecins, i64 %2, i64 1
  ret <2 x i64> %vecins.1
}

define <4 x i64> @lrint_v4i64f32(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a
  %vecext = extractelement <4 x float> %0, i64 0
  %1 = call i64 @llvm.lrint.i64.f32(float %vecext)
  %vecins = insertelement <4 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <4 x float> %0, i64 1
  %2 = call i64 @llvm.lrint.i64.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x i64> %vecins, i64 %2, i64 1
  %vecext.2 = extractelement <4 x float> %0, i64 2
  %3 = call i64 @llvm.lrint.i64.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x i64> %vecins.1, i64 %3, i64 2
  %vecext.3 = extractelement <4 x float> %0, i64 3
  %4 = call i64 @llvm.lrint.i64.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x i64> %vecins.2, i64 %4, i64 3
  ret <4 x i64> %vecins.3
}

define <8 x i64> @lrint_v8i64f32(ptr %a) {
entry:
  %0 = load <8 x float>, ptr %a
  %vecext = extractelement <8 x float> %0, i64 0
  %1 = call i64 @llvm.lrint.i64.f32(float %vecext)
  %vecins = insertelement <8 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <8 x float> %0, i64 1
  %2 = call i64 @llvm.lrint.i64.f32(float %vecext.1)
  %vecins.1 = insertelement <8 x i64> %vecins, i64 %2, i64 1
  %vecext.2 = extractelement <8 x float> %0, i64 2
  %3 = call i64 @llvm.lrint.i64.f32(float %vecext.2)
  %vecins.2 = insertelement <8 x i64> %vecins.1, i64 %3, i64 2
  %vecext.3 = extractelement <8 x float> %0, i64 3
  %4 = call i64 @llvm.lrint.i64.f32(float %vecext.3)
  %vecins.3 = insertelement <8 x i64> %vecins.2, i64 %4, i64 3
  %vecext.4 = extractelement <8 x float> %0, i64 4
  %5 = call i64 @llvm.lrint.i64.f32(float %vecext.4)
  %vecins.4 = insertelement <8 x i64> %vecins.3, i64 %5, i64 4
  %vecext.5 = extractelement <8 x float> %0, i64 5
  %6 = call i64 @llvm.lrint.i64.f32(float %vecext.5)
  %vecins.5 = insertelement <8 x i64> %vecins.4, i64 %6, i64 5
  %vecext.6 = extractelement <8 x float> %0, i64 6
  %7 = call i64 @llvm.lrint.i64.f32(float %vecext.6)
  %vecins.6 = insertelement <8 x i64> %vecins.5, i64 %7, i64 6
  %vecext.7 = extractelement <8 x float> %0, i64 7
  %8 = call i64 @llvm.lrint.i64.f32(float %vecext.7)
  %vecins.7 = insertelement <8 x i64> %vecins.6, i64 %8, i64 7
  ret <8 x i64> %vecins.7
}

define <2 x i64> @llrint_v2i64f32(ptr %a) {
entry:
  %0 = load <2 x float>, ptr %a
  %vecext = extractelement <2 x float> %0, i64 0
  %1 = call i64 @llvm.llrint.i64.f32(float %vecext)
  %vecins = insertelement <2 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <2 x float> %0, i64 1
  %2 = call i64 @llvm.llrint.i64.f32(float %vecext.1)
  %vecins.1 = insertelement <2 x i64> %vecins, i64 %2, i64 1
  ret <2 x i64> %vecins.1
}

define <4 x i64> @llrint_v4i64f32(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a
  %vecext = extractelement <4 x float> %0, i64 0
  %1 = call i64 @llvm.llrint.i64.f32(float %vecext)
  %vecins = insertelement <4 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <4 x float> %0, i64 1
  %2 = call i64 @llvm.llrint.i64.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x i64> %vecins, i64 %2, i64 1
  %vecext.2 = extractelement <4 x float> %0, i64 2
  %3 = call i64 @llvm.llrint.i64.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x i64> %vecins.1, i64 %3, i64 2
  %vecext.3 = extractelement <4 x float> %0, i64 3
  %4 = call i64 @llvm.llrint.i64.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x i64> %vecins.2, i64 %4, i64 3
  ret <4 x i64> %vecins.3
}

define <8 x i64> @llrint_v8i64f32(ptr %a) {
entry:
  %0 = load <8 x float>, ptr %a
  %vecext = extractelement <8 x float> %0, i64 0
  %1 = call i64 @llvm.llrint.i64.f32(float %vecext)
  %vecins = insertelement <8 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <8 x float> %0, i64 1
  %2 = call i64 @llvm.llrint.i64.f32(float %vecext.1)
  %vecins.1 = insertelement <8 x i64> %vecins, i64 %2, i64 1
  %vecext.2 = extractelement <8 x float> %0, i64 2
  %3 = call i64 @llvm.llrint.i64.f32(float %vecext.2)
  %vecins.2 = insertelement <8 x i64> %vecins.1, i64 %3, i64 2
  %vecext.3 = extractelement <8 x float> %0, i64 3
  %4 = call i64 @llvm.llrint.i64.f32(float %vecext.3)
  %vecins.3 = insertelement <8 x i64> %vecins.2, i64 %4, i64 3
  %vecext.4 = extractelement <8 x float> %0, i64 4
  %5 = call i64 @llvm.llrint.i64.f32(float %vecext.4)
  %vecins.4 = insertelement <8 x i64> %vecins.3, i64 %5, i64 4
  %vecext.5 = extractelement <8 x float> %0, i64 5
  %6 = call i64 @llvm.llrint.i64.f32(float %vecext.5)
  %vecins.5 = insertelement <8 x i64> %vecins.4, i64 %6, i64 5
  %vecext.6 = extractelement <8 x float> %0, i64 6
  %7 = call i64 @llvm.llrint.i64.f32(float %vecext.6)
  %vecins.6 = insertelement <8 x i64> %vecins.5, i64 %7, i64 6
  %vecext.7 = extractelement <8 x float> %0, i64 7
  %8 = call i64 @llvm.llrint.i64.f32(float %vecext.7)
  %vecins.7 = insertelement <8 x i64> %vecins.6, i64 %8, i64 7
  ret <8 x i64> %vecins.7
}

declare float @llvm.rint.f32(float)
declare i32 @llvm.lrint.i32.f32(float)
declare i64 @llvm.lrint.i64.f32(float)
declare i64 @llvm.llrint.i64.f32(float)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp2c1cgn_o.ll'
source_filename = "/tmp/tmp2c1cgn_o.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <4 x float> @rint_v4f32(ptr %a) #0 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call <4 x float> @llvm.rint.v4f32(<4 x float> %0)
  ret <4 x float> %1
}

define <2 x i32> @lrint_v2i32f32(ptr %a) #0 {
entry:
  %0 = load <2 x float>, ptr %a, align 8
  %1 = call <2 x i32> @llvm.lrint.v2i32.v2f32(<2 x float> %0)
  ret <2 x i32> %1
}

define <4 x i32> @lrint_v4i32f32(ptr %a) #0 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call <4 x i32> @llvm.lrint.v4i32.v4f32(<4 x float> %0)
  ret <4 x i32> %1
}

define <8 x i32> @lrint_v8i32f32(ptr %a) #0 {
entry:
  %0 = load <8 x float>, ptr %a, align 32
  %1 = call <8 x i32> @llvm.lrint.v8i32.v8f32(<8 x float> %0)
  ret <8 x i32> %1
}

define <2 x i64> @lrint_v2i64f32(ptr %a) #0 {
entry:
  %0 = load <2 x float>, ptr %a, align 8
  %1 = call <2 x i64> @llvm.lrint.v2i64.v2f32(<2 x float> %0)
  ret <2 x i64> %1
}

define <4 x i64> @lrint_v4i64f32(ptr %a) #0 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call <4 x i64> @llvm.lrint.v4i64.v4f32(<4 x float> %0)
  ret <4 x i64> %1
}

define <8 x i64> @lrint_v8i64f32(ptr %a) #0 {
entry:
  %0 = load <8 x float>, ptr %a, align 32
  %1 = shufflevector <8 x float> %0, <8 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = call <4 x i64> @llvm.lrint.v4i64.v4f32(<4 x float> %1)
  %3 = shufflevector <4 x i64> %2, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %4 = shufflevector <8 x float> %0, <8 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %5 = call <4 x i64> @llvm.lrint.v4i64.v4f32(<4 x float> %4)
  %6 = shufflevector <4 x i64> %5, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %vecins.71 = shufflevector <8 x i64> %3, <8 x i64> %6, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  ret <8 x i64> %vecins.71
}

define <2 x i64> @llrint_v2i64f32(ptr %a) #0 {
entry:
  %0 = load <2 x float>, ptr %a, align 8
  %1 = call <2 x i64> @llvm.llrint.v2i64.v2f32(<2 x float> %0)
  ret <2 x i64> %1
}

define <4 x i64> @llrint_v4i64f32(ptr %a) #0 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call <4 x i64> @llvm.llrint.v4i64.v4f32(<4 x float> %0)
  ret <4 x i64> %1
}

define <8 x i64> @llrint_v8i64f32(ptr %a) #0 {
entry:
  %0 = load <8 x float>, ptr %a, align 32
  %1 = shufflevector <8 x float> %0, <8 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = call <4 x i64> @llvm.llrint.v4i64.v4f32(<4 x float> %1)
  %3 = shufflevector <4 x i64> %2, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %4 = shufflevector <8 x float> %0, <8 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %5 = call <4 x i64> @llvm.llrint.v4i64.v4f32(<4 x float> %4)
  %6 = shufflevector <4 x i64> %5, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %vecins.71 = shufflevector <8 x i64> %3, <8 x i64> %6, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  ret <8 x i64> %vecins.71
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.rint.f32(float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.lrint.i32.f32(float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.lrint.i64.f32(float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.llrint.i64.f32(float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.rint.v4f32(<4 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i32> @llvm.lrint.v2i32.v2f32(<2 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.lrint.v4i32.v4f32(<4 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i32> @llvm.lrint.v8i32.v8f32(<8 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i64> @llvm.lrint.v2i64.v2f32(<2 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i64> @llvm.lrint.v4i64.v4f32(<4 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i64> @llvm.llrint.v2i64.v2f32(<2 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i64> @llvm.llrint.v4i64.v4f32(<4 x float>) #2

attributes #0 = { "target-features"="+v,+zvbb" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+zvbb" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
