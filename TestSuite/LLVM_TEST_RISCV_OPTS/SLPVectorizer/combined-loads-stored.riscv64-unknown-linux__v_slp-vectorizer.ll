; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/combined-loads-stored.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr noalias %p, ptr %p1) {
  %l1 = load i16, ptr %p, align 2
  %gep1 = getelementptr inbounds i8, ptr %p, i64 2
  %l2 = load i16, ptr %gep1, align 2
  %gep2 = getelementptr inbounds i8, ptr %p, i64 16
  %l3 = load i16, ptr %gep2, align 2
  %gep3 = getelementptr inbounds i8, ptr %p, i64 18
  %l4 = load i16, ptr %gep3, align 2
  store i16 %l1, ptr %p1, align 2
  %geps1 = getelementptr inbounds i8, ptr %p1, i64 2
  store i16 %l2, ptr %geps1, align 2
  %geps2 = getelementptr inbounds i8, ptr %p1, i64 4
  store i16 %l3, ptr %geps2, align 2
  %geps3 = getelementptr inbounds i8, ptr %p1, i64 6
  store i16 %l4, ptr %geps3, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp9xyw2ipd.ll'
source_filename = "/tmp/tmp9xyw2ipd.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @test(ptr noalias %p, ptr %p1) #0 {
  %gep2 = getelementptr inbounds i8, ptr %p, i64 16
  %1 = load <2 x i16>, ptr %p, align 2
  %2 = load <2 x i16>, ptr %gep2, align 2
  %3 = shufflevector <2 x i16> %1, <2 x i16> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %4 = shufflevector <2 x i16> %2, <2 x i16> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %5 = shufflevector <2 x i16> %1, <2 x i16> %2, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  store <4 x i16> %5, ptr %p1, align 2
  ret void
}

attributes #0 = { "target-features"="+v" }
