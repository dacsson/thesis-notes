; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/evl-compatible-loops.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure we do not vectorize a loop with a widened int induction.
define void @test_wide_integer_induction(ptr noalias %a, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %iv, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; Make sure we do not vectorize a loop with a widened ptr induction.
define void @test_wide_ptr_induction(ptr noalias %a, ptr noalias %b, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %addr = phi ptr [ %incdec.ptr, %for.body ], [ %b, %entry ]
  %incdec.ptr = getelementptr inbounds i8, ptr %addr, i64 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store ptr %addr, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpsk26hdq7.ll'
source_filename = "/tmp/tmpsk26hdq7.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test_wide_integer_induction(ptr noalias %a, i64 %N) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %3 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %vec.ind, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %middle.block
  ret void
}

define void @test_wide_ptr_induction(ptr noalias %a, ptr noalias %b, i64 %N) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %pointer.phi = phi ptr [ %b, %vector.ph ], [ %ptr.ind, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %1 = shl <vscale x 2 x i64> %0, splat (i64 3)
  %vector.gep = getelementptr i8, ptr %pointer.phi, <vscale x 2 x i64> %1
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %3 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2p0.p0(<vscale x 2 x ptr> %vector.gep, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %2)
  %4 = zext i32 %2 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = shl i64 %4, 3
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2p0.p0(<vscale x 2 x ptr>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
