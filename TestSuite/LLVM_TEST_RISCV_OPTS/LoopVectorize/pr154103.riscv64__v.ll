; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/pr154103.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64 -mattr=+v < %s -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure we don't duplicate the llvm.masked.sdiv cost in the VPlan cost model.

define void @pr154103(ptr noalias %a, ptr noalias %b, ptr noalias %c, ptr noalias %d) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %latch ]
  %gep = getelementptr i8, ptr %a, i64 %iv
  %x = load i8, ptr %gep, align 1
  %conv = zext i8 %x to i64
  %div = sdiv i64 0, %conv
  %cmp = icmp sgt i64 %div, 0
  br i1 %cmp, label %then, label %latch

then:
  %y = load i8, ptr %b
  %zext = zext i8 %y to i64
  %not = xor i64 %zext, 0
  br label %latch

latch:
  %cond = phi i64 [ %not, %then ], [ 0, %loop ]
  %trunc = trunc i64 %cond to i16
  store i16 %trunc, ptr %c
  store i32 0, ptr %d
  %iv.next = add i64 %iv, 7
  %done = icmp eq i64 %iv, 0
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpkhkjojru.ll'
source_filename = "/tmp/tmpkhkjojru.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @pr154103(ptr noalias %a, ptr noalias %b, ptr noalias %c, ptr noalias %d) #0 {
entry:
  br label %loop

loop:                                             ; preds = %latch, %entry
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %latch ]
  %gep = getelementptr i8, ptr %a, i64 %iv
  %x = load i8, ptr %gep, align 1
  %conv = zext i8 %x to i64
  %div = sdiv i64 0, %conv
  %cmp = icmp sgt i64 %div, 0
  br i1 %cmp, label %then, label %latch

then:                                             ; preds = %loop
  %y = load i8, ptr %b, align 1
  %zext = zext i8 %y to i64
  %not = xor i64 %zext, 0
  br label %latch

latch:                                            ; preds = %then, %loop
  %cond = phi i64 [ %not, %then ], [ 0, %loop ]
  %trunc = trunc i64 %cond to i16
  store i16 %trunc, ptr %c, align 2
  store i32 0, ptr %d, align 4
  %iv.next = add i64 %iv, 7
  %done = icmp eq i64 %iv, 0
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %latch
  ret void
}

attributes #0 = { "target-features"="+v" }
