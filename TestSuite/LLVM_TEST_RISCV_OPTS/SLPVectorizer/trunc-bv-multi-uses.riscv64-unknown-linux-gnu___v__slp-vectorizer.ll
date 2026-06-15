; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/trunc-bv-multi-uses.ll
; Variant: riscv64-unknown-linux-gnu_"+v"_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" -slp-threshold=-10 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" < %s -slp-threshold=-10 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test(i64 %v1, i64 %v2) {
entry:
  %t1 = trunc i64 %v1 to i32
  %t2 = trunc i64 %v2 to i32
  %lshr1 = lshr i64 %v1, 32
  %lshr2 = lshr i64 %v2, 32
  %t3 = trunc i64 %lshr1 to i32
  %t4 = trunc i64 %lshr2 to i32
  %add1 = add i32 %t1, %t3
  %add2 = add i32 %t2, %t4
  %mul = mul i32 %add1, %add2
  ret i32 %mul
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpm0vmwojz.ll'
source_filename = "/tmp/tmpm0vmwojz.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test(i64 %v1, i64 %v2) #0 {
entry:
  %0 = insertelement <2 x i64> poison, i64 %v1, i32 0
  %1 = insertelement <2 x i64> %0, i64 %v2, i32 1
  %2 = trunc <2 x i64> %1 to <2 x i32>
  %3 = lshr <2 x i64> %1, splat (i64 32)
  %4 = trunc <2 x i64> %3 to <2 x i32>
  %5 = add <2 x i32> %2, %4
  %6 = extractelement <2 x i32> %5, i32 0
  %7 = extractelement <2 x i32> %5, i32 1
  %mul = mul i32 %6, %7
  ret i32 %mul
}

attributes #0 = { "target-features"="+v" }
