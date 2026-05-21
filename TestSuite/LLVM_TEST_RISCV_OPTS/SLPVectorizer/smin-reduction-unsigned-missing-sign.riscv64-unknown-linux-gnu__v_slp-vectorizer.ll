; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/smin-reduction-unsigned-missing-sign.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test(i8 %0) {
entry:
  %1 = icmp ne i8 0, 0
  %2 = zext i1 %1 to i32
  %3 = icmp ne i8 %0, 0
  %4 = zext i1 %3 to i32
  %5 = icmp ne i8 0, 0
  %6 = zext i1 %5 to i32
  %7 = icmp ne i8 0, 0
  %8 = zext i1 %7 to i32
  %cond27.2 = tail call i32 @llvm.smin.i32(i32 %4, i32 %2)
  %cond27.3 = tail call i32 @llvm.smin.i32(i32 %6, i32 %cond27.2)
  %cond27.4 = tail call i32 @llvm.smin.i32(i32 %8, i32 %cond27.3)
  ret i32 %cond27.4
}

declare i32 @llvm.smin.i32(i32, i32)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpof3nk17y.ll'
source_filename = "/tmp/tmpof3nk17y.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test(i8 %0) #0 {
entry:
  %1 = insertelement <4 x i8> <i8 poison, i8 0, i8 0, i8 0>, i8 %0, i32 0
  %2 = icmp ne <4 x i8> %1, zeroinitializer
  %3 = zext <4 x i1> %2 to <4 x i8>
  %4 = call i8 @llvm.vector.reduce.smin.v4i8(<4 x i8> %3)
  %5 = zext i8 %4 to i32
  ret i32 %5
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.smin.v4i8(<4 x i8>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
