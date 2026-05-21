; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopUnroll/RISCV/unroll-Os.ll
; Variant: riscv64_loop-unroll
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -passes=loop-unroll -S
; Original: RUN: opt < %s -S -mtriple=riscv64 -passes=loop-unroll | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Function Attrs: optsize
define void @foo(ptr %array, i32 %x) #0 {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %array, i64 %indvars.iv
  store i32 %x, ptr %arrayidx, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 4
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

attributes #0 = { optsize }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpcxdzm8an.ll'
source_filename = "/tmp/tmpcxdzm8an.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: optsize
define void @foo(ptr %array, i32 %x) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry
  store i32 %x, ptr %array, align 4
  %arrayidx.1 = getelementptr inbounds i32, ptr %array, i64 1
  store i32 %x, ptr %arrayidx.1, align 4
  %arrayidx.2 = getelementptr inbounds i32, ptr %array, i64 2
  store i32 %x, ptr %arrayidx.2, align 4
  %arrayidx.3 = getelementptr inbounds i32, ptr %array, i64 3
  store i32 %x, ptr %arrayidx.3, align 4
  ret void
}

attributes #0 = { optsize }
