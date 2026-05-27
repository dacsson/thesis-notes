; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/pr87378-vpinstruction-or-drop-poison-generating-flags.ll
; Variant: "+v"
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mattr="+v" -S
; Original: RUN: opt -p loop-vectorize -mattr="+v" -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

; Test case for https://github.com/llvm/llvm-project/issues/87378.
define void @pr87378_vpinstruction_or_drop_poison_generating_flags(ptr %arg, i64 %a, i64 %b, i64 %c) {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %c.1 = icmp ule i64 %iv, %a
  br i1 %c.1, label %then.1, label %else.1

then.1:
  %c.2 = icmp ule i64 %iv, %b
  br i1 %c.2, label %else.1, label %merge

else.1:
  %c.3 = icmp ule i64 %iv, %c
  br i1 %c.3, label %then.2, label %loop.latch

then.2:
  br label %merge

merge:
  %idx = phi i64 [ %iv, %then.1 ], [ %iv, %then.2 ]
  %getelementptr = getelementptr i16, ptr %arg, i64 %idx
  store i16 0, ptr %getelementptr, align 2
  br label %loop.latch

loop.latch:
  %iv.next = add i64 %iv, 1
  %icmp = icmp eq i64 %iv, 1000
  br i1 %icmp, label %exit, label %loop.header

exit:
  ret void
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpiuk125t5.ll'
source_filename = "/tmp/tmpiuk125t5.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @pr87378_vpinstruction_or_drop_poison_generating_flags(ptr %arg, i64 %a, i64 %b, i64 %c) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %a, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 8 x i64> poison, i64 %b, i64 0
  %broadcast.splat2 = shufflevector <vscale x 8 x i64> %broadcast.splatinsert1, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <vscale x 8 x i64> poison, i64 %c, i64 0
  %broadcast.splat4 = shufflevector <vscale x 8 x i64> %broadcast.splatinsert3, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %0 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 8 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1001, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert5 = insertelement <vscale x 8 x i64> poison, i64 %2, i64 0
  %broadcast.splat6 = shufflevector <vscale x 8 x i64> %broadcast.splatinsert5, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %3 = icmp ule <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %4 = icmp ule <vscale x 8 x i64> %vec.ind, %broadcast.splat2
  %5 = select <vscale x 8 x i1> %3, <vscale x 8 x i1> %4, <vscale x 8 x i1> zeroinitializer
  %6 = xor <vscale x 8 x i1> %3, splat (i1 true)
  %7 = or <vscale x 8 x i1> %5, %6
  %8 = icmp ule <vscale x 8 x i64> %vec.ind, %broadcast.splat4
  %9 = select <vscale x 8 x i1> %7, <vscale x 8 x i1> %8, <vscale x 8 x i1> zeroinitializer
  %10 = xor <vscale x 8 x i1> %4, splat (i1 true)
  %11 = select <vscale x 8 x i1> %3, <vscale x 8 x i1> %10, <vscale x 8 x i1> zeroinitializer
  %12 = or <vscale x 8 x i1> %9, %11
  %13 = getelementptr i16, ptr %arg, i64 %index
  call void @llvm.vp.store.nxv8i16.p0(<vscale x 8 x i16> zeroinitializer, ptr align 2 %13, <vscale x 8 x i1> %12, i32 %1)
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add <vscale x 8 x i64> %vec.ind, %broadcast.splat6
  %14 = icmp eq i64 %avl.next, 0
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 8 x i64> @llvm.stepvector.nxv8i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i16.p0(<vscale x 8 x i16>, ptr captures(none), <vscale x 8 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
