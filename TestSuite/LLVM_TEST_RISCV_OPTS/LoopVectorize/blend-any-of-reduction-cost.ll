; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/blend-any-of-reduction-cost.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -S
; Original: RUN: opt -p loop-vectorize -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

; Test case for https://github.com/llvm/llvm-project/issues/111874.
define i32 @any_of_reduction_used_in_blend(ptr %src, i64 %N, i1 %c.0, i1 %c.1) #0 {
entry:
  br label %loop.header

loop.header:
  %any.of.red = phi i32 [ 0, %entry ], [ %any.of.red.next, %loop.latch ]
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c.0, label %loop.latch, label %else.1

else.1:
  br i1 %c.1, label %loop.latch, label %else.2

else.2:
  %l = load ptr, ptr %src, align 8
  %c.2 = icmp eq ptr %l, null
  %sel = select i1 %c.2, i32 0, i32 %any.of.red
  br label %loop.latch

loop.latch:
  %any.of.red.next = phi i32 [ %any.of.red, %loop.header ], [ %any.of.red, %else.1 ], [ %sel, %else.2 ]
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop.header

exit:
  %res = phi i32 [ %any.of.red.next, %loop.latch ]
  ret i32 %res
}

define i32 @any_of_reduction_used_in_blend_with_multiple_phis(ptr %src, i64 %N, i1 %c.0, i1 %c.1) #0 {
entry:
  br label %loop.header

loop.header:
  %any.of.red = phi i32 [ 0, %entry ], [ %any.of.red.next, %loop.latch ]
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c.0, label %x.1, label %else.1

else.1:
  br i1 %c.1, label %x.1, label %else.2

else.2:
  %l = load ptr, ptr %src, align 8
  %c.2 = icmp eq ptr %l, null
  %sel = select i1 %c.2, i32 0, i32 %any.of.red
  br label %loop.latch

x.1:
  %p = phi i32 [ %any.of.red, %loop.header ], [ %any.of.red, %else.1 ]
  br label %loop.latch

loop.latch:
  %any.of.red.next = phi i32 [ %p, %x.1 ], [ %sel, %else.2 ]
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop.header

exit:
  %res = phi i32 [ %any.of.red.next, %loop.latch ]
  ret i32 %res
}

attributes #0 = { "target-cpu"="sifive-p670" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp2gm26o12.ll'
source_filename = "/tmp/tmp2gm26o12.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @any_of_reduction_used_in_blend(ptr %src, i64 %N, i1 %c.0, i1 %c.1) #0 {
entry:
  br label %loop.header

loop.header:                                      ; preds = %loop.latch, %entry
  %any.of.red = phi i32 [ 0, %entry ], [ %any.of.red.next, %loop.latch ]
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c.0, label %loop.latch, label %else.1

else.1:                                           ; preds = %loop.header
  br i1 %c.1, label %loop.latch, label %else.2

else.2:                                           ; preds = %else.1
  %l = load ptr, ptr %src, align 8
  %c.2 = icmp eq ptr %l, null
  %sel = select i1 %c.2, i32 0, i32 %any.of.red
  br label %loop.latch

loop.latch:                                       ; preds = %else.2, %else.1, %loop.header
  %any.of.red.next = phi i32 [ %any.of.red, %loop.header ], [ %any.of.red, %else.1 ], [ %sel, %else.2 ]
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop.header

exit:                                             ; preds = %loop.latch
  %res = phi i32 [ %any.of.red.next, %loop.latch ]
  ret i32 %res
}

define i32 @any_of_reduction_used_in_blend_with_multiple_phis(ptr %src, i64 %N, i1 %c.0, i1 %c.1) #0 {
entry:
  br label %loop.header

loop.header:                                      ; preds = %loop.latch, %entry
  %any.of.red = phi i32 [ 0, %entry ], [ %any.of.red.next, %loop.latch ]
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c.0, label %x.1, label %else.1

else.1:                                           ; preds = %loop.header
  br i1 %c.1, label %x.1, label %else.2

else.2:                                           ; preds = %else.1
  %l = load ptr, ptr %src, align 8
  %c.2 = icmp eq ptr %l, null
  %sel = select i1 %c.2, i32 0, i32 %any.of.red
  br label %loop.latch

x.1:                                              ; preds = %else.1, %loop.header
  %p = phi i32 [ %any.of.red, %loop.header ], [ %any.of.red, %else.1 ]
  br label %loop.latch

loop.latch:                                       ; preds = %x.1, %else.2
  %any.of.red.next = phi i32 [ %p, %x.1 ], [ %sel, %else.2 ]
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop.header

exit:                                             ; preds = %loop.latch
  %res = phi i32 [ %any.of.red.next, %loop.latch ]
  ret i32 %res
}

attributes #0 = { "target-cpu"="sifive-p670" }
