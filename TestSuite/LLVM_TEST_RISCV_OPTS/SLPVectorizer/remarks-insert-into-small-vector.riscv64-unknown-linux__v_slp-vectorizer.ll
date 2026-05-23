; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/remarks-insert-into-small-vector.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -pass-remarks-output= -mattr=+v -slp-threshold=-10 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -pass-remarks-output=%t -mattr=+v -slp-threshold=-10 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @test() {
entry:
  %0 = load float, ptr null, align 4
  %1 = load float, ptr null, align 4
  %2 = load float, ptr null, align 4
  %cmp.i = fcmp ogt float %1, %0
  %v14.0 = select i1 %cmp.i, float %1, float 0.000000e+00
  %v0.0 = select i1 %cmp.i, float %0, float 0.000000e+00
  %cmp4.i = fcmp ogt float 0.000000e+00, %2
  %v19.0 = select i1 %cmp4.i, float 0.000000e+00, float 0.000000e+00
  %v9.0 = select i1 %cmp4.i, float %2, float 0.000000e+00
  store float %v0.0, ptr null, align 4
  %v9idx = getelementptr i8, ptr null, i32 4
  store float %v9.0, ptr %v9idx, align 4
  %v14idx = getelementptr i8, ptr null, i32 8
  store float %v14.0, ptr %v14idx, align 4
  %v19idx = getelementptr i8, ptr null, i32 12
  store float %v19.0, ptr %v19idx, align 4
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpd5zv82cm.ll'
source_filename = "/tmp/tmpd5zv82cm.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @test() #0 {
entry:
  %0 = load float, ptr null, align 4
  %1 = call <2 x float> @llvm.masked.gather.v2f32.v2p0(<2 x ptr> align 4 splat (ptr null), <2 x i1> splat (i1 true), <2 x float> poison)
  %2 = insertelement <2 x float> <float poison, float 0.000000e+00>, float %0, i32 0
  %3 = fcmp ogt <2 x float> %2, %1
  %4 = shufflevector <2 x i1> %3, <2 x i1> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %5 = shufflevector <2 x float> %1, <2 x float> %2, <4 x i32> <i32 0, i32 1, i32 2, i32 poison>
  %6 = shufflevector <4 x float> %5, <4 x float> <float poison, float poison, float poison, float 0.000000e+00>, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %7 = select <4 x i1> %4, <4 x float> %6, <4 x float> zeroinitializer
  store <4 x float> %7, ptr null, align 4
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <2 x float> @llvm.masked.gather.v2f32.v2p0(<2 x ptr>, <2 x i1>, <2 x float>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
