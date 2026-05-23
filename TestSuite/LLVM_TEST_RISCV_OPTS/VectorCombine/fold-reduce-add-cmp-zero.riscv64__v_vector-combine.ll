; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/fold-reduce-add-cmp-zero.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=vector-combine -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S -passes=vector-combine -mtriple=riscv64 -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i1 @nn_zext_eq_0(<4 x i1> %a, <4 x i1> %b) {
  %za = zext <4 x i1> %a to <4 x i32>
  %zb = zext <4 x i1> %b to <4 x i32>
  %add = add nuw <4 x i32> %za, %zb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @np_sext_eq_0(<4 x i1> %a, <4 x i1> %b) {
  %sa = sext <4 x i1> %a to <4 x i32>
  %sb = sext <4 x i1> %b to <4 x i32>
  %add = add nsw <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @np_sext_ne_0(<4 x i1> %a, <4 x i1> %b) {
  %sa = sext <4 x i1> %a to <4 x i32>
  %sb = sext <4 x i1> %b to <4 x i32>
  %add = add nsw <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

; Tautological: NN tree + sge 0 is always true; the fold must not rewrite
; the predicate into a non-tautological form.
define i1 @nn_sge_0_tautological(<4 x i1> %a, <4 x i1> %b) {
  %za = zext <4 x i1> %a to <4 x i32>
  %zb = zext <4 x i1> %b to <4 x i32>
  %add = add nuw <4 x i32> %za, %zb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp sge i32 %red, 0
  ret i1 %cmp
}

define i1 @np_sle_0_tautological(<4 x i1> %a, <4 x i1> %b) {
  %sa = sext <4 x i1> %a to <4 x i32>
  %sb = sext <4 x i1> %b to <4 x i32>
  %add = add nsw <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp sle i32 %red, 0
  ret i1 %cmp
}

define i1 @mixed_sign_bail(<4 x i1> %a, <4 x i1> %b) {
  %sa = sext <4 x i1> %a to <4 x i32>
  %zb = zext <4 x i1> %b to <4 x i32>
  %add = add <4 x i32> %sa, %zb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp42v2pwnh.ll'
source_filename = "/tmp/tmp42v2pwnh.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i1 @nn_zext_eq_0(<4 x i1> %a, <4 x i1> %b) #0 {
  %za = zext <4 x i1> %a to <4 x i32>
  %zb = zext <4 x i1> %b to <4 x i32>
  %add = add nuw <4 x i32> %za, %zb
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %add)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @np_sext_eq_0(<4 x i1> %a, <4 x i1> %b) #0 {
  %sa = sext <4 x i1> %a to <4 x i32>
  %sb = sext <4 x i1> %b to <4 x i32>
  %add = add nsw <4 x i32> %sa, %sb
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %add)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @np_sext_ne_0(<4 x i1> %a, <4 x i1> %b) #0 {
  %sa = sext <4 x i1> %a to <4 x i32>
  %sb = sext <4 x i1> %b to <4 x i32>
  %add = add nsw <4 x i32> %sa, %sb
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %add)
  %cmp = icmp ne i32 %1, 0
  ret i1 %cmp
}

define i1 @nn_sge_0_tautological(<4 x i1> %a, <4 x i1> %b) #0 {
  %za = zext <4 x i1> %a to <4 x i32>
  %zb = zext <4 x i1> %b to <4 x i32>
  %add = add nuw <4 x i32> %za, %zb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp sge i32 %red, 0
  ret i1 %cmp
}

define i1 @np_sle_0_tautological(<4 x i1> %a, <4 x i1> %b) #0 {
  %sa = sext <4 x i1> %a to <4 x i32>
  %sb = sext <4 x i1> %b to <4 x i32>
  %add = add nsw <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp sle i32 %red, 0
  ret i1 %cmp
}

define i1 @mixed_sign_bail(<4 x i1> %a, <4 x i1> %b) #0 {
  %sa = sext <4 x i1> %a to <4 x i32>
  %zb = zext <4 x i1> %b to <4 x i32>
  %add = add <4 x i32> %sa, %zb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %add)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
