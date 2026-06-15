; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopStrengthReduce/RISCV/term-fold-crash.ll
; Variant: riscv64-unknown-linux-gnu_loop-reduce,loop-term-fold
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-reduce,loop-term-fold -mtriple=riscv64-unknown-linux-gnu -S
; Original: RUN: opt -S -passes=loop-reduce,loop-term-fold -mtriple=riscv64-unknown-linux-gnu < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %p, i8 %arg, i32 %start) {
entry:
  %conv = zext i8 %arg to i32
  %shr = lshr i32 %conv, 1
  %wide.trip.count = zext nneg i32 %shr to i64
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %add810 = phi i32 [ %start, %entry ], [ %add, %for.body ]
  %idxprom2 = zext i32 %add810 to i64
  %arrayidx3 = getelementptr i8, ptr %p, i64 %idxprom2
  %v = load i8, ptr %arrayidx3, align 1
  %add = add i32 %add810, 1
  %indvars.iv.next = add i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv, %wide.trip.count
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpgcjau_vj.ll'
source_filename = "/tmp/tmpgcjau_vj.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(ptr %p, i8 %arg, i32 %start) {
entry:
  %conv = zext i8 %arg to i32
  %shr = lshr i32 %conv, 1
  %0 = add i32 %start, %shr
  %1 = add i32 %0, 1
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %add810 = phi i32 [ %start, %entry ], [ %add, %for.body ]
  %idxprom2 = zext i32 %add810 to i64
  %arrayidx3 = getelementptr i8, ptr %p, i64 %idxprom2
  %v = load i8, ptr %arrayidx3, align 1
  %add = add i32 %add810, 1
  %lsr_fold_term_cond.replaced_term_cond = icmp eq i32 %add, %1
  br i1 %lsr_fold_term_cond.replaced_term_cond, label %exit, label %for.body

exit:                                             ; preds = %for.body
  ret void
}
