; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-gather-scatter.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @gather_scatter(ptr noalias %in, ptr noalias %out, ptr noalias %index, i64 %n) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx3 = getelementptr inbounds i32, ptr %index, i64 %indvars.iv
  %0 = load i64, ptr %arrayidx3, align 8
  %arrayidx5 = getelementptr inbounds float, ptr %in, i64 %0
  %1 = load float, ptr %arrayidx5, align 4
  %arrayidx7 = getelementptr inbounds float, ptr %out, i64 %0
  store float %1, ptr %arrayidx7, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp19kj4aga.ll'
source_filename = "/tmp/tmp19kj4aga.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @gather_scatter(ptr noalias %in, ptr noalias %out, ptr noalias %index, i64 %n) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx3 = getelementptr inbounds i32, ptr %index, i64 %indvars.iv
  %0 = load i64, ptr %arrayidx3, align 8
  %arrayidx5 = getelementptr inbounds float, ptr %in, i64 %0
  %1 = load float, ptr %arrayidx5, align 4
  %arrayidx7 = getelementptr inbounds float, ptr %out, i64 %0
  store float %1, ptr %arrayidx7, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

attributes #0 = { "target-features"="+v" }
