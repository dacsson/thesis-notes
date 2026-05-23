; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/icmp-vector-reduce.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=vector-combine -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=vector-combine -S -mtriple=riscv64 -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i1 @or_zext(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_zext_i3(<4 x i3> %x) {
  %zext = zext <4 x i3> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_zext_v3_costly(<3 x i8> %x) {
  %zext = zext <3 x i8> %x to <3 x i32>
  %red = call i32 @llvm.vector.reduce.or.v3i32(<3 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_sext(<4 x i16> %x) {
  %sext = sext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %sext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_neg(<4 x i32> %x) {
  %neg = sub <4 x i32> zeroinitializer, %x
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_mul(<4 x i32> %x) {
  %mul = mul nuw <4 x i32> %x, splat (i32 7)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_shl(<4 x i32> %x, <4 x i32> %y) {
  %shl = shl nuw <4 x i32> %x, %y
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_zext(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_sext(<4 x i16> %x) {
  %sext = sext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %sext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_neg(<4 x i32> %x) {
  %neg = sub <4 x i32> zeroinitializer, %x
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_mul(<4 x i32> %x) {
  %mul = mul nuw <4 x i32> %x, splat (i32 7)
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_shl(<4 x i32> %x, <4 x i32> %y) {
  %shl = shl nuw <4 x i32> %x, %y
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_zext(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_sext(<4 x i16> %x) {
  %sext = sext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %sext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_neg(<4 x i32> %x) {
  %neg = sub <4 x i32> zeroinitializer, %x
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_mul(<4 x i32> %x) {
  %mul = mul nuw <4 x i32> %x, splat (i32 7)
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_shl(<4 x i32> %x, <4 x i32> %y) {
  %shl = shl nuw <4 x i32> %x, %y
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smin_zext(<4 x i16> %x) {
  %and = and <4 x i16> %x, splat (i16 32767)
  %zext = zext <4 x i16> %and to <4 x i32>
  %red = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smin_sext(<4 x i16> %x) {
  %and = and <4 x i16> %x, splat (i16 32767)
  %sext = sext <4 x i16> %and to <4 x i32>
  %red = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %sext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smin_neg(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %neg = sub nsw <4 x i32> zeroinitializer, %zext
  %red = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smin_mul(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw nsw <4 x i32> %zext, splat (i32 7)
  %red = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smin_shl(<4 x i16> %x, <4 x i32> %y) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nuw nsw <4 x i32> %zext, %ymasked
  %red = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smax_zext(<4 x i16> %x) {
  %and = and <4 x i16> %x, splat (i16 32767)
  %zext = zext <4 x i16> %and to <4 x i32>
  %red = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smax_sext(<4 x i16> %x) {
  %and = and <4 x i16> %x, splat (i16 32767)
  %sext = sext <4 x i16> %and to <4 x i32>
  %red = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %sext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smax_neg(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %neg = sub nsw <4 x i32> zeroinitializer, %zext
  %red = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smax_mul(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw nsw <4 x i32> %zext, splat (i32 7)
  %red = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smax_shl(<4 x i16> %x, <4 x i32> %y) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nuw nsw <4 x i32> %zext, %ymasked
  %red = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_zext(<4 x i16> %x) {
  %and = and <4 x i16> %x, splat (i16 8191)
  %zext = zext <4 x i16> %and to <4 x i32>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_sext(<4 x i16> %x) {
  %and = and <4 x i16> %x, splat (i16 8191)
  %sext = sext <4 x i16> %and to <4 x i32>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sext)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_neg(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %neg = sub nsw <4 x i32> zeroinitializer, %zext
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, splat (i32 7)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_shl(<4 x i16> %x, <4 x i32> %y) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nuw <4 x i32> %zext, %ymasked
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_shl_ne(<4 x i16> %x, <4 x i32> %y) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nuw <4 x i32> %zext, %ymasked
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @add_shl_negative(<4 x i32> %x, <4 x i32> %y) {
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nsw <4 x i32> %x, %ymasked
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_shl_nonzero_cmp(<4 x i16> %x, <4 x i32> %y) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nsw <4 x i32> %zext, %ymasked
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 42
  ret i1 %cmp
}

define i1 @add_shl_multiuse(<4 x i16> %x, <4 x i32> %y, ptr %p) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nsw <4 x i32> %zext, %ymasked
  store <4 x i32> %shl, ptr %p
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_shl_unbounded(<4 x i16> %x, <4 x i32> %y) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %shl = shl nsw <4 x i32> %zext, %y
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul_nonsplat(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, <i32 1, i32 2, i32 3, i32 4>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul_poison(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, <i32 1, i32 poison, i32 3, i32 4>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul_zero_lane(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, <i32 1, i32 0, i32 3, i32 4>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul_neg_const(<4 x i16> %x) {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, <i32 3, i32 -1, i32 2, i32 5>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

declare void @foo(<4 x i32>)

define void @or_zext_two_blocks(<4 x i16> %x) {
entry:
  %a = zext <4 x i16> %x to <4 x i32>
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %a)
  %cmp = icmp eq i32 %red, 0
  br i1 %cmp, label %then, label %exit

then:
  call void @foo(<4 x i32> %a)
  br label %exit

exit:
  ret void
}

define void @or_shl_two_blocks(<4 x i32> %x, <4 x i32> %y) {
entry:
  %a = shl nuw <4 x i32> %x, %y
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %a)
  %cmp = icmp eq i32 %red, 0
  br i1 %cmp, label %then, label %exit

then:
  call void @foo(<4 x i32> %a)
  br label %exit

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpts9mn1wm.ll'
source_filename = "/tmp/tmpts9mn1wm.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i1 @or_zext(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @or_zext_i3(<4 x i3> %x) #0 {
  %1 = call i3 @llvm.vector.reduce.or.v4i3(<4 x i3> %x)
  %cmp = icmp eq i3 %1, 0
  ret i1 %cmp
}

define i1 @or_zext_v3_costly(<3 x i8> %x) #0 {
  %1 = call i8 @llvm.vector.reduce.or.v3i8(<3 x i8> %x)
  %cmp = icmp eq i8 %1, 0
  ret i1 %cmp
}

define i1 @or_sext(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @or_neg(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @or_mul(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @or_shl(<4 x i32> %x, <4 x i32> %y) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @umin_zext(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.umin.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @umin_sext(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.umin.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @umin_neg(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @umin_mul(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @umin_shl(<4 x i32> %x, <4 x i32> %y) #0 {
  %1 = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @umax_zext(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.umax.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @umax_sext(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.umax.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @umax_neg(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @umax_mul(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @umax_shl(<4 x i32> %x, <4 x i32> %y) #0 {
  %1 = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @smin_zext(<4 x i16> %x) #0 {
  %and = and <4 x i16> %x, splat (i16 32767)
  %1 = call i16 @llvm.vector.reduce.smin.v4i16(<4 x i16> %and)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @smin_sext(<4 x i16> %x) #0 {
  %and = and <4 x i16> %x, splat (i16 32767)
  %1 = call i16 @llvm.vector.reduce.smin.v4i16(<4 x i16> %and)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @smin_neg(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %neg = sub nsw <4 x i32> zeroinitializer, %zext
  %red = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smin_mul(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %1 = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @smin_shl(<4 x i16> %x, <4 x i32> %y) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %1 = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @smax_zext(<4 x i16> %x) #0 {
  %and = and <4 x i16> %x, splat (i16 32767)
  %1 = call i16 @llvm.vector.reduce.smax.v4i16(<4 x i16> %and)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @smax_sext(<4 x i16> %x) #0 {
  %and = and <4 x i16> %x, splat (i16 32767)
  %1 = call i16 @llvm.vector.reduce.smax.v4i16(<4 x i16> %and)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @smax_neg(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %neg = sub nsw <4 x i32> zeroinitializer, %zext
  %red = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @smax_mul(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %1 = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @smax_shl(<4 x i16> %x, <4 x i32> %y) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %1 = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %zext)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @add_zext(<4 x i16> %x) #0 {
  %and = and <4 x i16> %x, splat (i16 8191)
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %and)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @add_sext(<4 x i16> %x) #0 {
  %and = and <4 x i16> %x, splat (i16 8191)
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %and)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @add_neg(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %neg = sub nsw <4 x i32> zeroinitializer, %zext
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %neg)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @add_shl(<4 x i16> %x, <4 x i32> %y) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @add_shl_ne(<4 x i16> %x, <4 x i32> %y) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp ne i16 %1, 0
  ret i1 %cmp
}

define i1 @add_shl_negative(<4 x i32> %x, <4 x i32> %y) #0 {
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nsw <4 x i32> %x, %ymasked
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_shl_nonzero_cmp(<4 x i16> %x, <4 x i32> %y) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nsw <4 x i32> %zext, %ymasked
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 42
  ret i1 %cmp
}

define i1 @add_shl_multiuse(<4 x i16> %x, <4 x i32> %y, ptr %p) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %ymasked = and <4 x i32> %y, splat (i32 7)
  %shl = shl nsw <4 x i32> %zext, %ymasked
  store <4 x i32> %shl, ptr %p, align 16
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @add_shl_unbounded(<4 x i16> %x, <4 x i32> %y) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %shl = shl nsw <4 x i32> %zext, %y
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shl)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_mul_nonsplat(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @add_mul_poison(<4 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %1, 0
  ret i1 %cmp
}

define i1 @add_mul_zero_lane(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, <i32 1, i32 0, i32 3, i32 4>
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @add_mul_neg_const(<4 x i16> %x) #0 {
  %zext = zext <4 x i16> %x to <4 x i32>
  %mul = mul nuw <4 x i32> %zext, <i32 3, i32 -1, i32 2, i32 5>
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %mul)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

declare void @foo(<4 x i32>) #0

define void @or_zext_two_blocks(<4 x i16> %x) #0 {
entry:
  %a = zext <4 x i16> %x to <4 x i32>
  %0 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> %x)
  %cmp = icmp eq i16 %0, 0
  br i1 %cmp, label %then, label %exit

then:                                             ; preds = %entry
  call void @foo(<4 x i32> %a)
  br label %exit

exit:                                             ; preds = %then, %entry
  ret void
}

define void @or_shl_two_blocks(<4 x i32> %x, <4 x i32> %y) #0 {
entry:
  %a = shl nuw <4 x i32> %x, %y
  %0 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %then, label %exit

then:                                             ; preds = %entry
  call void @foo(<4 x i32> %a)
  br label %exit

exit:                                             ; preds = %then, %entry
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v3i32(<3 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smin.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umax.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umin.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.or.v4i16(<4 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i3 @llvm.vector.reduce.or.v4i3(<4 x i3>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.or.v3i8(<3 x i8>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.umin.v4i16(<4 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.umax.v4i16(<4 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.smin.v4i16(<4 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.smax.v4i16(<4 x i16>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.add.v4i16(<4 x i16>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
