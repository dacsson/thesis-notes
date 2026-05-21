; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/riscv-vector-reverse.ll
; Variant: riscv64_+v_loop-vectorize_RV64-UF2
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -force-vector-interleave=2 -S
; Original: RUN: opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v  -force-vector-interleave=2 -S < %s  | FileCheck --check-prefix=RV64-UF2 %s

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

; ModuleID = '/tmp/tmpbd7u5f2u.ll'
source_filename = "/tmp/tmpbd7u5f2u.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vector_reverse_i32(ptr noalias %A, ptr noalias %B) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1023, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1023, %3
  %n.vec = sub i64 1023, %n.mod.vf
  %4 = sub i64 1023, %n.vec
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %5 = sub i64 1023, %index
  %6 = add nsw i64 %5, -1
  %7 = getelementptr inbounds i32, ptr %B, i64 %6
  %8 = sub nuw nsw i64 %2, 1
  %9 = sub i64 0, %8
  %10 = getelementptr inbounds i32, ptr %7, i64 %9
  %11 = sub i64 %9, %2
  %12 = getelementptr inbounds i32, ptr %7, i64 %11
  %wide.load = load <vscale x 4 x i32>, ptr %10, align 4
  %wide.load1 = load <vscale x 4 x i32>, ptr %12, align 4
  %reverse = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %wide.load)
  %reverse2 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %wide.load1)
  %13 = add <vscale x 4 x i32> %reverse, splat (i32 1)
  %14 = add <vscale x 4 x i32> %reverse2, splat (i32 1)
  %15 = getelementptr inbounds i32, ptr %A, i64 %6
  %16 = getelementptr inbounds i32, ptr %15, i64 %9
  %17 = getelementptr inbounds i32, ptr %15, i64 %11
  %reverse3 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %13)
  %reverse4 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %14)
  store <vscale x 4 x i32> %reverse3, ptr %16, align 4
  store <vscale x 4 x i32> %reverse4, ptr %17, align 4
  %index.next = add nuw i64 %index, %3
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1023, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %4, %middle.block ], [ 1023, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %dec.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds i32, ptr %B, i64 %iv.next
  %19 = load i32, ptr %arrayidx.b, align 4
  %add = add i32 %19, 1
  %arrayidx.a = getelementptr inbounds i32, ptr %A, i64 %iv.next
  store i32 %add, ptr %arrayidx.a, align 4
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !3

exit:                                             ; preds = %middle.block, %for.body
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
  %1 = call i64 @llvm.vscale.i64()
  %2 = shl nuw i64 %1, 3
  %min.iters.check = icmp ult i64 %0, %2
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %for.body.preheader
  %3 = add nsw i64 %0, -1
  %4 = add i32 %n, -1
  %5 = trunc i64 %3 to i32
  %6 = sub i32 %4, %5
  %7 = icmp ugt i32 %6, %4
  %8 = icmp ugt i64 %3, 4294967295
  %9 = or i1 %7, %8
  br i1 %9, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %10 = call i64 @llvm.vscale.i64()
  %11 = mul nuw i64 %10, 4
  %12 = mul i64 %11, 8
  %13 = sub i64 %B1, %A2
  %diff.check = icmp ult i64 %13, %12
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %14 = shl nuw i64 %1, 2
  %15 = shl nuw i64 %14, 1
  %n.mod.vf = urem i64 %0, %15
  %n.vec = sub i64 %0, %n.mod.vf
  %16 = sub i64 %0, %n.vec
  %17 = trunc i64 %n.vec to i32
  %18 = sub i32 %n, %17
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %19 = trunc i64 %index to i32
  %20 = sub i32 %n, %19
  %21 = add nsw i32 %20, -1
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds i32, ptr %B, i64 %22
  %24 = sub nuw nsw i64 %14, 1
  %25 = sub i64 0, %24
  %26 = getelementptr inbounds i32, ptr %23, i64 %25
  %27 = sub i64 %25, %14
  %28 = getelementptr inbounds i32, ptr %23, i64 %27
  %wide.load = load <vscale x 4 x i32>, ptr %26, align 4
  %wide.load3 = load <vscale x 4 x i32>, ptr %28, align 4
  %reverse = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %wide.load)
  %reverse4 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %wide.load3)
  %29 = add <vscale x 4 x i32> %reverse, splat (i32 1)
  %30 = add <vscale x 4 x i32> %reverse4, splat (i32 1)
  %31 = getelementptr inbounds i32, ptr %A, i64 %22
  %32 = getelementptr inbounds i32, ptr %31, i64 %25
  %33 = getelementptr inbounds i32, ptr %31, i64 %27
  %reverse5 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %29)
  %reverse6 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %30)
  store <vscale x 4 x i32> %reverse5, ptr %32, align 4
  store <vscale x 4 x i32> %reverse6, ptr %33, align 4
  %index.next = add nuw i64 %index, %15
  %34 = icmp eq i64 %index.next, %n.vec
  br i1 %34, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %0, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck, %for.body.preheader, %middle.block
  %bc.resume.val = phi i64 [ %16, %middle.block ], [ %0, %for.body.preheader ], [ %0, %vector.scevcheck ], [ %0, %vector.memcheck ]
  %bc.resume.val7 = phi i32 [ %18, %middle.block ], [ %n, %for.body.preheader ], [ %n, %vector.scevcheck ], [ %n, %vector.memcheck ]
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %middle.block, %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %i.0.in8 = phi i32 [ %bc.resume.val7, %scalar.ph ], [ %i.0, %for.body ]
  %i.0 = add nsw i32 %i.0.in8, -1
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %B, i64 %idxprom
  %35 = load i32, ptr %arrayidx, align 4
  %add9 = add i32 %35, 1
  %arrayidx3 = getelementptr inbounds i32, ptr %A, i64 %idxprom
  store i32 %add9, ptr %arrayidx3, align 4
  %cmp = icmp ugt i64 %indvars.iv, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit, !llvm.loop !5
}

define void @vector_reverse_f32(ptr noundef writeonly captures(none) %A, ptr noundef readonly captures(none) %B, i32 noundef signext %n) #0 {
entry:
  %A2 = ptrtoaddr ptr %A to i64
  %B1 = ptrtoaddr ptr %B to i64
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = zext i32 %n to i64
  %1 = call i64 @llvm.vscale.i64()
  %2 = shl nuw i64 %1, 3
  %min.iters.check = icmp ult i64 %0, %2
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %for.body.preheader
  %3 = add nsw i64 %0, -1
  %4 = add i32 %n, -1
  %5 = trunc i64 %3 to i32
  %6 = sub i32 %4, %5
  %7 = icmp ugt i32 %6, %4
  %8 = icmp ugt i64 %3, 4294967295
  %9 = or i1 %7, %8
  br i1 %9, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %10 = call i64 @llvm.vscale.i64()
  %11 = mul nuw i64 %10, 4
  %12 = mul i64 %11, 8
  %13 = sub i64 %B1, %A2
  %diff.check = icmp ult i64 %13, %12
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %14 = shl nuw i64 %1, 2
  %15 = shl nuw i64 %14, 1
  %n.mod.vf = urem i64 %0, %15
  %n.vec = sub i64 %0, %n.mod.vf
  %16 = sub i64 %0, %n.vec
  %17 = trunc i64 %n.vec to i32
  %18 = sub i32 %n, %17
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %19 = trunc i64 %index to i32
  %20 = sub i32 %n, %19
  %21 = add nsw i32 %20, -1
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds float, ptr %B, i64 %22
  %24 = sub nuw nsw i64 %14, 1
  %25 = sub i64 0, %24
  %26 = getelementptr inbounds float, ptr %23, i64 %25
  %27 = sub i64 %25, %14
  %28 = getelementptr inbounds float, ptr %23, i64 %27
  %wide.load = load <vscale x 4 x float>, ptr %26, align 4
  %wide.load3 = load <vscale x 4 x float>, ptr %28, align 4
  %reverse = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %wide.load)
  %reverse4 = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %wide.load3)
  %29 = fadd <vscale x 4 x float> %reverse, splat (float 1.000000e+00)
  %30 = fadd <vscale x 4 x float> %reverse4, splat (float 1.000000e+00)
  %31 = getelementptr inbounds float, ptr %A, i64 %22
  %32 = getelementptr inbounds float, ptr %31, i64 %25
  %33 = getelementptr inbounds float, ptr %31, i64 %27
  %reverse5 = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %29)
  %reverse6 = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %30)
  store <vscale x 4 x float> %reverse5, ptr %32, align 4
  store <vscale x 4 x float> %reverse6, ptr %33, align 4
  %index.next = add nuw i64 %index, %15
  %34 = icmp eq i64 %index.next, %n.vec
  br i1 %34, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %0, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck, %for.body.preheader, %middle.block
  %bc.resume.val = phi i64 [ %16, %middle.block ], [ %0, %for.body.preheader ], [ %0, %vector.scevcheck ], [ %0, %vector.memcheck ]
  %bc.resume.val7 = phi i32 [ %18, %middle.block ], [ %n, %for.body.preheader ], [ %n, %vector.scevcheck ], [ %n, %vector.memcheck ]
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %middle.block, %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %i.0.in8 = phi i32 [ %bc.resume.val7, %scalar.ph ], [ %i.0, %for.body ]
  %i.0 = add nsw i32 %i.0.in8, -1
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds float, ptr %B, i64 %idxprom
  %35 = load float, ptr %arrayidx, align 4
  %conv1 = fadd float %35, 1.000000e+00
  %arrayidx3 = getelementptr inbounds float, ptr %A, i64 %idxprom
  store float %conv1, ptr %arrayidx3, align 4
  %cmp = icmp ugt i64 %indvars.iv, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit, !llvm.loop !7
}

define void @vector_reverse_f32_simplify(ptr noalias %A, ptr noalias %B) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1023, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1023, %3
  %n.vec = sub i64 1023, %n.mod.vf
  %4 = sub i64 1023, %n.vec
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %5 = sub i64 1023, %index
  %6 = add nsw i64 %5, -1
  %7 = getelementptr inbounds float, ptr %B, i64 %6
  %8 = sub nuw nsw i64 %2, 1
  %9 = sub i64 0, %8
  %10 = getelementptr inbounds float, ptr %7, i64 %9
  %11 = sub i64 %9, %2
  %12 = getelementptr inbounds float, ptr %7, i64 %11
  %wide.load = load <vscale x 4 x float>, ptr %10, align 4
  %wide.load1 = load <vscale x 4 x float>, ptr %12, align 4
  %reverse = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %wide.load)
  %reverse2 = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %wide.load1)
  %13 = fadd <vscale x 4 x float> %reverse, splat (float 1.000000e+00)
  %14 = fadd <vscale x 4 x float> %reverse2, splat (float 1.000000e+00)
  %15 = getelementptr inbounds float, ptr %A, i64 %6
  %16 = getelementptr inbounds float, ptr %15, i64 %9
  %17 = getelementptr inbounds float, ptr %15, i64 %11
  %reverse3 = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %13)
  %reverse4 = call <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float> %14)
  store <vscale x 4 x float> %reverse3, ptr %16, align 4
  store <vscale x 4 x float> %reverse4, ptr %17, align 4
  %index.next = add nuw i64 %index, %3
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1023, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %4, %middle.block ], [ 1023, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %dec.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds float, ptr %B, i64 %iv.next
  %19 = load float, ptr %arrayidx.b, align 4
  %fadd = fadd float %19, 1.000000e+00
  %arrayidx.a = getelementptr inbounds float, ptr %A, i64 %iv.next
  store float %fadd, ptr %arrayidx.a, align 4
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !9

exit:                                             ; preds = %middle.block, %for.body
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
  %4 = add i64 %0, -4
  %5 = add i64 %0, -5
  %6 = add i64 %0, -6
  %7 = add i64 %0, -7
  %8 = add nsw i64 %0, -1
  %9 = add nsw i64 %1, -1
  %10 = add nsw i64 %2, -1
  %11 = add nsw i64 %3, -1
  %12 = add nsw i64 %4, -1
  %13 = add nsw i64 %5, -1
  %14 = add nsw i64 %6, -1
  %15 = add nsw i64 %7, -1
  %16 = getelementptr inbounds i7, ptr %B, i64 %8
  %17 = getelementptr inbounds i7, ptr %B, i64 %9
  %18 = getelementptr inbounds i7, ptr %B, i64 %10
  %19 = getelementptr inbounds i7, ptr %B, i64 %11
  %20 = getelementptr inbounds i7, ptr %B, i64 %12
  %21 = getelementptr inbounds i7, ptr %B, i64 %13
  %22 = getelementptr inbounds i7, ptr %B, i64 %14
  %23 = getelementptr inbounds i7, ptr %B, i64 %15
  %24 = load i7, ptr %16, align 1
  %25 = load i7, ptr %17, align 1
  %26 = load i7, ptr %18, align 1
  %27 = load i7, ptr %19, align 1
  %28 = insertelement <4 x i7> poison, i7 %24, i32 0
  %29 = insertelement <4 x i7> %28, i7 %25, i32 1
  %30 = insertelement <4 x i7> %29, i7 %26, i32 2
  %31 = insertelement <4 x i7> %30, i7 %27, i32 3
  %32 = load i7, ptr %20, align 1
  %33 = load i7, ptr %21, align 1
  %34 = load i7, ptr %22, align 1
  %35 = load i7, ptr %23, align 1
  %36 = insertelement <4 x i7> poison, i7 %32, i32 0
  %37 = insertelement <4 x i7> %36, i7 %33, i32 1
  %38 = insertelement <4 x i7> %37, i7 %34, i32 2
  %39 = insertelement <4 x i7> %38, i7 %35, i32 3
  %40 = add <4 x i7> %31, splat (i7 1)
  %41 = extractelement <4 x i7> %40, i64 0
  %42 = extractelement <4 x i7> %40, i64 1
  %43 = extractelement <4 x i7> %40, i64 2
  %44 = extractelement <4 x i7> %40, i64 3
  %45 = add <4 x i7> %39, splat (i7 1)
  %46 = extractelement <4 x i7> %45, i64 0
  %47 = extractelement <4 x i7> %45, i64 1
  %48 = extractelement <4 x i7> %45, i64 2
  %49 = extractelement <4 x i7> %45, i64 3
  %50 = getelementptr inbounds i7, ptr %A, i64 %8
  %51 = getelementptr inbounds i7, ptr %A, i64 %9
  %52 = getelementptr inbounds i7, ptr %A, i64 %10
  %53 = getelementptr inbounds i7, ptr %A, i64 %11
  %54 = getelementptr inbounds i7, ptr %A, i64 %12
  %55 = getelementptr inbounds i7, ptr %A, i64 %13
  %56 = getelementptr inbounds i7, ptr %A, i64 %14
  %57 = getelementptr inbounds i7, ptr %A, i64 %15
  store i7 %41, ptr %50, align 1
  store i7 %42, ptr %51, align 1
  store i7 %43, ptr %52, align 1
  store i7 %44, ptr %53, align 1
  store i7 %46, ptr %54, align 1
  store i7 %47, ptr %55, align 1
  store i7 %48, ptr %56, align 1
  store i7 %49, ptr %57, align 1
  %index.next = add nuw i64 %index, 8
  %58 = icmp eq i64 %index.next, 1016
  br i1 %58, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %dec.iv = phi i64 [ 7, %scalar.ph ], [ %iv.next, %for.body ]
  %iv.next = add nsw i64 %dec.iv, -1
  %arrayidx.b = getelementptr inbounds i7, ptr %B, i64 %iv.next
  %59 = load i7, ptr %arrayidx.b, align 1
  %add = add i7 %59, 1
  %arrayidx.a = getelementptr inbounds i7, ptr %A, i64 %iv.next
  store i7 %add, ptr %arrayidx.a, align 1
  %cmp = icmp ugt i64 %dec.iv, 1
  br i1 %cmp, label %for.body, label %exit, !llvm.loop !11

exit:                                             ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.vector.reverse.nxv4f32(<vscale x 4 x float>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !2, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !2, !1}
