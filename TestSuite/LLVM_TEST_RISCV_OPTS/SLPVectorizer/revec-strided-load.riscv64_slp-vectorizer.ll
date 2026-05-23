; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/revec-strided-load.ll
; Variant: riscv64_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mcpu=sifive-p870 -passes=slp-vectorizer -slp-revec -slp-threshold=-100 -S
; Original: RUN: opt -mtriple=riscv64 -mcpu=sifive-p870 -passes=slp-vectorizer -S -slp-revec -slp-threshold=-100 %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Base case of strided load, implicitly is widened
define void @widened_strided_load(ptr %in0, ptr %out0) {
entry:
  %in1 = getelementptr i8, ptr %in0, i64 16
  %l0 = load <8 x i8>, ptr %in0, align 2
  %l1 = load <8 x i8>, ptr %in1, align 2
  %out1 = getelementptr i8, ptr %out0, i64 8
  store <8 x i8> %l0, ptr %out0, align 2
  store <8 x i8> %l1, ptr %out1, align 2
  ret void
}

define void @widened_strided_load_runtime(ptr %in0, ptr %out0, i64 %stride) {
entry:
  %in1 = getelementptr <8 x i8>, ptr %in0, i64 %stride
  %l0 = load <8 x i8>, ptr %in0, align 2
  %l1 = load <8 x i8>, ptr %in1, align 2
  %out1 = getelementptr i8, ptr %out0, i64 8
  store <8 x i8> %l0, ptr %out0, align 2
  store <8 x i8> %l1, ptr %out1, align 2
  ret void
}

; Base case of strided load, implicitly is widened
define void @widened_strided_load_runtime_more_elements(ptr %in0, ptr %out0, i64 %stride) {
entry:
  %in1 = getelementptr <2 x i8>, ptr %in0, i64 %stride
  %in2 = getelementptr <2 x i8>, ptr %in1, i64 %stride
  %in3 = getelementptr <2 x i8>, ptr %in2, i64 %stride
  %l0 = load <2 x i8>, ptr %in0, align 2
  %l1 = load <2 x i8>, ptr %in1, align 2
  %l2 = load <2 x i8>, ptr %in2, align 2
  %l3 = load <2 x i8>, ptr %in3, align 2
  %out1 = getelementptr i8, ptr %out0, i64 2
  %out2 = getelementptr i8, ptr %out0, i64 4
  %out3 = getelementptr i8, ptr %out0, i64 6
  store <2 x i8> %l0, ptr %out0, align 2
  store <2 x i8> %l1, ptr %out1, align 2
  store <2 x i8> %l2, ptr %out2, align 2
  store <2 x i8> %l3, ptr %out3, align 2
  ret void
}

; Widened strided load pattern but vectorized types
define void @doubly_widened_strided_load(ptr %in0, ptr %out0) {
entry:
  %in1 = getelementptr i8, ptr %in0, i64 2
  %in2 = getelementptr i8, ptr %in0, i64 20
  %in3 = getelementptr i8, ptr %in0, i64 22
  %l0 = load <2 x i8>, ptr %in0, align 2
  %l1 = load <2 x i8>, ptr %in1, align 2
  %l2 = load <2 x i8>, ptr %in2, align 2
  %l3 = load <2 x i8>, ptr %in3, align 2
  %out1 = getelementptr i8, ptr %out0, i64 2
  %out2 = getelementptr i8, ptr %out0, i64 4
  %out3 = getelementptr i8, ptr %out0, i64 6
  store <2 x i8> %l0, ptr %out0, align 2
  store <2 x i8> %l1, ptr %out1, align 2
  store <2 x i8> %l2, ptr %out2, align 2
  store <2 x i8> %l3, ptr %out3, align 2
  ret void
}

define void @doubly_widened_strided_load_runtime(ptr %in0, ptr %out0, i64 %stride) {
entry:
  %in1 = getelementptr <2 x i8>, ptr %in0, i64 1
  %in2 = getelementptr <2 x i8>, ptr %in0, i64 %stride
  %in3 = getelementptr <2 x i8>, ptr %in2, i64 1
  %l0 = load <2 x i8>, ptr %in0, align 2
  %l1 = load <2 x i8>, ptr %in1, align 2
  %l2 = load <2 x i8>, ptr %in2, align 2
  %l3 = load <2 x i8>, ptr %in3, align 2
  %out1 = getelementptr i8, ptr %out0, i64 2
  %out2 = getelementptr i8, ptr %out0, i64 4
  %out3 = getelementptr i8, ptr %out0, i64 6
  store <2 x i8> %l0, ptr %out0, align 2
  store <2 x i8> %l1, ptr %out1, align 2
  store <2 x i8> %l2, ptr %out2, align 2
  store <2 x i8> %l3, ptr %out3, align 2
  ret void
}

; The resulting widened type isn't legal
define void @too_wide(ptr %in0, ptr %out0) {
entry:
  %in1 = getelementptr i16, ptr %in0, i64 16
  %l0 = load <8 x i16>, ptr %in0, align 2
  %l1 = load <8 x i16>, ptr %in1, align 2
  %out1 = getelementptr i16, ptr %out0, i64 8
  store <8 x i16> %l0, ptr %out0, align 2
  store <8 x i16> %l1, ptr %out1, align 2
  ret void
}

define void @too_wide_runtime(ptr %in0, ptr %out0, i64 %stride) {
entry:
  %in1 = getelementptr <8 x i16>, ptr %in0, i64 %stride
  %l0 = load <8 x i16>, ptr %in0, align 2
  %l1 = load <8 x i16>, ptr %in1, align 2
  %out1 = getelementptr i16, ptr %out0, i64 8
  store <8 x i16> %l0, ptr %out0, align 2
  store <8 x i16> %l1, ptr %out1, align 2
  ret void
}

; Stride size isn't aligned to the vector size
define void @non_aligned_stride(ptr %in0, ptr %out0) {
entry:
  %in1 = getelementptr i8, ptr %in0, i64 3
  %l0 = load <2 x i8>, ptr %in0, align 2
  %l1 = load <2 x i8>, ptr %in1, align 2
  %out1 = getelementptr i8, ptr %out0, i64 2
  store <2 x i8> %l0, ptr %out0, align 2
  store <2 x i8> %l1, ptr %out1, align 2
  ret void
}

; Stride size isn't aligned to the vector size
; Scalar version of @non_aligned_stride
define void @non_aligned_stride_scalar(ptr %in0, ptr %out0) {
entry:
  %in1 = getelementptr i8, ptr %in0, i64 1
  %in2 = getelementptr i8, ptr %in0, i64 3
  %in3 = getelementptr i8, ptr %in0, i64 4
  %l0 = load i8, ptr %in0, align 2
  %l1 = load i8, ptr %in1, align 2
  %l2 = load i8, ptr %in2, align 2
  %l3 = load i8, ptr %in3, align 2
  %out1 = getelementptr i8, ptr %out0, i64 1
  %out2 = getelementptr i8, ptr %out0, i64 2
  %out3 = getelementptr i8, ptr %out0, i64 3
  store i8 %l0, ptr %out0, align 2
  store i8 %l1, ptr %out1, align 2
  store i8 %l2, ptr %out2, align 2
  store i8 %l3, ptr %out3, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp18yqvckr.ll'
source_filename = "/tmp/tmp18yqvckr.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @widened_strided_load(ptr %in0, ptr %out0) #0 {
entry:
  %0 = call <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr align 2 %in0, i64 16, <2 x i1> splat (i1 true), i32 2)
  %1 = bitcast <2 x i64> %0 to <16 x i8>
  store <16 x i8> %1, ptr %out0, align 2
  ret void
}

define void @widened_strided_load_runtime(ptr %in0, ptr %out0, i64 %stride) #0 {
entry:
  %0 = mul i64 %stride, 8
  %1 = call <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr align 2 %in0, i64 %0, <2 x i1> splat (i1 true), i32 2)
  %2 = bitcast <2 x i64> %1 to <16 x i8>
  store <16 x i8> %2, ptr %out0, align 2
  ret void
}

define void @widened_strided_load_runtime_more_elements(ptr %in0, ptr %out0, i64 %stride) #0 {
entry:
  %0 = mul i64 %stride, 2
  %1 = call <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i64(ptr align 2 %in0, i64 %0, <4 x i1> splat (i1 true), i32 4)
  %2 = bitcast <4 x i16> %1 to <8 x i8>
  store <8 x i8> %2, ptr %out0, align 2
  ret void
}

define void @doubly_widened_strided_load(ptr %in0, ptr %out0) #0 {
entry:
  %0 = call <2 x i32> @llvm.experimental.vp.strided.load.v2i32.p0.i64(ptr align 2 %in0, i64 20, <2 x i1> splat (i1 true), i32 2)
  %1 = bitcast <2 x i32> %0 to <8 x i8>
  store <8 x i8> %1, ptr %out0, align 2
  ret void
}

define void @doubly_widened_strided_load_runtime(ptr %in0, ptr %out0, i64 %stride) #0 {
entry:
  %0 = mul i64 %stride, 2
  %1 = call <2 x i32> @llvm.experimental.vp.strided.load.v2i32.p0.i64(ptr align 2 %in0, i64 %0, <2 x i1> splat (i1 true), i32 2)
  %2 = bitcast <2 x i32> %1 to <8 x i8>
  store <8 x i8> %2, ptr %out0, align 2
  ret void
}

define void @too_wide(ptr %in0, ptr %out0) #0 {
entry:
  %in1 = getelementptr i16, ptr %in0, i64 16
  %0 = insertelement <2 x ptr> poison, ptr %in0, i32 0
  %1 = insertelement <2 x ptr> %0, ptr %in1, i32 1
  %2 = shufflevector <2 x ptr> %1, <2 x ptr> poison, <16 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %3 = getelementptr i16, <16 x ptr> %2, <16 x i64> <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %4 = call <16 x i16> @llvm.masked.gather.v16i16.v16p0(<16 x ptr> align 2 %3, <16 x i1> splat (i1 true), <16 x i16> poison)
  store <16 x i16> %4, ptr %out0, align 2
  ret void
}

define void @too_wide_runtime(ptr %in0, ptr %out0, i64 %stride) #0 {
entry:
  %in1 = getelementptr <8 x i16>, ptr %in0, i64 %stride
  %l0 = load <8 x i16>, ptr %in0, align 2
  %l1 = load <8 x i16>, ptr %in1, align 2
  %0 = shufflevector <8 x i16> %l0, <8 x i16> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %1 = shufflevector <8 x i16> %l1, <8 x i16> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %2 = shufflevector <16 x i16> %0, <16 x i16> %1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  store <16 x i16> %2, ptr %out0, align 2
  ret void
}

define void @non_aligned_stride(ptr %in0, ptr %out0) #0 {
entry:
  %in1 = getelementptr i8, ptr %in0, i64 3
  %0 = insertelement <2 x ptr> poison, ptr %in0, i32 0
  %1 = insertelement <2 x ptr> %0, ptr %in1, i32 1
  %2 = shufflevector <2 x ptr> %1, <2 x ptr> poison, <4 x i32> <i32 0, i32 0, i32 1, i32 1>
  %3 = getelementptr i8, <4 x ptr> %2, <4 x i64> <i64 0, i64 1, i64 0, i64 1>
  %4 = call <4 x i8> @llvm.masked.gather.v4i8.v4p0(<4 x ptr> align 2 %3, <4 x i1> splat (i1 true), <4 x i8> poison)
  store <4 x i8> %4, ptr %out0, align 2
  ret void
}

define void @non_aligned_stride_scalar(ptr %in0, ptr %out0) #0 {
entry:
  %0 = call <5 x i8> @llvm.masked.load.v5i8.p0(ptr align 2 %in0, <5 x i1> <i1 true, i1 true, i1 false, i1 true, i1 true>, <5 x i8> poison)
  %1 = shufflevector <5 x i8> %0, <5 x i8> poison, <4 x i32> <i32 0, i32 1, i32 3, i32 4>
  store <4 x i8> %1, ptr %out0, align 2
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr captures(none), i64, <2 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i64(ptr captures(none), i64, <4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <2 x i32> @llvm.experimental.vp.strided.load.v2i32.p0.i64(ptr captures(none), i64, <2 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i16> @llvm.masked.gather.v16i16.v16p0(<16 x ptr>, <16 x i1>, <16 x i16>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <4 x i8> @llvm.masked.gather.v4i8.v4p0(<4 x ptr>, <4 x i1>, <4 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <5 x i8> @llvm.masked.load.v5i8.p0(ptr captures(none), <5 x i1>, <5 x i8>) #1

attributes #0 = { "target-cpu"="sifive-p870" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(read) }
