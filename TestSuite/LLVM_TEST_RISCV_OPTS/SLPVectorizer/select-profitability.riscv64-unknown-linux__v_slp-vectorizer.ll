; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/select-profitability.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @pow2_zero_constant_shift(i16 zeroext %a, i16 zeroext %b, i16 zeroext %c, i16 zeroext %d) {
  %t39.i0 = icmp eq i16 %a, 1
  %t39.i1 = icmp eq i16 %b, 1
  %t39.i2 = icmp eq i16 %c, 1
  %t39.i3 = icmp eq i16 %d, 1
  %t40.i0 = select i1 %t39.i0, i32 65536, i32 0
  %t40.i1 = select i1 %t39.i1, i32 65536, i32 0
  %t40.i2 = select i1 %t39.i2, i32 65536, i32 0
  %t40.i3 = select i1 %t39.i3, i32 65536, i32 0
  %or.rdx0 = or i32 %t40.i0, %t40.i1
  %or.rdx1 = or i32 %t40.i2, %t40.i3
  %or.rdx2 = or i32 %or.rdx0, %or.rdx1
  ret i32 %or.rdx2
}

; TODO: This case is unprofitable, and we should not be vectorizing this.
define i32 @pow2_zero_variable_shift(i16 zeroext %a, i16 zeroext %b, i16 zeroext %c, i16 zeroext %d) {
  %t39.i0 = icmp eq i16 %a, 1
  %t39.i1 = icmp eq i16 %b, 1
  %t39.i2 = icmp eq i16 %c, 1
  %t39.i3 = icmp eq i16 %d, 1
  %t40.i0 = select i1 %t39.i0, i32 524288, i32 0
  %t40.i1 = select i1 %t39.i1, i32 262144, i32 0
  %t40.i2 = select i1 %t39.i2, i32 131072, i32 0
  %t40.i3 = select i1 %t39.i3, i32 65536, i32 0
  %or.rdx0 = or i32 %t40.i0, %t40.i1
  %or.rdx1 = or i32 %t40.i2, %t40.i3
  %or.rdx2 = or i32 %or.rdx0, %or.rdx1
  ret i32 %or.rdx2
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmprn4gn03s.ll'
source_filename = "/tmp/tmprn4gn03s.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define i32 @pow2_zero_constant_shift(i16 zeroext %a, i16 zeroext %b, i16 zeroext %c, i16 zeroext %d) #0 {
  %1 = insertelement <4 x i16> poison, i16 %a, i32 0
  %2 = insertelement <4 x i16> %1, i16 %b, i32 1
  %3 = insertelement <4 x i16> %2, i16 %c, i32 2
  %4 = insertelement <4 x i16> %3, i16 %d, i32 3
  %5 = icmp eq <4 x i16> %4, splat (i16 1)
  %6 = select <4 x i1> %5, <4 x i32> splat (i32 65536), <4 x i32> zeroinitializer
  %7 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %6)
  ret i32 %7
}

define i32 @pow2_zero_variable_shift(i16 zeroext %a, i16 zeroext %b, i16 zeroext %c, i16 zeroext %d) #0 {
  %t39.i0 = icmp eq i16 %a, 1
  %t39.i1 = icmp eq i16 %b, 1
  %t39.i2 = icmp eq i16 %c, 1
  %t39.i3 = icmp eq i16 %d, 1
  %t40.i0 = select i1 %t39.i0, i32 524288, i32 0
  %t40.i1 = select i1 %t39.i1, i32 262144, i32 0
  %t40.i2 = select i1 %t39.i2, i32 131072, i32 0
  %t40.i3 = select i1 %t39.i3, i32 65536, i32 0
  %or.rdx0 = or i32 %t40.i0, %t40.i1
  %or.rdx1 = or i32 %t40.i2, %t40.i3
  %or.rdx2 = or i32 %or.rdx0, %or.rdx1
  ret i32 %or.rdx2
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
