; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/segmented-stores.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -pass-remarks-output= -mcpu=sifive-p670 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -pass-remarks-output=%t -mcpu=sifive-p670 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; YAML-LABEL: --- !Passed
; YAML-NEXT: Pass:            slp-vectorizer
; YAML-NEXT: Name:            StoresVectorized
; YAML-NEXT: Function:        test
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:   - Cost:            '-2'
; YAML-NEXT:   - String:          ' and with tree size '
; YAML-NEXT:   - TreeSize:        '2'
define void @test(ptr %h) {
entry:
  %dct2x211 = alloca [0 x [0 x [8 x i64]]], i32 0, align 16
  %chroma_dc209 = getelementptr i8, ptr %h, i64 0
  %arrayidx30.i = getelementptr i8, ptr %dct2x211, i64 16
  %arrayidx33.i = getelementptr i8, ptr %dct2x211, i64 8
  %arrayidx36.i181 = getelementptr i8, ptr %dct2x211, i64 24
  %0 = load i64, ptr %dct2x211, align 16
  store i64 %0, ptr %chroma_dc209, align 2
  %1 = load i64, ptr %arrayidx30.i, align 4
  %arrayidx3.i224 = getelementptr i8, ptr %h, i64 8
  store i64 %1, ptr %arrayidx3.i224, align 2
  %2 = load i64, ptr %arrayidx33.i, align 2
  %arrayidx5.i226 = getelementptr i8, ptr %h, i64 16
  store i64 %2, ptr %arrayidx5.i226, align 2
  %3 = load i64, ptr %arrayidx36.i181, align 2
  %arrayidx7.i228 = getelementptr i8, ptr %h, i64 24
  store i64 %3, ptr %arrayidx7.i228, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp0vkxryso.ll'
source_filename = "/tmp/tmp0vkxryso.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @test(ptr %h) #0 {
entry:
  %dct2x211 = alloca [0 x [0 x [8 x i64]]], i32 0, align 16
  %chroma_dc209 = getelementptr i8, ptr %h, i64 0
  %0 = load <4 x i64>, ptr %dct2x211, align 16
  %1 = shufflevector <4 x i64> %0, <4 x i64> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  store <4 x i64> %1, ptr %chroma_dc209, align 2
  ret void
}

attributes #0 = { "target-cpu"="sifive-p670" "target-features"="+v" }
