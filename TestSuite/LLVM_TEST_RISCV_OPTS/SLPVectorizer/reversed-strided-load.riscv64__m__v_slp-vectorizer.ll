; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reversed-strided-load.ll
; Variant: riscv64_+m,+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+m,+v -passes=slp-vectorizer -slp-disable-tree-reorder=true -slp-force-strided-loads=true -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+m,+v  -passes=slp-vectorizer  -slp-disable-tree-reorder=true -slp-force-strided-loads=true  -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @const_stride_reversed(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr inbounds i8, ptr %pl, i64 0
  %gep_l1 = getelementptr inbounds i8, ptr %pl, i64 1
  %gep_l2 = getelementptr inbounds i8, ptr %pl, i64 2
  %gep_l3 = getelementptr inbounds i8, ptr %pl, i64 3
  %gep_l4 = getelementptr inbounds i8, ptr %pl, i64 4
  %gep_l5 = getelementptr inbounds i8, ptr %pl, i64 5
  %gep_l6 = getelementptr inbounds i8, ptr %pl, i64 6
  %gep_l7 = getelementptr inbounds i8, ptr %pl, i64 7
  %gep_l8 = getelementptr inbounds i8, ptr %pl, i64 8
  %gep_l9 = getelementptr inbounds i8, ptr %pl, i64 9
  %gep_l10 = getelementptr inbounds i8, ptr %pl, i64 10
  %gep_l11 = getelementptr inbounds i8, ptr %pl, i64 11
  %gep_l12 = getelementptr inbounds i8, ptr %pl, i64 12
  %gep_l13 = getelementptr inbounds i8, ptr %pl, i64 13
  %gep_l14 = getelementptr inbounds i8, ptr %pl, i64 14
  %gep_l15 = getelementptr inbounds i8, ptr %pl, i64 15

  %load0  = load i8, ptr %gep_l0 , align 16
  %load1  = load i8, ptr %gep_l1 , align 16
  %load2  = load i8, ptr %gep_l2 , align 16
  %load3  = load i8, ptr %gep_l3 , align 16
  %load4  = load i8, ptr %gep_l4 , align 16
  %load5  = load i8, ptr %gep_l5 , align 16
  %load6  = load i8, ptr %gep_l6 , align 16
  %load7  = load i8, ptr %gep_l7 , align 16
  %load8  = load i8, ptr %gep_l8 , align 16
  %load9  = load i8, ptr %gep_l9 , align 16
  %load10 = load i8, ptr %gep_l10, align 16
  %load11 = load i8, ptr %gep_l11, align 16
  %load12 = load i8, ptr %gep_l12, align 16
  %load13 = load i8, ptr %gep_l13, align 16
  %load14 = load i8, ptr %gep_l14, align 16
  %load15 = load i8, ptr %gep_l15, align 16

  %gep_s0 = getelementptr inbounds i8, ptr %ps, i64 0
  %gep_s1 = getelementptr inbounds i8, ptr %ps, i64 1
  %gep_s2 = getelementptr inbounds i8, ptr %ps, i64 2
  %gep_s3 = getelementptr inbounds i8, ptr %ps, i64 3
  %gep_s4 = getelementptr inbounds i8, ptr %ps, i64 4
  %gep_s5 = getelementptr inbounds i8, ptr %ps, i64 5
  %gep_s6 = getelementptr inbounds i8, ptr %ps, i64 6
  %gep_s7 = getelementptr inbounds i8, ptr %ps, i64 7
  %gep_s8 = getelementptr inbounds i8, ptr %ps, i64 8
  %gep_s9 = getelementptr inbounds i8, ptr %ps, i64 9
  %gep_s10 = getelementptr inbounds i8, ptr %ps, i64 10
  %gep_s11 = getelementptr inbounds i8, ptr %ps, i64 11
  %gep_s12 = getelementptr inbounds i8, ptr %ps, i64 12
  %gep_s13 = getelementptr inbounds i8, ptr %ps, i64 13
  %gep_s14 = getelementptr inbounds i8, ptr %ps, i64 14
  %gep_s15 = getelementptr inbounds i8, ptr %ps, i64 15

  store i8 %load0, ptr %gep_s15, align 16
  store i8 %load1, ptr %gep_s14, align 16
  store i8 %load2, ptr %gep_s13, align 16
  store i8 %load3, ptr %gep_s12, align 16
  store i8 %load4, ptr %gep_s11, align 16
  store i8 %load5, ptr %gep_s10, align 16
  store i8 %load6, ptr %gep_s9, align 16
  store i8 %load7, ptr %gep_s8, align 16
  store i8 %load8, ptr %gep_s7, align 16
  store i8 %load9, ptr %gep_s6, align 16
  store i8 %load10, ptr %gep_s5, align 16
  store i8 %load11, ptr %gep_s4, align 16
  store i8 %load12, ptr %gep_s3, align 16
  store i8 %load13, ptr %gep_s2, align 16
  store i8 %load14, ptr %gep_s1, align 16
  store i8 %load15, ptr %gep_s0, align 16

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp0b9oth7n.ll'
source_filename = "/tmp/tmp0b9oth7n.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @const_stride_reversed(ptr %pl, ptr %ps) #0 {
  %gep_l15 = getelementptr inbounds i8, ptr %pl, i64 15
  %gep_s0 = getelementptr inbounds i8, ptr %ps, i64 0
  %1 = call <16 x i8> @llvm.experimental.vp.strided.load.v16i8.p0.i64(ptr align 16 %gep_l15, i64 -1, <16 x i1> splat (i1 true), i32 16)
  store <16 x i8> %1, ptr %gep_s0, align 16
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <16 x i8> @llvm.experimental.vp.strided.load.v16i8.p0.i64(ptr captures(none), i64, <16 x i1>, i32) #1

attributes #0 = { "target-features"="+m,+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
