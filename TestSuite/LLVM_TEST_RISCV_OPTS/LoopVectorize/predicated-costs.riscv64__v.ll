; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/predicated-costs.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -S -p loop-vectorize -mtriple=riscv64 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; The innermost block then.1 has a 25% chance of being executed according to
; BranchProbabilityInfo, but if we vectorize it then we will unconditionally
; execute it. Avoid this unprofitable vectorization by taking the nested
; probability into account in the cost model.
define void @nested(ptr noalias %p0, ptr noalias %p1, i1 %c0, i1 %c1) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %latch ]
  br i1 %c0, label %then.0, label %latch

then.0:
  br i1 %c1, label %then.1, label %latch

then.1:
  %gep0 = getelementptr i32, ptr %p0, i32 %iv
  %x = load i32, ptr %gep0
  %gep1 = getelementptr i32, ptr %p1, i32 %x
  store i32 0, ptr %gep1
  br label %latch

latch:
  %iv.next = add i32 %iv, 1
  %done = icmp eq i32 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

; This is the same CFG as @nested above, but we have provided branch weights
; which tell BranchProbabilityInfo that then.1 will always be taken. In this
; case, we should vectorize because it is profitable.
define void @always_taken(ptr noalias %p0, ptr noalias %p1, i1 %c0, i1 %c1) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %latch ]
  br i1 %c0, label %then.0, label %latch, !prof !0

then.0:
  br i1 %c1, label %then.1, label %latch, !prof !0

then.1:
  %gep0 = getelementptr i32, ptr %p0, i32 %iv
  %x = load i32, ptr %gep0
  %gep1 = getelementptr i32, ptr %p1, i32 %x
  store i32 0, ptr %gep1
  br label %latch

latch:
  %iv.next = add i32 %iv, 1
  %done = icmp eq i32 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

!0 = !{!"branch_weights", i32 1, i32 0}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpqaofmugs.ll'
source_filename = "/tmp/tmpqaofmugs.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @nested(ptr noalias %p0, ptr noalias %p1, i1 %c0, i1 %c1) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i1> poison, i1 %c0, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert1, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %0 = select <vscale x 4 x i1> %broadcast.splat2, <vscale x 4 x i1> %broadcast.splat, <vscale x 4 x i1> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i32 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %2 = getelementptr i32, ptr %p0, i32 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> %0, i32 %1)
  %3 = getelementptr i32, ptr %p1, <vscale x 4 x i32> %vp.op.load
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x ptr> align 4 %3, <vscale x 4 x i1> %0, i32 %1)
  %current.iteration.next = add nuw i32 %1, %index
  %avl.next = sub nuw i32 %avl, %1
  %4 = icmp eq i32 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @always_taken(ptr noalias %p0, ptr noalias %p1, i1 %c0, i1 %c1) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i1> poison, i1 %c0, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert1, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %0 = select <vscale x 4 x i1> %broadcast.splat2, <vscale x 4 x i1> %broadcast.splat, <vscale x 4 x i1> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i32 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %2 = getelementptr i32, ptr %p0, i32 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> %0, i32 %1)
  %3 = getelementptr i32, ptr %p1, <vscale x 4 x i32> %vp.op.load
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x ptr> align 4 %3, <vscale x 4 x i1> %0, i32 %1)
  %current.iteration.next = add nuw i32 %1, %index
  %avl.next = sub nuw i32 %avl, %1
  %4 = icmp eq i32 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
