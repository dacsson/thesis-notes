; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/unordered-loads-operands.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -slp-threshold=-1000 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -slp-threshold=-1000 %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %mdct_forward_x) {
entry:
  br label %for.cond

for.cond:
  %0 = load ptr, ptr %mdct_forward_x, align 8
  %add.ptr.i = getelementptr i8, ptr %0, i64 24
  %arrayidx.i.i = getelementptr i8, ptr %0, i64 48
  %1 = load float, ptr %arrayidx.i.i, align 4
  %add.i.i = fadd float %1, 0.000000e+00
  %arrayidx2.i.i = getelementptr i8, ptr %0, i64 32
  %2 = load float, ptr %arrayidx2.i.i, align 4
  %sub.i.i = fsub float %1, %2
  %3 = load float, ptr %add.ptr.i, align 4
  %add4.i.i = fadd float %3, 0.000000e+00
  %arrayidx5.i.i = getelementptr i8, ptr %0, i64 40
  %4 = load float, ptr %arrayidx5.i.i, align 4
  %sub7.i.i = fsub float %4, %3
  %sub8.i.i = fsub float %add.i.i, %add4.i.i
  store float %sub8.i.i, ptr %arrayidx5.i.i, align 4
  %arrayidx10.i.i = getelementptr i8, ptr %0, i64 28
  %5 = load float, ptr %arrayidx10.i.i, align 4
  %sub11.i.i = fsub float 0.000000e+00, %5
  %arrayidx12.i.i = getelementptr i8, ptr %0, i64 36
  %6 = load float, ptr %arrayidx12.i.i, align 4
  %sub13.i.i = fsub float 0.000000e+00, %6
  store float 0.000000e+00, ptr %add.ptr.i, align 4
  %sub15.i.i = fsub float %sub.i.i, %sub11.i.i
  store float %sub15.i.i, ptr %arrayidx2.i.i, align 4
  %add17.i.i = fadd float %sub7.i.i, %sub13.i.i
  store float %add17.i.i, ptr %arrayidx12.i.i, align 4
  %arrayidx20.i.i = getelementptr i8, ptr %0, i64 44
  store float %sub15.i.i, ptr %arrayidx20.i.i, align 4
  br label %for.cond
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpkmyunvy2.ll'
source_filename = "/tmp/tmpkmyunvy2.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(ptr %mdct_forward_x) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %0 = load ptr, ptr %mdct_forward_x, align 8
  %arrayidx2.i.i = getelementptr i8, ptr %0, i64 32
  %arrayidx5.i.i = getelementptr i8, ptr %0, i64 40
  %add.ptr.i = getelementptr i8, ptr %0, i64 24
  %1 = insertelement <4 x ptr> poison, ptr %0, i32 0
  %2 = shufflevector <4 x ptr> %1, <4 x ptr> poison, <4 x i32> zeroinitializer
  %3 = getelementptr i8, <4 x ptr> %2, <4 x i64> <i64 28, i64 36, i64 24, i64 28>
  %4 = call <3 x float> @llvm.masked.load.v3f32.p0(ptr align 4 %add.ptr.i, <3 x i1> <i1 true, i1 false, i1 true>, <3 x float> poison)
  %5 = shufflevector <3 x float> %4, <3 x float> poison, <2 x i32> <i32 2, i32 0>
  %6 = call <3 x float> @llvm.masked.load.v3f32.p0(ptr align 4 %arrayidx5.i.i, <3 x i1> <i1 true, i1 false, i1 true>, <3 x float> poison)
  %7 = call <4 x float> @llvm.masked.gather.v4f32.v4p0(<4 x ptr> align 4 %3, <4 x i1> splat (i1 true), <4 x float> poison)
  %8 = shufflevector <3 x float> %6, <3 x float> poison, <4 x i32> <i32 2, i32 0, i32 2, i32 2>
  %9 = shufflevector <2 x float> %5, <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %10 = shufflevector <3 x float> %4, <3 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 poison>
  %11 = shufflevector <4 x float> <float poison, float poison, float 0.000000e+00, float poison>, <4 x float> %10, <4 x i32> <i32 poison, i32 poison, i32 2, i32 6>
  %12 = shufflevector <4 x float> %11, <4 x float> %9, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
  %13 = fsub <4 x float> %8, %12
  %14 = fadd <4 x float> %8, %12
  %15 = shufflevector <4 x float> %13, <4 x float> %14, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  %16 = fsub <4 x float> zeroinitializer, %7
  %17 = fadd <4 x float> zeroinitializer, %7
  %18 = shufflevector <4 x float> %16, <4 x float> %17, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  store float 0.000000e+00, ptr %add.ptr.i, align 4
  %19 = fsub <4 x float> %15, %18
  %20 = fadd <4 x float> %15, %18
  %21 = shufflevector <4 x float> %19, <4 x float> %20, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  store <4 x float> %21, ptr %arrayidx2.i.i, align 4
  br label %for.cond
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <3 x float> @llvm.masked.load.v3f32.p0(ptr captures(none), <3 x i1>, <3 x float>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <4 x float> @llvm.masked.gather.v4f32.v4p0(<4 x ptr>, <4 x i1>, <4 x float>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(read) }
