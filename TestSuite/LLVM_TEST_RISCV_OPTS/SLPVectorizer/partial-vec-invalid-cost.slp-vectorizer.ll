; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/partial-vec-invalid-cost.ll
; Variant: slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -S
; Original: RUN: opt < %s -passes=slp-vectorizer -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target triple = "riscv64-unknown-linux-gnu"

define void @partial_vec_invalid_cost() #0 {
entry:

  %lshr.1 = lshr i96 0, 1 ; These ops
  %lshr.2 = lshr i96 0, 0 ; return an
  %add.0 = add i96 0, 0   ; invalid
  %add.1 = add i96 -1, 1   ; vector cost.

  %trunc.i96.1 = trunc i96 %lshr.1 to i32 ; These ops
  %trunc.i96.2 = trunc i96 %lshr.2 to i32 ; return an
  %trunc.i96.3 = trunc i96 %add.0 to i32  ; invalid
  %trunc.i96.4 = trunc i96 %add.1 to i32  ; vector cost.

  %or.0 = or i32 %trunc.i96.1, %trunc.i96.2
  %or.1 = or i32 %or.0, %trunc.i96.3
  %or.2 = or i32 %or.1, %trunc.i96.4

  %zext.0 = zext i1 0 to i32 ; These
  %zext.1 = zext i1 0 to i32 ; ops
  %zext.2 = zext i1 0 to i32 ; are
  %zext.3 = zext i1 0 to i32 ; vectorized

  %or.3 = or i32 %or.2, %zext.0 ; users
  %or.4 = or i32 %or.3, %zext.1 ; of
  %or.5 = or i32 %or.4, %zext.2 ; vectorized
  %or.6 = or i32 %or.5, %zext.3 ; ops

  %store.this = zext i32 %or.6 to i96

  store i96 %store.this, ptr null, align 16
  ret void
}

attributes #0 = { "target-features"="+v" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp3_ro4rtw.ll'
source_filename = "/tmp/tmp3_ro4rtw.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @partial_vec_invalid_cost() #0 {
entry:
  %lshr.1 = lshr i96 0, 1
  %lshr.2 = lshr i96 0, 0
  %add.1 = add i96 -1, 1
  %0 = insertelement <4 x i96> poison, i96 %lshr.1, i32 0
  %1 = insertelement <4 x i96> %0, i96 %lshr.2, i32 1
  %2 = insertelement <4 x i96> %1, i96 0, i32 2
  %3 = insertelement <4 x i96> %2, i96 %add.1, i32 3
  %4 = trunc <4 x i96> %3 to <4 x i32>
  %rdx.op = or <4 x i32> zeroinitializer, %4
  %5 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %rdx.op)
  %store.this = zext i32 %5 to i96
  store i96 %store.this, ptr null, align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
