; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/mixed-extracts-types.ll
; Variant: riscv64-unknown-linux-gnu_"+v"_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test() {
entry:
  %vector.recur.extract = extractelement <vscale x 4 x i8> zeroinitializer, i64 0
  %0 = load i8, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 5), align 1
  %tobool1.not = icmp ne i8 %0, 0
  %conv2 = zext i1 %tobool1.not to i16
  store i16 %conv2, ptr getelementptr ([0 x i16], ptr null, i64 0, i64 -14), align 2
  %conv5 = sext i8 %vector.recur.extract to i32
  store i32 %conv5, ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -14), align 4
  %1 = load i8, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 6), align 1
  %tobool1.not.1 = icmp ne i8 %1, 0
  %conv2.1 = zext i1 %tobool1.not.1 to i16
  store i16 %conv2.1, ptr getelementptr ([0 x i16], ptr null, i64 0, i64 -13), align 2
  %conv5.1 = sext i8 %0 to i32
  store i32 %conv5.1, ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -13), align 4
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_d768sq9.ll'
source_filename = "/tmp/tmp_d768sq9.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test() #0 {
entry:
  %vector.recur.extract = extractelement <vscale x 4 x i8> zeroinitializer, i64 0
  %0 = load <2 x i8>, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 5), align 1
  %1 = load i8, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 5), align 1
  %2 = icmp ne <2 x i8> %0, zeroinitializer
  %3 = zext <2 x i1> %2 to <2 x i16>
  store <2 x i16> %3, ptr getelementptr ([0 x i16], ptr null, i64 0, i64 -14), align 2
  %4 = insertelement <2 x i8> poison, i8 %vector.recur.extract, i32 0
  %5 = insertelement <2 x i8> %4, i8 %1, i32 1
  %6 = sext <2 x i8> %5 to <2 x i32>
  store <2 x i32> %6, ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -14), align 4
  ret i32 0
}

attributes #0 = { "target-features"="+v" }
