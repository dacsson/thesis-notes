; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/shuffled-gather-casted.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S -passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test(ptr %p) {
entry:
  %d.0 = load i16, ptr %p, align 4
  %zext.d.0 = zext i16 %d.0 to i32
  %zero.0 = zext i16 0 to i32
  %zero.1 = zext i16 0 to i32
  %zero.2 = zext i16 0 to i32

  %or.d.0 = or i32 %zext.d.0, 0
  %or.zero.0 = or i32 %zero.0, 0
  %or.zero.1 = or i32 %zero.1, 0
  %or.zero.2 = or i32 %zero.2, 0

  %zero.d.0 = and i32 %or.d.0, 0
  %and.zero.0 = and i32 %or.zero.0, 0
  %and.zero.1 = and i32 %or.zero.1, 0
  %and.zero.2 = and i32 %or.zero.2, 0

  %d.0.gt.0 = icmp sgt i32 %zext.d.0, 0
  %false.0 = icmp sgt i32 0, 0
  %false.1 = icmp sgt i32 0, 0
  %false.2 = icmp sgt i32 0, 0

  %select.0.2 = select i1 %d.0.gt.0, i32 %zero.d.0, i32 2
  %select.1.0 = select i1 %false.0, i32 %and.zero.0, i32 0
  %select.2.0 = select i1 %false.1, i32 %and.zero.1, i32 0
  %select.3.0 = select i1 %false.2, i32 %and.zero.2, i32 0

  %max.0 = call i32 @llvm.umax.i32(i32 %select.0.2, i32 %select.1.0)
  %max.1 = call i32 @llvm.umax.i32(i32 %max.0, i32 %select.2.0)
  %max.2 = call i32 @llvm.umax.i32(i32 %max.1, i32 %select.3.0)
  %max.3 = call i32 @llvm.umax.i32(i32 %max.2, i32 1)

  ret i32 %max.3
}

define i32 @test1(ptr %p) {
entry:
  %d.0 = load i16, ptr %p, align 4
  %zext.d.0 = zext i16 %d.0 to i32
  %zero.0 = zext i16 0 to i32
  %zero.1 = zext i16 0 to i32
  %zero.2 = zext i16 0 to i32

  %or.d.0 = or i32 %zext.d.0, 0
  %or.zero.0 = or i32 %zero.0, 0
  %or.zero.1 = or i32 %zero.1, 0
  %or.zero.2 = or i32 %zero.2, 0

  %szero.00 = sext i16 65535 to i32
  %szero.0 = sext i16 -16383 to i32
  %uzero.1 = zext i16 65535 to i32
  %szero.2 = sext i16 65535 to i32

  %zero.d.0 = and i32 %or.d.0, %szero.00
  %and.zero.0 = and i32 %or.zero.0, %szero.0
  %and.zero.1 = and i32 %or.zero.1, %uzero.1
  %and.zero.2 = and i32 %or.zero.2, %szero.2

  %d.0.gt.0 = icmp eq i32 %zext.d.0, 65535
  %false.0 = icmp eq i32 %szero.0, -16383
  %false.1 = icmp eq i32 %uzero.1, 65535
  %false.2 = icmp eq i32 %szero.2, 65535

  %select.0.2 = select i1 %d.0.gt.0, i32 %zero.d.0, i32 4
  %select.1.0 = select i1 %false.0, i32 %and.zero.0, i32 3
  %select.2.0 = select i1 %false.1, i32 %and.zero.1, i32 2
  %select.3.0 = select i1 %false.2, i32 %and.zero.2, i32 1

  %max.0 = add i32 %select.0.2, %select.1.0
  %max.1 = add i32 %max.0, %select.2.0
  %max.2 = add i32 %max.1, %select.3.0

  ret i32 %max.2
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpeplq9cpj.ll'
source_filename = "/tmp/tmpeplq9cpj.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test(ptr %p) #0 {
entry:
  %d.0 = load i16, ptr %p, align 4
  %0 = insertelement <4 x i16> <i16 poison, i16 0, i16 0, i16 0>, i16 %d.0, i32 0
  %1 = or <4 x i16> %0, zeroinitializer
  %2 = and <4 x i16> %1, zeroinitializer
  %3 = zext <4 x i16> %0 to <4 x i32>
  %4 = shufflevector <4 x i32> %3, <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 5, i32 6, i32 7>
  %5 = icmp sgt <4 x i32> %4, zeroinitializer
  %6 = select <4 x i1> %5, <4 x i16> %2, <4 x i16> <i16 2, i16 0, i16 0, i16 0>
  %7 = call i16 @llvm.vector.reduce.umax.v4i16(<4 x i16> %6)
  %8 = zext i16 %7 to i32
  %9 = call i32 @llvm.umax.i32(i32 %8, i32 1)
  ret i32 %9
}

define i32 @test1(ptr %p) #0 {
entry:
  %d.0 = load i16, ptr %p, align 4
  %zext.d.0 = zext i16 %d.0 to i32
  %zero.0 = zext i16 0 to i32
  %zero.1 = zext i16 0 to i32
  %zero.2 = zext i16 0 to i32
  %or.d.0 = or i32 %zext.d.0, 0
  %or.zero.0 = or i32 %zero.0, 0
  %or.zero.1 = or i32 %zero.1, 0
  %or.zero.2 = or i32 %zero.2, 0
  %szero.00 = sext i16 -1 to i32
  %szero.0 = sext i16 -16383 to i32
  %uzero.1 = zext i16 -1 to i32
  %szero.2 = sext i16 -1 to i32
  %zero.d.0 = and i32 %or.d.0, %szero.00
  %and.zero.0 = and i32 %or.zero.0, %szero.0
  %and.zero.1 = and i32 %or.zero.1, %uzero.1
  %and.zero.2 = and i32 %or.zero.2, %szero.2
  %d.0.gt.0 = icmp eq i32 %zext.d.0, 65535
  %false.0 = icmp eq i32 %szero.0, -16383
  %false.1 = icmp eq i32 %uzero.1, 65535
  %false.2 = icmp eq i32 %szero.2, 65535
  %select.0.2 = select i1 %d.0.gt.0, i32 %zero.d.0, i32 4
  %select.1.0 = select i1 %false.0, i32 %and.zero.0, i32 3
  %select.2.0 = select i1 %false.1, i32 %and.zero.1, i32 2
  %select.3.0 = select i1 %false.2, i32 %and.zero.2, i32 1
  %max.0 = add i32 %select.0.2, %select.1.0
  %max.1 = add i32 %max.0, %select.2.0
  %max.2 = add i32 %max.1, %select.3.0
  ret i32 %max.2
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.umax.v4i16(<4 x i16>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
