; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-uniform-store.ll
; Variant: +v,+f_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --tail-folding-policy=prefer-fold-tail --passes=loop-vectorize -mcpu=sifive-p470 -mattr=+v,+f -S
; Original: RUN: opt < %s --tail-folding-policy=prefer-fold-tail --passes=loop-vectorize -mcpu=sifive-p470 -mattr=+v,+f -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

; Generated from issue #109468.
; In this test case, the vector store with tail mask will transfer to the vp intrinsic with EVL.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @lshift_significand(i32 %n, ptr nocapture writeonly %dst) {
entry:
  %cmp1.peel = icmp eq i32 %n, 0
  %spec.select = select i1 %cmp1.peel, i64 2, i64 0
  br label %loop

loop:
  %iv = phi i64 [ %spec.select, %entry ], [ %iv.next, %loop ]
  %1 = sub nuw nsw i64 1, %iv
  %arrayidx13 = getelementptr i64, ptr %dst, i64 %1
  store i64 0, ptr %arrayidx13, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 3
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !0

exit:
  ret void
}

!0 = distinct !{!0, !1, !2, !3}
!1 = !{!"llvm.loop.vectorize.width", i32 2}
!2 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}
!3 = !{!"llvm.loop.vectorize.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpu42_kvc3.ll'
source_filename = "/tmp/tmpu42_kvc3.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @lshift_significand(i32 %n, ptr writeonly captures(none) %dst) #0 {
entry:
  %cmp1.peel = icmp eq i32 %n, 0
  %spec.select = select i1 %cmp1.peel, i64 2, i64 0
  %0 = sub i64 3, %spec.select
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = add i64 %spec.select, %index
  %3 = sub nuw nsw i64 1, %2
  %4 = getelementptr i64, ptr %dst, i64 %3
  %5 = zext i32 %1 to i64
  %6 = sub nuw nsw i64 %5, 1
  %7 = sub i64 0, %6
  %8 = getelementptr i64, ptr %4, i64 %7
  %9 = call <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64> zeroinitializer, <vscale x 2 x i1> splat (i1 true), i32 %1)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %9, ptr align 8 %8, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #2

attributes #0 = { "target-cpu"="sifive-p470" "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
