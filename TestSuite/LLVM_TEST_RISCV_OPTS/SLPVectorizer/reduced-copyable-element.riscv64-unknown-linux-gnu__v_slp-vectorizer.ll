; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reduced-copyable-element.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@n = external global [0 x i64]

define i32 @main() {
entry:
  %0 = load i64, ptr getelementptr (i8, ptr @n, i64 32), align 8
  %conv13.i.1 = trunc i64 %0 to i32
  %cond.i.1 = tail call i32 @llvm.smin.i32(i32 %conv13.i.1, i32 0)
  %conv40.i.1 = sext i32 %cond.i.1 to i64
  %cond47.i.1 = tail call i64 @llvm.umin.i64(i64 %conv40.i.1, i64 17179869184)
  %1 = trunc i64 %cond47.i.1 to i32
  %2 = add i32 %1, 1
  %3 = load i64, ptr @n, align 8
  %conv13.i.2 = trunc i64 %3 to i32
  %cond.i.2 = tail call i32 @llvm.smin.i32(i32 %conv13.i.2, i32 0)
  %conv40.i.2 = sext i32 %cond.i.2 to i64
  %cond47.i.2 = tail call i64 @llvm.umin.i64(i64 %conv40.i.2, i64 17179869184)
  %4 = trunc i64 %cond47.i.2 to i32
  %5 = or i32 %2, %4
  ret i32 %5
}

declare i32 @llvm.smin.i32(i32, i32)
declare i64 @llvm.umin.i64(i64, i64)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmps4avj0wi.ll'
source_filename = "/tmp/tmps4avj0wi.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@n = external global [0 x i64]

define i32 @main() #0 {
entry:
  %0 = call <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr align 8 @n, i64 32, <2 x i1> splat (i1 true), i32 2)
  %1 = trunc <2 x i64> %0 to <2 x i32>
  %2 = call <2 x i32> @llvm.smin.v2i32(<2 x i32> %1, <2 x i32> zeroinitializer)
  %3 = sext <2 x i32> %2 to <2 x i64>
  %4 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> %3, <2 x i64> splat (i64 17179869184))
  %5 = trunc <2 x i64> %4 to <2 x i32>
  %6 = add <2 x i32> %5, <i32 0, i32 1>
  %7 = call i32 @llvm.vector.reduce.or.v2i32(<2 x i32> %6)
  ret i32 %7
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr captures(none), i64, <2 x i1>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i32> @llvm.smin.v2i32(<2 x i32>, <2 x i32>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i64> @llvm.umin.v2i64(<2 x i64>, <2 x i64>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v2i32(<2 x i32>) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
