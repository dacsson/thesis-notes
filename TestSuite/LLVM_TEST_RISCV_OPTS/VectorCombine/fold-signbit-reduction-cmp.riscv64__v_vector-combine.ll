; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/fold-signbit-reduction-cmp.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=vector-combine -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S -passes=vector-combine -mtriple=riscv64 -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i1 @or_eq_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_ne_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @or_ne_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 1
  ret i1 %cmp
}

define i1 @umax_eq_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_ne_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @umax_eq_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @umax_ne_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 1
  ret i1 %cmp
}

define i1 @and_eq_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @and_ne_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @and_eq_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @and_ne_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 1
  ret i1 %cmp
}

define i1 @umin_eq_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_ne_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @umin_eq_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @umin_ne_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 1
  ret i1 %cmp
}

define i1 @add_eq_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @add_ne_0(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @add_eq_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 4
  ret i1 %cmp
}

define i1 @add_ne_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, 4
  ret i1 %cmp
}

define i1 @add_ult_max(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, 4
  ret i1 %cmp
}

define i1 @add_ugt_max_minus_1(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ugt i32 %red, 3
  ret i1 %cmp
}

define i1 @ashr_add_eq_0(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @or_eq_0_v8i16(<8 x i16> %x) {
  %shr = lshr <8 x i16> %x, splat (i16 15)
  %red = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> %shr)
  %cmp = icmp eq i16 %red, 0
  ret i1 %cmp
}

define i1 @and_eq_max_v2i64(<2 x i64> %x) {
  %shr = lshr <2 x i64> %x, splat (i64 63)
  %red = call i64 @llvm.vector.reduce.and.v2i64(<2 x i64> %shr)
  %cmp = icmp eq i64 %red, 1
  ret i1 %cmp
}

define i1 @negative_wrong_shift(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 30)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @negative_wrong_cmp_const(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 2
  ret i1 %cmp
}

define i1 @negative_multi_use_shift(<4 x i32> %x, ptr %p) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  store <4 x i32> %shr, ptr %p
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @negative_sgt_wrong_const(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp sgt i32 %red, 1
  ret i1 %cmp
}

define i1 @negative_slt_wrong_const(<4 x i32> %x) {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp slt i32 %red, 2
  ret i1 %cmp
}

define i1 @negative_add_numelts_overflow(<8 x i2> %x) {
  %shr = lshr <8 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v8i2(<8 x i2> %shr)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

define i1 @ashr_add_eq_allneg(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, -4
  ret i1 %cmp
}

define i1 @ashr_add_ne_allneg(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ne i32 %red, -4
  ret i1 %cmp
}

define i1 @ashr_add_sgt_minus1(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @ashr_add_slt_0(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp slt i32 %red, 0
  ret i1 %cmp
}

define i1 @ashr_add_slt_minus3(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp slt i32 %red, -3
  ret i1 %cmp
}

define i1 @ashr_add_sgt_minus4(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp sgt i32 %red, -4
  ret i1 %cmp
}

define i1 @ashr_add_eq_allneg_v8i16(<8 x i16> %x) {
  %shr = ashr <8 x i16> %x, splat (i16 15)
  %red = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %shr)
  %cmp = icmp eq i16 %red, -8
  ret i1 %cmp
}

; negative: NumElts=2 doesn't fit as signed in i2
define i1 @add_eq_0_v2i2(<2 x i2> %x) {
  %shr = lshr <2 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v2i2(<2 x i2> %shr)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

; negative: NumElts=3 doesn't fit as signed in i2
define i1 @add_eq_max_v3i2(<3 x i2> %x) {
  %shr = lshr <3 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v3i2(<3 x i2> %shr)
  %cmp = icmp eq i2 %red, 3
  ret i1 %cmp
}

define i1 @negative_add_v4i2(<4 x i2> %x) {
  %shr = lshr <4 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v4i2(<4 x i2> %shr)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

; negative: ashr with NumElts=5 causes -5 to wrap to 3 (positive),
define i1 @negative_ashr_add_sgt_0(<5 x i3> %x) {
  %shr = ashr <5 x i3> %x, splat (i3 2)
  %red = call i3 @llvm.vector.reduce.add.v5i3(<5 x i3> %shr)
  %cmp = icmp sgt i3 %red, 0
  ret i1 %cmp
}

define i1 @i1_or_eq_0(<4 x i1> %x) {
  %shr = lshr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_or_ne_0(<4 x i1> %x) {
  %shr = lshr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_and_eq_0(<4 x i1> %x) {
  %shr = lshr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_and_ne_0(<4 x i1> %x) {
  %shr = lshr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_umax_eq_0(<4 x i1> %x) {
  %shr = lshr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.umax.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_umin_ne_0(<4 x i1> %x) {
  %shr = lshr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.umin.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_ashr_or_eq_0(<4 x i1> %x) {
  %shr = ashr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, 0
  ret i1 %cmp
}

define i1 @i1_ashr_and_ne_0(<4 x i1> %x) {
  %shr = ashr <4 x i1> %x, splat (i1 0)
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, 0
  ret i1 %cmp
}

define i1 @negative_ashr_add_ult_0(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, 0
  ret i1 %cmp
}

define i1 @negative_ashr_add_ugt_minus1(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ugt i32 %red, -1
  ret i1 %cmp
}

define i1 @negative_ashr_add_ult_minus3(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, -3
  ret i1 %cmp
}

define i1 @negative_ashr_or_ult_0(<4 x i32> %x) {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_add_lshr_eq_0(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_add_lshr_ne_0(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp ne i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_add_lshr_eq_8(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 8
  ret i1 %cmp
}

define i1 @multi_add_lshr_ne_8(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp ne i32 %red, 8
  ret i1 %cmp
}

define i1 @multi_or_lshr_eq_0(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %combined = or <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %combined)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_and_lshr_eq_1(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %combined = and <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %combined)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

define i1 @multi_triple_add_lshr_eq_0(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sc = lshr <4 x i32> %c, splat (i32 31)
  %ab = add <4 x i32> %sa, %sb
  %abc = add <4 x i32> %ab, %sc
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %abc)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_triple_add_lshr_eq_12(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sc = lshr <4 x i32> %c, splat (i32 31)
  %ab = add <4 x i32> %sa, %sb
  %abc = add <4 x i32> %ab, %sc
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %abc)
  %cmp = icmp eq i32 %red, 12
  ret i1 %cmp
}

define i1 @multi_add_ashr_eq_0(<4 x i32> %a, <4 x i32> %b) {
  %sa = ashr <4 x i32> %a, splat (i32 31)
  %sb = ashr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_add_ashr_eq_minus8(<4 x i32> %a, <4 x i32> %b) {
  %sa = ashr <4 x i32> %a, splat (i32 31)
  %sb = ashr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, -8
  ret i1 %cmp
}

define i1 @multi_add_ashr_sgt_minus1(<4 x i32> %a, <4 x i32> %b) {
  %sa = ashr <4 x i32> %a, splat (i32 31)
  %sb = ashr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp sgt i32 %red, -1
  ret i1 %cmp
}

define i1 @multi_add_ashr_slt_minus7(<4 x i32> %a, <4 x i32> %b) {
  %sa = ashr <4 x i32> %a, splat (i32 31)
  %sb = ashr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp slt i32 %red, -7
  ret i1 %cmp
}

define i1 @multi_umax_or_tree_eq_0(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %combined = or <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %combined)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_umin_and_tree_eq_1(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %combined = and <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %combined)
  %cmp = icmp eq i32 %red, 1
  ret i1 %cmp
}

; negative: mixed lshr/ashr shifts
define i1 @negative_multi_mixed_shifts(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = ashr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; negative: overflow with two vectors (2*8 = 16 > max for i2)
define i1 @negative_multi_overflow(<8 x i2> %a, <8 x i2> %b) {
  %sa = lshr <8 x i2> %a, splat (i2 1)
  %sb = lshr <8 x i2> %b, splat (i2 1)
  %sum = add <8 x i2> %sa, %sb
  %red = call i2 @llvm.vector.reduce.add.v8i2(<8 x i2> %sum)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

; negative: shift has multiple uses
define i1 @negative_multi_shift_multiuse(<4 x i32> %a, <4 x i32> %b, ptr %p) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  store <4 x i32> %sa, ptr %p
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; negative: internal tree node has multiple uses
define i1 @negative_multi_tree_node_multiuse(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, ptr %p) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sc = lshr <4 x i32> %c, splat (i32 31)
  %ab = add <4 x i32> %sa, %sb
  store <4 x i32> %ab, ptr %p
  %abc = add <4 x i32> %ab, %sc
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %abc)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; negative: tree op (add) doesn't match reduction (or/umax expects or tree)
define i1 @negative_multi_op_mismatch(<4 x i32> %a, <4 x i32> %b) {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpxccehqwr.ll'
source_filename = "/tmp/tmpxccehqwr.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i1 @or_eq_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @or_ne_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @or_eq_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @or_ne_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @umax_eq_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @umax_ne_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @umax_eq_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @umax_ne_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @and_eq_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @and_ne_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @and_eq_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @and_ne_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @umin_eq_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @umin_ne_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @umin_eq_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @umin_ne_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @add_eq_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @add_ne_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @add_eq_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @add_ne_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @add_ult_max(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @add_ugt_max_minus_1(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @ashr_add_eq_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @or_eq_0_v8i16(<8 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> %x)
  %cmp = icmp sgt i16 %1, -1
  ret i1 %cmp
}

define i1 @and_eq_max_v2i64(<2 x i64> %x) #0 {
  %1 = call i64 @llvm.vector.reduce.and.v2i64(<2 x i64> %x)
  %cmp = icmp slt i64 %1, 0
  ret i1 %cmp
}

define i1 @negative_wrong_shift(<4 x i32> %x) #0 {
  %shr = lshr <4 x i32> %x, splat (i32 30)
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @negative_wrong_cmp_const(<4 x i32> %x) #0 {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %red, 2
  ret i1 %cmp
}

define i1 @negative_multi_use_shift(<4 x i32> %x, ptr %p) #0 {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  store <4 x i32> %shr, ptr %p, align 16
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @negative_sgt_wrong_const(<4 x i32> %x) #0 {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp sgt i32 %red, 1
  ret i1 %cmp
}

define i1 @negative_slt_wrong_const(<4 x i32> %x) #0 {
  %shr = lshr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp slt i32 %red, 2
  ret i1 %cmp
}

define i1 @negative_add_numelts_overflow(<8 x i2> %x) #0 {
  %shr = lshr <8 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v8i2(<8 x i2> %shr)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

define i1 @ashr_add_eq_allneg(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @ashr_add_ne_allneg(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @ashr_add_sgt_minus1(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @ashr_add_slt_0(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @ashr_add_slt_minus3(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp slt i32 %1, 0
  ret i1 %cmp
}

define i1 @ashr_add_sgt_minus4(<4 x i32> %x) #0 {
  %1 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %x)
  %cmp = icmp sgt i32 %1, -1
  ret i1 %cmp
}

define i1 @ashr_add_eq_allneg_v8i16(<8 x i16> %x) #0 {
  %1 = call i16 @llvm.vector.reduce.and.v8i16(<8 x i16> %x)
  %cmp = icmp slt i16 %1, 0
  ret i1 %cmp
}

define i1 @add_eq_0_v2i2(<2 x i2> %x) #0 {
  %shr = lshr <2 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v2i2(<2 x i2> %shr)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

define i1 @add_eq_max_v3i2(<3 x i2> %x) #0 {
  %shr = lshr <3 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v3i2(<3 x i2> %shr)
  %cmp = icmp eq i2 %red, -1
  ret i1 %cmp
}

define i1 @negative_add_v4i2(<4 x i2> %x) #0 {
  %shr = lshr <4 x i2> %x, splat (i2 1)
  %red = call i2 @llvm.vector.reduce.add.v4i2(<4 x i2> %shr)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

define i1 @negative_ashr_add_sgt_0(<5 x i3> %x) #0 {
  %shr = ashr <5 x i3> %x, splat (i3 2)
  %red = call i3 @llvm.vector.reduce.add.v5i3(<5 x i3> %shr)
  %cmp = icmp sgt i3 %red, 0
  ret i1 %cmp
}

define i1 @i1_or_eq_0(<4 x i1> %x) #0 {
  %shr = lshr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, false
  ret i1 %cmp
}

define i1 @i1_or_ne_0(<4 x i1> %x) #0 {
  %shr = lshr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, false
  ret i1 %cmp
}

define i1 @i1_and_eq_0(<4 x i1> %x) #0 {
  %shr = lshr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, false
  ret i1 %cmp
}

define i1 @i1_and_ne_0(<4 x i1> %x) #0 {
  %shr = lshr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, false
  ret i1 %cmp
}

define i1 @i1_umax_eq_0(<4 x i1> %x) #0 {
  %shr = lshr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.umax.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, false
  ret i1 %cmp
}

define i1 @i1_umin_ne_0(<4 x i1> %x) #0 {
  %shr = lshr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.umin.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, false
  ret i1 %cmp
}

define i1 @i1_ashr_or_eq_0(<4 x i1> %x) #0 {
  %shr = ashr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %shr)
  %cmp = icmp eq i1 %red, false
  ret i1 %cmp
}

define i1 @i1_ashr_and_ne_0(<4 x i1> %x) #0 {
  %shr = ashr <4 x i1> %x, zeroinitializer
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %shr)
  %cmp = icmp ne i1 %red, false
  ret i1 %cmp
}

define i1 @negative_ashr_add_ult_0(<4 x i32> %x) #0 {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, 0
  ret i1 %cmp
}

define i1 @negative_ashr_add_ugt_minus1(<4 x i32> %x) #0 {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ugt i32 %red, -1
  ret i1 %cmp
}

define i1 @negative_ashr_add_ult_minus3(<4 x i32> %x) #0 {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, -3
  ret i1 %cmp
}

define i1 @negative_ashr_or_ult_0(<4 x i32> %x) #0 {
  %shr = ashr <4 x i32> %x, splat (i32 31)
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shr)
  %cmp = icmp ult i32 %red, 0
  ret i1 %cmp
}

define i1 @multi_add_lshr_eq_0(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = or <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %1)
  %cmp = icmp sgt i32 %2, -1
  ret i1 %cmp
}

define i1 @multi_add_lshr_ne_0(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = or <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %1)
  %cmp = icmp slt i32 %2, 0
  ret i1 %cmp
}

define i1 @multi_add_lshr_eq_8(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = and <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %1)
  %cmp = icmp slt i32 %2, 0
  ret i1 %cmp
}

define i1 @multi_add_lshr_ne_8(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = and <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %1)
  %cmp = icmp sgt i32 %2, -1
  ret i1 %cmp
}

define i1 @multi_or_lshr_eq_0(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = or <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %1)
  %cmp = icmp sgt i32 %2, -1
  ret i1 %cmp
}

define i1 @multi_and_lshr_eq_1(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = and <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %1)
  %cmp = icmp slt i32 %2, 0
  ret i1 %cmp
}

define i1 @multi_triple_add_lshr_eq_0(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) #0 {
  %1 = or <4 x i32> %c, %b
  %2 = or <4 x i32> %1, %a
  %3 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %2)
  %cmp = icmp sgt i32 %3, -1
  ret i1 %cmp
}

define i1 @multi_triple_add_lshr_eq_12(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) #0 {
  %1 = and <4 x i32> %c, %b
  %2 = and <4 x i32> %1, %a
  %3 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %2)
  %cmp = icmp slt i32 %3, 0
  ret i1 %cmp
}

define i1 @multi_add_ashr_eq_0(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = or <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %1)
  %cmp = icmp sgt i32 %2, -1
  ret i1 %cmp
}

define i1 @multi_add_ashr_eq_minus8(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = and <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %1)
  %cmp = icmp slt i32 %2, 0
  ret i1 %cmp
}

define i1 @multi_add_ashr_sgt_minus1(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = or <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %1)
  %cmp = icmp sgt i32 %2, -1
  ret i1 %cmp
}

define i1 @multi_add_ashr_slt_minus7(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = and <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %1)
  %cmp = icmp slt i32 %2, 0
  ret i1 %cmp
}

define i1 @multi_umax_or_tree_eq_0(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = or <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %1)
  %cmp = icmp sgt i32 %2, -1
  ret i1 %cmp
}

define i1 @multi_umin_and_tree_eq_1(<4 x i32> %a, <4 x i32> %b) #0 {
  %1 = and <4 x i32> %b, %a
  %2 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %1)
  %cmp = icmp slt i32 %2, 0
  ret i1 %cmp
}

define i1 @negative_multi_mixed_shifts(<4 x i32> %a, <4 x i32> %b) #0 {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = ashr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

define i1 @negative_multi_overflow(<8 x i2> %a, <8 x i2> %b) #0 {
  %sa = lshr <8 x i2> %a, splat (i2 1)
  %sb = lshr <8 x i2> %b, splat (i2 1)
  %sum = add <8 x i2> %sa, %sb
  %red = call i2 @llvm.vector.reduce.add.v8i2(<8 x i2> %sum)
  %cmp = icmp eq i2 %red, 0
  ret i1 %cmp
}

define i1 @negative_multi_shift_multiuse(<4 x i32> %a, <4 x i32> %b, ptr %p) #0 {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  store <4 x i32> %sa, ptr %p, align 16
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @negative_multi_tree_node_multiuse(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, ptr %p) #0 {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sc = lshr <4 x i32> %c, splat (i32 31)
  %ab = add <4 x i32> %sa, %sb
  store <4 x i32> %ab, ptr %p, align 16
  %abc = add <4 x i32> %ab, %sc
  %1 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %abc)
  %cmp = icmp eq i32 %1, 0
  ret i1 %cmp
}

define i1 @negative_multi_op_mismatch(<4 x i32> %a, <4 x i32> %b) #0 {
  %sa = lshr <4 x i32> %a, splat (i32 31)
  %sb = lshr <4 x i32> %b, splat (i32 31)
  %sum = add <4 x i32> %sa, %sb
  %red = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %sum)
  %cmp = icmp eq i32 %red, 0
  ret i1 %cmp
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i2 @llvm.vector.reduce.add.v2i2(<2 x i2>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i2 @llvm.vector.reduce.add.v3i2(<3 x i2>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i2 @llvm.vector.reduce.add.v4i2(<4 x i2>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i3 @llvm.vector.reduce.add.v5i3(<5 x i3>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i2 @llvm.vector.reduce.add.v8i2(<8 x i2>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.and.v2i64(<2 x i64>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.and.v4i1(<4 x i1>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.and.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.v4i1(<4 x i1>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.or.v8i16(<8 x i16>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.umax.v4i1(<4 x i1>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umax.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.umin.v4i1(<4 x i1>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umin.v4i32(<4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.and.v8i16(<8 x i16>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
