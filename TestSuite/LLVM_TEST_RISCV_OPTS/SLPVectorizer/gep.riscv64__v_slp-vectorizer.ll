; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/gep.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v -riscv-v-slp-max-vf=0 -S
; Original: RUN: opt < %s -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v  -riscv-v-slp-max-vf=0 -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; This should not be vectorized, as the cost of computing the offsets nullifies
; the benefits of vectorizing:
; copy_with_offset_v2i8:
;         addi    a0, a0, 8
;         vsetivli        zero, 2, e8, mf8, ta, ma
;         vle8.v  v8, (a0)
;         addi    a1, a1, 16
;         vse8.v  v8, (a1)
;         ret
; Compared to the scalar version where the offsets can be folded into the
; addressing mode:
; copy_with_offset_v2i8:
;         lbu     a2, 8(a0)
;         lbu     a0, 9(a0)
;         sb      a2, 16(a1)
;         sb      a0, 17(a1)
;	  ret

define void @copy_with_offset_v2i8(ptr noalias %p, ptr noalias %q) {
entry:
  %p1 = getelementptr i8, ptr %p, i32 8
  %x1 = load i8, ptr %p1
  %q1 = getelementptr i8, ptr %q, i32 16
  store i8 %x1, ptr %q1

  %p2 = getelementptr i8, ptr %p, i32 9
  %x2 = load i8, ptr %p2
  %q2 = getelementptr i8, ptr %q, i32 17
  store i8 %x2, ptr %q2

  ret void
}

; This on the other hand, should be vectorized as the vector savings outweigh
; the GEP costs.
define void @copy_with_offset_v4i8(ptr noalias %p, ptr noalias %q) {
entry:
  %p1 = getelementptr i8, ptr %p, i32 8
  %x1 = load i8, ptr %p1
  %q1 = getelementptr i8, ptr %q, i32 16
  store i8 %x1, ptr %q1

  %p2 = getelementptr i8, ptr %p, i32 9
  %x2 = load i8, ptr %p2
  %q2 = getelementptr i8, ptr %q, i32 17
  store i8 %x2, ptr %q2

  %p3 = getelementptr i8, ptr %p, i32 10
  %x3 = load i8, ptr %p3
  %q3 = getelementptr i8, ptr %q, i32 18
  store i8 %x3, ptr %q3

  %p4 = getelementptr i8, ptr %p, i32 11
  %x4 = load i8, ptr %p4
  %q4 = getelementptr i8, ptr %q, i32 19
  store i8 %x4, ptr %q4

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp669nnzij.ll'
source_filename = "/tmp/tmp669nnzij.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @copy_with_offset_v2i8(ptr noalias %p, ptr noalias %q) #0 {
entry:
  %p1 = getelementptr i8, ptr %p, i32 8
  %x1 = load i8, ptr %p1, align 1
  %q1 = getelementptr i8, ptr %q, i32 16
  store i8 %x1, ptr %q1, align 1
  %p2 = getelementptr i8, ptr %p, i32 9
  %x2 = load i8, ptr %p2, align 1
  %q2 = getelementptr i8, ptr %q, i32 17
  store i8 %x2, ptr %q2, align 1
  ret void
}

define void @copy_with_offset_v4i8(ptr noalias %p, ptr noalias %q) #0 {
entry:
  %p1 = getelementptr i8, ptr %p, i32 8
  %q1 = getelementptr i8, ptr %q, i32 16
  %0 = load <4 x i8>, ptr %p1, align 1
  store <4 x i8> %0, ptr %q1, align 1
  ret void
}

attributes #0 = { "target-features"="+v" }
