; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/strided-stores-vectorized.ll
; Variant: riscv32-unknown-linux_+v_slp-vectorizer_RV32
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv32-unknown-linux -mattr=+v -S
; Original: RUN: opt -passes=slp-vectorizer -S < %s -mtriple=riscv32-unknown-linux -mattr=+v  | FileCheck -check-prefix=RV32 %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @store_reverse(ptr %p3) {
entry:
  %0 = load i64, ptr %p3, align 8
  %arrayidx1 = getelementptr inbounds i64, ptr %p3, i64 8
  %1 = load i64, ptr %arrayidx1, align 8
  %shl = shl i64 %0, %1
  %arrayidx2 = getelementptr inbounds i64, ptr %p3, i64 7
  store i64 %shl, ptr %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds i64, ptr %p3, i64 1
  %2 = load i64, ptr %arrayidx3, align 8
  %arrayidx4 = getelementptr inbounds i64, ptr %p3, i64 9
  %3 = load i64, ptr %arrayidx4, align 8
  %shl5 = shl i64 %2, %3
  %arrayidx6 = getelementptr inbounds i64, ptr %p3, i64 6
  store i64 %shl5, ptr %arrayidx6, align 8
  %arrayidx7 = getelementptr inbounds i64, ptr %p3, i64 2
  %4 = load i64, ptr %arrayidx7, align 8
  %arrayidx8 = getelementptr inbounds i64, ptr %p3, i64 10
  %5 = load i64, ptr %arrayidx8, align 8
  %shl9 = shl i64 %4, %5
  %arrayidx10 = getelementptr inbounds i64, ptr %p3, i64 5
  store i64 %shl9, ptr %arrayidx10, align 8
  %arrayidx11 = getelementptr inbounds i64, ptr %p3, i64 3
  %6 = load i64, ptr %arrayidx11, align 8
  %arrayidx12 = getelementptr inbounds i64, ptr %p3, i64 11
  %7 = load i64, ptr %arrayidx12, align 8
  %shl13 = shl i64 %6, %7
  %arrayidx14 = getelementptr inbounds i64, ptr %p3, i64 4
  store i64 %shl13, ptr %arrayidx14, align 8
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpwdw66kh0.ll'
source_filename = "/tmp/tmpwdw66kh0.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-linux"

define void @store_reverse(ptr %p3) #0 {
entry:
  %arrayidx1 = getelementptr inbounds i64, ptr %p3, i64 8
  %arrayidx2 = getelementptr inbounds i64, ptr %p3, i64 7
  %0 = load <4 x i64>, ptr %p3, align 8
  %1 = load <4 x i64>, ptr %arrayidx1, align 8
  %2 = shl <4 x i64> %0, %1
  call void @llvm.experimental.vp.strided.store.v4i64.p0.i32(<4 x i64> %2, ptr align 8 %arrayidx2, i32 -8, <4 x i1> splat (i1 true), i32 4)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.vp.strided.store.v4i64.p0.i32(<4 x i64>, ptr captures(none), i32, <4 x i1>, i32) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
