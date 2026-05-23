; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/getpointerschaincost.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -riscv-v-slp-max-vf=0 -passes=slp-vectorizer -pass-remarks-output= -S
; Original: RUN: opt -S -mtriple=riscv64 -mattr=+v -riscv-v-slp-max-vf=0 -passes=slp-vectorizer -pass-remarks-output=%t < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Because all of these addresses are foldable, the scalar cost should be 0 when
; computing the pointers chain cost.
; TODO: These are currently costed as free the indices are all constants, but we
; should check if the constants are actually foldable
define void @f(ptr %dest, i64 %i) {
entry:
  %p1 = getelementptr i32, ptr %dest, i32 0
  store i32 1, ptr %p1
  %p2 = getelementptr i32, ptr %dest, i32 1
  store i32 1, ptr %p2
  %p3 = getelementptr i32, ptr %dest, i32 2
  store i32 1, ptr %p3
  %p4 = getelementptr i32, ptr %dest, i32 3
  store i32 1, ptr %p4
  ret void
}

; When computing the scalar pointers chain cost here, there is a cost of 1 for
; the base pointer, and the rest can be folded in, so the scalar cost should be
; 1.
; TODO: These are currently costed as free the indices are all constants, but we
; should check if the constants are actually foldable
define void @g(ptr %dest, i64 %i) {
entry:
  %p1 = getelementptr i32, ptr %dest, i32 2048
  store i32 1, ptr %p1
  %p2 = getelementptr i32, ptr %dest, i32 2049
  store i32 1, ptr %p2
  %p3 = getelementptr i32, ptr %dest, i32 2050
  store i32 1, ptr %p3
  %p4 = getelementptr i32, ptr %dest, i32 2051
  store i32 1, ptr %p4
  ret void
}

; When computing the scalar pointers chain cost here, there is a cost of
; 1 for the base pointer, and the rest can be folded in, so the scalar cost
; should be 1.
define void @h(ptr %dest, i32 %i) {
entry:
  %p1 = getelementptr [4 x i32], ptr %dest, i32 %i, i32 0
  store i32 1, ptr %p1
  %p2 = getelementptr [4 x i32], ptr %dest, i32 %i, i32 1
  store i32 1, ptr %p2
  %p3 = getelementptr [4 x i32], ptr %dest, i32 %i, i32 2
  store i32 1, ptr %p3
  %p4 = getelementptr [4 x i32], ptr %dest, i32 %i, i32 3
  store i32 1, ptr %p4
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpatd2di50.ll'
source_filename = "/tmp/tmpatd2di50.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @f(ptr %dest, i64 %i) #0 {
entry:
  %p1 = getelementptr i32, ptr %dest, i32 0
  store <4 x i32> splat (i32 1), ptr %p1, align 4
  ret void
}

define void @g(ptr %dest, i64 %i) #0 {
entry:
  %p1 = getelementptr i32, ptr %dest, i32 2048
  store <4 x i32> splat (i32 1), ptr %p1, align 4
  ret void
}

define void @h(ptr %dest, i32 %i) #0 {
entry:
  %p1 = getelementptr [4 x i32], ptr %dest, i32 %i, i32 0
  store <4 x i32> splat (i32 1), ptr %p1, align 4
  ret void
}

attributes #0 = { "target-features"="+v" }
