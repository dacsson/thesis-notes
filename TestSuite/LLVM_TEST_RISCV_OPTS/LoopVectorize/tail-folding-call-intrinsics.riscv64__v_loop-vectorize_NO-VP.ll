; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-call-intrinsics.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @vp_smax(ptr %a, ptr %b, ptr %c, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %1 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.smax.i32(i32 %0, i32 %1)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_smin(ptr %a, ptr %b, ptr %c, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %1 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.smin.i32(i32 %0, i32 %1)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_umax(ptr %a, ptr %b, ptr %c, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %1 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.umax.i32(i32 %0, i32 %1)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_umin(ptr %a, ptr %b, ptr %c, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %1 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.umin.i32(i32 %0, i32 %1)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}


define void @vp_ctlz(ptr %a, ptr %b, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %1 = tail call range(i32 0, 33) i32 @llvm.ctlz.i32(i32 %0, i1 true)
  %gep3 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %1, ptr %gep3, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_cttz(ptr %a, ptr %b, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %1 = tail call range(i32 0, 33) i32 @llvm.cttz.i32(i32 %0, i1 true)
  %gep3 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %1, ptr %gep3, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_lrint(ptr %a, ptr %b, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %0 = load float, ptr %gep, align 4
  %conv2 = fpext float %0 to double
  %1 = tail call i64 @llvm.lrint.i64.f64(double %conv2)
  %conv3 = trunc i64 %1 to i32
  %gep5 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv3, ptr %gep5, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_llrint(ptr %a, ptr %b, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %0 = load float, ptr %gep, align 4
  %conv2 = fpext float %0 to double
  %1 = tail call i64 @llvm.llrint.i64.f64(double %conv2)
  %conv3 = trunc i64 %1 to i32
  %gep5 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv3, ptr %gep5, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_abs(ptr %a, ptr %b, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %cond = tail call i32 @llvm.abs.i32(i32 %0, i1 true)
  %gep9 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %cond, ptr %gep9, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

; There's no @llvm.vp.log10, so don't transform it.
define void @log10(ptr %a, ptr %b, i64 %N) {

entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %0 = load float, ptr %gep, align 4
  %cond = tail call float @llvm.log10.f32(float %0)
  %gep9 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %cond, ptr %gep9, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}


;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmps425_prd.ll'
source_filename = "/tmp/tmps425_prd.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vp_smax(ptr %a, ptr %b, ptr %c, i64 %N) #0 {
entry:
  %c3 = ptrtoaddr ptr %c to i64
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 4
  %7 = sub i64 %a1, %c3
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 2
  %n.mod.vf = urem i64 %N, %9
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %c, i64 %index
  %wide.load5 = load <vscale x 4 x i32>, ptr %11, align 4
  %12 = call <vscale x 4 x i32> @llvm.smax.nxv4i32(<vscale x 4 x i32> %wide.load, <vscale x 4 x i32> %wide.load5)
  %13 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %15 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %16 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.smax.i32(i32 %15, i32 %16)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_smin(ptr %a, ptr %b, ptr %c, i64 %N) #0 {
entry:
  %c3 = ptrtoaddr ptr %c to i64
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 4
  %7 = sub i64 %a1, %c3
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 2
  %n.mod.vf = urem i64 %N, %9
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %c, i64 %index
  %wide.load5 = load <vscale x 4 x i32>, ptr %11, align 4
  %12 = call <vscale x 4 x i32> @llvm.smin.nxv4i32(<vscale x 4 x i32> %wide.load, <vscale x 4 x i32> %wide.load5)
  %13 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %15 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %16 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.smin.i32(i32 %15, i32 %16)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !5

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_umax(ptr %a, ptr %b, ptr %c, i64 %N) #0 {
entry:
  %c3 = ptrtoaddr ptr %c to i64
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 4
  %7 = sub i64 %a1, %c3
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 2
  %n.mod.vf = urem i64 %N, %9
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %c, i64 %index
  %wide.load5 = load <vscale x 4 x i32>, ptr %11, align 4
  %12 = call <vscale x 4 x i32> @llvm.umax.nxv4i32(<vscale x 4 x i32> %wide.load, <vscale x 4 x i32> %wide.load5)
  %13 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %15 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %16 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.umax.i32(i32 %15, i32 %16)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !7

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_umin(ptr %a, ptr %b, ptr %c, i64 %N) #0 {
entry:
  %c3 = ptrtoaddr ptr %c to i64
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 4
  %7 = sub i64 %a1, %c3
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 2
  %n.mod.vf = urem i64 %N, %9
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %c, i64 %index
  %wide.load5 = load <vscale x 4 x i32>, ptr %11, align 4
  %12 = call <vscale x 4 x i32> @llvm.umin.nxv4i32(<vscale x 4 x i32> %wide.load, <vscale x 4 x i32> %wide.load5)
  %13 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %15 = load i32, ptr %gep, align 4
  %gep3 = getelementptr inbounds i32, ptr %c, i64 %iv
  %16 = load i32, ptr %gep3, align 4
  %. = tail call i32 @llvm.umin.i32(i32 %15, i32 %16)
  %gep11 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %., ptr %gep11, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !9

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_ctlz(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %8, align 4
  %9 = call <vscale x 4 x i32> @llvm.ctlz.nxv4i32(<vscale x 4 x i32> %wide.load, i1 true)
  %10 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %12 = load i32, ptr %gep, align 4
  %13 = tail call range(i32 0, 33) i32 @llvm.ctlz.i32(i32 %12, i1 true)
  %gep3 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %13, ptr %gep3, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !11

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_cttz(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %8, align 4
  %9 = call <vscale x 4 x i32> @llvm.cttz.nxv4i32(<vscale x 4 x i32> %wide.load, i1 true)
  %10 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %12 = load i32, ptr %gep, align 4
  %13 = tail call range(i32 0, 33) i32 @llvm.cttz.i32(i32 %12, i1 true)
  %gep3 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %13, ptr %gep3, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !13

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_lrint(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fpext <vscale x 4 x float> %wide.load to <vscale x 4 x double>
  %10 = call <vscale x 4 x i64> @llvm.lrint.nxv4i64.nxv4f64(<vscale x 4 x double> %9)
  %11 = trunc <vscale x 4 x i64> %10 to <vscale x 4 x i32>
  %12 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %11, ptr %12, align 4
  %index.next = add nuw i64 %index, %7
  %13 = icmp eq i64 %index.next, %n.vec
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %14 = load float, ptr %gep, align 4
  %conv2 = fpext float %14 to double
  %15 = tail call i64 @llvm.lrint.i64.f64(double %conv2)
  %conv3 = trunc i64 %15 to i32
  %gep5 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv3, ptr %gep5, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !15

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_llrint(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fpext <vscale x 4 x float> %wide.load to <vscale x 4 x double>
  %10 = call <vscale x 4 x i64> @llvm.llrint.nxv4i64.nxv4f64(<vscale x 4 x double> %9)
  %11 = trunc <vscale x 4 x i64> %10 to <vscale x 4 x i32>
  %12 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %11, ptr %12, align 4
  %index.next = add nuw i64 %index, %7
  %13 = icmp eq i64 %index.next, %n.vec
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %14 = load float, ptr %gep, align 4
  %conv2 = fpext float %14 to double
  %15 = tail call i64 @llvm.llrint.i64.f64(double %conv2)
  %conv3 = trunc i64 %15 to i32
  %gep5 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv3, ptr %gep5, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !17

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_abs(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %8, align 4
  %9 = call <vscale x 4 x i32> @llvm.abs.nxv4i32(<vscale x 4 x i32> %wide.load, i1 true)
  %10 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %12 = load i32, ptr %gep, align 4
  %cond = tail call i32 @llvm.abs.i32(i32 %12, i1 true)
  %gep9 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %cond, ptr %gep9, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !19

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @log10(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %min.iters.check = icmp ult i64 %N, 12
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %0 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %0, 16
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.mod.vf = urem i64 %N, 4
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds float, ptr %b, i64 %index
  %wide.load = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.log10.v4f32(<4 x float> %wide.load)
  %3 = getelementptr inbounds float, ptr %a, i64 %index
  store <4 x float> %2, ptr %3, align 4
  %index.next = add nuw i64 %index, 4
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %5 = load float, ptr %gep, align 4
  %cond = tail call float @llvm.log10.f32(float %5)
  %gep9 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %cond, ptr %gep9, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !21

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.cttz.i32(i32, i1 immarg) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.llrint.i64.f64(double) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.log10.f32(float) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.lrint.i64.f64(double) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.smax.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.smin.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.umax.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.umin.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.ctlz.nxv4i32(<vscale x 4 x i32>, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.cttz.nxv4i32(<vscale x 4 x i32>, i1 immarg) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.lrint.nxv4i64.nxv4f64(<vscale x 4 x double>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.llrint.nxv4i64.nxv4f64(<vscale x 4 x double>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.abs.nxv4i32(<vscale x 4 x i32>, i1 immarg) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.log10.v4f32(<4 x float>) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !1}
!18 = distinct !{!18, !1, !2}
!19 = distinct !{!19, !1}
!20 = distinct !{!20, !1, !2}
!21 = distinct !{!21, !1}
