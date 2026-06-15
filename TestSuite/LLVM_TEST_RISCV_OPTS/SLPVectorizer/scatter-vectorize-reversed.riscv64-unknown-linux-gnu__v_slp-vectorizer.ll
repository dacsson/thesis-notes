; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/scatter-vectorize-reversed.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -slp-threshold=-11 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -slp-threshold=-11 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <4 x i32> @test(<2 x i64> %v, ptr %p) {
entry:
  %0 = extractelement <2 x i64> %v, i32 1
  %arrayidx127.2 = getelementptr i16, ptr %p, i64 %0
  %1 = load i16, ptr %arrayidx127.2, align 2
  %conv128.2 = zext i16 %1 to i32
  %2 = extractelement <2 x i64> %v, i32 0
  %arrayidx127.3 = getelementptr i16, ptr %p, i64 %2
  %3 = load i16, ptr %arrayidx127.3, align 2
  %conv128.3 = zext i16 %3 to i32
  %4 = insertelement <4 x i32> zeroinitializer, i32 %conv128.2, i32 0
  %5 = insertelement <4 x i32> %4, i32 %conv128.3, i32 1
  ret <4 x i32> %5
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp9b2mxpaz.ll'
source_filename = "/tmp/tmp9b2mxpaz.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define <4 x i32> @test(<2 x i64> %v, ptr %p) #0 {
entry:
  %0 = shufflevector <2 x i64> %v, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  %1 = insertelement <2 x ptr> poison, ptr %p, i32 0
  %2 = shufflevector <2 x ptr> %1, <2 x ptr> poison, <2 x i32> zeroinitializer
  %3 = getelementptr i16, <2 x ptr> %2, <2 x i64> %0
  %4 = call <2 x i16> @llvm.masked.gather.v2i16.v2p0(<2 x ptr> align 2 %3, <2 x i1> splat (i1 true), <2 x i16> poison)
  %5 = zext <2 x i16> %4 to <2 x i32>
  %6 = shufflevector <2 x i32> %5, <2 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %7 = shufflevector <4 x i32> zeroinitializer, <4 x i32> %6, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
  ret <4 x i32> %7
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <2 x i16> @llvm.masked.gather.v2i16.v2p0(<2 x ptr>, <2 x i1>, <2 x i16>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
