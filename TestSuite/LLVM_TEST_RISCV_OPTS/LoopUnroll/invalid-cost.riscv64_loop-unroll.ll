; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopUnroll/RISCV/invalid-cost.ll
; Variant: riscv64_loop-unroll
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -passes=loop-unroll -S
; Original: RUN: opt %s -S -mtriple=riscv64 -passes=loop-unroll | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Demonstrate handling of invalid costs in LoopUnroll.  This test uses
; scalable vectors on RISCV w/o +V to create a situation where a construct
; can not be lowered, and is thus invalid regardless of what the target
; does or does not implement in terms of a cost model.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

define void @invalid(ptr %p) nounwind ssp {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %a = load <vscale x 1 x i8>, ptr %p
  %b = add <vscale x 1 x i8> %a, %a
  store <vscale x 1 x i8> %b, ptr %p
  %inc = add nsw i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}


declare void @f()

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpzbykdhij.ll'
source_filename = "/tmp/tmpzbykdhij.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

; Function Attrs: nounwind ssp
define void @invalid(ptr %p) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %a = load <vscale x 1 x i8>, ptr %p, align 1
  %b = add <vscale x 1 x i8> %a, %a
  store <vscale x 1 x i8> %b, ptr %p, align 1
  %inc = add nsw i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

declare void @f()

attributes #0 = { nounwind ssp }
