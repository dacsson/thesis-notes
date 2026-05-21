; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/fminimumnum.ll
; Variant: riscv64_"+v,+zvfhmin"_loop-vectorize_ZVFHMIN
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=loop-vectorize --mtriple=riscv64 -mattr="+v,+zvfhmin" -S
; Original: RUN: opt --passes=loop-vectorize --mtriple=riscv64 -mattr="+v,+zvfhmin" -S < %s | FileCheck %s --check-prefix=ZVFHMIN

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

; FIXME: fmaximumnum/fminimumnum have no vectorizing support yet.

define void @fmin32(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x float], ptr %input1, i64 0, i64 %iv
  %in1 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds nuw [4096 x float], ptr %input2, i64 0, i64 %iv
  %in2 = load float, ptr %arrayidx2, align 4
  %out = tail call float @llvm.minimumnum.f32(float %in1, float %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x float], ptr %output, i64 0, i64 %iv
  store float %out, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}


define void @fmax32(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x float], ptr %input1, i64 0, i64 %iv
  %in1 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds nuw [4096 x float], ptr %input2, i64 0, i64 %iv
  %in2 = load float, ptr %arrayidx2, align 4
  %out = tail call float @llvm.maximumnum.f32(float %in1, float %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x float], ptr %output, i64 0, i64 %iv
  store float %out, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}


define void @fmin64(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x double], ptr %input1, i64 0, i64 %iv
  %in1 = load double, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds nuw [4096 x double], ptr %input2, i64 0, i64 %iv
  %in2 = load double, ptr %arrayidx2, align 8
  %out = tail call double @llvm.minimumnum.f64(double %in1, double %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x double], ptr %output, i64 0, i64 %iv
  store double %out, ptr %arrayidx4, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}


define void @fmax64(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x double], ptr %input1, i64 0, i64 %iv
  %in1 = load double, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds nuw [4096 x double], ptr %input2, i64 0, i64 %iv
  %in2 = load double, ptr %arrayidx2, align 8
  %out = tail call double @llvm.maximumnum.f64(double %in1, double %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x double], ptr %output, i64 0, i64 %iv
  store double %out, ptr %arrayidx4, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}


define void @fmin16(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x half], ptr %input1, i64 0, i64 %iv
  %in1 = load half, ptr %arrayidx, align 2
  %arrayidx2 = getelementptr inbounds nuw [4096 x half], ptr %input2, i64 0, i64 %iv
  %in2 = load half, ptr %arrayidx2, align 2
  %out = tail call half @llvm.minimumnum.f16(half %in1, half %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x half], ptr %output, i64 0, i64 %iv
  store half %out, ptr %arrayidx4, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}


define void @fmax16(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x half], ptr %input1, i64 0, i64 %iv
  %in1 = load half, ptr %arrayidx, align 2
  %arrayidx2 = getelementptr inbounds nuw [4096 x half], ptr %input2, i64 0, i64 %iv
  %in2 = load half, ptr %arrayidx2, align 2
  %out = tail call half @llvm.maximumnum.f16(half %in1, half %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x half], ptr %output, i64 0, i64 %iv
  store half %out, ptr %arrayidx4, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}

;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp8ir4pae4.ll'
source_filename = "/tmp/tmp8ir4pae4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @fmin32(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) #0 {
entry:
  %input23 = ptrtoaddr ptr %input2 to i64
  %input12 = ptrtoaddr ptr %input1 to i64
  %output1 = ptrtoaddr ptr %output to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 15)
  %min.iters.check = icmp ult i64 4096, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %output1, %input12
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 4
  %7 = sub i64 %output1, %input23
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds nuw [4096 x float], ptr %input1, i64 0, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %10, align 4
  %11 = getelementptr inbounds nuw [4096 x float], ptr %input2, i64 0, i64 %index
  %wide.load5 = load <vscale x 4 x float>, ptr %11, align 4
  %12 = call <vscale x 4 x float> @llvm.minimumnum.nxv4f32(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load5)
  %13 = getelementptr inbounds nuw [4096 x float], ptr %output, i64 0, i64 %index
  store <vscale x 4 x float> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, 4096
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br i1 true, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ 4096, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x float], ptr %input1, i64 0, i64 %iv
  %in1 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds nuw [4096 x float], ptr %input2, i64 0, i64 %iv
  %in2 = load float, ptr %arrayidx2, align 4
  %out = tail call float @llvm.minimumnum.f32(float %in1, float %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x float], ptr %output, i64 0, i64 %iv
  store float %out, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !3

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define void @fmax32(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) #0 {
entry:
  %input23 = ptrtoaddr ptr %input2 to i64
  %input12 = ptrtoaddr ptr %input1 to i64
  %output1 = ptrtoaddr ptr %output to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 15)
  %min.iters.check = icmp ult i64 4096, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %output1, %input12
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 4
  %7 = sub i64 %output1, %input23
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds nuw [4096 x float], ptr %input1, i64 0, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %10, align 4
  %11 = getelementptr inbounds nuw [4096 x float], ptr %input2, i64 0, i64 %index
  %wide.load5 = load <vscale x 4 x float>, ptr %11, align 4
  %12 = call <vscale x 4 x float> @llvm.maximumnum.nxv4f32(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load5)
  %13 = getelementptr inbounds nuw [4096 x float], ptr %output, i64 0, i64 %index
  store <vscale x 4 x float> %12, ptr %13, align 4
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, 4096
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br i1 true, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ 4096, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x float], ptr %input1, i64 0, i64 %iv
  %in1 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds nuw [4096 x float], ptr %input2, i64 0, i64 %iv
  %in2 = load float, ptr %arrayidx2, align 4
  %out = tail call float @llvm.maximumnum.f32(float %in1, float %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x float], ptr %output, i64 0, i64 %iv
  store float %out, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !5

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define void @fmin64(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) #0 {
entry:
  %input23 = ptrtoaddr ptr %input2 to i64
  %input12 = ptrtoaddr ptr %input1 to i64
  %output1 = ptrtoaddr ptr %output to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 15)
  %min.iters.check = icmp ult i64 4096, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 2
  %4 = mul i64 %3, 8
  %5 = sub i64 %output1, %input12
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 8
  %7 = sub i64 %output1, %input23
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 1
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds nuw [4096 x double], ptr %input1, i64 0, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %10, align 8
  %11 = getelementptr inbounds nuw [4096 x double], ptr %input2, i64 0, i64 %index
  %wide.load5 = load <vscale x 2 x double>, ptr %11, align 8
  %12 = call <vscale x 2 x double> @llvm.minimumnum.nxv2f64(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load5)
  %13 = getelementptr inbounds nuw [4096 x double], ptr %output, i64 0, i64 %index
  store <vscale x 2 x double> %12, ptr %13, align 8
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, 4096
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br i1 true, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ 4096, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x double], ptr %input1, i64 0, i64 %iv
  %in1 = load double, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds nuw [4096 x double], ptr %input2, i64 0, i64 %iv
  %in2 = load double, ptr %arrayidx2, align 8
  %out = tail call double @llvm.minimumnum.f64(double %in1, double %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x double], ptr %output, i64 0, i64 %iv
  store double %out, ptr %arrayidx4, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !7

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define void @fmax64(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) #0 {
entry:
  %input23 = ptrtoaddr ptr %input2 to i64
  %input12 = ptrtoaddr ptr %input1 to i64
  %output1 = ptrtoaddr ptr %output to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 15)
  %min.iters.check = icmp ult i64 4096, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 2
  %4 = mul i64 %3, 8
  %5 = sub i64 %output1, %input12
  %diff.check = icmp ult i64 %5, %4
  %6 = mul i64 %3, 8
  %7 = sub i64 %output1, %input23
  %diff.check4 = icmp ult i64 %7, %6
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %8 = call i64 @llvm.vscale.i64()
  %9 = shl nuw i64 %8, 1
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %10 = getelementptr inbounds nuw [4096 x double], ptr %input1, i64 0, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %10, align 8
  %11 = getelementptr inbounds nuw [4096 x double], ptr %input2, i64 0, i64 %index
  %wide.load5 = load <vscale x 2 x double>, ptr %11, align 8
  %12 = call <vscale x 2 x double> @llvm.maximumnum.nxv2f64(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load5)
  %13 = getelementptr inbounds nuw [4096 x double], ptr %output, i64 0, i64 %index
  store <vscale x 2 x double> %12, ptr %13, align 8
  %index.next = add nuw i64 %index, %9
  %14 = icmp eq i64 %index.next, 4096
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br i1 true, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ 4096, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x double], ptr %input1, i64 0, i64 %iv
  %in1 = load double, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds nuw [4096 x double], ptr %input2, i64 0, i64 %iv
  %in2 = load double, ptr %arrayidx2, align 8
  %out = tail call double @llvm.maximumnum.f64(double %in1, double %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x double], ptr %output, i64 0, i64 %iv
  store double %out, ptr %arrayidx4, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !9

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define void @fmin16(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) #0 {
entry:
  %input23 = ptrtoaddr ptr %input2 to i64
  %input12 = ptrtoaddr ptr %input1 to i64
  %output1 = ptrtoaddr ptr %output to i64
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 8
  %2 = mul i64 %1, 2
  %3 = sub i64 %output1, %input12
  %diff.check = icmp ult i64 %3, %2
  %4 = mul i64 %1, 2
  %5 = sub i64 %output1, %input23
  %diff.check4 = icmp ult i64 %5, %4
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 4096, %vector.ph ], [ %avl.next, %vector.body ]
  %6 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %7 = getelementptr inbounds nuw [4096 x half], ptr %input1, i64 0, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 2 %7, <vscale x 8 x i1> splat (i1 true), i32 %6)
  %8 = getelementptr inbounds nuw [4096 x half], ptr %input2, i64 0, i64 %index
  %vp.op.load5 = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 2 %8, <vscale x 8 x i1> splat (i1 true), i32 %6)
  %9 = call <vscale x 8 x half> @llvm.minimumnum.nxv8f16(<vscale x 8 x half> %vp.op.load, <vscale x 8 x half> %vp.op.load5)
  %10 = getelementptr inbounds nuw [4096 x half], ptr %output, i64 0, i64 %index
  call void @llvm.vp.store.nxv8f16.p0(<vscale x 8 x half> %9, ptr align 2 %10, <vscale x 8 x i1> splat (i1 true), i32 %6)
  %11 = zext i32 %6 to i64
  %current.iteration.next = add nuw i64 %11, %index
  %avl.next = sub nuw i64 %avl, %11
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 0, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x half], ptr %input1, i64 0, i64 %iv
  %in1 = load half, ptr %arrayidx, align 2
  %arrayidx2 = getelementptr inbounds nuw [4096 x half], ptr %input2, i64 0, i64 %iv
  %in2 = load half, ptr %arrayidx2, align 2
  %out = tail call half @llvm.minimumnum.f16(half %in1, half %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x half], ptr %output, i64 0, i64 %iv
  store half %out, ptr %arrayidx4, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !11

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

define void @fmax16(ptr noundef readonly captures(none) %input1, ptr noundef readonly captures(none) %input2, ptr noundef writeonly captures(none) %output) #0 {
entry:
  %input23 = ptrtoaddr ptr %input2 to i64
  %input12 = ptrtoaddr ptr %input1 to i64
  %output1 = ptrtoaddr ptr %output to i64
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 8
  %2 = mul i64 %1, 2
  %3 = sub i64 %output1, %input12
  %diff.check = icmp ult i64 %3, %2
  %4 = mul i64 %1, 2
  %5 = sub i64 %output1, %input23
  %diff.check4 = icmp ult i64 %5, %4
  %conflict.rdx = or i1 %diff.check, %diff.check4
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 4096, %vector.ph ], [ %avl.next, %vector.body ]
  %6 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %7 = getelementptr inbounds nuw [4096 x half], ptr %input1, i64 0, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 2 %7, <vscale x 8 x i1> splat (i1 true), i32 %6)
  %8 = getelementptr inbounds nuw [4096 x half], ptr %input2, i64 0, i64 %index
  %vp.op.load5 = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 2 %8, <vscale x 8 x i1> splat (i1 true), i32 %6)
  %9 = call <vscale x 8 x half> @llvm.maximumnum.nxv8f16(<vscale x 8 x half> %vp.op.load, <vscale x 8 x half> %vp.op.load5)
  %10 = getelementptr inbounds nuw [4096 x half], ptr %output, i64 0, i64 %index
  call void @llvm.vp.store.nxv8f16.p0(<vscale x 8 x half> %9, ptr align 2 %10, <vscale x 8 x i1> splat (i1 true), i32 %6)
  %11 = zext i32 %6 to i64
  %current.iteration.next = add nuw i64 %11, %index
  %avl.next = sub nuw i64 %avl, %11
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 0, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw [4096 x half], ptr %input1, i64 0, i64 %iv
  %in1 = load half, ptr %arrayidx, align 2
  %arrayidx2 = getelementptr inbounds nuw [4096 x half], ptr %input2, i64 0, i64 %iv
  %in2 = load half, ptr %arrayidx2, align 2
  %out = tail call half @llvm.maximumnum.f16(half %in1, half %in2)
  %arrayidx4 = getelementptr inbounds nuw [4096 x half], ptr %output, i64 0, i64 %iv
  store half %out, ptr %arrayidx4, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 4096
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !13

exit:                                             ; preds = %middle.block, %for.body
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.maximumnum.f16(half, half) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maximumnum.f32(float, float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.maximumnum.f64(double, double) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.minimumnum.f16(half, half) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minimumnum.f32(float, float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.minimumnum.f64(double, double) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.minimumnum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.maximumnum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x double> @llvm.minimumnum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x double> @llvm.maximumnum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x half> @llvm.minimumnum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8f16.p0(<vscale x 8 x half>, ptr captures(none), <vscale x 8 x i1>, i32) #5

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x half> @llvm.maximumnum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>) #3

attributes #0 = { "target-features"="+v,+zvfhmin" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+zvfhmin" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

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
