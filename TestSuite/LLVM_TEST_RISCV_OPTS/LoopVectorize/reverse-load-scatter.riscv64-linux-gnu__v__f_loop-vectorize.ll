; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/reverse-load-scatter.ll
; Variant: riscv64-linux-gnu_+v,+f_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-linux-gnu -mattr=+v,+f -passes=loop-vectorize -force-vector-width=2 -scalable-vectorization=on -S
; Original: RUN: opt -mtriple=riscv64-linux-gnu -mattr=+v,+f -passes=loop-vectorize -force-vector-width=2 -scalable-vectorization=on -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @reverse_load_scatter(ptr noalias %src, ptr noalias %dst, i64 %n) {
entry:
  br label %loop

loop:
  %iv.dec = phi i64 [ %n, %entry ], [ %iv.dec.next, %loop ]
  %src.ptr = getelementptr inbounds i64, ptr %src, i64 %iv.dec
  %val = load i64, ptr %src.ptr, align 8
  %dst.ptr = getelementptr inbounds i64, ptr %dst, i64 %val
  store i64 %val, ptr %dst.ptr, align 8
  %iv.dec.next = add i64 %iv.dec, -1
  %done = icmp eq i64 %iv.dec.next, 0
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpmq_lva50.ll'
source_filename = "/tmp/tmpmq_lva50.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @reverse_load_scatter(ptr noalias %src, ptr noalias %dst, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = sub i64 %n, %index
  %2 = getelementptr inbounds i64, ptr %src, i64 %1
  %3 = zext i32 %0 to i64
  %4 = sub nuw nsw i64 %3, 1
  %5 = sub i64 0, %4
  %6 = getelementptr i64, ptr %2, i64 %5
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %6, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %7 = call <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %8 = getelementptr inbounds i64, ptr %dst, <vscale x 2 x i64> %7
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %7, <vscale x 2 x ptr> align 8 %8, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %current.iteration.next = add i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
