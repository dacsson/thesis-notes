; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopRotate/RISCV/invalid-cost.ll
; Variant: loop-rotate
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-rotate -verify-memoryssa -S
; Original: RUN: opt -S -passes=loop-rotate -verify-memoryssa < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Demonstrate handling of invalid costs in LoopRotate.  This test uses
; scalable vectors on RISCV w/o +V to create a situation where a construct
; can not be lowered, and is thus invalid regardless of what the target
; does or does not implement in terms of a cost model.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

define void @valid() nounwind ssp {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end


for.body:                                         ; preds = %for.cond
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Despite having an invalid cost, we can rotate this because we don't
; need to duplicate any instructions or execute them more frequently.
define void @invalid_no_dup(ptr %p) nounwind ssp {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end


for.body:                                         ; preds = %for.cond
  %a = load <vscale x 1 x i8>, ptr %p
  %b = add <vscale x 1 x i8> %a, %a
  store <vscale x 1 x i8> %b, ptr %p
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; This demonstrates a case where a) loop rotate needs a cost estimate to
; know if rotation is profitable, and b) there is no cost estimate available
; due to invalid costs in the loop.  We can't rotate this loop.
define void @invalid_dup_required(ptr %p) nounwind ssp {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %a = load <vscale x 1 x i8>, ptr %p
  %b = add <vscale x 1 x i8> %a, %a
  store <vscale x 1 x i8> %b, ptr %p
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end


for.body:                                         ; preds = %for.cond
  call void @f()
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare void @f()

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp1rb31udw.ll'
source_filename = "/tmp/tmp1rb31udw.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

; Function Attrs: nounwind ssp
define void @valid() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.cond ]
  %cmp = icmp slt i32 %i.0, 100
  %inc = add nsw i32 %i.0, 1
  br i1 %cmp, label %for.cond, label %for.end

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind ssp
define void @invalid_no_dup(ptr %p) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.01 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %a = load <vscale x 1 x i8>, ptr %p, align 1
  %b = add <vscale x 1 x i8> %a, %a
  store <vscale x 1 x i8> %b, ptr %p, align 1
  %inc = add nsw i32 %i.01, 1
  %cmp = icmp slt i32 %inc, 100
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: nounwind ssp
define void @invalid_dup_required(ptr %p) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %a = load <vscale x 1 x i8>, ptr %p, align 1
  %b = add <vscale x 1 x i8> %a, %a
  store <vscale x 1 x i8> %b, ptr %p, align 1
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @f()
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare void @f()

attributes #0 = { nounwind ssp }
