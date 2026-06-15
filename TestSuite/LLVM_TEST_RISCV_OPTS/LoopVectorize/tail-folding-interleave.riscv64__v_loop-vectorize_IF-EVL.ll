; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-interleave.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck --check-prefix=IF-EVL %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @interleave(ptr noalias %a, ptr noalias %b, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [2 x i32], ptr %b, i64 %iv, i32 0
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds [2 x i32], ptr %b, i64 %iv, i32 1
  %1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %1, %0
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %add, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !0

for.cond.cleanup:
  ret void
}

; Interleaved group with gap but without tail gap
; E.g.
; int (*a)[4];
; int rdx = 0;
; for (int i = 0; i < n; i++) {
;   rdx += a[i][0];
;   rdx += a[i][1];
;   // No access a[i][2]
;   rdx += a[i][3];
; }
define i32 @load_factor_4_with_gap(i64 %n, ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ 0, %entry ], [ %add2, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 0
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %rdx, %0
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 1
  %1 = load i32, ptr %arrayidx1, align 4
  %add1 = add nsw i32 %add, %1
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 3
  %2 = load i32, ptr %arrayidx2, align 4
  %add2 = add nsw i32 %add1, %2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret i32 %add2
}

; Interleaved group with gap but without tail gap
; E.g.
; int (*a)[4];
; for (int i = 0; i < n; i++) {
;   a[i][0] = i;
;   a[i][1] = i;
;   // No access a[i][2]
;   a[i][3] = i;
; }
define void @store_factor_4_with_gap(i32 %n, ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 0
  store i32 %iv, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 1
  store i32 %iv, ptr %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 3
  store i32 %iv, ptr %arrayidx2, align 4
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}

; Interleaved group with tail gap
; E.g.
; int (*a)[4];
; int rdx = 0;
; for (int i = 0; i < n; i++) {
;   rdx += a[i][0];
;   rdx += a[i][1];
;   rdx += a[i][2];
;   // No access a[i][3]
; }
define i32 @load_factor_4_with_tail_gap(i64 %n, ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ 0, %entry ], [ %add2, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 0
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %rdx, %0
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 1
  %1 = load i32, ptr %arrayidx1, align 4
  %add1 = add nsw i32 %add, %1
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 2
  %2 = load i32, ptr %arrayidx2, align 4
  %add2 = add nsw i32 %add1, %2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret i32 %add2
}

; Interleaved group with tail gap
; E.g.
; int (*a)[4];
; int rdx = 0;
; for (int i = 0; i < n; i++) {
;   a[i][0] = i;
;   a[i][1] = i;
;   a[i][2] = i;
;   // No access a[i][3]
; }
define void @store_factor_4_with_tail_gap(i32 %n, ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 0
  store i32 %iv, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 1
  store i32 %iv, ptr %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 2
  store i32 %iv, ptr %arrayidx2, align 4
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}

define i32 @load_factor_4_reverse(i64 %n, ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %n, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ 0, %entry ], [ %add3, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 0
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %rdx, %0
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 1
  %1 = load i32, ptr %arrayidx1, align 4
  %add1 = add nsw i32 %add, %1
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 2
  %2 = load i32, ptr %arrayidx2, align 4
  %add2 = add nsw i32 %add1, %2
  %arrayidx3 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 3
  %3 = load i32, ptr %arrayidx3, align 4
  %add3 = add nsw i32 %add2, %3
  %iv.next = add nsw i64 %iv, -1
  %exitcond = icmp sgt i64 %iv.next, 0
  br i1 %exitcond, label %for.body, label %exit

exit:
  ret i32 %add3
}

define void @store_factor_4_reverse(i32 %n, ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i32 [ %n, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 0
  store i32 %iv, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 1
  store i32 %iv, ptr %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 2
  store i32 %iv, ptr %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 3
  store i32 %iv, ptr %arrayidx3, align 4
  %iv.next = add nsw i32 %iv, -1
  %exitcond = icmp sgt i32 %iv.next, 0
  br i1 %exitcond, label %for.body, label %exit

exit:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpzih10hyx.ll'
source_filename = "/tmp/tmpzih10hyx.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @interleave(ptr noalias %a, ptr noalias %b, i64 %N) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds [2 x i32], ptr %b, i64 %index, i32 0
  %interleave.evl = mul nuw nsw i32 %0, 2
  %wide.vp.load = call <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %wide.vp.load)
  %2 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %4 = add nsw <vscale x 4 x i32> %3, %2
  %5 = getelementptr inbounds i32, ptr %a, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %4, ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %6 = zext i32 %0 to i64
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %middle.block
  ret void
}

define i32 @load_factor_4_with_gap(i64 %n, ptr noalias %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %8, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds [4 x i32], ptr %a, i64 %index, i32 0
  %interleave.evl = mul nuw nsw i32 %0, 4
  %wide.vp.load = call <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr align 4 %1, <vscale x 16 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vp.load)
  %2 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %4 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 3
  %5 = add <vscale x 4 x i32> %vec.phi, %2
  %6 = add <vscale x 4 x i32> %5, %3
  %7 = add <vscale x 4 x i32> %6, %4
  %8 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %7, <vscale x 4 x i32> %vec.phi, i32 %0)
  %9 = zext i32 %0 to i64
  %current.iteration.next = add i64 %9, %index
  %avl.next = sub nuw i64 %avl, %9
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  %11 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %8)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %11
}

define void @store_factor_4_with_gap(i32 %n, ptr noalias %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %2 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 0
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 1
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %4 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 3
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %4, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %avl.next = sub nuw i32 %avl, %1
  %vec.ind.next = add nuw nsw <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %5 = icmp eq i32 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i32 @load_factor_4_with_tail_gap(i64 %n, ptr noalias %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %9, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 0
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %4 = add <vscale x 4 x i32> %vec.phi, %wide.masked.gather
  %5 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 1
  %wide.masked.gather1 = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %6 = add <vscale x 4 x i32> %4, %wide.masked.gather1
  %7 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 2
  %wide.masked.gather2 = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %8 = add <vscale x 4 x i32> %6, %wide.masked.gather2
  %9 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %8, <vscale x 4 x i32> %vec.phi, i32 %1)
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %11 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %9)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %11
}

define void @store_factor_4_with_tail_gap(i32 %n, ptr noalias %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %2 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 0
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 1
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %4 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 2
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %4, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %avl.next = sub nuw i32 %avl, %1
  %vec.ind.next = add nuw nsw <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %5 = icmp eq i32 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i32 @load_factor_4_reverse(i64 %n, ptr noalias %a) #0 {
entry:
  %0 = add nsw i64 %n, -1
  %smin = call i64 @llvm.smin.i64(i64 %0, i64 0)
  %1 = sub i64 %n, %smin
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %n, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = sub nsw <vscale x 4 x i64> %broadcast.splat, %2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %15, %vector.body ]
  %avl = phi i64 [ %1, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = zext i32 %4 to i64
  %6 = sub nsw i64 0, %5
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i64> poison, i64 %6, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert1, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %7 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 0
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = add <vscale x 4 x i32> %vec.phi, %wide.masked.gather
  %9 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 1
  %wide.masked.gather3 = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %9, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %10 = add <vscale x 4 x i32> %8, %wide.masked.gather3
  %11 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 2
  %wide.masked.gather4 = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %11, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %12 = add <vscale x 4 x i32> %10, %wide.masked.gather4
  %13 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 3
  %wide.masked.gather5 = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %13, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %14 = add <vscale x 4 x i32> %12, %wide.masked.gather5
  %15 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %14, <vscale x 4 x i32> %vec.phi, i32 %4)
  %avl.next = sub nuw i64 %avl, %5
  %vec.ind.next = add nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat2
  %16 = icmp eq i64 %avl.next, 0
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %17 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %15)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %17
}

define void @store_factor_4_reverse(i32 %n, ptr noalias %a) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i32 [ %n, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 0
  store i32 %iv, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 1
  store i32 %iv, ptr %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 2
  store i32 %iv, ptr %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 3
  store i32 %iv, ptr %arrayidx3, align 4
  %iv.next = add nsw i32 %iv, -1
  %exitcond = icmp sgt i32 %iv.next, 0
  br i1 %exitcond, label %for.body, label %exit

exit:                                             ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr captures(none), <vscale x 8 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr captures(none), <vscale x 16 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1, !2}
