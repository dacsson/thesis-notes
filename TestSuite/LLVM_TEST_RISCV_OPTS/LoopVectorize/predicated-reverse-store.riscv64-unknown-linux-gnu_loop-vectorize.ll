; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/predicated-reverse-store.ll
; Variant: riscv64-unknown-linux-gnu_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64-unknown-linux-gnu -S
; Original: RUN: opt -passes=loop-vectorize -mtriple=riscv64-unknown-linux-gnu -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @reverse_predicated_store(i1 %c, ptr %dst, i64 %n) #0 {
entry:
  br label %loop

loop:
  %iv = phi i64 [ %n, %entry ], [ %iv.next, %loop.latch ]
  %iv.next = add i64 %iv, -1
  br i1 %c, label %if.then, label %loop.latch

if.then:
  %arrayidx = getelementptr float, ptr %dst, i64 %iv.next
  store float 0.000000e+00, ptr %arrayidx, align 4
  br label %loop.latch

loop.latch:
  %exit.cond = icmp eq i64 %iv, 0
  br i1 %exit.cond, label %exit, label %loop

exit:
  ret void
}

attributes #0 = { "target-cpu"="sifive-p670" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpp93ghpyb.ll'
source_filename = "/tmp/tmpp93ghpyb.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @reverse_predicated_store(i1 %c, ptr %dst, i64 %n) #0 {
entry:
  %0 = add i64 %n, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = sub i64 %n, %index
  %3 = add i64 %2, -1
  %4 = getelementptr float, ptr %dst, i64 %3
  %5 = call <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1> %broadcast.splat, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %6 = zext i32 %1 to i64
  %7 = sub nuw nsw i64 %6, 1
  %8 = sub i64 0, %7
  %9 = getelementptr float, ptr %4, i64 %8
  %10 = call <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float> zeroinitializer, <vscale x 4 x i1> splat (i1 true), i32 %1)
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %10, ptr align 4 %9, <vscale x 4 x i1> %5, i32 %1)
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %11 = icmp eq i64 %avl.next, 0
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float>, ptr captures(none), <vscale x 4 x i1>, i32) #2

attributes #0 = { "target-cpu"="sifive-p670" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
