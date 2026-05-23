; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-cond-reduction.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL-INLOOP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -prefer-inloop-reductions -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -prefer-inloop-reductions  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefixes=IF-EVL-INLOOP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================





define i32 @cond_add(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp = icmp sgt i32 %0, 3
  %select = select i1 %cmp, i32 %0, i32 0
  %add = add nsw i32 %select, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %add
}

define i32 @cond_add_pred(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %rdx = phi i32 [ %start, %entry ], [ %rdx.add, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp = icmp sgt i32 %0, 3
  br i1 %cmp, label %if.then, label %for.inc

if.then:
  %add.pred = add nsw i32 %rdx, %0
  br label %for.inc

for.inc:
  %rdx.add = phi i32 [ %add.pred, %if.then ], [ %rdx, %for.body ]
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %rdx.add
}

define i32 @step_cond_add(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %iv.trunc = trunc i64 %iv to i32
  %cmp = icmp sgt i32 %0, %iv.trunc
  %select = select i1 %cmp, i32 %0, i32 0
  %add = add nsw i32 %select, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %add
}

define i32 @step_cond_add_pred(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %rdx = phi i32 [ %start, %entry ], [ %rdx.add, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %iv.trunc = trunc i64 %iv to i32
  %cmp = icmp sgt i32 %0, %iv.trunc
  br i1 %cmp, label %if.then, label %for.inc

if.then:
  %add.pred = add nsw i32 %rdx, %0
  br label %for.inc

for.inc:
  %rdx.add = phi i32 [ %add.pred, %if.then ], [ %rdx, %for.body ]
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %rdx.add
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.enable", i1 true}
;.
;.
;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpsagk_n9c.ll'
source_filename = "/tmp/tmpsagk_n9c.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @cond_add(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %5, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp sgt <vscale x 4 x i32> %vp.op.load, splat (i32 3)
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> zeroinitializer
  %4 = call i32 @llvm.vp.reduce.add.nxv4i32(i32 0, <vscale x 4 x i32> %3, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %5 = add i32 %4, %vec.phi
  %6 = zext i32 %0 to i64
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %5
}

define i32 @cond_add_pred(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp sgt <vscale x 4 x i32> %vp.op.load, splat (i32 3)
  %3 = call i32 @llvm.vp.reduce.add.nxv4i32(i32 0, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i1> %2, i32 %0)
  %4 = add i32 %3, %vec.phi
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %4
}

define i32 @step_cond_add(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %6, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %2 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = icmp sgt <vscale x 4 x i32> %vp.op.load, %vec.ind
  %4 = select <vscale x 4 x i1> %3, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> zeroinitializer
  %5 = call i32 @llvm.vp.reduce.add.nxv4i32(i32 0, <vscale x 4 x i32> %4, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %6 = add i32 %5, %vec.phi
  %7 = zext i32 %1 to i64
  %current.iteration.next = add i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %vec.ind.next = add <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %6
}

define i32 @step_cond_add_pred(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %5, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %2 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = icmp sgt <vscale x 4 x i32> %vp.op.load, %vec.ind
  %4 = call i32 @llvm.vp.reduce.add.nxv4i32(i32 0, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i1> %3, i32 %1)
  %5 = add i32 %4, %vec.phi
  %6 = zext i32 %1 to i64
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %vec.ind.next = add <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %5
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vp.reduce.add.nxv4i32(i32, <vscale x 4 x i32>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
