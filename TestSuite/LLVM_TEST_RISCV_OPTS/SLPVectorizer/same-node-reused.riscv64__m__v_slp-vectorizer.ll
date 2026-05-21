; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/same-node-reused.ll
; Variant: riscv64_+m,+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=-1 -riscv-v-slp-max-vf=0 -S
; Original: RUN: opt -passes=slp-vectorizer -S -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=-1 -riscv-v-slp-max-vf=0 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %dest, ptr %p) {
entry:
  %inc0 = getelementptr inbounds i16, ptr %p, i64 1
  %inc1 = getelementptr inbounds i16, ptr %p, i64 2
  %inc2 = getelementptr inbounds i16, ptr %p, i64 3
  %e0 = load i16, ptr %p, align 4
  %e1 = load i16, ptr %inc0, align 2
  %e2 = load i16, ptr %inc1, align 2
  %e3 = load i16, ptr %inc2, align 2

  %a0 = add i16 %e0, %e0
  %a1 = add i16 %e2, %e2
  %a2 = add i16 %e2, %e2
  %a3 = add i16 %e2, %e2

  %inc4 = getelementptr inbounds i16, ptr %dest, i64 1
  %inc5 = getelementptr inbounds i16, ptr %dest, i64 2
  %inc6 = getelementptr inbounds i16, ptr %dest, i64 3

  store i16 %a0, ptr %dest, align 4
  store i16 %a1, ptr %inc4, align 2
  store i16 %a2, ptr %inc5, align 2
  store i16 %a3, ptr %inc6, align 2
  ret void
}

define void @test1(ptr %dest, ptr %p) {
entry:
  %inc0 = getelementptr inbounds i16, ptr %p, i64 1
  %inc1 = getelementptr inbounds i16, ptr %p, i64 2
  %inc2 = getelementptr inbounds i16, ptr %p, i64 3
  %e0 = load i16, ptr %p, align 4
  %e1 = load i16, ptr %inc0, align 2
  %e2 = load i16, ptr %inc1, align 2
  %e3 = load i16, ptr %inc2, align 2

  %a0 = add i16 %e0, %e0
  %a1 = shl i16 %e2, 1
  %a2 = shl i16 %e2, 1
  %a3 = shl i16 %e2, 1

  %inc4 = getelementptr inbounds i16, ptr %dest, i64 1
  %inc5 = getelementptr inbounds i16, ptr %dest, i64 2
  %inc6 = getelementptr inbounds i16, ptr %dest, i64 3

  store i16 %a0, ptr %dest, align 4
  store i16 %a1, ptr %inc4, align 2
  store i16 %a2, ptr %inc5, align 2
  store i16 %a3, ptr %inc6, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpxm3jz0lf.ll'
source_filename = "/tmp/tmpxm3jz0lf.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test(ptr %dest, ptr %p) #0 {
entry:
  %inc0 = getelementptr inbounds i16, ptr %p, i64 1
  %inc2 = getelementptr inbounds i16, ptr %p, i64 3
  %e1 = load i16, ptr %inc0, align 2
  %e3 = load i16, ptr %inc2, align 2
  %0 = call <3 x i16> @llvm.masked.load.v3i16.p0(ptr align 4 %p, <3 x i1> <i1 true, i1 false, i1 true>, <3 x i16> poison)
  %1 = shufflevector <3 x i16> %0, <3 x i16> poison, <4 x i32> <i32 0, i32 2, i32 2, i32 2>
  %2 = add <4 x i16> %1, %1
  store <4 x i16> %2, ptr %dest, align 4
  ret void
}

define void @test1(ptr %dest, ptr %p) #0 {
entry:
  %inc0 = getelementptr inbounds i16, ptr %p, i64 1
  %inc2 = getelementptr inbounds i16, ptr %p, i64 3
  %e1 = load i16, ptr %inc0, align 2
  %e3 = load i16, ptr %inc2, align 2
  %0 = call <3 x i16> @llvm.masked.load.v3i16.p0(ptr align 4 %p, <3 x i1> <i1 true, i1 false, i1 true>, <3 x i16> poison)
  %1 = shufflevector <3 x i16> %0, <3 x i16> poison, <4 x i32> <i32 0, i32 2, i32 2, i32 2>
  %2 = add <4 x i16> %1, %1
  store <4 x i16> %2, ptr %dest, align 4
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <3 x i16> @llvm.masked.load.v3i16.p0(ptr captures(none), <3 x i1>, <3 x i16>) #1

attributes #0 = { "target-features"="+m,+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
