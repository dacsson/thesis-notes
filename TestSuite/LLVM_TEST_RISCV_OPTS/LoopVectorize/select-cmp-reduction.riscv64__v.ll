; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/select-cmp-reduction.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @select_icmp(i32 %x, i32 %y, ptr nocapture readonly %c, i64 %n) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %a = phi i32 [ 0, %entry], [ %cond, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %c, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp slt i32 %0, %x
  %cond = select i1 %cmp1, i32 %a, i32 %y
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %cond
}

define i32 @select_fcmp(float %x, i32 %y, ptr nocapture readonly %c, i64 %n) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %a = phi i32 [ 0, %entry], [ %cond, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %c, i64 %indvars.iv
  %0 = load float, ptr %arrayidx, align 4
  %cmp1 = fcmp fast olt float %0, %x
  %cond = select i1 %cmp1, i32 %a, i32 %y
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %cond
}

define i32 @select_const_i32_from_icmp(ptr nocapture readonly %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %0 = phi i64 [ 0, %entry ], [ %6, %for.body ]
  %1 = phi i32 [ 3, %entry ], [ %5, %for.body ]
  %2 = getelementptr inbounds i32, ptr %v, i64 %0
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 3
  %5 = select i1 %4, i32 %1, i32 7
  %6 = add nuw nsw i64 %0, 1
  %7 = icmp eq i64 %6, %n
  br i1 %7, label %exit, label %for.body

exit:
  ret i32 %5
}

define i32 @select_i32_from_icmp(ptr nocapture readonly %v, i32 %a, i32 %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %0 = phi i64 [ 0, %entry ], [ %6, %for.body ]
  %1 = phi i32 [ %a, %entry ], [ %5, %for.body ]
  %2 = getelementptr inbounds i32, ptr %v, i64 %0
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 3
  %5 = select i1 %4, i32 %1, i32 %b
  %6 = add nuw nsw i64 %0, 1
  %7 = icmp eq i64 %6, %n
  br i1 %7, label %exit, label %for.body

exit:
  ret i32 %5
}

define i32 @select_const_i32_from_fcmp(ptr nocapture readonly %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %0 = phi i64 [ 0, %entry ], [ %6, %for.body ]
  %1 = phi i32 [ 2, %entry ], [ %5, %for.body ]
  %2 = getelementptr inbounds float, ptr %v, i64 %0
  %3 = load float, ptr %2, align 4
  %4 = fcmp fast ueq float %3, 3.0
  %5 = select i1 %4, i32 %1, i32 1
  %6 = add nuw nsw i64 %0, 1
  %7 = icmp eq i64 %6, %n
  br i1 %7, label %exit, label %for.body

exit:
  ret i32 %5
}

define float @select_const_f32_from_icmp(ptr nocapture readonly %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %0 = phi i64 [ 0, %entry ], [ %6, %for.body ]
  %1 = phi fast float [ 3.0, %entry ], [ %5, %for.body ]
  %2 = getelementptr inbounds i32, ptr %v, i64 %0
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 3
  %5 = select fast i1 %4, float %1, float 7.0
  %6 = add nuw nsw i64 %0, 1
  %7 = icmp eq i64 %6, %n
  br i1 %7, label %exit, label %for.body

exit:
  ret float %5
}

define i32 @pred_select_const_i32_from_icmp(ptr noalias nocapture readonly %src1, ptr noalias nocapture readonly %src2, i64 %n) {
entry:
  br label %for.body

for.body:
  %i.013 = phi i64 [ %inc, %for.inc ], [ 0, %entry ]
  %r.012 = phi i32 [ %r.1, %for.inc ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %src1, i64 %i.013
  %0 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp sgt i32 %0, 35
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %arrayidx2 = getelementptr inbounds i32, ptr %src2, i64 %i.013
  %1 = load i32, ptr %arrayidx2, align 4
  %cmp3 = icmp eq i32 %1, 2
  %spec.select = select i1 %cmp3, i32 1, i32 %r.012
  br label %for.inc

for.inc:
  %r.1 = phi i32 [ %r.012, %for.body ], [ %spec.select, %if.then ]
  %inc = add nuw nsw i64 %i.013, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %for.end.loopexit, label %for.body

for.end.loopexit:
  %r.1.lcssa = phi i32 [ %r.1, %for.inc ]
  ret i32 %r.1.lcssa
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp532xdxi5.ll'
source_filename = "/tmp/tmp532xdxi5.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @select_icmp(i32 %x, i32 %y, ptr readonly captures(none) %c, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %x, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %c, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp sge <vscale x 4 x i32> %vp.op.load, %broadcast.splat
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 %y, i32 0
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %rdx.select
}

define i32 @select_fcmp(float %x, i32 %y, ptr readonly captures(none) %c, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x float> poison, float %x, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x float> %broadcast.splatinsert, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %c, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast uge <vscale x 4 x float> %vp.op.load, %broadcast.splat
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 %y, i32 0
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %rdx.select
}

define i32 @select_const_i32_from_icmp(ptr readonly captures(none) %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %v, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp ne <vscale x 4 x i32> %vp.op.load, splat (i32 3)
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 7, i32 3
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %rdx.select
}

define i32 @select_i32_from_icmp(ptr readonly captures(none) %v, i32 %a, i32 %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %v, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp ne <vscale x 4 x i32> %vp.op.load, splat (i32 3)
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 %b, i32 %a
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %rdx.select
}

define i32 @select_const_i32_from_fcmp(ptr readonly captures(none) %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %v, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast one <vscale x 4 x float> %vp.op.load, splat (float 3.000000e+00)
  %3 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %2, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %3)
  %7 = freeze i1 %6
  %rdx.select = select i1 %7, i32 1, i32 2
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %rdx.select
}

define float @select_const_f32_from_icmp(ptr readonly captures(none) %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ splat (float 3.000000e+00), %vector.ph ], [ %8, %vector.body ]
  %0 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %7, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds i32, ptr %v, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = icmp ne <vscale x 4 x i32> %vp.op.load, splat (i32 3)
  %4 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %3, <vscale x 4 x i1> zeroinitializer, i32 %1)
  %5 = freeze <vscale x 4 x i1> %4
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %5)
  %7 = select i1 %6, <vscale x 4 x i1> %4, <vscale x 4 x i1> %0
  %8 = select i1 %6, <vscale x 4 x float> splat (float 7.000000e+00), <vscale x 4 x float> %vec.phi
  %9 = zext i32 %1 to i64
  %current.iteration.next = add i64 %9, %index
  %avl.next = sub nuw i64 %avl, %9
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %11 = call float @llvm.experimental.vector.extract.last.active.nxv4f32(<vscale x 4 x float> %8, <vscale x 4 x i1> %7, float 3.000000e+00)
  br label %exit

exit:                                             ; preds = %middle.block
  ret float %11
}

define i32 @pred_select_const_i32_from_icmp(ptr noalias readonly captures(none) %src1, ptr noalias readonly captures(none) %src2, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %6, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %src1, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp sgt <vscale x 4 x i32> %vp.op.load, splat (i32 35)
  %3 = getelementptr i32, ptr %src2, i64 %index
  %vp.op.load1 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %3, <vscale x 4 x i1> %2, i32 %0)
  %4 = icmp eq <vscale x 4 x i32> %vp.op.load1, splat (i32 2)
  %5 = select <vscale x 4 x i1> %2, <vscale x 4 x i1> %4, <vscale x 4 x i1> zeroinitializer
  %6 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %5, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi, i32 %0)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %9 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %6)
  %10 = freeze i1 %9
  %rdx.select = select i1 %10, i32 1, i32 0
  br label %for.end.loopexit

for.end.loopexit:                                 ; preds = %middle.block
  ret i32 %rdx.select
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.experimental.vector.extract.last.active.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, float) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1, !2}
!8 = distinct !{!8, !1, !2}
