; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/conditional-scalar-assignment.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -force-tail-folding-style=none -mtriple riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -force-tail-folding-style=none -mtriple riscv64 -mattr=+v -S < %s | FileCheck %s

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

; ModuleID = '/tmp/tmpxz9i_pv5.ll'
source_filename = "/tmp/tmpxz9i_pv5.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @simple_find_last_reduction(i64 %N, ptr %data, i32 %a) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 5)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 %N, %3
  %n.vec = sub i64 %N, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %a, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ splat (i32 -1), %vector.ph ], [ %10, %vector.body ]
  %4 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %9, %vector.body ]
  %5 = getelementptr inbounds i32, ptr %data, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = icmp slt <vscale x 4 x i32> %broadcast.splat, %wide.load
  %7 = freeze <vscale x 4 x i1> %6
  %8 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %7)
  %9 = select i1 %8, <vscale x 4 x i1> %6, <vscale x 4 x i1> %4
  %10 = select i1 %8, <vscale x 4 x i32> %wide.load, <vscale x 4 x i32> %vec.phi
  %index.next = add nuw i64 %index, %3
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %12 = call i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32> %10, <vscale x 4 x i1> %9, i32 -1)
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %12, %middle.block ], [ -1, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %data.phi = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %select.data, %loop ]
  %ld.addr = getelementptr inbounds i32, ptr %data, i64 %iv
  %ld = load i32, ptr %ld.addr, align 4
  %select.cmp = icmp slt i32 %a, %ld
  %select.data = select i1 %select.cmp, i32 %ld, i32 %data.phi
  %iv.next = add nuw nsw i64 %iv, 1
  %exit.cmp = icmp eq i64 %iv.next, %N
  br i1 %exit.cmp, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %middle.block, %loop
  %select.data.lcssa = phi i32 [ %select.data, %loop ], [ %12, %middle.block ]
  ret i32 %select.data.lcssa
}

define i32 @non_speculatable_find_last_reduction(ptr noalias %a, ptr noalias %b, i32 %default_val, i64 %N, i32 %threshold) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 7)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 %N, %3
  %n.vec = sub i64 %N, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %threshold, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i32> poison, i32 %default_val, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i32> %broadcast.splatinsert1, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ %broadcast.splat2, %vector.ph ], [ %11, %vector.body ]
  %4 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %10, %vector.body ]
  %5 = getelementptr inbounds nuw i32, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = icmp sgt <vscale x 4 x i32> %wide.load, %broadcast.splat
  %7 = getelementptr i32, ptr %b, i64 %index
  %wide.masked.load = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr align 4 %7, <vscale x 4 x i1> %6, <vscale x 4 x i32> poison)
  %8 = freeze <vscale x 4 x i1> %6
  %9 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %8)
  %10 = select i1 %9, <vscale x 4 x i1> %6, <vscale x 4 x i1> %4
  %11 = select i1 %9, <vscale x 4 x i32> %wide.masked.load, <vscale x 4 x i32> %vec.phi
  %index.next = add nuw i64 %index, %3
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %13 = extractelement <vscale x 4 x i32> %broadcast.splat2, i64 0
  %14 = call i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32> %11, <vscale x 4 x i1> %10, i32 %13)
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %14, %middle.block ], [ %default_val, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %latch
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %latch ]
  %data.phi = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %select.data, %latch ]
  %a.addr = getelementptr inbounds nuw i32, ptr %a, i64 %iv
  %ld.a = load i32, ptr %a.addr, align 4
  %if.cond = icmp sgt i32 %ld.a, %threshold
  br i1 %if.cond, label %if.then, label %latch

if.then:                                          ; preds = %loop
  %b.addr = getelementptr inbounds nuw i32, ptr %b, i64 %iv
  %ld.b = load i32, ptr %b.addr, align 4
  br label %latch

latch:                                            ; preds = %if.then, %loop
  %select.data = phi i32 [ %ld.b, %if.then ], [ %data.phi, %loop ]
  %iv.next = add nuw nsw i64 %iv, 1
  %exit.cmp = icmp eq i64 %iv.next, %N
  br i1 %exit.cmp, label %exit, label %loop, !llvm.loop !5

exit:                                             ; preds = %middle.block, %latch
  %select.data.lcssa = phi i32 [ %select.data, %latch ], [ %14, %middle.block ]
  ret i32 %select.data.lcssa
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, <vscale x 4 x i32>) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
