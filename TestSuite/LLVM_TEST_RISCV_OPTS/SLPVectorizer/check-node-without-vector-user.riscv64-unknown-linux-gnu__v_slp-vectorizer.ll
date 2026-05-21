; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/check-node-without-vector-user.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@r = external global [8 x i8]

define void @test(i64 %0, ptr %1) {
  %3 = load i8, ptr @r, align 1
  %4 = trunc i8 %3 to i1
  %5 = select i1 %4, i64 %0, i64 0
  %6 = getelementptr i8, ptr @r, i64 %5
  %7 = load i8, ptr %6, align 1
  %8 = icmp ule i8 %3, %7
  %9 = sext i1 %8 to i32
  %10 = load i8, ptr getelementptr (i8, ptr @r, i64 -8049), align 1
  %11 = trunc i8 %10 to i1
  %12 = select i1 %11, i64 %0, i64 0
  %13 = getelementptr i8, ptr @r, i64 %12
  %14 = load i8, ptr %13, align 1
  %15 = icmp ule i8 %10, %14
  %16 = sext i1 %15 to i32
  %17 = add i32 %9, %16
  %18 = load i8, ptr getelementptr (i8, ptr @r, i64 -16098), align 1
  %19 = trunc i8 %18 to i1
  %20 = select i1 %19, i64 %0, i64 0
  %21 = getelementptr i8, ptr @r, i64 %20
  %22 = load i8, ptr %21, align 1
  %23 = icmp ule i8 %18, %22
  %24 = sext i1 %23 to i32
  %25 = add i32 %17, %24
  %26 = load i8, ptr getelementptr (i8, ptr @r, i64 -24147), align 1
  %27 = trunc i8 %26 to i1
  %28 = select i1 %27, i64 %0, i64 0
  %29 = getelementptr i8, ptr @r, i64 %28
  %30 = load i8, ptr %29, align 1
  %31 = icmp ule i8 %26, %30
  %32 = sext i1 %31 to i32
  %33 = add i32 %25, %32
  store i32 %33, ptr %1, align 4
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpqpsuzc49.ll'
source_filename = "/tmp/tmpqpsuzc49.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@r = external global [8 x i8]

define void @test(i64 %0, ptr %1) #0 {
  %3 = load i8, ptr @r, align 1
  %4 = trunc i8 %3 to i1
  %5 = select i1 %4, i64 %0, i64 0
  %6 = getelementptr i8, ptr @r, i64 %5
  %7 = load i8, ptr %6, align 1
  %8 = icmp ule i8 %3, %7
  %9 = sext i1 %8 to i32
  %10 = load i8, ptr getelementptr (i8, ptr @r, i64 -8049), align 1
  %11 = trunc i8 %10 to i1
  %12 = select i1 %11, i64 %0, i64 0
  %13 = getelementptr i8, ptr @r, i64 %12
  %14 = load i8, ptr %13, align 1
  %15 = icmp ule i8 %10, %14
  %16 = sext i1 %15 to i32
  %17 = add i32 %9, %16
  %18 = load i8, ptr getelementptr (i8, ptr @r, i64 -16098), align 1
  %19 = trunc i8 %18 to i1
  %20 = select i1 %19, i64 %0, i64 0
  %21 = getelementptr i8, ptr @r, i64 %20
  %22 = load i8, ptr %21, align 1
  %23 = icmp ule i8 %18, %22
  %24 = sext i1 %23 to i32
  %25 = add i32 %17, %24
  %26 = load i8, ptr getelementptr (i8, ptr @r, i64 -24147), align 1
  %27 = trunc i8 %26 to i1
  %28 = select i1 %27, i64 %0, i64 0
  %29 = getelementptr i8, ptr @r, i64 %28
  %30 = load i8, ptr %29, align 1
  %31 = icmp ule i8 %26, %30
  %32 = sext i1 %31 to i32
  %33 = add i32 %25, %32
  store i32 %33, ptr %1, align 4
  ret void
}

attributes #0 = { "target-features"="+v" }
