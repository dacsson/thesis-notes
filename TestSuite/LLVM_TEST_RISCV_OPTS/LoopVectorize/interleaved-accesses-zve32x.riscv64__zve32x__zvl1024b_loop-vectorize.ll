; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/interleaved-accesses-zve32x.ll
; Variant: riscv64_+zve32x,+zvl1024b_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+zve32x,+zvl1024b -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv64 -mattr=+zve32x,+zvl1024b -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; This element type isn't a supported SEW so this shouldn't be interleaved
define void @load_store_zve32x(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = shl i64 %i, 1
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp14rggg5r.ll'
source_filename = "/tmp/tmp14rggg5r.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store_zve32x(ptr %p) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %nexti, %loop ]
  %offset0 = shl i64 %i, 1
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0, align 8
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0, align 8
  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1, align 8
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1, align 8
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

attributes #0 = { "target-features"="+zve32x,+zvl1024b" }
