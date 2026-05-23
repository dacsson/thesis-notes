; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/conditional-scalar-assignment-fold-tail.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @simple_find_last_reduction(i64 %N, ptr %data, i32 %a) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %data.phi = phi i32 [ -1, %entry ], [ %select.data, %loop ]
  %ld.addr = getelementptr inbounds i32, ptr %data, i64 %iv
  %ld = load i32, ptr %ld.addr, align 4
  %select.cmp = icmp slt i32 %a, %ld
  %select.data = select i1 %select.cmp, i32 %ld, i32 %data.phi
  %iv.next = add nuw nsw i64 %iv, 1
  %exit.cmp = icmp eq i64 %iv.next, %N
  br i1 %exit.cmp, label %exit, label %loop

exit:
  ret i32 %select.data
}

; This test is derived from the following C program:
; int non_speculatable_find_last_reduction(
;   int* a, int* b, int default_val, int N, int threshold)
; {
;   int result = default_val;
;   for (int i = 0; i < N; ++i)
;     if (a[i] > threshold)
;       result = b[i];
;   return result;
; }
define i32 @non_speculatable_find_last_reduction(ptr noalias %a, ptr noalias %b, i32 %default_val, i64 %N, i32 %threshold) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %data.phi = phi i32 [ %default_val, %entry ], [ %select.data, %latch ]
  %a.addr = getelementptr inbounds nuw i32, ptr %a, i64 %iv
  %ld.a = load i32, ptr %a.addr, align 4
  %if.cond = icmp sgt i32 %ld.a, %threshold
  br i1 %if.cond, label %if.then, label %latch

if.then:
  %b.addr = getelementptr inbounds nuw i32, ptr %b, i64 %iv
  %ld.b = load i32, ptr %b.addr, align 4
  br label %latch

latch:
  %select.data = phi i32 [ %ld.b, %if.then ], [ %data.phi, %loop ]
  %iv.next = add nuw nsw i64 %iv, 1
  %exit.cmp = icmp eq i64 %iv.next, %N
  br i1 %exit.cmp, label %exit, label %loop

exit:
  ret i32 %select.data
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp7oqq7g5d.ll'
source_filename = "/tmp/tmp7oqq7g5d.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @simple_find_last_reduction(i64 %N, ptr %data, i32 %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %a, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ splat (i32 -1), %vector.ph ], [ %8, %vector.body ]
  %0 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %7, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds i32, ptr %data, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = icmp slt <vscale x 4 x i32> %broadcast.splat, %vp.op.load
  %4 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %3, <vscale x 4 x i1> zeroinitializer, i32 %1)
  %5 = freeze <vscale x 4 x i1> %4
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %5)
  %7 = select i1 %6, <vscale x 4 x i1> %4, <vscale x 4 x i1> %0
  %8 = select i1 %6, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %9 = zext i32 %1 to i64
  %current.iteration.next = add i64 %9, %index
  %avl.next = sub nuw i64 %avl, %9
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %11 = call i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32> %8, <vscale x 4 x i1> %7, i32 -1)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %11
}

define i32 @non_speculatable_find_last_reduction(ptr noalias %a, ptr noalias %b, i32 %default_val, i64 %N, i32 %threshold) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %threshold, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i32> poison, i32 %default_val, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i32> %broadcast.splatinsert1, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %broadcast.splat2, %vector.ph ], [ %9, %vector.body ]
  %0 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %8, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = getelementptr inbounds nuw i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %3 = icmp sgt <vscale x 4 x i32> %vp.op.load, %broadcast.splat
  %4 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %3, <vscale x 4 x i1> zeroinitializer, i32 %1)
  %5 = getelementptr i32, ptr %b, i64 %index
  %vp.op.load3 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %5, <vscale x 4 x i1> %3, i32 %1)
  %6 = freeze <vscale x 4 x i1> %4
  %7 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %6)
  %8 = select i1 %7, <vscale x 4 x i1> %4, <vscale x 4 x i1> %0
  %9 = select i1 %7, <vscale x 4 x i32> %vp.op.load3, <vscale x 4 x i32> %vec.phi
  %10 = zext i32 %1 to i64
  %current.iteration.next = add i64 %10, %index
  %avl.next = sub nuw i64 %avl, %10
  %11 = icmp eq i64 %avl.next, 0
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  %12 = extractelement <vscale x 4 x i32> %broadcast.splat2, i64 0
  %13 = call i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32> %9, <vscale x 4 x i1> %8, i32 %12)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %13
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i32) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
