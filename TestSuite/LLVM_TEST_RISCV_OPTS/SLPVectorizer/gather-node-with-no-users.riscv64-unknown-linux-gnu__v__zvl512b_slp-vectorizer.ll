; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/gather-node-with-no-users.ll
; Variant: riscv64-unknown-linux-gnu_+v,+zvl512b_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v,+zvl512b -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v,+zvl512b < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %c) {
entry:
  %arrayidx8.5.3 = getelementptr i8, ptr %c, i64 222
  %0 = load i8, ptr %arrayidx8.5.3, align 1
  %arrayidx8.7.3 = getelementptr i8, ptr %c, i64 228
  %1 = load i8, ptr %arrayidx8.7.3, align 1
  %arrayidx8.434 = getelementptr i8, ptr %c, i64 276
  %2 = load i8, ptr %arrayidx8.434, align 1
  %arrayidx8.1.4 = getelementptr i8, ptr %c, i64 279
  %3 = load i8, ptr %arrayidx8.1.4, align 1
  %arrayidx8.2.4 = getelementptr i8, ptr %c, i64 282
  %4 = load i8, ptr %arrayidx8.2.4, align 1
  %arrayidx8.3.4 = getelementptr i8, ptr %c, i64 285
  %5 = load i8, ptr %arrayidx8.3.4, align 1
  %arrayidx8.4.4 = getelementptr i8, ptr %c, i64 288
  %6 = load i8, ptr %arrayidx8.4.4, align 1
  %7 = load i8, ptr %c, align 1
  %8 = load i8, ptr %c, align 1
  %arrayidx8.536 = getelementptr i8, ptr %c, i64 345
  %9 = load i8, ptr %arrayidx8.536, align 1
  %arrayidx8.1.5 = getelementptr i8, ptr %c, i64 348
  %10 = load i8, ptr %arrayidx8.1.5, align 1
  %arrayidx8.2.5 = getelementptr i8, ptr %c, i64 351
  %11 = load i8, ptr %arrayidx8.2.5, align 1
  %arrayidx8.3.5 = getelementptr i8, ptr %c, i64 354
  %12 = load i8, ptr %arrayidx8.3.5, align 1
  %arrayidx8.4.5 = getelementptr i8, ptr %c, i64 357
  %13 = load i8, ptr %arrayidx8.4.5, align 1
  %arrayidx8.5.5 = getelementptr i8, ptr %c, i64 360
  %14 = load i8, ptr %arrayidx8.5.5, align 1
  %arrayidx8.6.5 = getelementptr i8, ptr %c, i64 363
  %15 = load i8, ptr %arrayidx8.6.5, align 1
  br label %for.cond

for.cond:
  %a.promoted2226 = phi i8 [ 0, %entry ], [ %or18.6.5, %for.cond ]
  %or18.7.3 = or i8 %0, %1
  %or18.435 = or i8 %or18.7.3, %2
  %or18.1.4 = or i8 %or18.435, %3
  %or18.2.4 = or i8 %or18.1.4, %4
  %or18.3.4 = or i8 %or18.2.4, %5
  %or18.4.4 = or i8 %or18.3.4, %6
  %or18.5.4 = or i8 %or18.4.4, %7
  %or18.6.4 = or i8 %or18.5.4, %8
  %or18.537 = or i8 %or18.6.4, %9
  %or18.1.5 = or i8 %or18.537, %10
  %or18.2.5 = or i8 %or18.1.5, %11
  %or18.3.5 = or i8 %or18.2.5, %12
  %or18.4.5 = or i8 %or18.3.5, %13
  %or18.5.5 = or i8 %or18.4.5, %14
  %or18.6.5 = or i8 %or18.5.5, %15
  br label %for.cond
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpndxc8jm2.ll'
source_filename = "/tmp/tmpndxc8jm2.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(ptr %c) #0 {
entry:
  %0 = insertelement <8 x ptr> poison, ptr %c, i32 0
  %1 = shufflevector <8 x ptr> %0, <8 x ptr> poison, <8 x i32> zeroinitializer
  %2 = getelementptr i8, <8 x ptr> %1, <8 x i64> <i64 222, i64 228, i64 276, i64 279, i64 282, i64 285, i64 288, i64 0>
  %3 = getelementptr i8, <8 x ptr> %1, <8 x i64> <i64 0, i64 345, i64 348, i64 351, i64 354, i64 357, i64 360, i64 363>
  %4 = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> align 1 %2, <8 x i1> splat (i1 true), <8 x i8> poison)
  %5 = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> align 1 %3, <8 x i1> splat (i1 true), <8 x i8> poison)
  %6 = shufflevector <8 x i8> %5, <8 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %7 = shufflevector <8 x i8> %4, <8 x i8> %5, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %a.promoted2226 = phi i8 [ 0, %entry ], [ %9, %for.cond ]
  %8 = shufflevector <8 x i8> %4, <8 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %9 = call i8 @llvm.vector.reduce.or.v16i8(<16 x i8> %7)
  br label %for.cond
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr>, <8 x i1>, <8 x i8>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.or.v16i8(<16 x i8>) #2

attributes #0 = { "target-features"="+v,+zvl512b" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
