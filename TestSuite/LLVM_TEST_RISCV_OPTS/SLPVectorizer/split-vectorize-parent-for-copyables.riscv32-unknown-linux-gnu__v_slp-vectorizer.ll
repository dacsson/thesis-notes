; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/split-vectorize-parent-for-copyables.ll
; Variant: riscv32-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv32-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv32-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i1 @test(i32 %0, i32 %add21.i, i32 %1) #0 {
entry:
  %2 = sub i32 0, %0
  %diff.check132 = icmp ugt i32 %add21.i, %2
  %3 = shl i32 %0, 1
  %diff.check134 = icmp eq i32 %3, 0
  %conflict.rdx135 = or i1 %diff.check132, %diff.check134
  %4 = sub i32 0, %0
  %diff.check136 = icmp ugt i32 %0, %4
  %conflict.rdx137 = or i1 %conflict.rdx135, %diff.check136
  %diff.check138 = icmp ult i32 %3, %1
  %conflict.rdx139 = or i1 %conflict.rdx137, %diff.check138
  %diff.check140 = icmp ugt i32 %0, %2
  %conflict.rdx141 = or i1 %conflict.rdx139, %diff.check140
  %5 = mul i32 %0, %0
  %diff.check142 = icmp eq i32 %5, 0
  %conflict.rdx143 = or i1 %conflict.rdx141, %diff.check142
  %6 = sub i32 0, %0
  %diff.check146 = icmp ugt i32 %0, %6
  %conflict.rdx147 = or i1 %conflict.rdx143, %diff.check146
  %diff.check148 = icmp ult i32 %3, %add21.i
  %conflict.rdx149 = or i1 %conflict.rdx147, %diff.check148
  ret i1 %conflict.rdx149
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpt_m9g8r2.ll'
source_filename = "/tmp/tmpt_m9g8r2.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-linux-gnu"

define i1 @test(i32 %0, i32 %add21.i, i32 %1) #0 {
entry:
  %2 = insertelement <4 x i32> poison, i32 %0, i32 0
  %3 = shufflevector <4 x i32> %2, <4 x i32> poison, <4 x i32> zeroinitializer
  %4 = sub <4 x i32> zeroinitializer, %3
  %5 = shl i32 %0, 1
  %diff.check134 = icmp eq i32 %5, 0
  %diff.check138 = icmp ult i32 %5, %1
  %6 = mul i32 %0, %0
  %diff.check142 = icmp eq i32 %6, 0
  %7 = insertelement <4 x i32> poison, i32 %add21.i, i32 0
  %8 = shufflevector <4 x i32> %3, <4 x i32> %7, <4 x i32> <i32 4, i32 1, i32 2, i32 3>
  %9 = icmp ugt <4 x i32> %8, %4
  %diff.check148 = icmp ult i32 %5, %add21.i
  %10 = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %9)
  %op.rdx = or i1 %10, %diff.check138
  %op.rdx1 = or i1 %diff.check148, %diff.check134
  %op.rdx2 = or i1 %op.rdx, %op.rdx1
  %op.rdx3 = or i1 %op.rdx2, %diff.check142
  ret i1 %op.rdx3
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.v4i1(<4 x i1>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
