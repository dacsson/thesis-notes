; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/runtime-check-dependent-on-stride.ll
; Variant: riscv64_+v_loop-vectorize_UNIT-STRIDE-MV
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=loop-vectorize -enable-mem-access-versioning=true -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+v -passes=loop-vectorize -S < %s -enable-mem-access-versioning=true  | FileCheck %s --check-prefix=UNIT-STRIDE-MV

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; TODO: Make sure that optimizations (unit-stride multiversioning) don't prohibit vectorization.

define void @foo(ptr %p, ptr %p.strided, i64 %n, i64 %stride) {
entry:
  %add = add nsw nuw i64 %stride, 2
  %mul = mul nsw nuw i64 %add, %add
  %out.offset = add i64 %mul, 16
  %out = getelementptr i64, ptr %p, i64 %out.offset
  br label %header

header:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %header ]
  %iv.next = add nsw i64 %iv, 1
  %idx = mul i64 %iv, %stride

  %gep.ld = getelementptr i64, ptr %p, i64 %iv
  %gep.st = getelementptr i64, ptr %out, i64 %iv
  %gep.strided = getelementptr i64, ptr %p.strided, i64 %idx

  %ld1 = load i64, ptr %gep.ld
  %ld2 = load i64, ptr %gep.strided
  %val = add i64 %ld1, %ld2
  store i64 %val, ptr %gep.st

  %exitcond = icmp slt i64 %iv.next, 64
  br i1 %exitcond, label %header, label %exit

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp1b2kp853.ll'
source_filename = "/tmp/tmp1b2kp853.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @foo(ptr %p, ptr %p.strided, i64 %n, i64 %stride) #0 {
entry:
  %add = add nuw nsw i64 %stride, 2
  %mul = mul nuw nsw i64 %add, %add
  %out.offset = add i64 %mul, 16
  %out = getelementptr i64, ptr %p, i64 %out.offset
  br label %header

header:                                           ; preds = %header, %entry
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %header ]
  %iv.next = add nsw i64 %iv, 1
  %idx = mul i64 %iv, %stride
  %gep.ld = getelementptr i64, ptr %p, i64 %iv
  %gep.st = getelementptr i64, ptr %out, i64 %iv
  %gep.strided = getelementptr i64, ptr %p.strided, i64 %idx
  %ld1 = load i64, ptr %gep.ld, align 8
  %ld2 = load i64, ptr %gep.strided, align 8
  %val = add i64 %ld1, %ld2
  store i64 %val, ptr %gep.st, align 8
  %exitcond = icmp slt i64 %iv.next, 64
  br i1 %exitcond, label %header, label %exit

exit:                                             ; preds = %header
  ret void
}

attributes #0 = { "target-features"="+v" }
