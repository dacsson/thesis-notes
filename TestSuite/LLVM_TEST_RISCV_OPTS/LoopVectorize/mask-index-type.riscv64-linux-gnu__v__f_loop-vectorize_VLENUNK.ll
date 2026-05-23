; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/mask-index-type.ll
; Variant: riscv64-linux-gnu_+v,+f_loop-vectorize_VLENUNK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+v,+f -S 2>%t | FileCheck %s -check-prefix=VLENUNK

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

; FIXME: In this example, we pick a vector index with which is wider than
; the data width.  This is correct, but sub-optimal as it causes a vsetvli
; toggle in the generated code for no reason.  We could have used a i32
; element type for the index here and matched the data width.
define void @test(ptr noalias nocapture %a, ptr noalias nocapture %b, i32 %v) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %icmp = icmp ult i64 %iv, 512
  br i1 %icmp, label %do_load, label %latch

do_load:
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %elem = load i32, ptr %arrayidx
  br label %latch

latch:
  %phi = phi i32 [%elem, %do_load], [0, %for.body]
  %add = add i32 %phi, %v
  %arrayidx2 = getelementptr inbounds i32, ptr %b, i64 %iv
  store i32 %add, ptr %arrayidx2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpvt9tkgp3.ll'
source_filename = "/tmp/tmpvt9tkgp3.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i32 %v) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert1, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = icmp ult <vscale x 4 x i64> %vec.ind, splat (i64 512)
  %4 = getelementptr i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %4, <vscale x 4 x i1> %3, i32 %1)
  %predphi = select <vscale x 4 x i1> %3, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> zeroinitializer
  %5 = add <vscale x 4 x i32> %predphi, %broadcast.splat
  %6 = getelementptr inbounds i32, ptr %b, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %5, ptr align 4 %6, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat2
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #4

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
