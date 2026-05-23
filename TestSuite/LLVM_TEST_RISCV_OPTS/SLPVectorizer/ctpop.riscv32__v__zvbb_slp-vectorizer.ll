; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/ctpop.ll
; Variant: riscv32_+v,+zvbb_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv32 -mattr=+v,+zvbb -S
; Original: RUN: opt < %s -passes=slp-vectorizer -S -mtriple=riscv32 -mattr=+v,+zvbb | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <4 x i8> @ctpop_v4i8(ptr %a) {
entry:
  %0 = load <4 x i8>, ptr %a
  %vecext = extractelement <4 x i8> %0, i8 0
  %1 = call i8 @llvm.ctpop.i8(i8 %vecext)
  %vecins = insertelement <4 x i8> undef, i8 %1, i8 0
  %vecext.1 = extractelement <4 x i8> %0, i8 1
  %2 = call i8 @llvm.ctpop.i8(i8 %vecext.1)
  %vecins.1 = insertelement <4 x i8> %vecins, i8 %2, i8 1
  %vecext.2 = extractelement <4 x i8> %0, i8 2
  %3 = call i8 @llvm.ctpop.i8(i8 %vecext.2)
  %vecins.2 = insertelement <4 x i8> %vecins.1, i8 %3, i8 2
  %vecext.3 = extractelement <4 x i8> %0, i8 3
  %4 = call i8 @llvm.ctpop.i8(i8 %vecext.3)
  %vecins.3 = insertelement <4 x i8> %vecins.2, i8 %4, i8 3
  ret <4 x i8> %vecins.3
}

define <4 x i16> @ctpop_v4i16(ptr %a) {
entry:
  %0 = load <4 x i16>, ptr %a
  %vecext = extractelement <4 x i16> %0, i16 0
  %1 = call i16 @llvm.ctpop.i16(i16 %vecext)
  %vecins = insertelement <4 x i16> undef, i16 %1, i16 0
  %vecext.1 = extractelement <4 x i16> %0, i16 1
  %2 = call i16 @llvm.ctpop.i16(i16 %vecext.1)
  %vecins.1 = insertelement <4 x i16> %vecins, i16 %2, i16 1
  %vecext.2 = extractelement <4 x i16> %0, i16 2
  %3 = call i16 @llvm.ctpop.i16(i16 %vecext.2)
  %vecins.2 = insertelement <4 x i16> %vecins.1, i16 %3, i16 2
  %vecext.3 = extractelement <4 x i16> %0, i16 3
  %4 = call i16 @llvm.ctpop.i16(i16 %vecext.3)
  %vecins.3 = insertelement <4 x i16> %vecins.2, i16 %4, i16 3
  ret <4 x i16> %vecins.3
}

define <4 x i32> @ctpop_v4i32(ptr %a) {
entry:
  %0 = load <4 x i32>, ptr %a
  %vecext = extractelement <4 x i32> %0, i32 0
  %1 = call i32 @llvm.ctpop.i32(i32 %vecext)
  %vecins = insertelement <4 x i32> undef, i32 %1, i32 0
  %vecext.1 = extractelement <4 x i32> %0, i32 1
  %2 = call i32 @llvm.ctpop.i32(i32 %vecext.1)
  %vecins.1 = insertelement <4 x i32> %vecins, i32 %2, i32 1
  %vecext.2 = extractelement <4 x i32> %0, i32 2
  %3 = call i32 @llvm.ctpop.i32(i32 %vecext.2)
  %vecins.2 = insertelement <4 x i32> %vecins.1, i32 %3, i32 2
  %vecext.3 = extractelement <4 x i32> %0, i32 3
  %4 = call i32 @llvm.ctpop.i32(i32 %vecext.3)
  %vecins.3 = insertelement <4 x i32> %vecins.2, i32 %4, i32 3
  ret <4 x i32> %vecins.3
}

define <4 x i64> @ctpop_v4i64(ptr %a) {
entry:
  %0 = load <4 x i64>, ptr %a
  %vecext = extractelement <4 x i64> %0, i32 0
  %1 = call i64 @llvm.ctpop.i64(i64 %vecext)
  %vecins = insertelement <4 x i64> undef, i64 %1, i64 0
  %vecext.1 = extractelement <4 x i64> %0, i32 1
  %2 = call i64 @llvm.ctpop.i64(i64 %vecext.1)
  %vecins.1 = insertelement <4 x i64> %vecins, i64 %2, i64 1
  %vecext.2 = extractelement <4 x i64> %0, i32 2
  %3 = call i64 @llvm.ctpop.i64(i64 %vecext.2)
  %vecins.2 = insertelement <4 x i64> %vecins.1, i64 %3, i64 2
  %vecext.3 = extractelement <4 x i64> %0, i32 3
  %4 = call i64 @llvm.ctpop.i64(i64 %vecext.3)
  %vecins.3 = insertelement <4 x i64> %vecins.2, i64 %4, i64 3
  ret <4 x i64> %vecins.3
}

declare i8 @llvm.ctpop.i8(i8)
declare i16 @llvm.ctpop.i16(i16)
declare i32 @llvm.ctpop.i32(i32)
declare i64 @llvm.ctpop.i64(i64)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_n17s4kc.ll'
source_filename = "/tmp/tmp_n17s4kc.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define <4 x i8> @ctpop_v4i8(ptr %a) #0 {
entry:
  %0 = load <4 x i8>, ptr %a, align 4
  %1 = call <4 x i8> @llvm.ctpop.v4i8(<4 x i8> %0)
  ret <4 x i8> %1
}

define <4 x i16> @ctpop_v4i16(ptr %a) #0 {
entry:
  %0 = load <4 x i16>, ptr %a, align 8
  %1 = call <4 x i16> @llvm.ctpop.v4i16(<4 x i16> %0)
  ret <4 x i16> %1
}

define <4 x i32> @ctpop_v4i32(ptr %a) #0 {
entry:
  %0 = load <4 x i32>, ptr %a, align 16
  %1 = call <4 x i32> @llvm.ctpop.v4i32(<4 x i32> %0)
  ret <4 x i32> %1
}

define <4 x i64> @ctpop_v4i64(ptr %a) #0 {
entry:
  %0 = load <4 x i64>, ptr %a, align 32
  %1 = call <4 x i64> @llvm.ctpop.v4i64(<4 x i64> %0)
  ret <4 x i64> %1
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.ctpop.i8(i8) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.ctpop.i16(i16) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.ctpop.i32(i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.ctpop.i64(i64) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i8> @llvm.ctpop.v4i8(<4 x i8>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i16> @llvm.ctpop.v4i16(<4 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.ctpop.v4i32(<4 x i32>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i64> @llvm.ctpop.v4i64(<4 x i64>) #2

attributes #0 = { "target-features"="+v,+zvbb" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+zvbb" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
