; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/init-ext-node-not-truncable.ll
; Variant: riscv64-unknown-linux-gnu_"+v"_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" -slp-threshold=-5 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" < %s -slp-threshold=-5 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@h = global [16 x i64] zeroinitializer

define void @test() {
entry:
  %sext.0 = sext i8 0 to i32
  %sext.1 = sext i8 0 to i32

  %lshr.0 = lshr i32 0, %sext.0
  %lshr.1 = lshr i32 0, %sext.1

  %or.0 = or i32 %lshr.0, -1
  %or.1 = or i32 %lshr.1, 0

  %zext.0 = zext i32 %or.0 to i64
  %zext.1 = zext i32 %or.1 to i64

  store i64 %zext.0, ptr @h, align 8
  store i64 %zext.1, ptr getelementptr inbounds ([16 x i64], ptr @h, i64 0, i64 1), align 8
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_ubqe1ks.ll'
source_filename = "/tmp/tmp_ubqe1ks.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@h = global [16 x i64] zeroinitializer

define void @test() #0 {
entry:
  store <2 x i64> <i64 4294967295, i64 0>, ptr @h, align 8
  ret void
}

attributes #0 = { "target-features"="+v" }
