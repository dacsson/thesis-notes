; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/load-store.ll
; Variant: riscv64_+v_slp-vectorizer_DEFAULT
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v -S | FileCheck %s --check-prefixes=DEFAULT

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @simple_copy(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  store i16 %e0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %e1, ptr %inc2, align 2
  ret void
}

define void @vec_add(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %a0 = add i16 %e0, 1
  %a1 = add i16 %e1, 1

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}


define void @splat_store_i16(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4

  store i16 %e0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %e0, ptr %inc2, align 2
  ret void
}

define void @splat_store_i64(ptr %dest, ptr %p) {
entry:
  %e0 = load i64, ptr %p, align 4

  store i64 %e0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i64, ptr %dest, i64 1
  store i64 %e0, ptr %inc2, align 2
  ret void
}

define void @splat_store_i64_zero(ptr %dest) {
entry:
  store i64 0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i64, ptr %dest, i64 1
  store i64 0, ptr %inc2, align 2
  ret void
}

define void @splat_store_i64_one(ptr %dest) {
entry:
  store i64 1, ptr %dest, align 4
  %inc2 = getelementptr inbounds i64, ptr %dest, i64 1
  store i64 1, ptr %inc2, align 2
  ret void
}

define void @splat_store_i32_zero(ptr %dest) {
entry:
  store i32 0, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 0, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 0, ptr %inc2, align 2
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 0, ptr %inc3, align 2
  ret void
}

define void @splat_store_i32_one(ptr %dest) {
entry:
  store i32 1, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 1, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 1, ptr %inc2, align 2
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 1, ptr %inc3, align 2
  ret void
}

define void @store_stepvector_i32(ptr %dest) {
entry:
  store i32 0, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 1, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 2, ptr %inc2, align 2
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 3, ptr %inc3, align 2
  ret void
}

define void @store_arbitrary_constant_i32(ptr %dest) {
entry:
  store i32 0, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 -33, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 44, ptr %inc2, align 2
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 77, ptr %inc3, align 2
  ret void
}

define void @shared-chain-ordering(ptr %dest, ptr %p, i64 %offset) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2
  %inc1 = getelementptr inbounds i16, ptr %p, i64 2
  %e2 = load i16, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i16, ptr %p, i64 3
  %e3 = load i16, ptr %inc2, align 2

  %incs0 = getelementptr inbounds i16, ptr %dest, i64 %offset
  store i16 %e0, ptr %incs0, align 4
  %incs1 = getelementptr inbounds i16, ptr %incs0, i64 1
  store i16 %e1, ptr %incs1, align 2
  %incs2 = getelementptr inbounds i16, ptr %incs0, i64 2
  store i16 %e2, ptr %incs2, align 2
  %incs3 = getelementptr inbounds i16, ptr %incs0, i64 3
  store i16 %e3, ptr %incs3, align 2

  store i16 %e0, ptr %dest, align 4
  %incs = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %e1, ptr %incs, align 2

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpkbpw3n5z.ll'
source_filename = "/tmp/tmpkbpw3n5z.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @simple_copy(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  store <2 x i16> %0, ptr %dest, align 4
  ret void
}

define void @vec_add(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = add <2 x i16> %0, splat (i16 1)
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

define void @splat_store_i16(ptr %dest, ptr %p) #0 {
entry:
  %e0 = load i16, ptr %p, align 4
  store i16 %e0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %e0, ptr %inc2, align 2
  ret void
}

define void @splat_store_i64(ptr %dest, ptr %p) #0 {
entry:
  %e0 = load i64, ptr %p, align 4
  store i64 %e0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i64, ptr %dest, i64 1
  store i64 %e0, ptr %inc2, align 2
  ret void
}

define void @splat_store_i64_zero(ptr %dest) #0 {
entry:
  store i64 0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i64, ptr %dest, i64 1
  store i64 0, ptr %inc2, align 2
  ret void
}

define void @splat_store_i64_one(ptr %dest) #0 {
entry:
  store i64 1, ptr %dest, align 4
  %inc2 = getelementptr inbounds i64, ptr %dest, i64 1
  store i64 1, ptr %inc2, align 2
  ret void
}

define void @splat_store_i32_zero(ptr %dest) #0 {
entry:
  store <4 x i32> zeroinitializer, ptr %dest, align 4
  ret void
}

define void @splat_store_i32_one(ptr %dest) #0 {
entry:
  store <4 x i32> splat (i32 1), ptr %dest, align 4
  ret void
}

define void @store_stepvector_i32(ptr %dest) #0 {
entry:
  store i32 0, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 1, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 2, ptr %inc2, align 2
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 3, ptr %inc3, align 2
  ret void
}

define void @store_arbitrary_constant_i32(ptr %dest) #0 {
entry:
  store i32 0, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 -33, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 44, ptr %inc2, align 2
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 77, ptr %inc3, align 2
  ret void
}

define void @shared-chain-ordering(ptr %dest, ptr %p, i64 %offset) #0 {
entry:
  %incs0 = getelementptr inbounds i16, ptr %dest, i64 %offset
  %0 = load <4 x i16>, ptr %p, align 4
  store <4 x i16> %0, ptr %incs0, align 4
  %1 = shufflevector <4 x i16> %0, <4 x i16> poison, <2 x i32> <i32 0, i32 1>
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

attributes #0 = { "target-features"="+v" }
