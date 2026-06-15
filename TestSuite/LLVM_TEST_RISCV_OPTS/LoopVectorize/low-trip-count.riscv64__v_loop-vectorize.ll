; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/low-trip-count.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @trip1_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 1
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @trip3_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 3
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @trip5_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 5
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @trip8_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 8
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @trip16_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 16
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}


define void @trip32_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 32
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @trip24_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
entry:
  br label %for.body

for.body:
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 24
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @const_tc_with_predicated_store(i1 %c1, i1 %c2, i1 %c3, ptr %dst) #1 {
entry:
  br label %header

header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  br i1 %c1, label %if.else1, label %if.then

if.then:
  br i1 %c2, label %if.else2, label %if.else1

if.else1:
  %phi1 = phi float [ 0.0, %if.then ], [ 1.0, %header ]
  br i1 %c3, label %latch, label %if.else2

if.else2:
  br label %latch

latch:
  %phi = phi float [ %phi1, %if.else1 ], [ 2.0, %if.else2 ]
  %gep = getelementptr float, ptr %dst, i64 %iv
  store float %phi, ptr %gep, align 4
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, 56
  br i1 %ec, label %exit, label %header

exit:
  ret void
}


attributes #0 = { "target-features"="+v,+d" vscale_range(2, 1024) }
attributes #1 = { vscale_range(16, 1024) "target-features"="+v" }

; This is a non-power-of-2 low trip count, so we will try to tail-fold this. But
; the reduction is a multiply which is only legal for fixed-length VFs. But
; fixed-length VFs aren't legal for the default tail-folding style
; data-with-evl, so make sure we gracefully fall back to data-without-lane-mask.

define i8 @mul_non_pow_2_low_trip_count(ptr noalias %a) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %rdx = phi i8 [ 2, %entry ], [ %mul, %for.body ]
  %gep = getelementptr i8, ptr %a, i64 %iv
  %0 = load i8, ptr %gep
  %mul = mul i8 %0, %rdx
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 10
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i8 %mul
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpa8jb267o.ll'
source_filename = "/tmp/tmpa8jb267o.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: vscale_range(2,1024)
define void @trip1_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 1
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @trip3_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 3
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @trip5_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 5
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @trip8_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %vp.op.load = call <vscale x 4 x i8> @llvm.vp.load.nxv4i8.p0(ptr align 1 %src, <vscale x 4 x i1> splat (i1 true), i32 8)
  %0 = shl <vscale x 4 x i8> %vp.op.load, splat (i8 1)
  %vp.op.load1 = call <vscale x 4 x i8> @llvm.vp.load.nxv4i8.p0(ptr align 1 %dst, <vscale x 4 x i1> splat (i1 true), i32 8)
  %1 = add <vscale x 4 x i8> %0, %vp.op.load1
  call void @llvm.vp.store.nxv4i8.p0(<vscale x 4 x i8> %1, ptr align 1 %dst, <vscale x 4 x i1> splat (i1 true), i32 8)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @trip16_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %vp.op.load = call <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr align 1 %src, <vscale x 8 x i1> splat (i1 true), i32 16)
  %0 = shl <vscale x 8 x i8> %vp.op.load, splat (i8 1)
  %vp.op.load1 = call <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr align 1 %dst, <vscale x 8 x i1> splat (i1 true), i32 16)
  %1 = add <vscale x 8 x i8> %0, %vp.op.load1
  call void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8> %1, ptr align 1 %dst, <vscale x 8 x i1> splat (i1 true), i32 16)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @trip32_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %src, <vscale x 16 x i1> splat (i1 true), i32 32)
  %0 = shl <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %vp.op.load1 = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %dst, <vscale x 16 x i1> splat (i1 true), i32 32)
  %1 = add <vscale x 16 x i8> %0, %vp.op.load1
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %1, ptr align 1 %dst, <vscale x 16 x i1> splat (i1 true), i32 32)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @trip24_i8(ptr noalias noundef captures(none) %dst, ptr noalias noundef readonly captures(none) %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %src, <vscale x 16 x i1> splat (i1 true), i32 24)
  %0 = shl <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %vp.op.load1 = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %dst, <vscale x 16 x i1> splat (i1 true), i32 24)
  %1 = add <vscale x 16 x i8> %0, %vp.op.load1
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %1, ptr align 1 %dst, <vscale x 16 x i1> splat (i1 true), i32 24)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: vscale_range(16,1024)
define void @const_tc_with_predicated_store(i1 %c1, i1 %c2, i1 %c3, ptr %dst) #1 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i1> poison, i1 %c1, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert1, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %0 = xor <vscale x 4 x i1> %broadcast.splat2, splat (i1 true)
  %1 = xor <vscale x 4 x i1> %broadcast.splat, splat (i1 true)
  %2 = select <vscale x 4 x i1> %0, <vscale x 4 x i1> %1, <vscale x 4 x i1> zeroinitializer
  %3 = or <vscale x 4 x i1> %2, %broadcast.splat2
  %predphi = select i1 %c1, <vscale x 4 x float> splat (float 1.000000e+00), <vscale x 4 x float> zeroinitializer
  %broadcast.splatinsert3 = insertelement <vscale x 4 x i1> poison, i1 %c3, i64 0
  %broadcast.splat4 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert3, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %4 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %3, <vscale x 4 x i1> zeroinitializer, i32 57)
  %5 = select <vscale x 4 x i1> %4, <vscale x 4 x i1> %broadcast.splat4, <vscale x 4 x i1> zeroinitializer
  %predphi5 = select <vscale x 4 x i1> %5, <vscale x 4 x float> %predphi, <vscale x 4 x float> splat (float 2.000000e+00)
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %predphi5, ptr align 4 %dst, <vscale x 4 x i1> splat (i1 true), i32 57)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i8 @mul_non_pow_2_low_trip_count(ptr noalias %a) #2 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %wide.load = load <8 x i8>, ptr %a, align 1
  %0 = mul <8 x i8> %wide.load, <i8 2, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  %1 = call i8 @llvm.vector.reduce.mul.v8i8(<8 x i8> %0)
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 8, %scalar.ph ], [ %iv.next, %for.body ]
  %rdx = phi i8 [ %1, %scalar.ph ], [ %mul, %for.body ]
  %gep = getelementptr i8, ptr %a, i64 %iv
  %2 = load i8, ptr %gep, align 1
  %mul = mul i8 %2, %rdx
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 10
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:                                          ; preds = %for.body
  %mul.lcssa = phi i8 [ %mul, %for.body ]
  ret i8 %mul.lcssa
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i8> @llvm.vp.load.nxv4i8.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i8.p0(<vscale x 4 x i8>, ptr captures(none), <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr captures(none), <vscale x 8 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8>, ptr captures(none), <vscale x 8 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr captures(none), <vscale x 16 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8>, ptr captures(none), <vscale x 16 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float>, ptr captures(none), <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.mul.v8i8(<8 x i8>) #6

attributes #0 = { vscale_range(2,1024) "target-features"="+v,+d,+v" }
attributes #1 = { vscale_range(16,1024) "target-features"="+v,+v" }
attributes #2 = { "target-features"="+v" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.unroll.runtime.disable"}
!2 = !{!"llvm.loop.isvectorized", i32 1}
