; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InterleavedAccess/RISCV/zve32x.ll
; Variant: riscv64_+zve64x,+zvl128b_interleaved-access_ZVE64X
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+zve64x,+zvl128b -passes=interleaved-access -S
; Original: RUN: opt < %s -mtriple=riscv64 -mattr=+zve64x,+zvl128b -passes=interleaved-access -S | FileCheck %s -check-prefix=ZVE64X

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

; ModuleID = '/tmp/tmpjfzltcll.ll'
source_filename = "/tmp/tmpjfzltcll.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <4 x i1> @load_large_vector(ptr %p) #0 {
  %1 = call { <4 x ptr>, <4 x ptr>, <4 x ptr> } @llvm.riscv.seg3.load.mask.v4p0.p0.i64(ptr %p, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x ptr>, <4 x ptr>, <4 x ptr> } %1, 1
  %3 = extractvalue { <4 x ptr>, <4 x ptr>, <4 x ptr> } %1, 0
  %ret = icmp ne <4 x ptr> %3, %2
  ret <4 x i1> %ret
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x ptr>, <4 x ptr>, <4 x ptr> } @llvm.riscv.seg3.load.mask.v4p0.p0.i64(ptr captures(none), <4 x i1>, i64) #1

attributes #0 = { "target-features"="+zve64x,+zvl128b" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
