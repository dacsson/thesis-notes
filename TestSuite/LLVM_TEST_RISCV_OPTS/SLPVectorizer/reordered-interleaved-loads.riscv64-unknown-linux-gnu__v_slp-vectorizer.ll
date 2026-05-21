; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reordered-interleaved-loads.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@h = external global [21 x i16]
@a = external global [21 x [21 x i16]]

define i1 @test(i32 %conv15.12, i16 %0, ptr %1, i16 %2, i16 %3, i16 %4, i16 %5, i32 %conv15.1.3, i16 %6, i32 %conv15.1.4) {
entry:
  %7 = load i16, ptr %1, align 2
  %conv15.121 = sext i16 %7 to i32
  %cond.13 = tail call i32 @llvm.smax.i32(i32 %conv15.121, i32 0)
  %tobool.not.14 = icmp eq i16 %7, 0
  %cond27.15 = select i1 %tobool.not.14, i32 8, i32 %conv15.121
  %xor.16 = xor i32 %cond27.15, %conv15.12
  %cmp28.17 = icmp sgt i32 %cond.13, %xor.16
  %conv30.18 = zext i1 %cmp28.17 to i16
  store i16 %conv30.18, ptr @a, align 2
  %conv15.213 = sext i16 %0 to i32
  %cond.214 = tail call i32 @llvm.smax.i32(i32 %conv15.213, i32 0)
  %tobool.not.215 = icmp eq i16 %0, 0
  %cond27.216 = select i1 %tobool.not.215, i32 8, i32 %conv15.213
  %xor.217 = xor i32 %cond27.216, %conv15.213
  %cmp28.218 = icmp sgt i32 %cond.214, %xor.217
  %conv30.219 = zext i1 %cmp28.218 to i16
  store i16 %conv30.219, ptr @a, align 2
  %8 = load i16, ptr @h, align 2
  %conv15.324 = sext i16 %8 to i32
  %cond.325 = tail call i32 @llvm.smax.i32(i32 %conv15.324, i32 0)
  %tobool.not.326 = icmp eq i16 %8, 0
  %cond27.327 = select i1 %tobool.not.326, i32 8, i32 %conv15.324
  %xor.328 = xor i32 %cond27.327, %conv15.324
  %cmp28.329 = icmp sgt i32 %cond.325, %xor.328
  %conv30.330 = zext i1 %cmp28.329 to i16
  store i16 %conv30.330, ptr @a, align 2
  %conv15.4 = sext i16 %2 to i32
  %cond.4 = tail call i32 @llvm.smax.i32(i32 %conv15.4, i32 0)
  %tobool.not.4 = icmp eq i16 %2, 0
  %cond27.4 = select i1 %tobool.not.4, i32 8, i32 %conv15.4
  %xor.4 = xor i32 %cond27.4, %conv15.4
  %cmp28.4 = icmp sgt i32 %cond.4, %xor.4
  %conv30.4 = zext i1 %cmp28.4 to i16
  store i16 %conv30.4, ptr @a, align 2
  %9 = load i16, ptr getelementptr inbounds nuw (i8, ptr @h, i64 6), align 2
  %conv15.1.1 = sext i16 %3 to i32
  %cond.1.1 = tail call i32 @llvm.smax.i32(i32 %conv15.1.1, i32 0)
  %tobool.not.1.1 = icmp eq i16 %9, 0
  %cond27.1.1 = select i1 %tobool.not.1.1, i32 8, i32 %conv15.1.1
  %xor.1.1 = xor i32 %cond27.1.1, %conv15.1.1
  %cmp28.1.1 = icmp sgt i32 %cond.1.1, %xor.1.1
  %conv30.1.1 = zext i1 %cmp28.1.1 to i16
  store i16 %conv30.1.1, ptr @a, align 2
  %10 = load i16, ptr getelementptr inbounds nuw (i8, ptr @h, i64 12), align 4
  %conv15.1.2 = sext i16 %4 to i32
  %cond.1.2 = tail call i32 @llvm.smax.i32(i32 %conv15.1.2, i32 0)
  %tobool.not.1.2 = icmp eq i16 %10, 0
  %cond27.1.2 = select i1 %tobool.not.1.2, i32 8, i32 %conv15.1.2
  %xor.1.2 = xor i32 %cond27.1.2, %conv15.1.2
  %cmp28.1.2 = icmp sgt i32 %cond.1.2, %xor.1.2
  %conv30.1.2 = zext i1 %cmp28.1.2 to i16
  store i16 %conv30.1.2, ptr @a, align 2
  %11 = load i16, ptr getelementptr inbounds nuw (i8, ptr @h, i64 18), align 2
  %conv15.1.32 = sext i16 %5 to i32
  %cond.1.3 = tail call i32 @llvm.smax.i32(i32 %conv15.1.32, i32 0)
  %tobool.not.1.3 = icmp eq i16 %11, 0
  %cond27.1.3 = select i1 %tobool.not.1.3, i32 8, i32 %conv15.1.32
  %xor.1.3 = xor i32 %cond27.1.3, %conv15.1.3
  %cmp28.1.3 = icmp sgt i32 %cond.1.3, %xor.1.3
  %conv30.1.3 = zext i1 %cmp28.1.3 to i16
  store i16 %conv30.1.3, ptr @a, align 2
  %12 = load i16, ptr getelementptr inbounds nuw (i8, ptr @h, i64 24), align 8
  %conv15.1.43 = sext i16 %6 to i32
  %cond.1.4 = tail call i32 @llvm.smax.i32(i32 %conv15.1.43, i32 0)
  %tobool.not.1.4 = icmp eq i16 %12, 0
  %cond27.1.4 = select i1 %tobool.not.1.4, i32 8, i32 %conv15.1.43
  %xor.1.4 = xor i32 %cond27.1.4, %conv15.1.4
  %cmp28.1.4 = icmp sgt i32 %cond.1.4, %xor.1.4
  ret i1 %cmp28.1.4
}

declare i32 @llvm.smax.i32(i32, i32)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_d9rhkgd.ll'
source_filename = "/tmp/tmp_d9rhkgd.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@h = external global [21 x i16]
@a = external global [21 x [21 x i16]]

define i1 @test(i32 %conv15.12, i16 %0, ptr %1, i16 %2, i16 %3, i16 %4, i16 %5, i32 %conv15.1.3, i16 %6, i32 %conv15.1.4) #0 {
entry:
  %7 = load i16, ptr %1, align 2
  %8 = load i16, ptr @h, align 2
  %9 = insertelement <4 x i16> poison, i16 %2, i32 0
  %10 = insertelement <4 x i16> %9, i16 %0, i32 2
  %11 = insertelement <4 x i16> %10, i16 %8, i32 1
  %12 = insertelement <4 x i16> %11, i16 %7, i32 3
  %13 = sext <4 x i16> %12 to <4 x i32>
  %14 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %13, <4 x i32> zeroinitializer)
  %15 = icmp eq <4 x i16> %12, zeroinitializer
  %16 = select <4 x i1> %15, <4 x i32> splat (i32 8), <4 x i32> %13
  %17 = insertelement <4 x i32> %13, i32 %conv15.12, i32 3
  %18 = xor <4 x i32> %16, %17
  %19 = icmp sgt <4 x i32> %14, %18
  %20 = extractelement <4 x i1> %19, i32 3
  %conv30.18 = zext i1 %20 to i16
  store i16 %conv30.18, ptr @a, align 2
  %21 = extractelement <4 x i1> %19, i32 2
  %conv30.219 = zext i1 %21 to i16
  store i16 %conv30.219, ptr @a, align 2
  %22 = extractelement <4 x i1> %19, i32 1
  %conv30.330 = zext i1 %22 to i16
  store i16 %conv30.330, ptr @a, align 2
  %23 = extractelement <4 x i1> %19, i32 0
  %conv30.4 = zext i1 %23 to i16
  store i16 %conv30.4, ptr @a, align 2
  %24 = insertelement <4 x i16> poison, i16 %3, i32 0
  %25 = insertelement <4 x i16> %24, i16 %4, i32 1
  %26 = insertelement <4 x i16> %25, i16 %5, i32 2
  %27 = insertelement <4 x i16> %26, i16 %6, i32 3
  %28 = sext <4 x i16> %27 to <4 x i32>
  %29 = load <16 x i16>, ptr getelementptr inbounds nuw (i8, ptr @h, i64 6), align 2
  %30 = shufflevector <16 x i16> %29, <16 x i16> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %31 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %28, <4 x i32> zeroinitializer)
  %32 = icmp eq <4 x i16> %30, zeroinitializer
  %33 = select <4 x i1> %32, <4 x i32> splat (i32 8), <4 x i32> %28
  %34 = insertelement <4 x i32> %28, i32 %conv15.1.3, i32 2
  %35 = insertelement <4 x i32> %34, i32 %conv15.1.4, i32 3
  %36 = xor <4 x i32> %33, %35
  %37 = icmp sgt <4 x i32> %31, %36
  %38 = extractelement <4 x i1> %37, i32 0
  %conv30.1.1 = zext i1 %38 to i16
  store i16 %conv30.1.1, ptr @a, align 2
  %39 = extractelement <4 x i1> %37, i32 1
  %conv30.1.2 = zext i1 %39 to i16
  store i16 %conv30.1.2, ptr @a, align 2
  %40 = extractelement <4 x i1> %37, i32 2
  %conv30.1.3 = zext i1 %40 to i16
  store i16 %conv30.1.3, ptr @a, align 2
  %41 = extractelement <4 x i1> %37, i32 3
  ret i1 %41
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
