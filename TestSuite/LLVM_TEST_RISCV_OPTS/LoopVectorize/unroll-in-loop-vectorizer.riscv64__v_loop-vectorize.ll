; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/unroll-in-loop-vectorizer.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=loop-vectorize -scalable-vectorization=off -force-vector-width=1 -S
; Original: RUN: opt -S -mtriple=riscv64 -mattr=+v -passes=loop-vectorize -scalable-vectorization=off -force-vector-width=1 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure we don't unroll scalar loops in the loop vectorizer.
define void @small_loop(ptr nocapture %inArray, i32 %size) {
entry:
  %0 = icmp sgt i32 %size, 0
  br i1 %0, label %loop, label %exit

loop:
  %iv = phi i32 [ %iv1, %loop ], [ 0, %entry ]
  %1 = getelementptr inbounds i32, ptr %inArray, i32 %iv
  %2 = load i32, ptr %1, align 4
  %3 = add nsw i32 %2, 6
  store i32 %3, ptr %1, align 4
  %iv1 = add i32 %iv, 1
  %cond = icmp eq i32 %iv1, %size
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp8o3lkts3.ll'
source_filename = "/tmp/tmp8o3lkts3.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @small_loop(ptr captures(none) %inArray, i32 %size) #0 {
entry:
  %0 = icmp sgt i32 %size, 0
  br i1 %0, label %loop.preheader, label %exit

loop.preheader:                                   ; preds = %entry
  br label %loop

loop:                                             ; preds = %loop.preheader, %loop
  %iv = phi i32 [ %iv1, %loop ], [ 0, %loop.preheader ]
  %1 = getelementptr inbounds i32, ptr %inArray, i32 %iv
  %2 = load i32, ptr %1, align 4
  %3 = add nsw i32 %2, 6
  store i32 %3, ptr %1, align 4
  %iv1 = add i32 %iv, 1
  %cond = icmp eq i32 %iv1, %size
  br i1 %cond, label %exit.loopexit, label %loop

exit.loopexit:                                    ; preds = %loop
  br label %exit

exit:                                             ; preds = %exit.loopexit, %entry
  ret void
}

attributes #0 = { "target-features"="+v" }
