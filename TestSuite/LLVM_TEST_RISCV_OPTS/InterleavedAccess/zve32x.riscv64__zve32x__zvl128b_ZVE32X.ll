; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InterleavedAccess/RISCV/zve32x.ll
; Variant: riscv64_+zve32x,+zvl128b_ZVE32X
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+zve32x,+zvl128b -interleaved-access -S
; Original: RUN: opt < %s -mtriple=riscv64 -mattr=+zve32x,+zvl128b -interleaved-access -S | FileCheck %s -check-prefix=ZVE32X

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <4 x i1> @load_large_vector(ptr %p) {
  %l = load <12 x ptr>, ptr %p
  %s1 = shufflevector <12 x ptr> %l, <12 x ptr> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %s2 = shufflevector <12 x ptr> %l, <12 x ptr> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %ret = icmp ne <4 x ptr> %s1, %s2
  ret <4 x i1> %ret
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpdgv7r9q6.ll'
source_filename = "/tmp/tmpdgv7r9q6.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <4 x i1> @load_large_vector(ptr %p) #0 {
  %l = load <12 x ptr>, ptr %p, align 128
  %s1 = shufflevector <12 x ptr> %l, <12 x ptr> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %s2 = shufflevector <12 x ptr> %l, <12 x ptr> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %ret = icmp ne <4 x ptr> %s1, %s2
  ret <4 x i1> %ret
}

attributes #0 = { "target-features"="+zve32x,+zvl128b" }
