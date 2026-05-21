; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/load-binop-store.ll
; Variant: riscv64_+m,+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=-1 -riscv-v-slp-max-vf=0 -S
; Original: RUN: opt < %s -passes=slp-vectorizer -mtriple=riscv64 -mattr=+m,+v  -riscv-v-vector-bits-min=-1 -riscv-v-slp-max-vf=0 -S | FileCheck %s --check-prefixes=CHECK

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


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

define void @vec_sub(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %a0 = sub i16 %e0, 17
  %a1 = sub i16 %e1, 17

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

define void @vec_rsub(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %a0 = sub i16 29, %e0
  %a1 = sub i16 29, %e1

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

define void @vec_mul(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %a0 = mul i16 %e0, 7
  %a1 = mul i16 %e1, 7

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

define void @vec_sdiv(ptr %dest, ptr %p) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %a0 = sdiv i16 %e0, 7
  %a1 = sdiv i16 %e1, 7

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

define void @vec_and(ptr %dest, ptr %p, ptr %q) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %f0 = load i16, ptr %q, align 4
  %inq = getelementptr inbounds i16, ptr %q, i64 1
  %f1 = load i16, ptr %inq, align 2

  %a0 = and i16 %e0, %f0
  %a1 = and i16 %e1, %f1

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

define void @vec_or(ptr %dest, ptr %p, ptr %q) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %f0 = load i16, ptr %q, align 4
  %inq = getelementptr inbounds i16, ptr %q, i64 1
  %f1 = load i16, ptr %inq, align 2

  %a0 = or i16 %e0, %f0
  %a1 = or i16 %e1, %f1

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

define void @vec_sll(ptr %dest, ptr %p, ptr %q) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %f0 = load i16, ptr %q, align 4
  %inq = getelementptr inbounds i16, ptr %q, i64 1
  %f1 = load i16, ptr %inq, align 2

  %a0 = shl i16 %e0, %f0
  %a1 = shl i16 %e1, %f1

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

declare i16 @llvm.smin.i16(i16, i16)
define void @vec_smin(ptr %dest, ptr %p, ptr %q) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %f0 = load i16, ptr %q, align 4
  %inq = getelementptr inbounds i16, ptr %q, i64 1
  %f1 = load i16, ptr %inq, align 2

  %a0 = tail call i16 @llvm.smin.i16(i16 %e0, i16 %f0)
  %a1 = tail call i16 @llvm.smin.i16(i16 %e1, i16 %f1)

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

declare i16 @llvm.umax.i16(i16, i16)
define void @vec_umax(ptr %dest, ptr %p, ptr %q) {
entry:
  %e0 = load i16, ptr %p, align 4
  %inc = getelementptr inbounds i16, ptr %p, i64 1
  %e1 = load i16, ptr %inc, align 2

  %f0 = load i16, ptr %q, align 4
  %inq = getelementptr inbounds i16, ptr %q, i64 1
  %f1 = load i16, ptr %inq, align 2

  %a0 = tail call i16 @llvm.umax.i16(i16 %e0, i16 %f0)
  %a1 = tail call i16 @llvm.umax.i16(i16 %e1, i16 %f1)

  store i16 %a0, ptr %dest, align 4
  %inc2 = getelementptr inbounds i16, ptr %dest, i64 1
  store i16 %a1, ptr %inc2, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpdh2wg1wl.ll'
source_filename = "/tmp/tmpdh2wg1wl.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vec_add(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = add <2 x i16> %0, splat (i16 1)
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

define void @vec_sub(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = sub <2 x i16> %0, splat (i16 17)
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

define void @vec_rsub(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = sub <2 x i16> splat (i16 29), %0
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

define void @vec_mul(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = mul <2 x i16> %0, splat (i16 7)
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

define void @vec_sdiv(ptr %dest, ptr %p) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = sdiv <2 x i16> %0, splat (i16 7)
  store <2 x i16> %1, ptr %dest, align 4
  ret void
}

define void @vec_and(ptr %dest, ptr %p, ptr %q) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = load <2 x i16>, ptr %q, align 4
  %2 = and <2 x i16> %0, %1
  store <2 x i16> %2, ptr %dest, align 4
  ret void
}

define void @vec_or(ptr %dest, ptr %p, ptr %q) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = load <2 x i16>, ptr %q, align 4
  %2 = or <2 x i16> %0, %1
  store <2 x i16> %2, ptr %dest, align 4
  ret void
}

define void @vec_sll(ptr %dest, ptr %p, ptr %q) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = load <2 x i16>, ptr %q, align 4
  %2 = shl <2 x i16> %0, %1
  store <2 x i16> %2, ptr %dest, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.smin.i16(i16, i16) #1

define void @vec_smin(ptr %dest, ptr %p, ptr %q) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = load <2 x i16>, ptr %q, align 4
  %2 = call <2 x i16> @llvm.smin.v2i16(<2 x i16> %0, <2 x i16> %1)
  store <2 x i16> %2, ptr %dest, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.umax.i16(i16, i16) #1

define void @vec_umax(ptr %dest, ptr %p, ptr %q) #0 {
entry:
  %0 = load <2 x i16>, ptr %p, align 4
  %1 = load <2 x i16>, ptr %q, align 4
  %2 = call <2 x i16> @llvm.umax.v2i16(<2 x i16> %0, <2 x i16> %1)
  store <2 x i16> %2, ptr %dest, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i16> @llvm.smin.v2i16(<2 x i16>, <2 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i16> @llvm.umax.v2i16(<2 x i16>, <2 x i16>) #2

attributes #0 = { "target-features"="+m,+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+m,+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
