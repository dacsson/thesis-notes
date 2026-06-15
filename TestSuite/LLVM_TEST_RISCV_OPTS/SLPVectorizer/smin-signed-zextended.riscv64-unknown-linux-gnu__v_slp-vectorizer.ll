; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/smin-signed-zextended.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S -passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <4 x i32> @test(i16 %0, i16 %1) {
entry:
  %conv13.1.i = zext i16 %1 to i32
  %not.i = xor i32 %conv13.1.i, -1
  %cond19.i = tail call i32 @llvm.smax.i32(i32 %not.i, i32 0)
  %conv21.i = and i32 %cond19.i, 65535
  %not.1.i = xor i32 %conv13.1.i, -1
  %conv15.i = sext i16 %0 to i32
  %cond19.1.i = tail call i32 @llvm.smax.i32(i32 %not.1.i, i32 %conv15.i)
  %conv21.1.i = and i32 %cond19.1.i, 65535
  %not.2.i = xor i32 %conv13.1.i, -1
  %cond19.2.i = tail call i32 @llvm.smax.i32(i32 %not.2.i, i32 %conv15.i)
  %conv21.2.i = and i32 %cond19.2.i, 65535
  %conv13.3.i = zext i16 0 to i32
  %not.3.i = xor i32 %conv13.3.i, -1
  %cond19.3.i = tail call i32 @llvm.smax.i32(i32 %not.3.i, i32 %conv15.i)
  %conv21.3.i = and i32 %cond19.3.i, 65535
  %ins1 = insertelement <4 x i32> poison, i32 %conv21.i, i32 0
  %ins2 = insertelement <4 x i32> %ins1, i32 %conv21.1.i, i32 1
  %ins3 = insertelement <4 x i32> %ins2, i32 %conv21.2.i, i32 2
  %ins4 = insertelement <4 x i32> %ins3, i32 %conv21.3.i, i32 3
  ret <4 x i32> %ins4
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpjzo28i8j.ll'
source_filename = "/tmp/tmpjzo28i8j.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define <4 x i32> @test(i16 %0, i16 %1) #0 {
entry:
  %2 = insertelement <4 x i16> <i16 poison, i16 poison, i16 poison, i16 0>, i16 %1, i32 0
  %3 = shufflevector <4 x i16> %2, <4 x i16> poison, <4 x i32> <i32 0, i32 0, i32 0, i32 3>
  %4 = zext <4 x i16> %3 to <4 x i32>
  %conv15.i = sext i16 %0 to i32
  %5 = xor <4 x i32> %4, splat (i32 -1)
  %6 = insertelement <4 x i32> <i32 0, i32 poison, i32 poison, i32 poison>, i32 %conv15.i, i32 1
  %7 = shufflevector <4 x i32> %6, <4 x i32> poison, <4 x i32> <i32 0, i32 1, i32 1, i32 1>
  %8 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %5, <4 x i32> %7)
  %9 = and <4 x i32> %8, splat (i32 65535)
  ret <4 x i32> %9
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
