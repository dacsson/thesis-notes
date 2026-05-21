; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-cond-reduction.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP-INLOOP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -prefer-inloop-reductions -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -prefer-inloop-reductions  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefixes=NO-VP-INLOOP

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

; ModuleID = '/tmp/tmpyz858c4k.ll'
source_filename = "/tmp/tmpyz858c4k.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @cond_add(ptr %a, i64 %n, i32 %start) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %n, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %n, %2
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %7, %vector.body ]
  %3 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %3, align 4
  %4 = icmp sgt <vscale x 4 x i32> %wide.load, splat (i32 3)
  %5 = select <vscale x 4 x i1> %4, <vscale x 4 x i32> %wide.load, <vscale x 4 x i32> zeroinitializer
  %6 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %5)
  %7 = add i32 %vec.phi, %6
  %index.next = add nuw i64 %index, %2
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %7, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %9 = load i32, ptr %arrayidx, align 4
  %cmp = icmp sgt i32 %9, 3
  %select = select i1 %cmp, i32 %9, i32 0
  %add = add nsw i32 %select, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  %add.lcssa = phi i32 [ %add, %for.body ], [ %7, %middle.block ]
  ret i32 %add.lcssa
}

define i32 @cond_add_pred(ptr %a, i64 %n, i32 %start) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %n, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %n, %2
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %7, %vector.body ]
  %3 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %3, align 4
  %4 = icmp sgt <vscale x 4 x i32> %wide.load, splat (i32 3)
  %5 = select <vscale x 4 x i1> %4, <vscale x 4 x i32> %wide.load, <vscale x 4 x i32> zeroinitializer
  %6 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %5)
  %7 = add i32 %vec.phi, %6
  %index.next = add nuw i64 %index, %2
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %7, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.inc ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %rdx.add, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %9 = load i32, ptr %arrayidx, align 4
  %cmp = icmp sgt i32 %9, 3
  br i1 %cmp, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %add.pred = add nsw i32 %rdx, %9
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %rdx.add = phi i32 [ %add.pred, %if.then ], [ %rdx, %for.body ]
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !5

for.end:                                          ; preds = %middle.block, %for.inc
  %rdx.add.lcssa = phi i32 [ %rdx.add, %for.inc ], [ %7, %middle.block ]
  ret i32 %rdx.add.lcssa
}

define i32 @step_cond_add(ptr %a, i64 %n, i32 %start) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %n, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %n, %2
  %n.vec = sub i64 %n, %n.mod.vf
  %3 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  %4 = trunc i64 %2 to i32
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %9, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %5 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = icmp sgt <vscale x 4 x i32> %wide.load, %vec.ind
  %7 = select <vscale x 4 x i1> %6, <vscale x 4 x i32> %wide.load, <vscale x 4 x i32> zeroinitializer
  %8 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %7)
  %9 = add i32 %vec.phi, %8
  %index.next = add nuw i64 %index, %2
  %vec.ind.next = add <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %9, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %11 = load i32, ptr %arrayidx, align 4
  %iv.trunc = trunc i64 %iv to i32
  %cmp = icmp sgt i32 %11, %iv.trunc
  %select = select i1 %cmp, i32 %11, i32 0
  %add = add nsw i32 %select, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !7

for.end:                                          ; preds = %middle.block, %for.body
  %add.lcssa = phi i32 [ %add, %for.body ], [ %9, %middle.block ]
  ret i32 %add.lcssa
}

define i32 @step_cond_add_pred(ptr %a, i64 %n, i32 %start) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %n, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %n, %2
  %n.vec = sub i64 %n, %n.mod.vf
  %3 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  %4 = trunc i64 %2 to i32
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi i32 [ %start, %vector.ph ], [ %9, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %5 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = icmp sgt <vscale x 4 x i32> %wide.load, %vec.ind
  %7 = select <vscale x 4 x i1> %6, <vscale x 4 x i32> %wide.load, <vscale x 4 x i32> zeroinitializer
  %8 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %7)
  %9 = add i32 %vec.phi, %8
  %index.next = add nuw i64 %index, %2
  %vec.ind.next = add <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %9, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.inc ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %rdx.add, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %11 = load i32, ptr %arrayidx, align 4
  %iv.trunc = trunc i64 %iv to i32
  %cmp = icmp sgt i32 %11, %iv.trunc
  br i1 %cmp, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %add.pred = add nsw i32 %rdx, %11
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %rdx.add = phi i32 [ %add.pred, %if.then ], [ %rdx, %for.body ]
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !9

for.end:                                          ; preds = %middle.block, %for.inc
  %rdx.add.lcssa = phi i32 [ %rdx.add, %for.inc ], [ %9, %middle.block ]
  ret i32 %rdx.add.lcssa
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !2, !1}
