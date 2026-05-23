; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InterleavedAccess/RISCV/zvl32b.ll
; Variant: riscv32_+zve32x,+zvl128b_interleaved-access_ZVL128B
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv32 -mattr=+zve32x,+zvl128b -passes=interleaved-access -S
; Original: RUN: opt < %s -mtriple=riscv32 -mattr=+zve32x,+zvl128b -passes=interleaved-access -S | FileCheck %s -check-prefix=ZVL128B

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure that we don't lower interleaved loads that won't fit into the minimum vlen

define {<16 x i32>, <16 x i32>} @load_factor2_large(ptr %ptr) {
  %interleaved.vec = load <32 x i32>, ptr %ptr
  %v0 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30>
  %v1 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <16 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31>
  %res0 = insertvalue {<16 x i32>, <16 x i32>} undef, <16 x i32> %v0, 0
  %res1 = insertvalue {<16 x i32>, <16 x i32>} %res0, <16 x i32> %v1, 1
  ret {<16 x i32>, <16 x i32>} %res1
  ; ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp39cxjt7c.ll'
source_filename = "/tmp/tmp39cxjt7c.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define { <16 x i32>, <16 x i32> } @load_factor2_large(ptr %ptr) #0 {
  %1 = call { <16 x i32>, <16 x i32> } @llvm.riscv.seg2.load.mask.v16i32.p0.i32(ptr %ptr, <16 x i1> splat (i1 true), i32 16)
  %2 = extractvalue { <16 x i32>, <16 x i32> } %1, 1
  %3 = extractvalue { <16 x i32>, <16 x i32> } %1, 0
  %res0 = insertvalue { <16 x i32>, <16 x i32> } undef, <16 x i32> %3, 0
  %res1 = insertvalue { <16 x i32>, <16 x i32> } %res0, <16 x i32> %2, 1
  ret { <16 x i32>, <16 x i32> } %res1
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <16 x i32>, <16 x i32> } @llvm.riscv.seg2.load.mask.v16i32.p0.i32(ptr captures(none), <16 x i1>, i32) #1

attributes #0 = { "target-features"="+zve32x,+zvl128b" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
