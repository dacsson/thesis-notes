; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/pointer-induction-rv32.ll
; Variant: riscv32_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv32 -mattr=+v -S
; Original: RUN: opt < %s -S -p loop-vectorize -mtriple riscv32 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; The VPWidenPointerInductionRecipe is expanded into a ptradd that uses EVL,
; make sure we allow it in VPlanVerifier
define i32 @widenpointerinduction_evl(ptr noalias %p) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ],  [ %iv.next, %loop ]
  %x = phi ptr [ %p, %entry ], [ %x.next, %loop ]

  store ptr %x, ptr %p

  %iv.next = add i32 %iv, 1
  %x.next = getelementptr i8, ptr %x, i32 1
  %ec = icmp eq i32 %iv.next, 1024
  br i1 %ec, label %exit, label %loop

exit:
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpjj5z5fv6.ll'
source_filename = "/tmp/tmpjj5z5fv6.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define i32 @widenpointerinduction_evl(ptr noalias %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x ptr> poison, ptr %p, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %pointer.phi = phi ptr [ %p, %vector.ph ], [ %ptr.ind, %vector.body ]
  %avl = phi i32 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  %vector.gep = getelementptr i8, ptr %pointer.phi, <vscale x 4 x i32> %0
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  call void @llvm.vp.scatter.nxv4p0.nxv4p0(<vscale x 4 x ptr> %vector.gep, <vscale x 4 x ptr> align 4 %broadcast.splat, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %avl.next = sub nuw i32 %avl, %1
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i32 %1
  %2 = icmp eq i32 %avl.next, 0
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4p0.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
