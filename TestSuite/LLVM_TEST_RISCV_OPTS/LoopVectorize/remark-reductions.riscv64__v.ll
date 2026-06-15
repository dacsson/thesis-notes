; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/remark-reductions.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -p loop-vectorize -pass-remarks-analysis=loop-vectorize -S
; Original: RUN: opt < %s -mtriple=riscv64 -mattr=+v -p loop-vectorize -pass-remarks-analysis=loop-vectorize -S 2>&1 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define float @s311(float %a_0, float %s311_sum) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %red = phi float [ %s311_sum, %entry ], [ %red.next, %loop ]
  %red.next = fadd float %a_0, %red
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond = icmp eq i32 %iv.next, 1200
  br i1 %exitcond, label %exit, label %loop

exit:
  %red.lcssa = phi float [ %red.next, %loop ]
  ret float %red.lcssa
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpa0txjyfx.ll'
source_filename = "/tmp/tmpa0txjyfx.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define float @s311(float %a_0, float %s311_sum) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x float> poison, float %a_0, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x float> %broadcast.splatinsert, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.phi = phi float [ %s311_sum, %vector.ph ], [ %1, %vector.body ]
  %avl = phi i32 [ 1200, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %1 = call float @llvm.vp.reduce.fadd.nxv4f32(float %vec.phi, <vscale x 4 x float> %broadcast.splat, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %avl.next = sub nuw i32 %avl, %0
  %2 = icmp eq i32 %avl.next, 0
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret float %1
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vp.reduce.fadd.nxv4f32(float, <vscale x 4 x float>, <vscale x 4 x i1>, i32) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2, !3}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.vectorize.body", i32 1}
!3 = !{!"llvm.loop.unroll.runtime.disable"}
