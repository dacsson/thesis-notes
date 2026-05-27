; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/segmented-loads-simple.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -S
; Original: RUN: opt -S -passes=slp-vectorizer < %s -mtriple=riscv64-unknown-linux -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @sum_of_abs_stride_2(ptr noalias %a, ptr noalias %b) {
entry:
  %0 = load i8, ptr %a, align 1
  %spec.select.i = tail call i8 @llvm.abs.i8(i8 %0, i1 false)
  %conv = sext i8 %spec.select.i to i32
  %arrayidx.1 = getelementptr inbounds i8, ptr %a, i64 2
  %1 = load i8, ptr %arrayidx.1, align 1
  %spec.select.i.1 = tail call i8 @llvm.abs.i8(i8 %1, i1 false)
  %conv.1 = sext i8 %spec.select.i.1 to i32
  %add.1 = add nsw i32 %conv, %conv.1
  %arrayidx.2 = getelementptr inbounds i8, ptr %a, i64 4
  %2 = load i8, ptr %arrayidx.2, align 1
  %spec.select.i.2 = tail call i8 @llvm.abs.i8(i8 %2, i1 false)
  %conv.2 = sext i8 %spec.select.i.2 to i32
  %add.2 = add nsw i32 %add.1, %conv.2
  %arrayidx.3 = getelementptr inbounds i8, ptr %a, i64 6
  %3 = load i8, ptr %arrayidx.3, align 1
  %spec.select.i.3 = tail call i8 @llvm.abs.i8(i8 %3, i1 false)
  %conv.3 = sext i8 %spec.select.i.3 to i32
  %add.3 = add nsw i32 %add.2, %conv.3
  %arrayidx.4 = getelementptr inbounds i8, ptr %a, i64 8
  %4 = load i8, ptr %arrayidx.4, align 1
  %spec.select.i.4 = tail call i8 @llvm.abs.i8(i8 %4, i1 false)
  %conv.4 = sext i8 %spec.select.i.4 to i32
  %add.4 = add nsw i32 %add.3, %conv.4
  %arrayidx.5 = getelementptr inbounds i8, ptr %a, i64 10
  %5 = load i8, ptr %arrayidx.5, align 1
  %spec.select.i.5 = tail call i8 @llvm.abs.i8(i8 %5, i1 false)
  %conv.5 = sext i8 %spec.select.i.5 to i32
  %add.5 = add nsw i32 %add.4, %conv.5
  %arrayidx.6 = getelementptr inbounds i8, ptr %a, i64 12
  %6 = load i8, ptr %arrayidx.6, align 1
  %spec.select.i.6 = tail call i8 @llvm.abs.i8(i8 %6, i1 false)
  %conv.6 = sext i8 %spec.select.i.6 to i32
  %add.6 = add nsw i32 %add.5, %conv.6
  %arrayidx.7 = getelementptr inbounds i8, ptr %a, i64 14
  %7 = load i8, ptr %arrayidx.7, align 1
  %spec.select.i.7 = tail call i8 @llvm.abs.i8(i8 %7, i1 false)
  %conv.7 = sext i8 %spec.select.i.7 to i32
  %add.7 = add nsw i32 %add.6, %conv.7
  ret i32 %add.7
}

define i32 @sum_of_abs_stride_3(ptr noalias %a, ptr noalias %b) {
entry:
  %0 = load i8, ptr %a, align 1
  %spec.select.i = tail call i8 @llvm.abs.i8(i8 %0, i1 false)
  %conv = sext i8 %spec.select.i to i32
  %arrayidx.1 = getelementptr inbounds i8, ptr %a, i64 3
  %1 = load i8, ptr %arrayidx.1, align 1
  %spec.select.i.1 = tail call i8 @llvm.abs.i8(i8 %1, i1 false)
  %conv.1 = sext i8 %spec.select.i.1 to i32
  %add.1 = add nsw i32 %conv, %conv.1
  %arrayidx.2 = getelementptr inbounds i8, ptr %a, i64 6
  %2 = load i8, ptr %arrayidx.2, align 1
  %spec.select.i.2 = tail call i8 @llvm.abs.i8(i8 %2, i1 false)
  %conv.2 = sext i8 %spec.select.i.2 to i32
  %add.2 = add nsw i32 %add.1, %conv.2
  %arrayidx.3 = getelementptr inbounds i8, ptr %a, i64 9
  %3 = load i8, ptr %arrayidx.3, align 1
  %spec.select.i.3 = tail call i8 @llvm.abs.i8(i8 %3, i1 false)
  %conv.3 = sext i8 %spec.select.i.3 to i32
  %add.3 = add nsw i32 %add.2, %conv.3
  %arrayidx.4 = getelementptr inbounds i8, ptr %a, i64 12
  %4 = load i8, ptr %arrayidx.4, align 1
  %spec.select.i.4 = tail call i8 @llvm.abs.i8(i8 %4, i1 false)
  %conv.4 = sext i8 %spec.select.i.4 to i32
  %add.4 = add nsw i32 %add.3, %conv.4
  %arrayidx.5 = getelementptr inbounds i8, ptr %a, i64 15
  %5 = load i8, ptr %arrayidx.5, align 1
  %spec.select.i.5 = tail call i8 @llvm.abs.i8(i8 %5, i1 false)
  %conv.5 = sext i8 %spec.select.i.5 to i32
  %add.5 = add nsw i32 %add.4, %conv.5
  %arrayidx.6 = getelementptr inbounds i8, ptr %a, i64 18
  %6 = load i8, ptr %arrayidx.6, align 1
  %spec.select.i.6 = tail call i8 @llvm.abs.i8(i8 %6, i1 false)
  %conv.6 = sext i8 %spec.select.i.6 to i32
  %add.6 = add nsw i32 %add.5, %conv.6
  %arrayidx.7 = getelementptr inbounds i8, ptr %a, i64 21
  %7 = load i8, ptr %arrayidx.7, align 1
  %spec.select.i.7 = tail call i8 @llvm.abs.i8(i8 %7, i1 false)
  %conv.7 = sext i8 %spec.select.i.7 to i32
  %add.7 = add nsw i32 %add.6, %conv.7
  ret i32 %add.7
}
declare i8 @llvm.abs.i8(i8, i1 immarg)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpsl0s3qp4.ll'
source_filename = "/tmp/tmpsl0s3qp4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define i32 @sum_of_abs_stride_2(ptr noalias %a, ptr noalias %b) #0 {
entry:
  %0 = call <15 x i8> @llvm.masked.load.v15i8.p0(ptr align 1 %a, <15 x i1> <i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true>, <15 x i8> poison)
  %1 = shufflevector <15 x i8> %0, <15 x i8> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %2 = call <8 x i8> @llvm.abs.v8i8(<8 x i8> %1, i1 false)
  %3 = sext <8 x i8> %2 to <8 x i32>
  %4 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %3)
  ret i32 %4
}

define i32 @sum_of_abs_stride_3(ptr noalias %a, ptr noalias %b) #0 {
entry:
  %0 = call <22 x i8> @llvm.masked.load.v22i8.p0(ptr align 1 %a, <22 x i1> <i1 true, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true>, <22 x i8> poison)
  %1 = shufflevector <22 x i8> %0, <22 x i8> poison, <8 x i32> <i32 0, i32 3, i32 6, i32 9, i32 12, i32 15, i32 18, i32 21>
  %2 = call <8 x i8> @llvm.abs.v8i8(<8 x i8> %1, i1 false)
  %3 = sext <8 x i8> %2 to <8 x i32>
  %4 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %3)
  ret i32 %4
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.abs.i8(i8, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <15 x i8> @llvm.masked.load.v15i8.p0(ptr captures(none), <15 x i1>, <15 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i8> @llvm.abs.v8i8(<8 x i8>, i1 immarg) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <22 x i8> @llvm.masked.load.v22i8.p0(ptr captures(none), <22 x i1>, <22 x i8>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
