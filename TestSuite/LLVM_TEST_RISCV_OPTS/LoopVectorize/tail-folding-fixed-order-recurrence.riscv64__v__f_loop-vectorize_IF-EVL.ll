; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-fixed-order-recurrence.ll
; Variant: riscv64_+v,+f_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -prefer-inloop-reductions -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v,+f -S
; Original: RUN: opt -passes=loop-vectorize  -prefer-inloop-reductions  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v,+f -S < %s| FileCheck %s --check-prefix=IF-EVL

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

; ModuleID = '/tmp/tmputv04wlt.ll'
source_filename = "/tmp/tmputv04wlt.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @first_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %2 = trunc i64 %1 to i32
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 4
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 4 x i32> poison, i32 33, i32 %5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %vp.op.load, %vector.body ]
  %avl = phi i64 [ %TC, %vector.ph ], [ %avl.next, %vector.body ]
  %prev.evl = phi i32 [ %2, %vector.ph ], [ %6, %vector.body ]
  %6 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %7 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %6)
  %8 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %vp.op.load, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %6)
  %9 = add nsw <vscale x 4 x i32> %8, %vp.op.load
  %10 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %9, ptr align 4 %10, <vscale x 4 x i1> splat (i1 true), i32 %6)
  %11 = zext i32 %6 to i64
  %current.iteration.next = add i64 %11, %index
  %avl.next = sub nuw i64 %avl, %11
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @second_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %2 = trunc i64 %1 to i32
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
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %vp.op.load, %vector.body ]
  %vector.recur2 = phi <vscale x 4 x i32> [ %vector.recur.init1, %vector.ph ], [ %11, %vector.body ]
  %avl = phi i64 [ %TC, %vector.ph ], [ %avl.next, %vector.body ]
  %prev.evl = phi i32 [ %2, %vector.ph ], [ %9, %vector.body ]
  %9 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %10 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %10, <vscale x 4 x i1> splat (i1 true), i32 %9)
  %11 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %vp.op.load, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %9)
  %12 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur2, <vscale x 4 x i32> %11, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %9)
  %13 = add nsw <vscale x 4 x i32> %11, %12
  %14 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %13, ptr align 4 %14, <vscale x 4 x i1> splat (i1 true), i32 %9)
  %15 = zext i32 %9 to i64
  %current.iteration.next = add i64 %15, %index
  %avl.next = sub nuw i64 %avl, %15
  %16 = icmp eq i64 %avl.next, 0
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @third_order_recurrence(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %2 = trunc i64 %1 to i32
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
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %vp.op.load, %vector.body ]
  %vector.recur2 = phi <vscale x 4 x i32> [ %vector.recur.init1, %vector.ph ], [ %14, %vector.body ]
  %vector.recur4 = phi <vscale x 4 x i32> [ %vector.recur.init3, %vector.ph ], [ %15, %vector.body ]
  %avl = phi i64 [ %TC, %vector.ph ], [ %avl.next, %vector.body ]
  %prev.evl = phi i32 [ %2, %vector.ph ], [ %12, %vector.body ]
  %12 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %13 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %13, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %14 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %vp.op.load, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %12)
  %15 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur2, <vscale x 4 x i32> %14, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %12)
  %16 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur4, <vscale x 4 x i32> %15, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %12)
  %17 = add nsw <vscale x 4 x i32> %15, %16
  %18 = add <vscale x 4 x i32> %17, %14
  %19 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %18, ptr align 4 %19, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %20 = zext i32 %12 to i64
  %current.iteration.next = add i64 %20, %index
  %avl.next = sub nuw i64 %avl, %20
  %21 = icmp eq i64 %avl.next, 0
  br i1 %21, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define i32 @FOR_reduction(ptr noalias %A, ptr noalias %B, i64 %TC) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %2 = trunc i64 %1 to i32
  %3 = call i32 @llvm.vscale.i32()
  %4 = mul nuw i32 %3, 4
  %5 = sub i32 %4, 1
  %vector.recur.init = insertelement <vscale x 4 x i32> poison, i32 33, i32 %5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vector.recur = phi <vscale x 4 x i32> [ %vector.recur.init, %vector.ph ], [ %vp.op.load, %vector.body ]
  %avl = phi i64 [ %TC, %vector.ph ], [ %avl.next, %vector.body ]
  %prev.evl = phi i32 [ %2, %vector.ph ], [ %6, %vector.body ]
  %6 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %7 = getelementptr inbounds nuw i32, ptr %A, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %6)
  %8 = call <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32> %vector.recur, <vscale x 4 x i32> %vp.op.load, i32 -1, <vscale x 4 x i1> splat (i1 true), i32 %prev.evl, i32 %6)
  %9 = add nsw <vscale x 4 x i32> %8, %vp.op.load
  %10 = getelementptr inbounds nuw i32, ptr %B, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %9, ptr align 4 %10, <vscale x 4 x i1> splat (i1 true), i32 %6)
  %11 = zext i32 %6 to i64
  %current.iteration.next = add i64 %11, %index
  %avl.next = sub nuw i64 %avl, %11
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %13 = sub i64 %11, 1
  %14 = extractelement <vscale x 4 x i32> %8, i64 %13
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %14
}

define void @first_order_recurrence_indvar(ptr noalias %A, i64 %TC) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %2 = trunc i64 %1 to i32
  %3 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %4 = call i32 @llvm.vscale.i32()
  %5 = mul nuw i32 %4, 2
  %6 = sub i32 %5, 1
  %vector.recur.init = insertelement <vscale x 2 x i64> poison, i64 33, i32 %6
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vector.recur = phi <vscale x 2 x i64> [ %vector.recur.init, %vector.ph ], [ %9, %vector.body ]
  %avl = phi i64 [ %TC, %vector.ph ], [ %avl.next, %vector.body ]
  %prev.evl = phi i32 [ %2, %vector.ph ], [ %7, %vector.body ]
  %7 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %8 = zext i32 %7 to i64
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %8, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %9 = add <vscale x 2 x i64> %vec.ind, splat (i64 42)
  %10 = call <vscale x 2 x i64> @llvm.experimental.vp.splice.nxv2i64(<vscale x 2 x i64> %vector.recur, <vscale x 2 x i64> %9, i32 -1, <vscale x 2 x i1> splat (i1 true), i32 %prev.evl, i32 %7)
  %11 = getelementptr inbounds nuw i64, ptr %A, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %10, ptr align 8 %11, <vscale x 2 x i1> splat (i1 true), i32 %7)
  %current.iteration.next = add i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.experimental.vp.splice.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>, i32 immarg, <vscale x 4 x i1>, i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.experimental.vp.splice.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, i32 immarg, <vscale x 2 x i1>, i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
