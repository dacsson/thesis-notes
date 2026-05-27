; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/zvl1024b-crash.ll
; Variant: riscv64_+v,+zvl1024b
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v,+zvl1024b -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64 -mattr=+v,+zvl1024b < %s -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @foo(i32 %0, ptr %p) {
entry:
  br label %loop

exit:
  ret void

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %exiting ]
  switch i32 %0, label %loop.split [
  i32 308, label %exiting
  i32 309, label %exiting
  i32 160, label %exiting
  i32 243, label %exiting
  i32 53, label %exiting
  i32 162, label %exiting
  i32 161, label %exiting
  i32 172, label %exiting
  i32 159, label %exiting
  ]

loop.split:
  %arridx = getelementptr i8, ptr %p, i64 %iv
  store i8 0, ptr %arridx, align 1
  br label %exiting

exiting:
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv, 523
  br i1 %exitcond.not, label %exit, label %loop
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp9tn8h4zp.ll'
source_filename = "/tmp/tmp9tn8h4zp.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @foo(i32 %0, ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 8 x i32> poison, i32 %0, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i32> %broadcast.splatinsert, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %1 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 308)
  %2 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 309)
  %3 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 160)
  %4 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 243)
  %5 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 53)
  %6 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 162)
  %7 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 161)
  %8 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 172)
  %9 = icmp eq <vscale x 8 x i32> %broadcast.splat, splat (i32 159)
  %10 = or <vscale x 8 x i1> %1, %2
  %11 = or <vscale x 8 x i1> %10, %3
  %12 = or <vscale x 8 x i1> %11, %4
  %13 = or <vscale x 8 x i1> %12, %5
  %14 = or <vscale x 8 x i1> %13, %6
  %15 = or <vscale x 8 x i1> %14, %7
  %16 = or <vscale x 8 x i1> %15, %8
  %17 = or <vscale x 8 x i1> %16, %9
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 524, %vector.ph ], [ %avl.next, %vector.body ]
  %18 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %19 = call <vscale x 8 x i1> @llvm.vp.merge.nxv8i1(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x i1> %17, <vscale x 8 x i1> zeroinitializer, i32 %18)
  %20 = xor <vscale x 8 x i1> %19, splat (i1 true)
  %21 = getelementptr i8, ptr %p, i64 %index
  call void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8> zeroinitializer, ptr align 1 %21, <vscale x 8 x i1> %20, i32 %18)
  %22 = zext i32 %18 to i64
  %current.iteration.next = add nuw i64 %22, %index
  %avl.next = sub nuw i64 %avl, %22
  %23 = icmp eq i64 %avl.next, 0
  br i1 %23, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i1> @llvm.vp.merge.nxv8i1(<vscale x 8 x i1>, <vscale x 8 x i1>, <vscale x 8 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8>, ptr captures(none), <vscale x 8 x i1>, i32) #2

attributes #0 = { "target-features"="+v,+zvl1024b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
