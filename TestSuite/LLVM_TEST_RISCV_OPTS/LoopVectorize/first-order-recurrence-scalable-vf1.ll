; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/first-order-recurrence-scalable-vf1.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -scalable-vectorization=on -S
; Original: RUN: opt -p loop-vectorize -scalable-vectorization=on -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i64 @pr97452_scalable_vf1_for(ptr %src, ptr noalias %dst) #0 {
entry:
  br label %loop

loop:
  %for = phi i64 [ 0, %entry ], [ %l, %loop ]
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %iv.next = add i64 %iv, 1
  %gep.src = getelementptr inbounds i64, ptr %src, i64 %iv
  %l = load i64, ptr %gep.src, align 8
  %gep.dst = getelementptr inbounds i64, ptr %dst, i64 %iv
  store i64 %for, ptr %gep.dst
  %ec = icmp eq i64 %iv, 22
  br i1 %ec, label %exit, label %loop

exit:
  %res = phi i64 [ %for, %loop ]
  ret i64 %res
}

attributes #0 = { "target-features"="+64bit,+v,+zvl128b,+zvl256b" }
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmps5t2w0g_.ll'
source_filename = "/tmp/tmps5t2w0g_.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i64 @pr97452_scalable_vf1_for(ptr %src, ptr noalias %dst) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %2 = trunc i64 %1 to i32
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 2
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 2 x i64> poison, i64 0, i32 %5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vector.recur = phi <vscale x 2 x i64> [ %vector.recur.init, %vector.ph ], [ %vp.op.load, %vector.body ]
  %avl = phi i64 [ 23, %vector.ph ], [ %avl.next, %vector.body ]
  %prev.evl = phi i32 [ %2, %vector.ph ], [ %6, %vector.body ]
  %6 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %7 = getelementptr inbounds i64, ptr %src, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %7, <vscale x 2 x i1> splat (i1 true), i32 %6)
  %8 = call <vscale x 2 x i64> @llvm.experimental.vp.splice.nxv2i64(<vscale x 2 x i64> %vector.recur, <vscale x 2 x i64> %vp.op.load, i32 -1, <vscale x 2 x i1> splat (i1 true), i32 %prev.evl, i32 %6)
  %9 = getelementptr inbounds i64, ptr %dst, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %8, ptr align 8 %9, <vscale x 2 x i1> splat (i1 true), i32 %6)
  %10 = zext i32 %6 to i64
  %current.iteration.next = add nuw i64 %10, %index
  %avl.next = sub nuw i64 %avl, %10
  %11 = icmp eq i64 %avl.next, 0
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %12 = sub i64 %10, 1
  %13 = extractelement <vscale x 2 x i64> %8, i64 %12
  br label %exit

exit:                                             ; preds = %middle.block
  ret i64 %13
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.experimental.vp.splice.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, i32 immarg, <vscale x 2 x i1>, i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+64bit,+v,+zvl128b,+zvl256b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
