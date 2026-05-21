; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reduced-value-repeated-and-vectorized.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test() {
entry:
  %0 = load i16, ptr null, align 2
  %1 = xor i16 %0, 0
  %2 = tail call i16 @llvm.smax.i16(i16 %1, i16 %0)
  %3 = tail call i16 @llvm.smax.i16(i16 0, i16 %2)
  %4 = load i16, ptr getelementptr inbounds (i8, ptr null, i64 6), align 2
  %5 = xor i16 %4, 0
  %6 = tail call i16 @llvm.smax.i16(i16 %5, i16 %0)
  %7 = tail call i16 @llvm.smax.i16(i16 %3, i16 %6)
  %8 = load i16, ptr getelementptr (i8, ptr null, i64 12), align 2
  %9 = xor i16 %8, 0
  %10 = tail call i16 @llvm.smax.i16(i16 %9, i16 %0)
  %11 = tail call i16 @llvm.smax.i16(i16 %7, i16 %10)
  %12 = load i16, ptr getelementptr (i8, ptr null, i64 18), align 2
  %13 = xor i16 %12, 0
  %14 = tail call i16 @llvm.smax.i16(i16 %13, i16 %0)
  %15 = tail call i16 @llvm.smax.i16(i16 %11, i16 %14)
  %16 = tail call i16 @llvm.smax.i16(i16 %15, i16 0)
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpd80o_rcp.ll'
source_filename = "/tmp/tmpd80o_rcp.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test() #0 {
entry:
  %0 = call <3 x i16> @llvm.experimental.vp.strided.load.v3i16.p0.i64(ptr align 2 null, i64 6, <3 x i1> splat (i1 true), i32 3)
  %1 = shufflevector <3 x i16> %0, <3 x i16> poison, <4 x i32> <i32 0, i32 0, i32 1, i32 2>
  %2 = xor <4 x i16> %1, zeroinitializer
  %3 = load i16, ptr getelementptr (i8, ptr null, i64 18), align 2
  %4 = xor i16 %3, 0
  %5 = call i16 @llvm.vector.reduce.smax.v4i16(<4 x i16> %2)
  %6 = call i16 @llvm.smax.i16(i16 %5, i16 %4)
  %7 = call i16 @llvm.smax.i16(i16 %6, i16 0)
  %8 = tail call i16 @llvm.smax.i16(i16 %7, i16 0)
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.smax.i16(i16, i16) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <3 x i16> @llvm.experimental.vp.strided.load.v3i16.p0.i64(ptr captures(none), i64, <3 x i1>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.smax.v4i16(<4 x i16>) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
