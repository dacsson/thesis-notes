; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/gather-insert-point-restore.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i16 @test(ptr %i) {
entry:
  %gep.us154 = getelementptr i8, ptr %i, i64 132860
  %gep.us154.1 = getelementptr i8, ptr %i, i64 137774
  %gep.us154.2 = getelementptr i8, ptr %i, i64 142688
  %gep.us154.3 = getelementptr i8, ptr %i, i64 147602
  %gep.us154.4 = getelementptr i8, ptr %i, i64 152516
  %gep.us154.5 = getelementptr i8, ptr %i, i64 157430
  br label %for.cond5.us

for.cond5.us:
  %0 = load i16, ptr %gep.us154, align 2
  %1 = load i16, ptr %gep.us154.1, align 2
  %2 = load i16, ptr %gep.us154.2, align 2
  %3 = load i16, ptr %gep.us154.3, align 2
  %4 = load i16, ptr %gep.us154.4, align 2
  %5 = load i16, ptr %gep.us154.5, align 2
  %6 = call i16 @llvm.umax.i16(i16 %5, i16 0)
  %7 = call i16 @llvm.umax.i16(i16 %0, i16 %6)
  %8 = call i16 @llvm.umax.i16(i16 %1, i16 %7)
  %9 = call i16 @llvm.umax.i16(i16 %2, i16 %8)
  %10 = call i16 @llvm.umax.i16(i16 %3, i16 %9)
  %11 = call i16 @llvm.umax.i16(i16 %2, i16 %10)
  %12 = call i16 @llvm.umax.i16(i16 %3, i16 %11)
  %13 = call i16 @llvm.umax.i16(i16 %4, i16 %12)
  %14 = load i16, ptr %gep.us154, align 2
  %15 = call i16 @llvm.umax.i16(i16 %14, i16 %13)
  %16 = load i16, ptr %gep.us154.1, align 2
  %17 = call i16 @llvm.umax.i16(i16 %16, i16 %15)
  %18 = call i16 @llvm.umax.i16(i16 %4, i16 %17)
  ret i16 %18
}

declare i16 @llvm.umax.i16(i16, i16) #1

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpk8myfmqd.ll'
source_filename = "/tmp/tmpk8myfmqd.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i16 @test(ptr %i) #0 {
entry:
  %0 = insertelement <4 x ptr> poison, ptr %i, i32 0
  %1 = shufflevector <4 x ptr> %0, <4 x ptr> poison, <4 x i32> zeroinitializer
  %2 = getelementptr i8, <4 x ptr> %1, <4 x i64> <i64 132860, i64 137774, i64 132860, i64 137774>
  %gep.us154.2 = getelementptr i8, ptr %i, i64 142688
  br label %for.cond5.us

for.cond5.us:                                     ; preds = %entry
  %3 = call <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i64(ptr align 2 %gep.us154.2, i64 4914, <4 x i1> splat (i1 true), i32 4)
  %4 = call <4 x i16> @llvm.masked.gather.v4i16.v4p0(<4 x ptr> align 2 %2, <4 x i1> splat (i1 true), <4 x i16> poison)
  %5 = shufflevector <4 x i16> %3, <4 x i16> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %6 = shufflevector <4 x i16> %4, <4 x i16> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %7 = shufflevector <4 x i16> %3, <4 x i16> %4, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %8 = call i16 @llvm.vector.reduce.umax.v8i16(<8 x i16> %7)
  %9 = call i16 @llvm.umax.i16(i16 %8, i16 0)
  ret i16 %9
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.umax.i16(i16, i16) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i64(ptr captures(none), i64, <4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <4 x i16> @llvm.masked.gather.v4i16.v4p0(<4 x ptr>, <4 x i1>, <4 x i16>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.umax.v8i16(<8 x i16>) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
