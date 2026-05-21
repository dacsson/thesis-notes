; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/riscv-vector-reverse.ll
; Variant: riscv64_+v_loop-vectorize_RV64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S < %s  | FileCheck --check-prefix=RV64 %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

;; This is the loop in c++ being vectorize in this file with
;; vector.reverse
;;  #pragma clang loop vectorize_width(4, scalable)
;;  for (int i = N-1; i >= 0; --i)
;;    a[i] = b[i] + 1.0;




define void @vector_reverse_i32(ptr noalias %A, ptr noalias %B) {
entry:
  br label %for.body

for.body:
  %dec.iv = phi i64 [ 1023, %entry ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds i32, ptr %B, i64 %iv.next
  %0 = load i32, ptr %arrayidx.b, align 4
  %add = add i32 %0, 1
  %arrayidx.a = getelementptr inbounds i32, ptr %A, i64 %iv.next
  store i32 %add, ptr %arrayidx.a, align 4
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !0

exit:
  ret void
}

define void @vector_reverse_i64(ptr nocapture noundef writeonly %A, ptr nocapture noundef readonly %B, i32 noundef signext %n) {
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %0 = zext i32 %n to i64
  br label %for.body

for.cond.cleanup:
  ret void

for.body:
  %indvars.iv = phi i64 [ %0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %i.0.in8 = phi i32 [ %n, %for.body.preheader ], [ %i.0, %for.body ]
  %i.0 = add nsw i32 %i.0.in8, -1
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %B, i64 %idxprom
  %1 = load i32, ptr %arrayidx, align 4
  %add9 = add i32 %1, 1
  %arrayidx3 = getelementptr inbounds i32, ptr %A, i64 %idxprom
  store i32 %add9, ptr %arrayidx3, align 4
  %cmp = icmp ugt i64 %indvars.iv, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !0
}

define void @vector_reverse_f32(ptr nocapture noundef writeonly %A, ptr nocapture noundef readonly %B, i32 noundef signext %n) {
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %0 = zext i32 %n to i64
  br label %for.body

for.cond.cleanup:
  ret void

for.body:
  %indvars.iv = phi i64 [ %0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %i.0.in8 = phi i32 [ %n, %for.body.preheader ], [ %i.0, %for.body ]
  %i.0 = add nsw i32 %i.0.in8, -1
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds float, ptr %B, i64 %idxprom
  %1 = load float, ptr %arrayidx, align 4
  %conv1 = fadd float %1, 1.000000e+00
  %arrayidx3 = getelementptr inbounds float, ptr %A, i64 %idxprom
  store float %conv1, ptr %arrayidx3, align 4
  %cmp = icmp ugt i64 %indvars.iv, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !0
}

define void @vector_reverse_f32_simplify(ptr noalias %A, ptr noalias %B) {
entry:
  br label %for.body

for.body:
  %dec.iv = phi i64 [ 1023, %entry ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds float, ptr %B, i64 %iv.next
  %0 = load float, ptr %arrayidx.b, align 4
  %fadd = fadd float %0, 1.000000e+00
  %arrayidx.a = getelementptr inbounds float, ptr %A, i64 %iv.next
  store float %fadd, ptr %arrayidx.a, align 4
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !0

exit:
  ret void
}

define void @vector_reverse_irregular_type(ptr noalias %A, ptr noalias %B) {
entry:
  br label %for.body

for.body:
  %dec.iv = phi i64 [ 1023, %entry ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds i7, ptr %B, i64 %iv.next
  %0 = load i7, ptr %arrayidx.b, align 1
  %add = add i7 %0, 1
  %arrayidx.a = getelementptr inbounds i7, ptr %A, i64 %iv.next
  store i7 %add, ptr %arrayidx.a, align 1
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !4

exit:
  ret void
}

!0 = distinct !{!0, !1, !2, !3}
!1 = !{!"llvm.loop.vectorize.width", i32 4}
!2 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}
!3 = !{!"llvm.loop.vectorize.enable", i1 true}
!4 = distinct !{!4, !1, !3}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpt2r9lmto.ll'
source_filename = "/tmp/tmpt2r9lmto.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vector_reverse_i32(ptr noalias %A, ptr noalias %B) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1023, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = sub i64 1023, %index
  %2 = add nsw i64 %1, -1
  %3 = getelementptr inbounds i32, ptr %B, i64 %2
  %4 = zext i32 %0 to i64
  %5 = sub nuw nsw i64 %4, 1
  %6 = sub i64 0, %5
  %7 = getelementptr i32, ptr %3, i64 %6
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %8 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %9 = add <vscale x 4 x i32> %8, splat (i32 1)
  %10 = getelementptr inbounds i32, ptr %A, i64 %2
  %11 = getelementptr i32, ptr %10, i64 %6
  %12 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %9, <vscale x 4 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %12, ptr align 4 %11, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %13 = icmp eq i64 %avl.next, 0
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @vector_reverse_i64(ptr noundef writeonly captures(none) %A, ptr noundef readonly captures(none) %B, i32 noundef signext %n) #0 {
entry:
  %A2 = ptrtoaddr ptr %A to i64
  %B1 = ptrtoaddr ptr %B to i64
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = zext i32 %n to i64
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %for.body.preheader
  %1 = add nsw i64 %0, -1
  %2 = add i32 %n, -1
  %3 = trunc i64 %1 to i32
  %4 = sub i32 %2, %3
  %5 = icmp ugt i32 %4, %2
  %6 = icmp ugt i64 %1, 4294967295
  %7 = or i1 %5, %6
  br i1 %7, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = mul nuw i64 %8, 4
  %10 = mul i64 %9, 4
  %11 = sub i64 %B1, %A2
  %diff.check = icmp ult i64 %11, %10
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %12 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %13 = trunc i64 %index to i32
  %14 = sub i32 %n, %13
  %15 = add nsw i32 %14, -1
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds i32, ptr %B, i64 %16
  %18 = zext i32 %12 to i64
  %19 = sub nuw nsw i64 %18, 1
  %20 = sub i64 0, %19
  %21 = getelementptr i32, ptr %17, i64 %20
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %21, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %22 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %23 = add <vscale x 4 x i32> %22, splat (i32 1)
  %24 = getelementptr inbounds i32, ptr %A, i64 %16
  %25 = getelementptr i32, ptr %24, i64 %20
  %26 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %23, <vscale x 4 x i1> splat (i1 true), i32 %12)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %26, ptr align 4 %25, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %current.iteration.next = add nuw i64 %18, %index
  %avl.next = sub nuw i64 %avl, %18
  %27 = icmp eq i64 %avl.next, 0
  br i1 %27, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.cond.cleanup.loopexit

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %middle.block, %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars.iv = phi i64 [ %0, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %i.0.in8 = phi i32 [ %n, %scalar.ph ], [ %i.0, %for.body ]
  %i.0 = add nsw i32 %i.0.in8, -1
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %B, i64 %idxprom
  %28 = load i32, ptr %arrayidx, align 4
  %add9 = add i32 %28, 1
  %arrayidx3 = getelementptr inbounds i32, ptr %A, i64 %idxprom
  store i32 %add9, ptr %arrayidx3, align 4
  %cmp = icmp ugt i64 %indvars.iv, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit, !llvm.loop !4
}

define void @vector_reverse_f32(ptr noundef writeonly captures(none) %A, ptr noundef readonly captures(none) %B, i32 noundef signext %n) #0 {
entry:
  %A2 = ptrtoaddr ptr %A to i64
  %B1 = ptrtoaddr ptr %B to i64
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = zext i32 %n to i64
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %for.body.preheader
  %1 = add nsw i64 %0, -1
  %2 = add i32 %n, -1
  %3 = trunc i64 %1 to i32
  %4 = sub i32 %2, %3
  %5 = icmp ugt i32 %4, %2
  %6 = icmp ugt i64 %1, 4294967295
  %7 = or i1 %5, %6
  br i1 %7, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = mul nuw i64 %8, 4
  %10 = mul i64 %9, 4
  %11 = sub i64 %B1, %A2
  %diff.check = icmp ult i64 %11, %10
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %12 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %13 = trunc i64 %index to i32
  %14 = sub i32 %n, %13
  %15 = add nsw i32 %14, -1
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds float, ptr %B, i64 %16
  %18 = zext i32 %12 to i64
  %19 = sub nuw nsw i64 %18, 1
  %20 = sub i64 0, %19
  %21 = getelementptr float, ptr %17, i64 %20
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %21, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %22 = call <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %23 = fadd <vscale x 4 x float> %22, splat (float 1.000000e+00)
  %24 = getelementptr inbounds float, ptr %A, i64 %16
  %25 = getelementptr float, ptr %24, i64 %20
  %26 = call <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float> %23, <vscale x 4 x i1> splat (i1 true), i32 %12)
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %26, ptr align 4 %25, <vscale x 4 x i1> splat (i1 true), i32 %12)
  %current.iteration.next = add nuw i64 %18, %index
  %avl.next = sub nuw i64 %avl, %18
  %27 = icmp eq i64 %avl.next, 0
  br i1 %27, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %for.cond.cleanup.loopexit

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %middle.block, %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars.iv = phi i64 [ %0, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %i.0.in8 = phi i32 [ %n, %scalar.ph ], [ %i.0, %for.body ]
  %i.0 = add nsw i32 %i.0.in8, -1
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds float, ptr %B, i64 %idxprom
  %28 = load float, ptr %arrayidx, align 4
  %conv1 = fadd float %28, 1.000000e+00
  %arrayidx3 = getelementptr inbounds float, ptr %A, i64 %idxprom
  store float %conv1, ptr %arrayidx3, align 4
  %cmp = icmp ugt i64 %indvars.iv, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit, !llvm.loop !6
}

define void @vector_reverse_f32_simplify(ptr noalias %A, ptr noalias %B) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1023, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = sub i64 1023, %index
  %2 = add nsw i64 %1, -1
  %3 = getelementptr inbounds float, ptr %B, i64 %2
  %4 = zext i32 %0 to i64
  %5 = sub nuw nsw i64 %4, 1
  %6 = sub i64 0, %5
  %7 = getelementptr float, ptr %3, i64 %6
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %8 = call <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %9 = fadd <vscale x 4 x float> %8, splat (float 1.000000e+00)
  %10 = getelementptr inbounds float, ptr %A, i64 %2
  %11 = getelementptr float, ptr %10, i64 %6
  %12 = call <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float> %9, <vscale x 4 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %12, ptr align 4 %11, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %13 = icmp eq i64 %avl.next, 0
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @vector_reverse_irregular_type(ptr noalias %A, ptr noalias %B) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = sub i64 1023, %index
  %1 = add i64 %0, -1
  %2 = add i64 %0, -2
  %3 = add i64 %0, -3
  %4 = add nsw i64 %0, -1
  %5 = add nsw i64 %1, -1
  %6 = add nsw i64 %2, -1
  %7 = add nsw i64 %3, -1
  %8 = getelementptr inbounds i7, ptr %B, i64 %4
  %9 = getelementptr inbounds i7, ptr %B, i64 %5
  %10 = getelementptr inbounds i7, ptr %B, i64 %6
  %11 = getelementptr inbounds i7, ptr %B, i64 %7
  %12 = load i7, ptr %8, align 1
  %13 = load i7, ptr %9, align 1
  %14 = load i7, ptr %10, align 1
  %15 = load i7, ptr %11, align 1
  %16 = insertelement <4 x i7> poison, i7 %12, i32 0
  %17 = insertelement <4 x i7> %16, i7 %13, i32 1
  %18 = insertelement <4 x i7> %17, i7 %14, i32 2
  %19 = insertelement <4 x i7> %18, i7 %15, i32 3
  %20 = add <4 x i7> %19, splat (i7 1)
  %21 = extractelement <4 x i7> %20, i64 0
  %22 = extractelement <4 x i7> %20, i64 1
  %23 = extractelement <4 x i7> %20, i64 2
  %24 = extractelement <4 x i7> %20, i64 3
  %25 = getelementptr inbounds i7, ptr %A, i64 %4
  %26 = getelementptr inbounds i7, ptr %A, i64 %5
  %27 = getelementptr inbounds i7, ptr %A, i64 %6
  %28 = getelementptr inbounds i7, ptr %A, i64 %7
  store i7 %21, ptr %25, align 1
  store i7 %22, ptr %26, align 1
  store i7 %23, ptr %27, align 1
  store i7 %24, ptr %28, align 1
  %index.next = add nuw i64 %index, 4
  %29 = icmp eq i64 %index.next, 1020
  br i1 %29, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %dec.iv = phi i64 [ 3, %scalar.ph ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds i7, ptr %B, i64 %iv.next
  %30 = load i7, ptr %arrayidx.b, align 1
  %add = add i7 %30, 1
  %arrayidx.a = getelementptr inbounds i7, ptr %A, i64 %iv.next
  store i7 %add, ptr %arrayidx.a, align 1
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !9

exit:                                             ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.experimental.vp.reverse.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float>, ptr captures(none), <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1}
!7 = distinct !{!7, !1, !2}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !2, !1}
