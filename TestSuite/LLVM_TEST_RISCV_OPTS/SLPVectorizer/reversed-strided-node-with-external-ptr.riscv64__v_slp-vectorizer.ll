; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reversed-strided-node-with-external-ptr.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -slp-threshold=-99999 -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -slp-threshold=-99999 -mtriple=riscv64 -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %a, i64 %0) {
entry:
  br label %bb

bb:
  %indvars.iv.next239.i = add i64 0, 0
  %arrayidx.i.1 = getelementptr double, ptr %a, i64 %indvars.iv.next239.i
  %1 = load double, ptr %arrayidx.i.1, align 8
  %arrayidx10.i.1 = getelementptr double, ptr %a, i64 %0
  %2 = or disjoint i64 %0, 1
  %arrayidx17.i28.1 = getelementptr double, ptr %a, i64 %2
  %3 = load double, ptr %arrayidx17.i28.1, align 8
  %4 = load double, ptr %a, align 8
  %5 = load double, ptr %a, align 8
  %arrayidx38.i.1 = getelementptr double, ptr %a, i64 1
  %6 = load double, ptr %arrayidx38.i.1, align 8
  %arrayidx41.i.1 = getelementptr double, ptr %a, i64 1
  %7 = load double, ptr %arrayidx41.i.1, align 8
  %sub47.i.1 = fsub double %4, %5
  %sub54.i.1 = fsub double %6, %7
  %sub69.i.1 = fsub double %1, %sub54.i.1
  store double %sub69.i.1, ptr %arrayidx10.i.1, align 8
  %sub72.i.1 = fsub double %3, %sub47.i.1
  store double %sub72.i.1, ptr %arrayidx17.i28.1, align 8
  br label %bb
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpm__yp5vl.ll'
source_filename = "/tmp/tmpm__yp5vl.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test(ptr %a, i64 %0) #0 {
entry:
  %1 = insertelement <2 x ptr> poison, ptr %a, i32 0
  %2 = shufflevector <2 x ptr> %1, <2 x ptr> poison, <2 x i32> zeroinitializer
  %3 = insertelement <2 x i64> <i64 poison, i64 0>, i64 %0, i32 0
  br label %bb

bb:                                               ; preds = %bb, %entry
  %4 = or disjoint <2 x i64> %3, <i64 1, i64 0>
  %5 = getelementptr double, <2 x ptr> %2, <2 x i64> %4
  %6 = extractelement <2 x ptr> %5, i32 0
  %7 = call <2 x double> @llvm.masked.gather.v2f64.v2p0(<2 x ptr> align 8 %5, <2 x i1> splat (i1 true), <2 x double> poison)
  %8 = load <2 x double>, ptr %a, align 8
  %9 = load <2 x double>, ptr %a, align 8
  %10 = fsub <2 x double> %8, %9
  %11 = fsub <2 x double> %7, %10
  call void @llvm.experimental.vp.strided.store.v2f64.p0.i64(<2 x double> %11, ptr align 8 %6, i64 -8, <2 x i1> splat (i1 true), i32 2)
  br label %bb
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <2 x double> @llvm.masked.gather.v2f64.v2p0(<2 x ptr>, <2 x i1>, <2 x double>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.vp.strided.store.v2f64.p0.i64(<2 x double>, ptr captures(none), i64, <2 x i1>, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
