; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/vpintrin-scalarization.ll
; Variant: riscv64_+v,+m,+zvfh_ALL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v,+m,+zvfh -S
; Original: RUN: opt -S -mtriple=riscv64 -mattr=+v,+m,+zvfh %s | FileCheck %s --check-prefixes=ALL,NO-VEC-COMBINE

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


declare <vscale x 1 x i64> @llvm.vp.add.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.sub.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.ashr.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.lshr.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.shl.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.or.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.and.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.xor.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.smin.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.smax.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.umin.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i64> @llvm.vp.umax.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.fsub.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.copysign.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.minnum.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x float> @llvm.vp.maxnum.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32)
declare <vscale x 8 x i8> @llvm.vp.add.nxv8i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i1>, i32)
declare <vscale x 8 x i8> @llvm.vp.mul.nxv8i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i1>, i32)
declare <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x i1>, i32)
declare <1 x i64> @llvm.vp.add.v1i64(<1 x i64>, <1 x i64>, <1 x i1>, i32)
declare <4 x i64> @llvm.vp.add.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32)
declare <1 x i64> @llvm.vp.mul.v1i64(<1 x i64>, <1 x i64>, <1 x i1>, i32)
declare <4 x i64> @llvm.vp.mul.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32)

define <vscale x 1 x i64> @add_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.add.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @add_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.add.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sub_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sub.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sub_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sub.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @mul_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @mul_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sdiv_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sdiv_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sdiv_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @udiv_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @udiv_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @udiv_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @srem_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @srem_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @srem_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @urem_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @urem_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @urem_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @sdiv_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @sdiv_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @udiv_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @udiv_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @srem_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @srem_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @urem_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @urem_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @ashr_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.ashr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @ashr_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.ashr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @lshr_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.lshr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @lshr_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.lshr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @shl_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.shl.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @shl_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.shl.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @or_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.or.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @or_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.or.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @and_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.and.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @and_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.and.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @xor_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.xor.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @xor_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.xor.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smin_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smin.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smin_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smin.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smax_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smax_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @umin_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.umin.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @umax_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.umax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @umax_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.umax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x float> @fadd_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fadd_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fsub_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fsub.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fsub_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fsub.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @frem_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
  }

  define <vscale x 1 x float> @frem_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_allonesmask_knownvl(<vscale x 1 x float> %x, float %y) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_anymask_knownvl(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @frem_nxv1f32_allonesmask_knownvl(<vscale x 1 x float> %x, float %y) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

  define <vscale x 1 x float> @frem_nxv1f32_anymask_knownvl(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @copysign_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.copysign.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @copysign_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.copysign.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @minnum_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.minnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @minnum_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.minnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @maxnum_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float > %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.maxnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @maxnum_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.maxnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 42.0), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 8 x i8> @add_nxv8i8_allonesmask(<vscale x 8 x i8> %x, i8 %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 8 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = insertelement <vscale x 8 x i8> poison, i8 %y, i64 0
  %2 = shufflevector <vscale x 8 x i8> %1, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x i8>  @llvm.vp.add.nxv8i8(<vscale x 8 x i8> %2, <vscale x 8 x i8> splat (i8 42), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x i8> @llvm.vp.mul.nxv8i8(<vscale x 8 x i8> %x, <vscale x 8 x i8> %3,  <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x i8> %4
}

define <vscale x 8 x i8> @add_nxv8i8_anymask(<vscale x 8 x i8> %x, i8 %y, <vscale x 8 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 8 x i8> poison, i8 %y, i64 0
  %2 = shufflevector <vscale x 8 x i8> %1, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x i8>  @llvm.vp.add.nxv8i8(<vscale x 8 x i8> %2, <vscale x 8 x i8> splat (i8 42), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x i8> @llvm.vp.mul.nxv8i8(<vscale x 8 x i8> %x, <vscale x 8 x i8> %3,  <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x i8> %4
}

define <vscale x 8 x half> @fadd_nxv1f16_allonesmask(<vscale x 8 x half> %x, half %y, i32 zeroext %evl) {
  %splat = insertelement <vscale x 8 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = insertelement <vscale x 8 x half> poison, half %y, i64 0
  %2 = shufflevector <vscale x 8 x half> %1, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %2, <vscale x 8 x half> splat (half 42.0), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %x, <vscale x 8 x half> %3, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x half> %4
}

define <vscale x 8 x half> @fadd_nxv8f16_anymask(<vscale x 8 x half> %x, half %y, <vscale x 8 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <vscale x 8 x half> poison, half %y, i64 0
  %2 = shufflevector <vscale x 8 x half> %1, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %2, <vscale x 8 x half> splat (half 42.0), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %x, <vscale x 8 x half> %3, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x half> %4
}

define <1 x i64> @add_v1i64_allonesmask(<1 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <1 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <1 x i1> %splat, <1 x i1> poison, <1 x i32> zeroinitializer
  %1 = insertelement <1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <1 x i64> %1, <1 x i64> poison, <1 x i32> zeroinitializer
  %3 = call <1 x i64> @llvm.vp.add.v1i64(<1 x i64> %2, <1 x i64> shufflevector(<1 x i64> insertelement(<1 x i64> poison, i64 42, i32 0), <1 x i64> poison, <1 x i32> zeroinitializer), <1 x i1> %mask, i32 %evl)
  %4 = call <1 x i64> @llvm.vp.mul.v1i64(<1 x i64> %x, <1 x i64> %3, <1 x i1> %mask, i32 %evl)
  ret <1 x i64> %4
}

define <1 x i64> @add_v1i64_anymask(<1 x i64> %x, i64 %y, <1 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <1 x i64> %1, <1 x i64> poison, <1 x i32> zeroinitializer
  %3 = call <1 x i64> @llvm.vp.add.v1i64(<1 x i64> %2, <1 x i64> shufflevector(<1 x i64> insertelement(<1 x i64> poison, i64 42, i32 0), <1 x i64> poison, <1 x i32> zeroinitializer), <1 x i1> %mask, i32 %evl)
  %4 = call <1 x i64> @llvm.vp.mul.v1i64(<1 x i64> %x, <1 x i64> %3, <1 x i1> %mask, i32 %evl)
  ret <1 x i64> %4
}

define <4 x i64> @add_v4i64_allonesmask(<4 x i64> %x, i64 %y, i32 zeroext %evl) {
  %splat = insertelement <4 x i1> poison, i1 -1, i32 0
  %mask = shufflevector <4 x i1> %splat, <4 x i1> poison, <4 x i32> zeroinitializer
  %1 = insertelement <4 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <4 x i64> %1, <4 x i64> poison, <4 x i32> zeroinitializer
  %3 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %2, <4 x i64> shufflevector(<4 x i64> insertelement(<4 x i64> poison, i64 42, i32 0), <4 x i64> poison, <4 x i32> zeroinitializer), <4 x i1> %mask, i32 %evl)
  %4 = call <4 x i64> @llvm.vp.mul.v4i64(<4 x i64> %x, <4 x i64> %3, <4 x i1> %mask, i32 %evl)
  ret <4 x i64> %4
}

define <4 x i64> @add_v4i64_anymask(<4 x i64> %x, i64 %y, <4 x i1> %mask, i32 zeroext %evl) {
  %1 = insertelement <4 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <4 x i64> %1, <4 x i64> poison, <4 x i32> zeroinitializer
  %3 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %2, <4 x i64> shufflevector(<4 x i64> insertelement(<4 x i64> poison, i64 42, i32 0), <4 x i64> poison, <4 x i32> zeroinitializer), <4 x i1> %mask, i32 %evl)
  %4 = call <4 x i64> @llvm.vp.mul.v4i64(<4 x i64> %x, <4 x i64> %3, <4 x i1> %mask, i32 %evl)
  ret <4 x i64> %4
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp74b8es58.ll'
source_filename = "/tmp/tmp74b8es58.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.add.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.sub.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.ashr.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.lshr.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.shl.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.or.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.and.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.xor.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.smin.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.smax.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.umin.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x i64> @llvm.vp.umax.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.fsub.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.copysign.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.minnum.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 1 x float> @llvm.vp.maxnum.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i8> @llvm.vp.add.nxv8i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i8> @llvm.vp.mul.nxv8i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <1 x i64> @llvm.vp.add.v1i64(<1 x i64>, <1 x i64>, <1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i64> @llvm.vp.add.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <1 x i64> @llvm.vp.mul.v1i64(<1 x i64>, <1 x i64>, <1 x i1>, i32) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i64> @llvm.vp.mul.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32) #0

define <vscale x 1 x i64> @add_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.add.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @add_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.add.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sub_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sub.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sub_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sub.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @mul_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @mul_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sdiv_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sdiv_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @sdiv_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @udiv_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @udiv_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @udiv_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @srem_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @srem_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @srem_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @urem_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @urem_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @urem_nxv1i64_unspeculatable(i64 %x, i64 %y, i32 zeroext %evl) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @sdiv_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @sdiv_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) #2 {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.sdiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @udiv_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @udiv_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) #2 {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.udiv.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @srem_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @srem_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) #2 {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.srem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @urem_nxv1i64_allonesmask_knownvl(i64 %x, i64 %y) #2 {
  %mask.head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %mask.head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @urem_nxv1i64_anymask_knownvl(i64 %x, i64 %y, <vscale x 1 x i1> %mask) #2 {
  %x.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %x.splat = shufflevector <vscale x 1 x i64> %x.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %y.head = insertelement <vscale x 1 x i64> poison, i64 %x, i64 0
  %y.splat = shufflevector <vscale x 1 x i64> %y.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %res = call <vscale x 1 x i64> @llvm.vp.urem.nxv1i64(<vscale x 1 x i64> %x.splat, <vscale x 1 x i64> %y.splat, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x i64> %res
}

define <vscale x 1 x i64> @ashr_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.ashr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @ashr_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.ashr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @lshr_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.lshr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @lshr_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.lshr.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @shl_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.shl.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @shl_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.shl.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @or_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.or.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @or_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.or.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @and_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.and.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @and_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.and.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @xor_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.xor.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @xor_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.xor.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smin_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smin.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smin_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smin.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smax_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @smax_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.smax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @umin_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.umin.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @umax_nxv1i64_allonesmask(<vscale x 1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.umax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x i64> @umax_nxv1i64_anymask(<vscale x 1 x i64> %x, i64 %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <vscale x 1 x i64> %1, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x i64> @llvm.vp.umax.nxv1i64(<vscale x 1 x i64> %2, <vscale x 1 x i64> splat (i64 42), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x i64> @llvm.vp.mul.nxv1i64(<vscale x 1 x i64> %x, <vscale x 1 x i64> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i64> %4
}

define <vscale x 1 x float> @fadd_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fadd_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fsub_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fsub.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fsub_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fsub.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @frem_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @frem_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_allonesmask_knownvl(<vscale x 1 x float> %x, float %y) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @fdiv_nxv1f32_anymask_knownvl(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.fdiv.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @frem_nxv1f32_allonesmask_knownvl(<vscale x 1 x float> %x, float %y) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @frem_nxv1f32_anymask_knownvl(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.frem.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 4)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 4)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @copysign_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.copysign.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @copysign_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.copysign.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @minnum_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.minnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @minnum_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.minnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @maxnum_nxv1f32_allonesmask(<vscale x 1 x float> %x, float %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.maxnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 1 x float> @maxnum_nxv1f32_anymask(<vscale x 1 x float> %x, float %y, <vscale x 1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 1 x float> poison, float %y, i64 0
  %2 = shufflevector <vscale x 1 x float> %1, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %3 = call <vscale x 1 x float> @llvm.vp.maxnum.nxv1f32(<vscale x 1 x float> %2, <vscale x 1 x float> splat (float 4.200000e+01), <vscale x 1 x i1> %mask, i32 %evl)
  %4 = call <vscale x 1 x float> @llvm.vp.fadd.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x float> %3, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x float> %4
}

define <vscale x 8 x i8> @add_nxv8i8_allonesmask(<vscale x 8 x i8> %x, i8 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = insertelement <vscale x 8 x i8> poison, i8 %y, i64 0
  %2 = shufflevector <vscale x 8 x i8> %1, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x i8> @llvm.vp.add.nxv8i8(<vscale x 8 x i8> %2, <vscale x 8 x i8> splat (i8 42), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x i8> @llvm.vp.mul.nxv8i8(<vscale x 8 x i8> %x, <vscale x 8 x i8> %3, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x i8> %4
}

define <vscale x 8 x i8> @add_nxv8i8_anymask(<vscale x 8 x i8> %x, i8 %y, <vscale x 8 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 8 x i8> poison, i8 %y, i64 0
  %2 = shufflevector <vscale x 8 x i8> %1, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x i8> @llvm.vp.add.nxv8i8(<vscale x 8 x i8> %2, <vscale x 8 x i8> splat (i8 42), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x i8> @llvm.vp.mul.nxv8i8(<vscale x 8 x i8> %x, <vscale x 8 x i8> %3, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x i8> %4
}

define <vscale x 8 x half> @fadd_nxv1f16_allonesmask(<vscale x 8 x half> %x, half %y, i32 zeroext %evl) #2 {
  %splat = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %mask = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = insertelement <vscale x 8 x half> poison, half %y, i64 0
  %2 = shufflevector <vscale x 8 x half> %1, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %2, <vscale x 8 x half> splat (half 4.200000e+01), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %x, <vscale x 8 x half> %3, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x half> %4
}

define <vscale x 8 x half> @fadd_nxv8f16_anymask(<vscale x 8 x half> %x, half %y, <vscale x 8 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <vscale x 8 x half> poison, half %y, i64 0
  %2 = shufflevector <vscale x 8 x half> %1, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %3 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %2, <vscale x 8 x half> splat (half 4.200000e+01), <vscale x 8 x i1> %mask, i32 %evl)
  %4 = call <vscale x 8 x half> @llvm.vp.fadd.nxv8f16(<vscale x 8 x half> %x, <vscale x 8 x half> %3, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x half> %4
}

define <1 x i64> @add_v1i64_allonesmask(<1 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <1 x i1> poison, i1 true, i32 0
  %mask = shufflevector <1 x i1> %splat, <1 x i1> poison, <1 x i32> zeroinitializer
  %1 = insertelement <1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <1 x i64> %1, <1 x i64> poison, <1 x i32> zeroinitializer
  %3 = call <1 x i64> @llvm.vp.add.v1i64(<1 x i64> %2, <1 x i64> splat (i64 42), <1 x i1> %mask, i32 %evl)
  %4 = call <1 x i64> @llvm.vp.mul.v1i64(<1 x i64> %x, <1 x i64> %3, <1 x i1> %mask, i32 %evl)
  ret <1 x i64> %4
}

define <1 x i64> @add_v1i64_anymask(<1 x i64> %x, i64 %y, <1 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <1 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <1 x i64> %1, <1 x i64> poison, <1 x i32> zeroinitializer
  %3 = call <1 x i64> @llvm.vp.add.v1i64(<1 x i64> %2, <1 x i64> splat (i64 42), <1 x i1> %mask, i32 %evl)
  %4 = call <1 x i64> @llvm.vp.mul.v1i64(<1 x i64> %x, <1 x i64> %3, <1 x i1> %mask, i32 %evl)
  ret <1 x i64> %4
}

define <4 x i64> @add_v4i64_allonesmask(<4 x i64> %x, i64 %y, i32 zeroext %evl) #2 {
  %splat = insertelement <4 x i1> poison, i1 true, i32 0
  %mask = shufflevector <4 x i1> %splat, <4 x i1> poison, <4 x i32> zeroinitializer
  %1 = insertelement <4 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <4 x i64> %1, <4 x i64> poison, <4 x i32> zeroinitializer
  %3 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %2, <4 x i64> splat (i64 42), <4 x i1> %mask, i32 %evl)
  %4 = call <4 x i64> @llvm.vp.mul.v4i64(<4 x i64> %x, <4 x i64> %3, <4 x i1> %mask, i32 %evl)
  ret <4 x i64> %4
}

define <4 x i64> @add_v4i64_anymask(<4 x i64> %x, i64 %y, <4 x i1> %mask, i32 zeroext %evl) #2 {
  %1 = insertelement <4 x i64> poison, i64 %y, i64 0
  %2 = shufflevector <4 x i64> %1, <4 x i64> poison, <4 x i32> zeroinitializer
  %3 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %2, <4 x i64> splat (i64 42), <4 x i1> %mask, i32 %evl)
  %4 = call <4 x i64> @llvm.vp.mul.v4i64(<4 x i64> %x, <4 x i64> %3, <4 x i1> %mask, i32 %evl)
  ret <4 x i64> %4
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+m,+zvfh" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) "target-features"="+v,+m,+zvfh" }
attributes #2 = { "target-features"="+v,+m,+zvfh" }
