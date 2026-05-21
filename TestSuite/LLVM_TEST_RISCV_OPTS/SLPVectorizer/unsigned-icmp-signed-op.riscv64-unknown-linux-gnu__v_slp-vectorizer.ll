; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/unsigned-icmp-signed-op.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test(ptr %f, i16 %0) {
entry:
  %1 = load i16, ptr %f, align 2

  %zext.0 = zext i16 %1 to i32
  %sext.0 = sext i16 %0 to i32

  %zext.1 = zext i16 0 to i32
  %sext.1 = sext i16 0 to i32
  %zext.2 = zext i16 0 to i32
  %sext.2 = sext i16 0 to i32
  %zext.3 = zext i16 0 to i32
  %sext.3 = sext i16 0 to i32

  %cmp.0 = icmp ule i32 %zext.0, %sext.0
  %cmp.1 = icmp ule i32 %zext.1, %sext.1
  %cmp.2 = icmp ule i32 %zext.2, %sext.2
  %cmp.3 = icmp ule i32 %zext.3, %sext.3

  %and.0 = and i1 %cmp.0, %cmp.1
  %and.1 = and i1 %and.0, %cmp.2
  %and.2 = and i1 %and.1, %cmp.3

  %zext.4 = zext i1 %and.2 to i32

  ret i32 %zext.4
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpelxrxupv.ll'
source_filename = "/tmp/tmpelxrxupv.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test(ptr %f, i16 %0) #0 {
entry:
  %1 = load i16, ptr %f, align 2
  %2 = insertelement <4 x i16> <i16 poison, i16 0, i16 0, i16 0>, i16 %0, i32 0
  %3 = insertelement <4 x i16> <i16 poison, i16 0, i16 0, i16 0>, i16 %1, i32 0
  %4 = zext <4 x i16> %3 to <4 x i32>
  %5 = sext <4 x i16> %2 to <4 x i32>
  %6 = icmp ule <4 x i32> %4, %5
  %7 = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %6)
  %zext.4 = zext i1 %7 to i32
  ret i32 %zext.4
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.and.v4i1(<4 x i1>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
