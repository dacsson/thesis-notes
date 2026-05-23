; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/smax-unsigned-operand.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@e = global [2 x i8] zeroinitializer

define void @main(ptr noalias %p) {
bb:
  %conv.4 = zext i32 0 to i64
  %cond.4 = tail call i64 @llvm.smax.i64(i64 %conv.4, i64 0)
  %conv5.4 = trunc i64 %cond.4 to i8
  store i8 %conv5.4, ptr getelementptr inbounds ([11 x i8], ptr @e, i64 0, i64 4), align 1
  %0 = load i32, ptr %p, align 4
  %conv.5 = zext i32 %0 to i64
  %cond.5 = tail call i64 @llvm.smax.i64(i64 %conv.5, i64 1)
  %conv5.5 = trunc i64 %cond.5 to i8
  store i8 %conv5.5, ptr getelementptr inbounds ([11 x i8], ptr @e, i64 0, i64 5), align 1
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmph2wl1euz.ll'
source_filename = "/tmp/tmph2wl1euz.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@e = global [2 x i8] zeroinitializer

define void @main(ptr noalias %p) #0 {
bb:
  %conv.4 = zext i32 0 to i64
  %cond.4 = tail call i64 @llvm.smax.i64(i64 %conv.4, i64 0)
  %conv5.4 = trunc i64 %cond.4 to i8
  store i8 %conv5.4, ptr getelementptr inbounds ([11 x i8], ptr @e, i64 0, i64 4), align 1
  %0 = load i32, ptr %p, align 4
  %conv.5 = zext i32 %0 to i64
  %cond.5 = tail call i64 @llvm.smax.i64(i64 %conv.5, i64 1)
  %conv5.5 = trunc i64 %cond.5 to i8
  store i8 %conv5.5, ptr getelementptr inbounds ([11 x i8], ptr @e, i64 0, i64 5), align 1
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
