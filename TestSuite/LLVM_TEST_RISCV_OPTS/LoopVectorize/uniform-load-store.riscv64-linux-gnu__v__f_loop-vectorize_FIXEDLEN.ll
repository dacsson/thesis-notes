; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/uniform-load-store.ll
; Variant: riscv64-linux-gnu_+v,+f_loop-vectorize_FIXEDLEN
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=off -mtriple riscv64-linux-gnu -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=off -mtriple riscv64-linux-gnu -mattr=+v,+f -S 2>%t | FileCheck %s -check-prefix=FIXEDLEN

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

; ModuleID = '/tmp/tmpeqdgsu5z.ll'
source_filename = "/tmp/tmpeqdgsu5z.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @uniform_load(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = load i64, ptr %b, align 8
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %0, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %2 = getelementptr inbounds i64, ptr %1, i64 4
  store <4 x i64> %broadcast.splat, ptr %1, align 8
  store <4 x i64> %broadcast.splat, ptr %2, align 8
  %index.next = add nuw i64 %index, 8
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %for.body ]
  %v = load i64, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %for.body
  ret void
}

define i64 @uniform_load_outside_use(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = load i64, ptr %b, align 8
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %0, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %2 = getelementptr inbounds i64, ptr %1, i64 4
  store <4 x i64> %broadcast.splat, ptr %1, align 8
  store <4 x i64> %broadcast.splat, ptr %2, align 8
  %index.next = add nuw i64 %index, 8
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %for.body ]
  %v = load i64, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !5

for.end:                                          ; preds = %for.body
  %v.lcssa = phi i64 [ %v, %for.body ]
  ret i64 %v.lcssa
}

define void @conditional_uniform_load(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x ptr> poison, ptr %b, i64 0
  %broadcast.splat = shufflevector <4 x ptr> %broadcast.splatinsert, <4 x ptr> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw <4 x i64> %vec.ind, splat (i64 4)
  %0 = icmp ugt <4 x i64> %vec.ind, splat (i64 10)
  %1 = icmp ugt <4 x i64> %step.add, splat (i64 10)
  %wide.masked.gather = call <4 x i64> @llvm.masked.gather.v4i64.v4p0(<4 x ptr> align 8 %broadcast.splat, <4 x i1> %0, <4 x i64> poison)
  %wide.masked.gather1 = call <4 x i64> @llvm.masked.gather.v4i64.v4p0(<4 x ptr> align 8 %broadcast.splat, <4 x i1> %1, <4 x i64> poison)
  %predphi = select <4 x i1> %0, <4 x i64> %wide.masked.gather, <4 x i64> zeroinitializer
  %predphi2 = select <4 x i1> %1, <4 x i64> %wide.masked.gather1, <4 x i64> zeroinitializer
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  %3 = getelementptr inbounds i64, ptr %2, i64 4
  store <4 x i64> %predphi, ptr %2, align 8
  store <4 x i64> %predphi2, ptr %3, align 8
  %index.next = add nuw i64 %index, 8
  %vec.ind.next = add nuw nsw <4 x i64> %step.add, splat (i64 4)
  %4 = icmp eq i64 %index.next, 1024
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %latch
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %latch ]
  %cmp = icmp ugt i64 %iv, 10
  br i1 %cmp, label %do_load, label %latch

do_load:                                          ; preds = %for.body
  %v = load i64, ptr %b, align 8
  br label %latch

latch:                                            ; preds = %do_load, %for.body
  %phi = phi i64 [ 0, %for.body ], [ %v, %do_load ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %phi, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !7

for.end:                                          ; preds = %latch
  ret void
}

define void @uniform_load_unaligned(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = load i64, ptr %b, align 1
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %0, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %2 = getelementptr inbounds i64, ptr %1, i64 4
  store <4 x i64> %broadcast.splat, ptr %1, align 8
  store <4 x i64> %broadcast.splat, ptr %2, align 8
  %index.next = add nuw i64 %index, 8
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %for.body ]
  %v = load i64, ptr %b, align 1
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !9

for.end:                                          ; preds = %for.body
  ret void
}

define void @uniform_store(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  store i64 %v, ptr %b, align 8
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %1 = getelementptr inbounds i64, ptr %0, i64 4
  store <4 x i64> %broadcast.splat, ptr %0, align 8
  store <4 x i64> %broadcast.splat, ptr %1, align 8
  %index.next = add nuw i64 %index, 8
  %2 = icmp eq i64 %index.next, 1024
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %for.body ]
  store i64 %v, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !11

for.end:                                          ; preds = %for.body
  ret void
}

define void @uniform_store_of_loop_varying(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = add i64 %index, 7
  store i64 %0, ptr %b, align 8
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %2 = getelementptr inbounds i64, ptr %1, i64 4
  store <4 x i64> %broadcast.splat, ptr %1, align 8
  store <4 x i64> %broadcast.splat, ptr %2, align 8
  %index.next = add nuw i64 %index, 8
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %for.body ]
  store i64 %iv, ptr %b, align 8
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !13

for.end:                                          ; preds = %for.body
  ret void
}

define void @conditional_uniform_store(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <4 x ptr> poison, ptr %b, i64 0
  %broadcast.splat2 = shufflevector <4 x ptr> %broadcast.splatinsert1, <4 x ptr> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw <4 x i64> %vec.ind, splat (i64 4)
  %0 = icmp ugt <4 x i64> %vec.ind, splat (i64 10)
  %1 = icmp ugt <4 x i64> %step.add, splat (i64 10)
  call void @llvm.masked.scatter.v4i64.v4p0(<4 x i64> %broadcast.splat, <4 x ptr> align 8 %broadcast.splat2, <4 x i1> %0)
  call void @llvm.masked.scatter.v4i64.v4p0(<4 x i64> %broadcast.splat, <4 x ptr> align 8 %broadcast.splat2, <4 x i1> %1)
  %2 = getelementptr inbounds i64, ptr %a, i64 %index
  %3 = getelementptr inbounds i64, ptr %2, i64 4
  store <4 x i64> %broadcast.splat, ptr %2, align 8
  store <4 x i64> %broadcast.splat, ptr %3, align 8
  %index.next = add nuw i64 %index, 8
  %vec.ind.next = add nuw nsw <4 x i64> %step.add, splat (i64 4)
  %4 = icmp eq i64 %index.next, 1024
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %latch
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %latch ]
  %cmp = icmp ugt i64 %iv, 10
  br i1 %cmp, label %do_store, label %latch

do_store:                                         ; preds = %for.body
  store i64 %v, ptr %b, align 8
  br label %latch

latch:                                            ; preds = %do_store, %for.body
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !15

for.end:                                          ; preds = %latch
  ret void
}

define void @uniform_store_unaligned(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  store i64 %v, ptr %b, align 1
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %1 = getelementptr inbounds i64, ptr %0, i64 4
  store <4 x i64> %broadcast.splat, ptr %0, align 8
  store <4 x i64> %broadcast.splat, ptr %1, align 8
  %index.next = add nuw i64 %index, 8
  %2 = icmp eq i64 %index.next, 1024
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ 1024, %scalar.ph ], [ %iv.next, %for.body ]
  store i64 %v, ptr %b, align 1
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1025
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !17

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <4 x i64> @llvm.masked.gather.v4i64.v4p0(<4 x ptr>, <4 x i1>, <4 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.masked.scatter.v4i64.v4p0(<4 x i64>, <4 x ptr>, <4 x i1>) #2

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !2, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !2, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !2, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !2, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !2, !1}
