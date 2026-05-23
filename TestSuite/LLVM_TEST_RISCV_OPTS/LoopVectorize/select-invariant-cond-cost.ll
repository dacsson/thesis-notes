; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/select-invariant-cond-cost.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -S
; Original: RUN: opt -p loop-vectorize -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

; Test for https://github.com/llvm/llvm-project/issues/114860.
define void @test_invariant_cond_for_select(ptr %dst, i8 %x) #0 {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %c.1 = icmp eq i8 %x, 0
  %c.2 = icmp sgt i64 %iv, 0
  %c.2.ext = zext i1 %c.2 to i64
  %sel = select i1 %c.1, i64 %c.2.ext, i64 0
  %sel.trunc = trunc i64 %sel to i8
  %gep = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %sel.trunc, ptr %gep, align 1
  %iv.next = add i64 %iv, 4
  %ec = icmp ult i64 %iv, 14
  br i1 %ec, label %loop, label %exit

exit:
  ret void
}

attributes #0 = { "target-features"="+64bit,+v" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpwjfrd7rf.ll'
source_filename = "/tmp/tmpwjfrd7rf.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test_invariant_cond_for_select(ptr %dst, i8 %x) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %c.1 = icmp eq i8 %x, 0
  %c.2 = icmp sgt i64 %iv, 0
  %c.2.ext = zext i1 %c.2 to i64
  %sel = select i1 %c.1, i64 %c.2.ext, i64 0
  %sel.trunc = trunc i64 %sel to i8
  %gep = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %sel.trunc, ptr %gep, align 1
  %iv.next = add i64 %iv, 4
  %ec = icmp ult i64 %iv, 14
  br i1 %ec, label %loop, label %exit

exit:                                             ; preds = %loop
  ret void
}

attributes #0 = { "target-features"="+64bit,+v" }
