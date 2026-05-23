; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/uniform-load-store.ll
; Variant: riscv64-linux-gnu_+v,+f_loop-vectorize_SCALABLE
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=on -riscv-v-vector-bits-min=0 -mtriple riscv64-linux-gnu -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=on -riscv-v-vector-bits-min=0 -mtriple riscv64-linux-gnu -mattr=+v,+f -S 2>%t | FileCheck %s -check-prefix=SCALABLE

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

define void @uniform_load(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %v = load i64, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define i64 @uniform_load_outside_use(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %v = load i64, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i64 %v
}


define void @conditional_uniform_load(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %cmp = icmp ugt i64 %iv, 10
  br i1 %cmp, label %do_load, label %latch
do_load:
  %v = load i64, ptr %b, align 8
  br label %latch

latch:
  %phi = phi i64 [0, %for.body], [%v, %do_load]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @uniform_load_unaligned(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %v = load i64, ptr %b, align 1
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @uniform_store(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  store i64 %v, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @uniform_store_of_loop_varying(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  store i64 %iv, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @conditional_uniform_store(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %cmp = icmp ugt i64 %iv, 10
  br i1 %cmp, label %do_store, label %latch
do_store:
  store i64 %v, ptr %b, align 8
  br label %latch
latch:
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}


define void @uniform_store_unaligned(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  store i64 %v, ptr %b, align 1
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 4}
!2 = !{!"llvm.loop.vectorize.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp4yv6xxgl.ll'
source_filename = "/tmp/tmp4yv6xxgl.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @uniform_load(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = load i64, ptr %b, align 8
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
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

define i64 @uniform_load_outside_use(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = load i64, ptr %b, align 8
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i64 %1
}

define void @conditional_uniform_load(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x ptr> poison, ptr %b, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert1, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = icmp ugt <vscale x 4 x i64> %vec.ind, splat (i64 10)
  %wide.masked.gather = call <vscale x 4 x i64> @llvm.vp.gather.nxv4i64.nxv4p0(<vscale x 4 x ptr> align 8 %broadcast.splat, <vscale x 4 x i1> %3, i32 %1)
  %predphi = select <vscale x 4 x i1> %3, <vscale x 4 x i64> %wide.masked.gather, <vscale x 4 x i64> zeroinitializer
  %4 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv4i64.p0(<vscale x 4 x i64> %predphi, ptr align 8 %4, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat2
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @uniform_load_unaligned(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = load i64, ptr %b, align 1
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %1, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
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

define void @uniform_store(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  store i64 %v, ptr %b, align 8
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @uniform_store_of_loop_varying(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %b, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert1, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %0 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert3 = insertelement <vscale x 2 x i64> poison, i64 %2, i64 0
  %broadcast.splat4 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert3, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %vec.ind, <vscale x 2 x ptr> align 8 %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %3 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat2, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat4
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @conditional_uniform_store(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 2 x ptr> poison, ptr %b, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert1, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %0 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert3 = insertelement <vscale x 2 x i64> poison, i64 %2, i64 0
  %broadcast.splat4 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert3, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %3 = icmp ugt <vscale x 2 x i64> %vec.ind, splat (i64 10)
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %broadcast.splat, <vscale x 2 x ptr> align 8 %broadcast.splat2, <vscale x 2 x i1> %3, i32 %1)
  %4 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @uniform_store_unaligned(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  store i64 %v, ptr %b, align 1
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i64> @llvm.vp.gather.nxv4i64.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i64.p0(<vscale x 4 x i64>, ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(read) }
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
