; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/vec15-base.ll
; Variant: riscv64_+v_slp-vectorizer_POW2-ONLY
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2=false -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2=false -mtriple=riscv64 -mattr=+v -S %s | FileCheck --check-prefixes=POW2-ONLY %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @v15_load_i8_mul_by_constant_store(ptr %src, ptr noalias %dst) {
entry:
  %gep.src.0 = getelementptr inbounds i8, ptr %src, i8 0
  %l.src.0 = load i8, ptr %gep.src.0, align 4
  %mul.0 = mul nsw i8 %l.src.0, 10
  store i8 %mul.0, ptr %dst

  %gep.src.1 = getelementptr inbounds i8, ptr %src, i8 1
  %l.src.1 = load i8, ptr %gep.src.1, align 4
  %mul.1 = mul nsw i8 %l.src.1, 10
  %dst.1 = getelementptr i8, ptr %dst, i8 1
  store i8 %mul.1, ptr %dst.1

  %gep.src.2 = getelementptr inbounds i8, ptr %src, i8 2
  %l.src.2 = load i8, ptr %gep.src.2, align 4
  %mul.2 = mul nsw i8 %l.src.2, 10
  %dst.2 = getelementptr i8, ptr %dst, i8 2
  store i8 %mul.2, ptr %dst.2

  %gep.src.3 = getelementptr inbounds i8, ptr %src, i8 3
  %l.src.3 = load i8, ptr %gep.src.3, align 4
  %mul.3 = mul nsw i8 %l.src.3, 10
  %dst.3 = getelementptr i8, ptr %dst, i8 3
  store i8 %mul.3, ptr %dst.3

  %gep.src.4 = getelementptr inbounds i8, ptr %src, i8 4
  %l.src.4 = load i8, ptr %gep.src.4, align 4
  %mul.4 = mul nsw i8 %l.src.4, 10
  %dst.4 = getelementptr i8, ptr %dst, i8 4
  store i8 %mul.4, ptr %dst.4

  %gep.src.5 = getelementptr inbounds i8, ptr %src, i8 5
  %l.src.5 = load i8, ptr %gep.src.5, align 4
  %mul.5 = mul nsw i8 %l.src.5, 10
  %dst.5 = getelementptr i8, ptr %dst, i8 5
  store i8 %mul.5, ptr %dst.5

  %gep.src.6 = getelementptr inbounds i8, ptr %src, i8 6
  %l.src.6 = load i8, ptr %gep.src.6, align 4
  %mul.6 = mul nsw i8 %l.src.6, 10
  %dst.6 = getelementptr i8, ptr %dst, i8 6
  store i8 %mul.6, ptr %dst.6

  %gep.src.7 = getelementptr inbounds i8, ptr %src, i8 7
  %l.src.7 = load i8, ptr %gep.src.7, align 4
  %mul.7 = mul nsw i8 %l.src.7, 10
  %dst.7 = getelementptr i8, ptr %dst, i8 7
  store i8 %mul.7, ptr %dst.7

  %gep.src.8 = getelementptr inbounds i8, ptr %src, i8 8
  %l.src.8 = load i8, ptr %gep.src.8, align 4
  %mul.8 = mul nsw i8 %l.src.8, 10
  %dst.8 = getelementptr i8, ptr %dst, i8 8
  store i8 %mul.8, ptr %dst.8

  %gep.src.9 = getelementptr inbounds i8, ptr %src, i8 9
  %l.src.9 = load i8, ptr %gep.src.9, align 4
  %mul.9 = mul nsw i8 %l.src.9, 10
  %dst.9 = getelementptr i8, ptr %dst, i8 9
  store i8 %mul.9, ptr %dst.9

  %gep.src.10 = getelementptr inbounds i8, ptr %src, i8 10
  %l.src.10 = load i8, ptr %gep.src.10, align 4
  %mul.10 = mul nsw i8 %l.src.10, 10
  %dst.10 = getelementptr i8, ptr %dst, i8 10
  store i8 %mul.10, ptr %dst.10

  %gep.src.11 = getelementptr inbounds i8, ptr %src, i8 11
  %l.src.11 = load i8, ptr %gep.src.11, align 4
  %mul.11 = mul nsw i8 %l.src.11, 10
  %dst.11 = getelementptr i8, ptr %dst, i8 11
  store i8 %mul.11, ptr %dst.11

  %gep.src.12 = getelementptr inbounds i8, ptr %src, i8 12
  %l.src.12 = load i8, ptr %gep.src.12, align 4
  %mul.12 = mul nsw i8 %l.src.12, 10
  %dst.12 = getelementptr i8, ptr %dst, i8 12
  store i8 %mul.12, ptr %dst.12

  %gep.src.13 = getelementptr inbounds i8, ptr %src, i8 13
  %l.src.13 = load i8, ptr %gep.src.13, align 4
  %mul.13 = mul nsw i8 %l.src.13, 10
  %dst.13 = getelementptr i8, ptr %dst, i8 13
  store i8 %mul.13, ptr %dst.13

  %gep.src.14 = getelementptr inbounds i8, ptr %src, i8 14
  %l.src.14 = load i8, ptr %gep.src.14, align 4
  %mul.14 = mul nsw i8 %l.src.14, 10
  %dst.14 = getelementptr i8, ptr %dst, i8 14
  store i8 %mul.14, ptr %dst.14

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp5g4plst6.ll'
source_filename = "/tmp/tmp5g4plst6.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @v15_load_i8_mul_by_constant_store(ptr %src, ptr noalias %dst) #0 {
entry:
  %gep.src.0 = getelementptr inbounds i8, ptr %src, i8 0
  %0 = load <8 x i8>, ptr %gep.src.0, align 4
  %1 = mul nsw <8 x i8> %0, splat (i8 10)
  store <8 x i8> %1, ptr %dst, align 1
  %gep.src.8 = getelementptr inbounds i8, ptr %src, i8 8
  %dst.8 = getelementptr i8, ptr %dst, i8 8
  %2 = load <4 x i8>, ptr %gep.src.8, align 4
  %3 = mul nsw <4 x i8> %2, splat (i8 10)
  store <4 x i8> %3, ptr %dst.8, align 1
  %gep.src.12 = getelementptr inbounds i8, ptr %src, i8 12
  %dst.12 = getelementptr i8, ptr %dst, i8 12
  %4 = load <2 x i8>, ptr %gep.src.12, align 4
  %5 = mul nsw <2 x i8> %4, splat (i8 10)
  store <2 x i8> %5, ptr %dst.12, align 1
  %gep.src.14 = getelementptr inbounds i8, ptr %src, i8 14
  %l.src.14 = load i8, ptr %gep.src.14, align 4
  %mul.14 = mul nsw i8 %l.src.14, 10
  %dst.14 = getelementptr i8, ptr %dst, i8 14
  store i8 %mul.14, ptr %dst.14, align 1
  ret void
}

attributes #0 = { "target-features"="+v" }
