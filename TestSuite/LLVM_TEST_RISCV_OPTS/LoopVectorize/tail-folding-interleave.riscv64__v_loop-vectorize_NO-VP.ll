; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-interleave.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck --check-prefix=NO-VP %s

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

; ModuleID = '/tmp/tmpl541y2qe.ll'
source_filename = "/tmp/tmpl541y2qe.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @interleave(ptr noalias %a, ptr noalias %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %N, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %N, %2
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds [2 x i32], ptr %b, i64 %index, i32 0
  %wide.vec = load <vscale x 8 x i32>, ptr %3, align 4
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %wide.vec)
  %4 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %5 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %6 = add nsw <vscale x 4 x i32> %5, %4
  %7 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %6, ptr %7, align 4
  %index.next = add nuw i64 %index, %2
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [2 x i32], ptr %b, i64 %iv, i32 0
  %9 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds [2 x i32], ptr %b, i64 %iv, i32 1
  %10 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %10, %9
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %add, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !3

for.cond.cleanup:                                 ; preds = %middle.block, %for.body
  ret void
}

define i32 @load_factor_4_with_gap(i64 %n, ptr noalias %a) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %n, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 %n, %3
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %10, %vector.body ]
  %4 = getelementptr inbounds [4 x i32], ptr %a, i64 %index, i32 0
  %wide.vec = load <vscale x 16 x i32>, ptr %4, align 4
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vec)
  %5 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %6 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %7 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 3
  %8 = add <vscale x 4 x i32> %vec.phi, %5
  %9 = add <vscale x 4 x i32> %8, %6
  %10 = add <vscale x 4 x i32> %9, %7
  %index.next = add nuw i64 %index, %3
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %12 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %10)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %12, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %add2, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 0
  %13 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %rdx, %13
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 1
  %14 = load i32, ptr %arrayidx1, align 4
  %add1 = add nsw i32 %add, %14
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 3
  %15 = load i32, ptr %arrayidx2, align 4
  %add2 = add nsw i32 %add1, %15
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !5

exit:                                             ; preds = %middle.block, %for.body
  %add2.lcssa = phi i32 [ %add2, %for.body ], [ %12, %middle.block ]
  ret i32 %add2.lcssa
}

define void @store_factor_4_with_gap(i32 %n, ptr noalias %a) #0 {
entry:
  %0 = call i32 @llvm.vscale.i32()
  %1 = shl nuw i32 %0, 2
  %umax = call i32 @llvm.umax.i32(i32 %1, i32 8)
  %min.iters.check = icmp ult i32 %n, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i32 @llvm.vscale.i32()
  %3 = shl nuw i32 %2, 2
  %n.mod.vf = urem i32 %n, %3
  %n.vec = sub i32 %n, %n.mod.vf
  %4 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %3, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %5 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 0
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %5, <vscale x 4 x i1> splat (i1 true))
  %6 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 1
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %6, <vscale x 4 x i1> splat (i1 true))
  %7 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i32> %vec.ind, i32 3
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %vec.ind, <vscale x 4 x ptr> align 4 %7, <vscale x 4 x i1> splat (i1 true))
  %index.next = add nuw i32 %index, %3
  %vec.ind.next = add nuw nsw <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %8 = icmp eq i32 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i32 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i32 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 0
  store i32 %iv, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 1
  store i32 %iv, ptr %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 3
  store i32 %iv, ptr %arrayidx2, align 4
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !7

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define i32 @load_factor_4_with_tail_gap(i64 %n, ptr noalias %a) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ule i64 %n, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %n, %2
  %3 = icmp eq i64 %n.mod.vf, 0
  %4 = select i1 %3, i64 %2, i64 %n.mod.vf
  %n.vec = sub i64 %n, %4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %11, %vector.body ]
  %5 = getelementptr inbounds [4 x i32], ptr %a, i64 %index, i32 0
  %wide.vec = load <vscale x 16 x i32>, ptr %5, align 4
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vec)
  %6 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %7 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %8 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 2
  %9 = add <vscale x 4 x i32> %vec.phi, %6
  %10 = add <vscale x 4 x i32> %9, %7
  %11 = add <vscale x 4 x i32> %10, %8
  %index.next = add nuw i64 %index, %2
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %13 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %11)
  br label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %13, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %add2, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 0
  %14 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %rdx, %14
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 1
  %15 = load i32, ptr %arrayidx1, align 4
  %add1 = add nsw i32 %add, %15
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 2
  %16 = load i32, ptr %arrayidx2, align 4
  %add2 = add nsw i32 %add1, %16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !9

exit:                                             ; preds = %for.body
  %add2.lcssa = phi i32 [ %add2, %for.body ]
  ret i32 %add2.lcssa
}

define void @store_factor_4_with_tail_gap(i32 %n, ptr noalias %a) #0 {
entry:
  %min.iters.check = icmp ult i32 %n, 8
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i32 %n, 8
  %n.vec = sub i32 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %0 = getelementptr inbounds [4 x i32], ptr %a, i32 %index, i32 0
  %1 = shufflevector <8 x i32> %vec.ind, <8 x i32> %vec.ind, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %2 = shufflevector <8 x i32> %vec.ind, <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = shufflevector <16 x i32> %1, <16 x i32> %2, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %interleaved.vec = shufflevector <32 x i32> %3, <32 x i32> poison, <32 x i32> <i32 0, i32 8, i32 16, i32 24, i32 1, i32 9, i32 17, i32 25, i32 2, i32 10, i32 18, i32 26, i32 3, i32 11, i32 19, i32 27, i32 4, i32 12, i32 20, i32 28, i32 5, i32 13, i32 21, i32 29, i32 6, i32 14, i32 22, i32 30, i32 7, i32 15, i32 23, i32 31>
  call void @llvm.masked.store.v32i32.p0(<32 x i32> %interleaved.vec, ptr align 4 %0, <32 x i1> <i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 false>)
  %index.next = add nuw i32 %index, 8
  %vec.ind.next = add nuw nsw <8 x i32> %vec.ind, splat (i32 8)
  %4 = icmp eq i32 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i32 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i32 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 0
  store i32 %iv, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 1
  store i32 %iv, ptr %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i32 %iv, i32 2
  store i32 %iv, ptr %arrayidx2, align 4
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !11

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define i32 @load_factor_4_reverse(i64 %n, ptr noalias %a) #0 {
entry:
  %0 = add nsw i64 %n, -1
  %smin = call i64 @llvm.smin.i64(i64 %0, i64 0)
  %1 = sub i64 %n, %smin
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %umax = call i64 @llvm.umax.i64(i64 %3, i64 8)
  %min.iters.check = icmp ult i64 %1, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %4 = call i64 @llvm.vscale.i64()
  %5 = shl nuw i64 %4, 2
  %n.mod.vf = urem i64 %1, %5
  %n.vec = sub i64 %1, %n.mod.vf
  %6 = sub i64 %n, %n.vec
  %7 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %n, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %8 = sub nsw <vscale x 4 x i64> %broadcast.splat, %7
  %9 = sub nsw i64 0, %5
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i64> poison, i64 %9, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert1, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %8, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %17, %vector.body ]
  %10 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 0
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %10, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %11 = add <vscale x 4 x i32> %vec.phi, %wide.masked.gather
  %12 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 1
  %wide.masked.gather3 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %12, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %13 = add <vscale x 4 x i32> %11, %wide.masked.gather3
  %14 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 2
  %wide.masked.gather4 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %14, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %15 = add <vscale x 4 x i32> %13, %wide.masked.gather4
  %16 = getelementptr inbounds [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind, i32 3
  %wide.masked.gather5 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %16, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %17 = add <vscale x 4 x i32> %15, %wide.masked.gather5
  %index.next = add nuw i64 %index, %5
  %vec.ind.next = add nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat2
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %19 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %17)
  %cmp.n = icmp eq i64 %1, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %6, %middle.block ], [ %n, %entry ]
  %bc.merge.rdx = phi i32 [ %19, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %add3, %for.body ]
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 0
  %20 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %rdx, %20
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 1
  %21 = load i32, ptr %arrayidx1, align 4
  %add1 = add nsw i32 %add, %21
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 2
  %22 = load i32, ptr %arrayidx2, align 4
  %add2 = add nsw i32 %add1, %22
  %arrayidx3 = getelementptr inbounds [4 x i32], ptr %a, i64 %iv, i32 3
  %23 = load i32, ptr %arrayidx3, align 4
  %add3 = add nsw i32 %add2, %23
  %iv.next = add nsw i64 %iv, -1
  %exitcond = icmp sgt i64 %iv.next, 0
  br i1 %exitcond, label %for.body, label %exit, !llvm.loop !13

exit:                                             ; preds = %middle.block, %for.body
  %add3.lcssa = phi i32 [ %add3, %for.body ], [ %19, %middle.block ]
  ret i32 %add3.lcssa
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
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v32i32.p0(<32 x i32>, ptr captures(none), <32 x i1>) #5

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, <vscale x 4 x i32>) #6

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(write) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(read) }

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
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !2, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !2, !1}
