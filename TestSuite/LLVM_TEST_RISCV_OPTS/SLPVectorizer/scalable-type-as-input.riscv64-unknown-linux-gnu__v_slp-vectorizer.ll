; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/scalable-type-as-input.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(i32 %lhsWords) {
entry:
  %wide.vp.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr null, <vscale x 4 x i1> zeroinitializer, i32 0)
  %strided.vec = call { <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave2.nxv4i32(<vscale x 4 x i32> %wide.vp.load)
  %0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } %strided.vec, 0
  %1 = zext <vscale x 2 x i32> %0 to <vscale x 2 x i64>
  %wide.trip.count404 = zext i32 %lhsWords to i64
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %wide.trip.count404, i32 1, i1 false)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %1, ptr null, <vscale x 2 x i1> zeroinitializer, i32 %2)
  ret void
}

declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32)
declare { <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave2.nxv4i32(<vscale x 4 x i32>)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpimhmvhwk.ll'
source_filename = "/tmp/tmpimhmvhwk.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(i32 %lhsWords) #0 {
entry:
  %wide.vp.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr null, <vscale x 4 x i1> zeroinitializer, i32 0)
  %strided.vec = call { <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave2.nxv4i32(<vscale x 4 x i32> %wide.vp.load)
  %0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } %strided.vec, 0
  %1 = zext <vscale x 2 x i32> %0 to <vscale x 2 x i64>
  %wide.trip.count404 = zext i32 %lhsWords to i64
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %wide.trip.count404, i32 1, i1 false)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %1, ptr null, <vscale x 2 x i1> zeroinitializer, i32 %2)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave2.nxv4i32(<vscale x 4 x i32>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) "target-features"="+v" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) "target-features"="+v" }
