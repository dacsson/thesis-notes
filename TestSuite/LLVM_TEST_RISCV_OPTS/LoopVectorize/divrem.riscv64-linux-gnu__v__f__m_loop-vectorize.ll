; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/divrem.ll
; Variant: riscv64-linux-gnu_+v,+f,+m_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+v,+f,+m -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+v,+f,+m -S 2>%t | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Tests specific to div/rem handling - both predicated and not

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

define void @vector_udiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = udiv i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @vector_sdiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = sdiv i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @vector_urem(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = urem i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @vector_srem(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = srem i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_udiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %v, 0
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = udiv i64 %elem, %v
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_sdiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %v, 0
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = sdiv i64 %elem, %v
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_udiv_by_constant(ptr noalias nocapture %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %elem, 42
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = udiv i64 %elem, 27
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_sdiv_by_constant(ptr noalias nocapture %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %elem, 42
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = sdiv i64 %elem, 27
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_sdiv_by_minus_one(ptr noalias nocapture %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %iv
  %elem = load i8, ptr %arrayidx
  %c = icmp ne i8 %elem, 128
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = sdiv i8 %elem, -1 ;; UB if %elem = INT_MIN
  br label %latch
latch:
  %phi = phi i8 [%elem, %for.body], [%divrem, %do_op]
  store i8 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; Test for https://github.com/llvm/llvm-project/issues/159402. For invariant divisors,
; selects can be introduced outside the vector loop and their cost should not be
; considered for each loop iteration.
define void @udiv_sdiv_with_invariant_divisors(i8 %x, i16 %y, i1 %c, ptr %p) {
entry:
  br label %loop.header

loop.header:
  %iv = phi i16 [ -12, %entry ], [ %iv.next, %loop.latch ]
  %narrow.iv = phi i8 [ -12, %entry ], [ %iv.next.trunc, %loop.latch ]
  br i1 %c, label %loop.latch, label %then

then:
  %ud = udiv i8 %narrow.iv, %x
  %ud.ext = zext i8 %ud to i16
  %sd = sdiv i16 %ud.ext, %y
  %sd.ext = sext i16 %sd to i32
  br label %loop.latch

loop.latch:
  %merge = phi i32 [ 0, %loop.header ], [ %sd.ext, %then ]
  store i32 %merge, ptr %p, align 4
  %iv.next = add nsw i16 %iv, 1
  %ec = icmp eq i16 %iv.next, 0
  %iv.next.trunc = trunc i16 %iv.next to i8
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpbq9gv6qe.ll'
source_filename = "/tmp/tmpbq9gv6qe.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @vector_udiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = udiv <vscale x 2 x i64> %vp.op.load, %broadcast.splat
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_sdiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = call <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_urem(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = urem <vscale x 2 x i64> %vp.op.load, %broadcast.splat
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_srem(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = call <vscale x 2 x i64> @llvm.vp.srem.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_udiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %0 = icmp ne <vscale x 2 x i64> %broadcast.splat, zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %3 = call <vscale x 2 x i64> @llvm.vp.udiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %broadcast.splat, <vscale x 2 x i1> %0, i32 %1)
  %4 = extractelement <vscale x 2 x i1> %0, i64 0
  %predphi = select i1 %4, <vscale x 2 x i64> %3, <vscale x 2 x i64> %vp.op.load
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %predphi, ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_sdiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %0 = icmp ne <vscale x 2 x i64> %broadcast.splat, zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %3 = call <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %broadcast.splat, <vscale x 2 x i1> %0, i32 %1)
  %4 = extractelement <vscale x 2 x i1> %0, i64 0
  %predphi = select i1 %4, <vscale x 2 x i64> %3, <vscale x 2 x i64> %vp.op.load
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %predphi, ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_udiv_by_constant(ptr noalias captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = icmp ne <vscale x 2 x i64> %vp.op.load, splat (i64 42)
  %3 = udiv <vscale x 2 x i64> %vp.op.load, splat (i64 27)
  %predphi = select <vscale x 2 x i1> %2, <vscale x 2 x i64> %3, <vscale x 2 x i64> %vp.op.load
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %predphi, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_sdiv_by_constant(ptr noalias captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = icmp ne <vscale x 2 x i64> %vp.op.load, splat (i64 42)
  %3 = sdiv <vscale x 2 x i64> %vp.op.load, splat (i64 27)
  %predphi = select <vscale x 2 x i1> %2, <vscale x 2 x i64> %3, <vscale x 2 x i64> %vp.op.load
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %predphi, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_sdiv_by_minus_one(ptr noalias captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %1 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %1, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %2 = icmp ne <vscale x 16 x i8> %vp.op.load, splat (i8 -128)
  %3 = call <vscale x 16 x i8> @llvm.vp.sdiv.nxv16i8(<vscale x 16 x i8> %vp.op.load, <vscale x 16 x i8> splat (i8 -1), <vscale x 16 x i1> %2, i32 %0)
  %predphi = select <vscale x 16 x i1> %2, <vscale x 16 x i8> %3, <vscale x 16 x i8> %vp.op.load
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %predphi, ptr align 1 %1, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @udiv_sdiv_with_invariant_divisors(i8 %x, i16 %y, i1 %c, ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %0 = xor <vscale x 4 x i1> %broadcast.splat, splat (i1 true)
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i8> poison, i8 %x, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i8> %broadcast.splatinsert1, <vscale x 4 x i8> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <vscale x 4 x i16> poison, i16 %y, i64 0
  %broadcast.splat4 = shufflevector <vscale x 4 x i16> %broadcast.splatinsert3, <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert5 = insertelement <vscale x 4 x ptr> poison, ptr %p, i64 0
  %broadcast.splat6 = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert5, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  %1 = call <vscale x 4 x i8> @llvm.stepvector.nxv4i8()
  %induction = add <vscale x 4 x i8> splat (i8 -12), %1
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i8> [ %induction, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ 12, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %3 = trunc i32 %2 to i8
  %broadcast.splatinsert7 = insertelement <vscale x 4 x i8> poison, i8 %3, i64 0
  %broadcast.splat8 = shufflevector <vscale x 4 x i8> %broadcast.splatinsert7, <vscale x 4 x i8> poison, <vscale x 4 x i32> zeroinitializer
  %4 = call <vscale x 4 x i8> @llvm.vp.udiv.nxv4i8(<vscale x 4 x i8> %vec.ind, <vscale x 4 x i8> %broadcast.splat2, <vscale x 4 x i1> %0, i32 %2)
  %5 = zext <vscale x 4 x i8> %4 to <vscale x 4 x i16>
  %6 = call <vscale x 4 x i16> @llvm.vp.sdiv.nxv4i16(<vscale x 4 x i16> %5, <vscale x 4 x i16> %broadcast.splat4, <vscale x 4 x i1> %0, i32 %2)
  %7 = sext <vscale x 4 x i16> %6 to <vscale x 4 x i32>
  %predphi = select i1 %c, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %7
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %predphi, <vscale x 4 x ptr> align 4 %broadcast.splat6, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i32 %avl, %2
  %vec.ind.next = add <vscale x 4 x i8> %vec.ind, %broadcast.splat8
  %8 = icmp eq i32 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.srem.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.udiv.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr captures(none), <vscale x 16 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 16 x i8> @llvm.vp.sdiv.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8>, ptr captures(none), <vscale x 16 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i8> @llvm.stepvector.nxv4i8() #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i8> @llvm.vp.udiv.nxv4i8(<vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i16> @llvm.vp.sdiv.nxv4i16(<vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #5

attributes #0 = { "target-features"="+v,+f,+m" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #5 = { nocallback nofree nosync nounwind willreturn }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1, !2}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1, !2}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1, !2}
