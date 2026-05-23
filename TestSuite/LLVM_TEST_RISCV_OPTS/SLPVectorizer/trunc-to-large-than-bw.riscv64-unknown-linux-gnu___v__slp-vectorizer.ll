; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/trunc-to-large-than-bw.ll
; Variant: riscv64-unknown-linux-gnu_"+v"_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@c = global [12 x i64] zeroinitializer

define i32 @test() {
entry:
  %0 = load i64, ptr @c, align 8
  %conv = trunc i64 %0 to i32
  %conv3 = and i32 %conv, 65535
  %conv4 = xor i32 %conv3, 65535
  %.conv4 = tail call i32 @llvm.umax.i32(i32 1, i32 %conv4)
  %1 = load i64, ptr getelementptr inbounds ([12 x i64], ptr @c, i64 0, i64 3), align 8
  %conv.1 = trunc i64 %1 to i32
  %conv3.1 = and i32 %conv.1, 65535
  %conv4.1 = xor i32 %conv3.1, 65535
  %.conv4.1 = tail call i32 @llvm.umax.i32(i32 %.conv4, i32 %conv4.1)
  %2 = load i64, ptr getelementptr inbounds ([12 x i64], ptr @c, i64 0, i64 6), align 8
  %conv.2 = trunc i64 %2 to i32
  %conv3.2 = and i32 %conv.2, 65535
  %conv4.2 = xor i32 %conv3.2, 65535
  %.conv4.2 = tail call i32 @llvm.umax.i32(i32 %.conv4.1, i32 %conv4.2)
  %3 = load i64, ptr getelementptr inbounds ([12 x i64], ptr @c, i64 0, i64 9), align 8
  %conv.3 = trunc i64 %3 to i32
  %conv3.3 = and i32 %conv.3, 65535
  %conv4.3 = xor i32 %conv3.3, 65535
  %.conv4.3 = tail call i32 @llvm.umax.i32(i32 %.conv4.2, i32 %conv4.3)
  ret i32 %.conv4.3
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpsa9roy7s.ll'
source_filename = "/tmp/tmpsa9roy7s.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@c = global [12 x i64] zeroinitializer

define i32 @test() #0 {
entry:
  %0 = call <4 x i64> @llvm.experimental.vp.strided.load.v4i64.p0.i64(ptr align 8 @c, i64 24, <4 x i1> splat (i1 true), i32 4)
  %1 = trunc <4 x i64> %0 to <4 x i16>
  %2 = xor <4 x i16> %1, splat (i16 -1)
  %3 = call i16 @llvm.vector.reduce.umax.v4i16(<4 x i16> %2)
  %4 = zext i16 %3 to i32
  %5 = call i32 @llvm.umax.i32(i32 %4, i32 1)
  ret i32 %5
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <4 x i64> @llvm.experimental.vp.strided.load.v4i64.p0.i64(ptr captures(none), i64, <4 x i1>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.umax.v4i16(<4 x i16>) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
