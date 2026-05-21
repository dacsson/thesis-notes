; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/vf-will-not-generate-any-vector-insts.ll
; Variant: +v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mattr=+v -passes=loop-vectorize -S
; Original: RUN: opt  -mattr=+v -passes=loop-vectorize -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown-elf"

define void @vf_will_not_generate_any_vector_insts(ptr %src, ptr %dst) {
entry:
  br label %loop

loop:
  %0 = phi i64 [ 0, %entry ], [ %1, %loop ]
  %.pre = load i32, ptr %src, align 4
  store i32 %.pre, ptr %dst, align 4
  %1 = add nuw i64 %0, 1
  %ec = icmp eq i64 %1, 100
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmplmo6nqbs.ll'
source_filename = "/tmp/tmplmo6nqbs.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown-elf"

define void @vf_will_not_generate_any_vector_insts(ptr %src, ptr %dst) #0 {
entry:
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %dst, i64 4
  %scevgep1 = getelementptr i8, ptr %src, i64 4
  %bound0 = icmp ult ptr %dst, %scevgep1
  %bound1 = icmp ult ptr %src, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %0 = load i32, ptr %src, align 4, !alias.scope !0
  %broadcast.splatinsert2 = insertelement <vscale x 4 x i32> poison, i32 %0, i64 0
  %broadcast.splat3 = shufflevector <vscale x 4 x i32> %broadcast.splatinsert2, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert = insertelement <vscale x 4 x ptr> poison, ptr %dst, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %broadcast.splat3, <vscale x 4 x ptr> align 4 %broadcast.splat, <vscale x 4 x i1> splat (i1 true), i32 %1), !alias.scope !3, !noalias !0
  %2 = zext i32 %1 to i64
  %avl.next = sub nuw i64 %avl, %2
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %4 = phi i64 [ 0, %scalar.ph ], [ %5, %loop ]
  %.pre = load i32, ptr %src, align 4
  store i32 %.pre, ptr %dst, align 4
  %5 = add nuw i64 %4, 1
  %ec = icmp eq i64 %5, 100
  br i1 %ec, label %exit, label %loop, !llvm.loop !8

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.isvectorized", i32 1}
!7 = !{!"llvm.loop.unroll.runtime.disable"}
!8 = distinct !{!8, !6}
