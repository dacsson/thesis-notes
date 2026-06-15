; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/revec-strided-store.ll
; Variant: riscv64_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mcpu=sifive-p870 -passes=slp-vectorizer -slp-revec -slp-threshold=-100 -S
; Original: RUN: opt -mtriple=riscv64 -mcpu=sifive-p870 -passes=slp-vectorizer -S -slp-revec -slp-threshold=-100 %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Strided load into strided store
define void @strided_load_and_store(ptr %in, ptr %out) {
entry:
  %0 = getelementptr i8, ptr %in, i64 16
  %1 = load <8 x i8>, ptr %in, align 2
  %2 = load <8 x i8>, ptr %0, align 2
  %5 = getelementptr i8, ptr %out, i64 16
  store <8 x i8> %1, ptr %out, align 2
  store <8 x i8> %2, ptr %5, align 2
  ret void
}

; Base case of strided store, implicitly is widened
define void @widened_strided_store(ptr %out0) {
  %1 = getelementptr i16, ptr null, i64 16
  store <4 x i16> zeroinitializer, ptr %1, align 2
  store <4 x i16> zeroinitializer, ptr null, align 2
  ret void
}

; Widened strided store pattern but vectorized types
define void @doubly_widened_strided_store(ptr %out0) {
  %out1 = getelementptr i8, ptr %out0, i64 2
  %out2 = getelementptr i8, ptr %out0, i64 12
  %out3 = getelementptr i8, ptr %out0, i64 14
  store <2 x i8> zeroinitializer, ptr %out0, align 2
  store <2 x i8> zeroinitializer, ptr %out1, align 2
  store <2 x i8> zeroinitializer, ptr %out2, align 2
  store <2 x i8> zeroinitializer, ptr %out3, align 2
  ret void
}

; The resulting widened type isn't legal
define void @too_wide(ptr %out0) {
entry:
  %out1 = getelementptr i16, ptr %out0, i64 8
  store <8 x i16> zeroinitializer, ptr %out0, align 2
  store <8 x i16> zeroinitializer, ptr %out1, align 2
  ret void
}

; Stride size isn't aligned to the vector size
define void @non_aligned_stride(ptr %out0) {
entry:
  %out1 = getelementptr i8, ptr %out0, i64 3
  store <2 x i8> zeroinitializer, ptr %out0, align 2
  store <2 x i8> zeroinitializer, ptr %out1, align 2
  ret void
}

; Stride size isn't aligned to the vector size
; Scalar version of @non_aligned_stride
define void @non_aligned_stride_scalar(ptr %out0) {
entry:
  %out1 = getelementptr i8, ptr %out0, i64 1
  %out2 = getelementptr i8, ptr %out0, i64 3
  %out3 = getelementptr i8, ptr %out0, i64 4
  store i8 0, ptr %out0, align 2
  store i8 0, ptr %out1, align 2
  store i8 0, ptr %out2, align 2
  store i8 0, ptr %out3, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpmlft0x9x.ll'
source_filename = "/tmp/tmpmlft0x9x.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @strided_load_and_store(ptr %in, ptr %out) #0 {
entry:
  %0 = call <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr align 2 %in, i64 16, <2 x i1> splat (i1 true), i32 2)
  %1 = bitcast <2 x i64> %0 to <16 x i8>
  %2 = getelementptr i8, ptr %out, i64 16
  %3 = shufflevector <16 x i8> %1, <16 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  store <8 x i8> %3, ptr %out, align 2
  %4 = shufflevector <16 x i8> %1, <16 x i8> poison, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  store <8 x i8> %4, ptr %2, align 2
  ret void
}

define void @widened_strided_store(ptr %out0) #0 {
  %1 = getelementptr i16, ptr null, i64 16
  store <4 x i16> zeroinitializer, ptr %1, align 2
  store <4 x i16> zeroinitializer, ptr null, align 2
  ret void
}

define void @doubly_widened_strided_store(ptr %out0) #0 {
  %out2 = getelementptr i8, ptr %out0, i64 12
  store <4 x i8> zeroinitializer, ptr %out0, align 2
  store <4 x i8> zeroinitializer, ptr %out2, align 2
  ret void
}

define void @too_wide(ptr %out0) #0 {
entry:
  store <16 x i16> zeroinitializer, ptr %out0, align 2
  ret void
}

define void @non_aligned_stride(ptr %out0) #0 {
entry:
  %out1 = getelementptr i8, ptr %out0, i64 3
  store <2 x i8> zeroinitializer, ptr %out0, align 2
  store <2 x i8> zeroinitializer, ptr %out1, align 2
  ret void
}

define void @non_aligned_stride_scalar(ptr %out0) #0 {
entry:
  %out2 = getelementptr i8, ptr %out0, i64 3
  store <2 x i8> zeroinitializer, ptr %out0, align 2
  store <2 x i8> zeroinitializer, ptr %out2, align 2
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i64(ptr captures(none), i64, <2 x i1>, i32) #1

attributes #0 = { "target-cpu"="sifive-p870" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
