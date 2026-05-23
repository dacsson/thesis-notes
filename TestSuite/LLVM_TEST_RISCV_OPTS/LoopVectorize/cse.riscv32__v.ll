; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/cse.ll
; Variant: riscv32_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv32 -mattr=+v -S
; Original: RUN: opt < %s -S -p loop-vectorize -mtriple riscv32 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; The EVL here is used by two VPWidenPointerInductionRecipes which are then
; expanded to two muls. The muls are then CSE'd, so make sure the verifier
; doesn't complain if a user of EVL has multiple uses.
define i32 @widenpointerinduction_evl_cse(ptr noalias %p0, ptr noalias %p1) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry], [ %iv.next, %loop ]
  %x = phi ptr [ %p0, %entry ], [ %x.next, %loop ]
  %y = phi ptr [ %p1, %entry ], [ %y.next, %loop ]

  store ptr %x, ptr %p0
  store ptr %y, ptr %p1

  %iv.next = add i32 %iv, 1
  %x.next = getelementptr i8, ptr %x, i32 2
  %y.next = getelementptr i8, ptr %y, i32 2
  %ec = icmp eq i32 %iv.next, 1024
  br i1 %ec, label %exit, label %loop

exit:
  ret i32 0
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpifl0hp67.ll'
source_filename = "/tmp/tmpifl0hp67.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define i32 @widenpointerinduction_evl_cse(ptr noalias %p0, ptr noalias %p1) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x ptr> poison, ptr %p0, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 4 x ptr> poison, ptr %p1, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert1, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %pointer.phi = phi ptr [ %p0, %vector.ph ], [ %ptr.ind, %vector.body ]
  %pointer.phi3 = phi ptr [ %p1, %vector.ph ], [ %ptr.ind5, %vector.body ]
  %avl = phi i32 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  %1 = shl <vscale x 4 x i32> %0, splat (i32 1)
  %vector.gep = getelementptr i8, ptr %pointer.phi3, <vscale x 4 x i32> %1
  %vector.gep4 = getelementptr i8, ptr %pointer.phi, <vscale x 4 x i32> %1
  %2 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  call void @llvm.vp.scatter.nxv4p0.nxv4p0(<vscale x 4 x ptr> %vector.gep4, <vscale x 4 x ptr> align 4 %broadcast.splat, <vscale x 4 x i1> splat (i1 true), i32 %2)
  call void @llvm.vp.scatter.nxv4p0.nxv4p0(<vscale x 4 x ptr> %vector.gep, <vscale x 4 x ptr> align 4 %broadcast.splat2, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i32 %avl, %2
  %3 = shl i32 %2, 1
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i32 %3
  %ptr.ind5 = getelementptr i8, ptr %pointer.phi3, i32 %3
  %4 = icmp eq i32 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

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
