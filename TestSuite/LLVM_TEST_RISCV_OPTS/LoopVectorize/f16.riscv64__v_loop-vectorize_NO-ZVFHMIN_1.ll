; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/f16.ll
; Variant: riscv64_+v_loop-vectorize_NO-ZVFHMIN_1
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v -tail-folding-policy=dont-fold-tail -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v -S -tail-folding-policy=dont-fold-tail | FileCheck %s -check-prefix=NO-ZVFHMIN

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @fadd(ptr noalias %a, ptr noalias %b, i64 %n) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%i.next, %loop]
  %a.gep = getelementptr half, ptr %a, i64 %i
  %b.gep = getelementptr half, ptr %b, i64 %i
  %x = load half, ptr %a.gep
  %y = load half, ptr %b.gep
  %z = fadd half %x, %y
  store half %z, ptr %a.gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp8ls1z937.ll'
source_filename = "/tmp/tmp8ls1z937.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @fadd(ptr noalias %a, ptr noalias %b, i64 %n) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %a.gep = getelementptr half, ptr %a, i64 %i
  %b.gep = getelementptr half, ptr %b, i64 %i
  %x = load half, ptr %a.gep, align 2
  %y = load half, ptr %b.gep, align 2
  %z = fadd half %x, %y
  store half %z, ptr %a.gep, align 2
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

attributes #0 = { "target-features"="+v" }
