; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/fold-equivalent-reduction-cmp.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=vector-combine -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S -passes=vector-combine -mtriple=riscv64 -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i1 @or_eq_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_ne_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @or_slt_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @or_sgt_m1(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @and_eq_allones(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, -1
  ret i1 %cmp
}

define i1 @and_ne_allones(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, -1
  ret i1 %cmp
}

define i1 @and_slt_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @and_sgt_m1(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @or_slt_1(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 1
  ret i1 %cmp
}

define i1 @and_sgt_m2(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -2
  ret i1 %cmp
}

define i1 @umax_eq_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_ne_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_slt_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_sgt_m1(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @umin_eq_allones(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, -1
  ret i1 %cmp
}

define i1 @umin_ne_allones(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, -1
  ret i1 %cmp
}

define i1 @umin_slt_0(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_sgt_m1(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @or_eq_0_i8(<16 x i8> %x) {
  %red = call i8 @llvm.vector.reduce.or.v16i8(<16 x i8> %x)
  %cmp = icmp eq i8 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_0_i64(<2 x i64> %x) {
  %red = call i64 @llvm.vector.reduce.or.v2i64(<2 x i64> %x)
  %cmp = icmp eq i64 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_1(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @and_eq_minus2(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, -2
  ret i1 %cmp
}

define i1 @or_slt_2(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 2
  ret i1 %cmp
}

define i1 @and_sgt_m3(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -3
  ret i1 %cmp
}

define i1 @and_eq_0_negative(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_ult_0_negative(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp ult i32 %red, 1
  ret i1 %cmp
}

define i1 @or_eq_0_multiuse_negative(<4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  call void @use(i32 %red)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_0_scalable_negative(<vscale x 4 x i32> %x) {
  %red = call i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

declare void @use(i32)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp9zjumhg3.ll'
source_filename = "/tmp/tmp9zjumhg3.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i1 @or_eq_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_ne_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @or_slt_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @or_sgt_m1(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @and_eq_allones(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, -1
  ret i1 %cmp
}

define i1 @and_ne_allones(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, -1
  ret i1 %cmp
}

define i1 @and_slt_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @and_sgt_m1(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @or_slt_1(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 1
  ret i1 %cmp
}

define i1 @and_sgt_m2(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -2
  ret i1 %cmp
}

define i1 @umax_eq_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_ne_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_slt_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_sgt_m1(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @umin_eq_allones(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, -1
  ret i1 %cmp
}

define i1 @umin_ne_allones(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp ne i32 %red, -1
  ret i1 %cmp
}

define i1 @umin_slt_0(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_sgt_m1(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @or_eq_0_i8(<16 x i8> %x) #0 {
  %red = call i8 @llvm.vector.reduce.or.v16i8(<16 x i8> %x)
  %cmp = icmp eq i8 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_0_i64(<2 x i64> %x) #0 {
  %red = call i64 @llvm.vector.reduce.or.v2i64(<2 x i64> %x)
  %cmp = icmp eq i64 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_1(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @and_eq_minus2(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, -2
  ret i1 %cmp
}

define i1 @or_slt_2(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %red, 2
  ret i1 %cmp
}

define i1 @and_sgt_m3(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %red, -3
  ret i1 %cmp
}

define i1 @and_eq_0_negative(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_ult_0_negative(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp ult i32 %red, 1
  ret i1 %cmp
}

define i1 @or_eq_0_multiuse_negative(<4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  call void @use(i32 %red)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_0_scalable_negative(<vscale x 4 x i32> %x) #0 {
  %red = call i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32> %x)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

declare void @use(i32) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.and.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.or.v16i8(<16 x i8>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.or.v2i64(<2 x i64>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umax.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umin.v4i32(<4 x i32>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
