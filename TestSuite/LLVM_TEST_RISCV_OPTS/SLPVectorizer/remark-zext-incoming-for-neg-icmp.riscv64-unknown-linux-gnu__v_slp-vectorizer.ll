; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/remark-zext-incoming-for-neg-icmp.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -pass-remarks-output= -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -pass-remarks-output=%t < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test(i32 %a, i8 %b, i8 %c) {
entry:
  %0 = add i8 %c, -3
  %dec19 = add i8 %c, -1
  %conv20 = zext i8 %dec19 to i32
  %conv16.1 = sext i8 %b to i32
  %cmp17.1 = icmp sle i32 %conv20, %conv16.1
  %conv18.1 = zext i1 %cmp17.1 to i32
  %a.1 = add nsw i32 %conv18.1, %a
  %dec19.1 = add i8 %c, -2
  %conv20.1 = zext i8 %dec19.1 to i32
  %conv16.2 = sext i8 %b to i32
  %cmp17.2 = icmp sle i32 %conv20.1, %conv16.2
  %conv18.2 = zext i1 %cmp17.2 to i32
  %a.2 = add nsw i32 %a.1, %conv18.2
  %1 = zext i8 %0 to i32
  %conv16.158 = sext i8 %b to i32
  %cmp17.159 = icmp sle i32 %1, %conv16.158
  %conv18.160 = zext i1 %cmp17.159 to i32
  %a.161 = add nsw i32 %a.2, %conv18.160
  %dec19.162 = add i8 %c, -4
  %conv20.163 = zext i8 %dec19.162 to i32
  %conv16.1.1 = sext i8 %b to i32
  %cmp17.1.1 = icmp sle i32 %conv20.163, %conv16.1.1
  %conv18.1.1 = zext i1 %cmp17.1.1 to i32
  %a.1.1 = add nsw i32 %a.161, %conv18.1.1
  ret i32 %a.1.1
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp535gt52g.ll'
source_filename = "/tmp/tmp535gt52g.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test(i32 %a, i8 %b, i8 %c) #0 {
entry:
  %0 = insertelement <4 x i8> poison, i8 %c, i32 0
  %1 = shufflevector <4 x i8> %0, <4 x i8> poison, <4 x i32> zeroinitializer
  %2 = add <4 x i8> %1, <i8 -1, i8 -2, i8 -3, i8 -4>
  %3 = insertelement <4 x i8> poison, i8 %b, i32 0
  %4 = shufflevector <4 x i8> %3, <4 x i8> poison, <4 x i32> zeroinitializer
  %5 = zext <4 x i8> %2 to <4 x i16>
  %6 = sext <4 x i8> %4 to <4 x i16>
  %7 = icmp sle <4 x i16> %5, %6
  %8 = bitcast <4 x i1> %7 to i4
  %9 = call i4 @llvm.ctpop.i4(i4 %8)
  %10 = zext i4 %9 to i32
  %op.rdx = add i32 %10, %a
  ret i32 %op.rdx
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i4 @llvm.ctpop.i4(i4) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
