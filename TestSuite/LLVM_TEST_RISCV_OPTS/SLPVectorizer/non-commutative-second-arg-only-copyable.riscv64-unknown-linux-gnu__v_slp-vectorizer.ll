; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/non-commutative-second-arg-only-copyable.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -slp-threshold=-9999 -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -passes=slp-vectorizer -S -slp-threshold=-9999 -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @main(ptr %q, ptr %a, i8 %.pre) {
entry:
  %.pre1 = load i8, ptr %q, align 1
  %conv11.i = sext i8 %.pre to i32
  %shl18.i = shl i32 %conv11.i, %conv11.i
  %conv19.i = trunc i32 %shl18.i to i16
  store i16 %conv19.i, ptr %a, align 2
  %0 = sext i8 %.pre1 to i32
  %1 = add i32 %0, 1
  %shl18.i.1 = shl i32 1, %1
  %conv19.i.1 = trunc i32 %shl18.i.1 to i16
  %arrayidx21.i.1 = getelementptr i8, ptr %a, i64 2
  store i16 %conv19.i.1, ptr %arrayidx21.i.1, align 2
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp5ykzxl8a.ll'
source_filename = "/tmp/tmp5ykzxl8a.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @main(ptr %q, ptr %a, i8 %.pre) #0 {
entry:
  %.pre1 = load i8, ptr %q, align 1
  %0 = insertelement <2 x i8> poison, i8 %.pre, i32 0
  %1 = insertelement <2 x i8> %0, i8 %.pre1, i32 1
  %2 = sext <2 x i8> %1 to <2 x i32>
  %3 = add <2 x i32> %2, <i32 0, i32 1>
  %4 = shufflevector <2 x i32> %2, <2 x i32> <i32 poison, i32 1>, <2 x i32> <i32 0, i32 3>
  %5 = shl <2 x i32> %4, %3
  %6 = trunc <2 x i32> %5 to <2 x i16>
  store <2 x i16> %6, ptr %a, align 2
  ret i32 0
}

attributes #0 = { "target-features"="+v" }
