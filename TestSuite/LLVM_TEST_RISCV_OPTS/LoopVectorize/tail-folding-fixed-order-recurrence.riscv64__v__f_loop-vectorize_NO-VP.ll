; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-fixed-order-recurrence.ll
; Variant: riscv64_+v,+f_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -prefer-inloop-reductions -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v,+f -S
; Original: RUN: opt -passes=loop-vectorize  -prefer-inloop-reductions  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v,+f -S < %s| FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @first_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) {
entry:
  br label %for.body

for.body:
  %indvars = phi i64 [ 0, %entry ], [ %indvars.next, %for.body ]
  %for1 = phi i32 [ 33, %entry ], [ %0, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %indvars
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for1, %0
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %indvars
  store i32 %add, ptr %arrayidx2, align 4
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @second_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) {
entry:
  br label %for.body

for.body:
  %indvars = phi i64 [ 0, %entry ], [ %indvars.next, %for.body ]
  %for1 = phi i32 [ 33, %entry ], [ %0, %for.body ]
  %for2 = phi i32 [ 22, %entry ], [ %for1, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %indvars
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for1, %for2
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %indvars
  store i32 %add, ptr %arrayidx2, align 4
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @third_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) {
entry:
  br label %for.body

for.body:
  %indvars = phi i64 [ 0, %entry ], [ %indvars.next, %for.body ]
  %for1 = phi i32 [ 33, %entry ], [ %0, %for.body ]
  %for2 = phi i32 [ 22, %entry ], [ %for1, %for.body ]
  %for3 = phi i32 [ 11, %entry ], [ %for2, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %indvars
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for2, %for3
  %add1 = add i32 %add, %for1
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %indvars
  store i32 %add1, ptr %arrayidx2, align 4
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define i32 @FOR_reduction(ptr noalias %A, ptr noalias %B, i64 %TC) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %for1 = phi i32 [ 33, %entry ], [ %0, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for1, %0
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %iv
  store i32 %add, ptr %arrayidx2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %for1
}

define void @first_order_recurrence_indvar(ptr noalias %A, i64 %TC) {
entry:
  br label %for.body

for.body:
  %indvars = phi i64 [ 0, %entry ], [ %indvars.next, %for.body ]
  %for1 = phi i64 [ 33, %entry ], [ %x, %for.body ]

  %x = add i64 %indvars, 42

  %arrayidx = getelementptr inbounds nuw i64, ptr %A, i64 %indvars
  store i64 %for1, ptr %arrayidx

  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.enable", i1 true}
;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp8ewdqfzj.ll'
source_filename = "/tmp/tmp8ewdqfzj.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @first_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %TC, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %TC, %2
  %n.vec = sub i64 %TC, %n.mod.vf
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 4
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 4 x i32> poison, i32 33, i32 %5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %wide.load, %vector.body ]
  %6 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %6, align 4
  %7 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %wide.load, i32 1)
  %8 = add nsw <vscale x 4 x i32> %7, %wide.load
  %9 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  store <vscale x 4 x i32> %8, ptr %9, align 4
  %index.next = add nuw i64 %index, %2
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %11 = call i32 @llvm.vscale.i32()
  %12 = mul nuw i32 %11, 4
  %13 = sub i32 %12, 1
  %vector.recur.extract = extractelement <vscale x 4 x i32> %wide.load, i32 %13
  %cmp.n = icmp eq i64 %TC, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %scalar.recur.init = phi i32 [ %vector.recur.extract, %middle.block ], [ 33, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.next, %for.body ]
  %for1 = phi i32 [ %scalar.recur.init, %scalar.ph ], [ %14, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %indvars
  %14 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for1, %14
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %indvars
  store i32 %add, ptr %arrayidx2, align 4
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @second_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %TC, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %TC, %2
  %n.vec = sub i64 %TC, %n.mod.vf
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 4
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 4 x i32> poison, i32 33, i32 %5
  %6 = call i32 @llvm.vscale.i32()
  %7 = mul nuw i32 %6, 4
  %8 = sub i32 %7, 1
  %vector.recur.init1 = insertelement <vscale x 4 x i32> poison, i32 22, i32 %8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %wide.load, %vector.body ]
  %vector.recur2 = phi <vscale x 4 x i32> [ %vector.recur.init1, %vector.ph ], [ %10, %vector.body ]
  %9 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %9, align 4
  %10 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %wide.load, i32 1)
  %11 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur2, <vscale x 4 x i32> %10, i32 1)
  %12 = add nsw <vscale x 4 x i32> %10, %11
  %13 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  store <vscale x 4 x i32> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %2
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %15 = call i32 @llvm.vscale.i32()
  %16 = mul nuw i32 %15, 4
  %17 = sub i32 %16, 1
  %vector.recur.extract = extractelement <vscale x 4 x i32> %wide.load, i32 %17
  %18 = call i32 @llvm.vscale.i32()
  %19 = mul nuw i32 %18, 4
  %20 = sub i32 %19, 1
  %vector.recur.extract3 = extractelement <vscale x 4 x i32> %10, i32 %20
  %cmp.n = icmp eq i64 %TC, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %scalar.recur.init = phi i32 [ %vector.recur.extract, %middle.block ], [ 33, %entry ]
  %scalar.recur.init4 = phi i32 [ %vector.recur.extract3, %middle.block ], [ 22, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.next, %for.body ]
  %for1 = phi i32 [ %scalar.recur.init, %scalar.ph ], [ %21, %for.body ]
  %for2 = phi i32 [ %scalar.recur.init4, %scalar.ph ], [ %for1, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %indvars
  %21 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for1, %for2
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %indvars
  store i32 %add, ptr %arrayidx2, align 4
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !5

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @third_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %TC, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %TC, %2
  %n.vec = sub i64 %TC, %n.mod.vf
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 4
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 4 x i32> poison, i32 33, i32 %5
  %6 = call i32 @llvm.vscale.i32()
  %7 = mul nuw i32 %6, 4
  %8 = sub i32 %7, 1
  %vector.recur.init1 = insertelement <vscale x 4 x i32> poison, i32 22, i32 %8
  %9 = call i32 @llvm.vscale.i32()
  %10 = mul nuw i32 %9, 4
  %11 = sub i32 %10, 1
  %vector.recur.init3 = insertelement <vscale x 4 x i32> poison, i32 11, i32 %11
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %wide.load, %vector.body ]
  %vector.recur2 = phi <vscale x 4 x i32> [ %vector.recur.init1, %vector.ph ], [ %13, %vector.body ]
  %vector.recur4 = phi <vscale x 4 x i32> [ %vector.recur.init3, %vector.ph ], [ %14, %vector.body ]
  %12 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %12, align 4
  %13 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %wide.load, i32 1)
  %14 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur2, <vscale x 4 x i32> %13, i32 1)
  %15 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur4, <vscale x 4 x i32> %14, i32 1)
  %16 = add nsw <vscale x 4 x i32> %14, %15
  %17 = add <vscale x 4 x i32> %16, %13
  %18 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  store <vscale x 4 x i32> %17, ptr %18, align 4
  %index.next = add nuw i64 %index, %2
  %19 = icmp eq i64 %index.next, %n.vec
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %20 = call i32 @llvm.vscale.i32()
  %21 = mul nuw i32 %20, 4
  %22 = sub i32 %21, 1
  %vector.recur.extract = extractelement <vscale x 4 x i32> %wide.load, i32 %22
  %23 = call i32 @llvm.vscale.i32()
  %24 = mul nuw i32 %23, 4
  %25 = sub i32 %24, 1
  %vector.recur.extract5 = extractelement <vscale x 4 x i32> %13, i32 %25
  %26 = call i32 @llvm.vscale.i32()
  %27 = mul nuw i32 %26, 4
  %28 = sub i32 %27, 1
  %vector.recur.extract6 = extractelement <vscale x 4 x i32> %14, i32 %28
  %cmp.n = icmp eq i64 %TC, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %scalar.recur.init = phi i32 [ %vector.recur.extract, %middle.block ], [ 33, %entry ]
  %scalar.recur.init7 = phi i32 [ %vector.recur.extract5, %middle.block ], [ 22, %entry ]
  %scalar.recur.init8 = phi i32 [ %vector.recur.extract6, %middle.block ], [ 11, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.next, %for.body ]
  %for1 = phi i32 [ %scalar.recur.init, %scalar.ph ], [ %29, %for.body ]
  %for2 = phi i32 [ %scalar.recur.init7, %scalar.ph ], [ %for1, %for.body ]
  %for3 = phi i32 [ %scalar.recur.init8, %scalar.ph ], [ %for2, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %indvars
  %29 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for2, %for3
  %add1 = add i32 %add, %for1
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %indvars
  store i32 %add1, ptr %arrayidx2, align 4
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !7

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define i32 @FOR_reduction(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 %TC, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 %TC, %2
  %n.vec = sub i64 %TC, %n.mod.vf
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 4
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 4 x i32> poison, i32 33, i32 %5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %wide.load, %vector.body ]
  %6 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %6, align 4
  %7 = call <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %wide.load, i32 1)
  %8 = add nsw <vscale x 4 x i32> %7, %wide.load
  %9 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  store <vscale x 4 x i32> %8, ptr %9, align 4
  %index.next = add nuw i64 %index, %2
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %11 = call i32 @llvm.vscale.i32()
  %12 = mul nuw i32 %11, 4
  %13 = sub i32 %12, 2
  %vector.recur.extract.for.phi = extractelement <vscale x 4 x i32> %wide.load, i32 %13
  %14 = call i32 @llvm.vscale.i32()
  %15 = mul nuw i32 %14, 4
  %16 = sub i32 %15, 1
  %vector.recur.extract = extractelement <vscale x 4 x i32> %wide.load, i32 %16
  %cmp.n = icmp eq i64 %TC, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %scalar.recur.init = phi i32 [ %vector.recur.extract, %middle.block ], [ 33, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %for1 = phi i32 [ %scalar.recur.init, %scalar.ph ], [ %17, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %A, i64 %iv
  %17 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %for1, %17
  %arrayidx2 = getelementptr inbounds nuw i32, ptr %B, i64 %iv
  store i32 %add, ptr %arrayidx2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !9

for.end:                                          ; preds = %middle.block, %for.body
  %for1.lcssa = phi i32 [ %for1, %for.body ], [ %vector.recur.extract.for.phi, %middle.block ]
  ret i32 %for1.lcssa
}

define void @first_order_recurrence_indvar(ptr noalias %A, i64 %TC) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 %TC, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 %TC, %2
  %n.vec = sub i64 %TC, %n.mod.vf
  %3 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %4 = call i32 @llvm.vscale.i32()
  %5 = mul nuw i32 %4, 2
  %6 = sub i32 %5, 1
  %vector.recur.init = insertelement <vscale x 2 x i64> poison, i64 33, i32 %6
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vector.recur = phi <vscale x 2 x i64> [ %vector.recur.init, %vector.ph ], [ %7, %vector.body ]
  %7 = add <vscale x 2 x i64> %vec.ind, splat (i64 42)
  %8 = call <vscale x 2 x i64> @llvm.vector.splice.right.nxv2i64(<vscale x 2 x i64> %vector.recur, <vscale x 2 x i64> %7, i32 1)
  %9 = getelementptr inbounds nuw i64, ptr %A, i64 %index
  store <vscale x 2 x i64> %8, ptr %9, align 8
  %index.next = add nuw i64 %index, %2
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %11 = call i32 @llvm.vscale.i32()
  %12 = mul nuw i32 %11, 2
  %13 = sub i32 %12, 1
  %vector.recur.extract = extractelement <vscale x 2 x i64> %7, i32 %13
  %cmp.n = icmp eq i64 %TC, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %scalar.recur.init = phi i64 [ %vector.recur.extract, %middle.block ], [ 33, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.next, %for.body ]
  %for1 = phi i64 [ %scalar.recur.init, %scalar.ph ], [ %x, %for.body ]
  %x = add i64 %indvars, 42
  %arrayidx = getelementptr inbounds nuw i64, ptr %A, i64 %indvars
  store i64 %for1, ptr %arrayidx, align 8
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %TC
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !11

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vector.splice.right.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vector.splice.right.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, i32) #1

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }

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
