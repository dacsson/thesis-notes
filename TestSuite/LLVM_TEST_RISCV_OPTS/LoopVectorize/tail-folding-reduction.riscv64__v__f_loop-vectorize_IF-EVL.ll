; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-reduction.ll
; Variant: riscv64_+v,+f_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v,+f -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v,+f -S < %s| FileCheck %s --check-prefix=IF-EVL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define i32 @add(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %add
}

; not support mul reduction for scalable vector
define i32 @mul(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %mul = mul nsw i32 %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %mul
}

define i32 @or(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %or, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %or = or i32 %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %or
}

define i32 @and(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %and, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %and = and i32 %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %and
}

define i32 @xor(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %xor, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %xor = xor i32 %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %xor
}

define i32 @smin(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %smin, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp slt i32 %0, %rdx
  %smin = select i1 %cmp.i, i32 %0, i32 %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %smin
}

define i32 @smax(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %smax, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp sgt i32 %0, %rdx
  %smax = select i1 %cmp.i, i32 %0, i32 %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %smax
}

define i32 @umin(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %umin, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp ult i32 %0, %rdx
  %umin = select i1 %cmp.i, i32 %0, i32 %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %umin
}

define i32 @umax(ptr %a, i64 %n, i32 %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %umax, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp ugt i32 %0, %rdx
  %umax = select i1 %cmp.i, i32 %0, i32 %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %umax
}

define float @fadd(ptr %a, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %add = fadd reassoc float %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %add
}

; not support fmul reduction for scalable vector
define float @fmul(ptr %a, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %mul = fmul reassoc float %0, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %mul
}

define float @fmin(ptr %a, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %min, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %cmp = fcmp fast olt float %0, %rdx
  %min = select nnan nsz i1 %cmp, float %0, float %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %min
}

define float @fmax(ptr %a, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %max, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %cmp = fcmp fast ogt float %0, %rdx
  %max = select nnan nsz i1 %cmp, float %0, float %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %max
}

define float @fminimum(ptr %a, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %min, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %min = tail call float @llvm.minimum.f32(float %rdx, float %0)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %min
}

define float @fmaximum(ptr %a, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %max, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %max = tail call float @llvm.maximum.f32(float %rdx, float %0)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %max
}

define float @fmuladd(ptr %a, ptr %b, i64 %n, float %start) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi float [ %start, %entry ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds float, ptr %b, i64 %iv
  %1 = load float, ptr %arrayidx2, align 4
  %muladd = tail call reassoc float @llvm.fmuladd.f32(float %0, float %1, float %rdx)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %muladd
}

define i32 @anyof_icmp(ptr %a, i64 %n, i32 %start, i32 %inv) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %anyof, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp slt i32 %0, 3
  %anyof = select i1 %cmp.i, i32 %inv, i32 %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %anyof
}

define i32 @anyof_fcmp(ptr %a, i64 %n, i32 %start, i32 %inv) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %start, %entry ], [ %anyof, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %cmp.i = fcmp fast olt float %0, 3.0
  %anyof = select i1 %cmp.i, i32 %inv, i32 %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret i32 %anyof
}



!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpl6_xt329.ll'
source_filename = "/tmp/tmpl6_xt329.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @add(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x i32> zeroinitializer, i32 %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = add <vscale x 4 x i32> %vp.op.load, %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @mul(ptr %a, i64 %n, i32 %start) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 16
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 16
  %n.vec = sub i64 %n, %n.mod.vf
  %0 = insertelement <8 x i32> splat (i32 1), i32 %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x i32> [ %0, %vector.ph ], [ %3, %vector.body ]
  %vec.phi1 = phi <8 x i32> [ splat (i32 1), %vector.ph ], [ %4, %vector.body ]
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %2 = getelementptr inbounds i32, ptr %1, i64 8
  %wide.load = load <8 x i32>, ptr %1, align 4
  %wide.load2 = load <8 x i32>, ptr %2, align 4
  %3 = mul <8 x i32> %wide.load, %vec.phi
  %4 = mul <8 x i32> %wide.load2, %vec.phi1
  %index.next = add nuw i64 %index, 16
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  %bin.rdx = mul <8 x i32> %4, %3
  %6 = call i32 @llvm.vector.reduce.mul.v8i32(<8 x i32> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %6, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %7 = load i32, ptr %arrayidx, align 4
  %mul = mul nsw i32 %7, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !4

for.end:                                          ; preds = %middle.block, %for.body
  %mul.lcssa = phi i32 [ %mul, %for.body ], [ %6, %middle.block ]
  ret i32 %mul.lcssa
}

define i32 @or(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x i32> zeroinitializer, i32 %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = or <vscale x 4 x i32> %vp.op.load, %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @and(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x i32> splat (i32 -1), i32 %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = and <vscale x 4 x i32> %vp.op.load, %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.and.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @xor(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x i32> zeroinitializer, i32 %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %0, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = xor <vscale x 4 x i32> %vp.op.load, %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.xor.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @smin(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %start, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %broadcast.splat, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp slt <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.smin.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @smax(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %start, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %broadcast.splat, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp sgt <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.smax.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @umin(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %start, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %broadcast.splat, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp ult <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.umin.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @umax(ptr %a, i64 %n, i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %start, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %broadcast.splat, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp ugt <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.umax.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define float @fadd(ptr %a, i64 %n, float %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x float> splat (float -0.000000e+00), float %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ %0, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = fadd reassoc <vscale x 4 x float> %vp.op.load, %vec.phi
  %4 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %3, <vscale x 4 x float> %vec.phi, i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %7 = call reassoc float @llvm.vector.reduce.fadd.nxv4f32(float -0.000000e+00, <vscale x 4 x float> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %7
}

define float @fmul(ptr %a, i64 %n, float %start) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 16
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 16
  %n.vec = sub i64 %n, %n.mod.vf
  %0 = insertelement <8 x float> splat (float 1.000000e+00), float %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x float> [ %0, %vector.ph ], [ %3, %vector.body ]
  %vec.phi1 = phi <8 x float> [ splat (float 1.000000e+00), %vector.ph ], [ %4, %vector.body ]
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %2 = getelementptr inbounds float, ptr %1, i64 8
  %wide.load = load <8 x float>, ptr %1, align 4
  %wide.load2 = load <8 x float>, ptr %2, align 4
  %3 = fmul reassoc <8 x float> %wide.load, %vec.phi
  %4 = fmul reassoc <8 x float> %wide.load2, %vec.phi1
  %index.next = add nuw i64 %index, 16
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !13

middle.block:                                     ; preds = %vector.body
  %bin.rdx = fmul reassoc <8 x float> %4, %3
  %6 = call reassoc float @llvm.vector.reduce.fmul.v8f32(float 1.000000e+00, <8 x float> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi float [ %6, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi float [ %bc.merge.rdx, %scalar.ph ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %7 = load float, ptr %arrayidx, align 4
  %mul = fmul reassoc float %7, %rdx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !14

for.end:                                          ; preds = %middle.block, %for.body
  %mul.lcssa = phi float [ %mul, %for.body ], [ %6, %middle.block ]
  ret float %mul.lcssa
}

define float @fmin(ptr %a, i64 %n, float %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x float> poison, float %start, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x float> %broadcast.splatinsert, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ %broadcast.splat, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast olt <vscale x 4 x float> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 4 x i1> %2, <vscale x 4 x float> %vp.op.load, <vscale x 4 x float> %vec.phi
  %4 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %3, <vscale x 4 x float> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !15

middle.block:                                     ; preds = %vector.body
  %7 = call fast float @llvm.vector.reduce.fmin.nxv4f32(<vscale x 4 x float> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %7
}

define float @fmax(ptr %a, i64 %n, float %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x float> poison, float %start, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x float> %broadcast.splatinsert, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ %broadcast.splat, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast ogt <vscale x 4 x float> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 4 x i1> %2, <vscale x 4 x float> %vp.op.load, <vscale x 4 x float> %vec.phi
  %4 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %3, <vscale x 4 x float> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %7 = call fast float @llvm.vector.reduce.fmax.nxv4f32(<vscale x 4 x float> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %7
}

define float @fminimum(ptr %a, i64 %n, float %start) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 16
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 16
  %n.vec = sub i64 %n, %n.mod.vf
  %broadcast.splatinsert = insertelement <8 x float> poison, float %start, i64 0
  %broadcast.splat = shufflevector <8 x float> %broadcast.splatinsert, <8 x float> poison, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x float> [ %broadcast.splat, %vector.ph ], [ %2, %vector.body ]
  %vec.phi1 = phi <8 x float> [ %broadcast.splat, %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds float, ptr %a, i64 %index
  %1 = getelementptr inbounds float, ptr %0, i64 8
  %wide.load = load <8 x float>, ptr %0, align 4
  %wide.load2 = load <8 x float>, ptr %1, align 4
  %2 = call <8 x float> @llvm.minimum.v8f32(<8 x float> %vec.phi, <8 x float> %wide.load)
  %3 = call <8 x float> @llvm.minimum.v8f32(<8 x float> %vec.phi1, <8 x float> %wide.load2)
  %index.next = add nuw i64 %index, 16
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !17

middle.block:                                     ; preds = %vector.body
  %rdx.minmax = call <8 x float> @llvm.minimum.v8f32(<8 x float> %2, <8 x float> %3)
  %5 = call float @llvm.vector.reduce.fminimum.v8f32(<8 x float> %rdx.minmax)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi float [ %5, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi float [ %bc.merge.rdx, %scalar.ph ], [ %min, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %6 = load float, ptr %arrayidx, align 4
  %min = tail call float @llvm.minimum.f32(float %rdx, float %6)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !18

for.end:                                          ; preds = %middle.block, %for.body
  %min.lcssa = phi float [ %min, %for.body ], [ %5, %middle.block ]
  ret float %min.lcssa
}

define float @fmaximum(ptr %a, i64 %n, float %start) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 16
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 16
  %n.vec = sub i64 %n, %n.mod.vf
  %broadcast.splatinsert = insertelement <8 x float> poison, float %start, i64 0
  %broadcast.splat = shufflevector <8 x float> %broadcast.splatinsert, <8 x float> poison, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x float> [ %broadcast.splat, %vector.ph ], [ %2, %vector.body ]
  %vec.phi1 = phi <8 x float> [ %broadcast.splat, %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds float, ptr %a, i64 %index
  %1 = getelementptr inbounds float, ptr %0, i64 8
  %wide.load = load <8 x float>, ptr %0, align 4
  %wide.load2 = load <8 x float>, ptr %1, align 4
  %2 = call <8 x float> @llvm.maximum.v8f32(<8 x float> %vec.phi, <8 x float> %wide.load)
  %3 = call <8 x float> @llvm.maximum.v8f32(<8 x float> %vec.phi1, <8 x float> %wide.load2)
  %index.next = add nuw i64 %index, 16
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !19

middle.block:                                     ; preds = %vector.body
  %rdx.minmax = call <8 x float> @llvm.maximum.v8f32(<8 x float> %2, <8 x float> %3)
  %5 = call float @llvm.vector.reduce.fmaximum.v8f32(<8 x float> %rdx.minmax)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi float [ %5, %middle.block ], [ %start, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi float [ %bc.merge.rdx, %scalar.ph ], [ %max, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %6 = load float, ptr %arrayidx, align 4
  %max = tail call float @llvm.maximum.f32(float %rdx, float %6)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !20

for.end:                                          ; preds = %middle.block, %for.body
  %max.lcssa = phi float [ %max, %for.body ], [ %5, %middle.block ]
  ret float %max.lcssa
}

define float @fmuladd(ptr %a, ptr %b, i64 %n, float %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x float> splat (float -0.000000e+00), float %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ %0, %vector.ph ], [ %5, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = getelementptr inbounds float, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %4 = call reassoc <vscale x 4 x float> @llvm.fmuladd.nxv4f32(<vscale x 4 x float> %vp.op.load, <vscale x 4 x float> %vp.op.load1, <vscale x 4 x float> %vec.phi)
  %5 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %4, <vscale x 4 x float> %vec.phi, i32 %1)
  %6 = zext i32 %1 to i64
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !21

middle.block:                                     ; preds = %vector.body
  %8 = call reassoc float @llvm.vector.reduce.fadd.nxv4f32(float -0.000000e+00, <vscale x 4 x float> %5)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %8
}

define i32 @anyof_icmp(ptr %a, i64 %n, i32 %start, i32 %inv) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp slt <vscale x 4 x i32> %vp.op.load, splat (i32 3)
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 %inv, i32 %start
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %rdx.select
}

define i32 @anyof_fcmp(ptr %a, i64 %n, i32 %start, i32 %inv) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast olt <vscale x 4 x float> %vp.op.load, splat (float 3.000000e+00)
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !23

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 %inv, i32 %start
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %rdx.select
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maximum.f32(float, float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minimum.f32(float, float) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.mul.v8i32(<8 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.and.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.xor.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smin.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umin.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umax.nxv4i32(<vscale x 4 x i32>) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1>, <vscale x 4 x float>, <vscale x 4 x float>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.nxv4f32(float, <vscale x 4 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fmul.v8f32(float, <8 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fmin.nxv4f32(<vscale x 4 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fmax.nxv4f32(<vscale x 4 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.minimum.v8f32(<8 x float>, <8 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fminimum.v8f32(<8 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.maximum.v8f32(<8 x float>, <8 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fmaximum.v8f32(<8 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.fmuladd.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #4

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !2, !1}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1, !2}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1, !2}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1, !2}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !1, !2}
!14 = distinct !{!14, !2, !1}
!15 = distinct !{!15, !1, !2}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !1, !2}
!18 = distinct !{!18, !2, !1}
!19 = distinct !{!19, !1, !2}
!20 = distinct !{!20, !2, !1}
!21 = distinct !{!21, !1, !2}
!22 = distinct !{!22, !1, !2}
!23 = distinct !{!23, !1, !2}
