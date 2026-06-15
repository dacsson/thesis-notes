; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/iv-select-cmp.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -force-vector-width=4 -mtriple riscv64 -mattr=+v -scalable-vectorization=on -S
; Original: RUN: opt -p loop-vectorize -force-vector-width=4 -mtriple riscv64 -mattr=+v -scalable-vectorization=on -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @find_last_trunc_iv(ptr %src, i64 %n) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %rdx = phi i32 [ 0, %entry ], [ %rdx.next, %loop ]
  %gep.src = getelementptr inbounds i32, ptr %src, i64 %iv
  %l = load i32, ptr %gep.src
  %cmp103 = icmp eq i32 %l, 0
  %0 = trunc i64 %iv to i32
  %rdx.next = select i1 %cmp103, i32 %0, i32 %rdx
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret i32 %rdx.next
}

define i64 @select_decreasing_induction_icmp_non_const_start(ptr %a, ptr %b, i64 %rdx.start, i64 %n) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ %n, %entry ]
  %rdx = phi i64 [ %cond, %loop ], [ %rdx.start, %entry ]
  %iv.next = add nsw i64 %iv, -1
  %gep.a.iv = getelementptr inbounds i64, ptr %a, i64 %iv.next
  %ld.a = load i64, ptr %gep.a.iv, align 8
  %gep.b.iv = getelementptr inbounds i64, ptr %b, i64 %iv.next
  %ld.b = load i64, ptr %gep.b.iv, align 8
  %cmp.a.b = icmp sgt i64 %ld.a, %ld.b
  %cond = select i1 %cmp.a.b, i64 %iv.next, i64 %rdx
  %exit.cond = icmp ugt i64 %iv, 1
  br i1 %exit.cond, label %loop, label %exit

exit:
  ret i64 %cond
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_2bl99vb.ll'
source_filename = "/tmp/tmp_2bl99vb.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @find_last_trunc_iv(ptr %src, i64 %n) #0 {
entry:
  %0 = add i64 %n, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %1 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %10, %vector.body ]
  %2 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %9, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %3, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %4 = getelementptr inbounds i32, ptr %src, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %4, <vscale x 4 x i1> splat (i1 true), i32 %3)
  %5 = icmp eq <vscale x 4 x i32> %vp.op.load, zeroinitializer
  %6 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %5, <vscale x 4 x i1> zeroinitializer, i32 %3)
  %7 = freeze <vscale x 4 x i1> %6
  %8 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %7)
  %9 = select i1 %8, <vscale x 4 x i1> %6, <vscale x 4 x i1> %2
  %10 = select i1 %8, <vscale x 4 x i32> %vec.ind, <vscale x 4 x i32> %vec.phi
  %11 = zext i32 %3 to i64
  %current.iteration.next = add i64 %11, %index
  %avl.next = sub nuw i64 %avl, %11
  %vec.ind.next = add <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %13 = call i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32> %10, <vscale x 4 x i1> %9, i32 0)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %13
}

define i64 @select_decreasing_induction_icmp_non_const_start(ptr %a, ptr %b, i64 %rdx.start, i64 %n) #0 {
entry:
  %0 = add i64 %n, 1
  %umin = call i64 @llvm.umin.i64(i64 %n, i64 1)
  %1 = sub i64 %0, %umin
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %n, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = sub nsw <vscale x 4 x i64> %broadcast.splat, %2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i64> [ splat (i64 9223372036854775807), %vector.ph ], [ %18, %vector.body ]
  %vec.phi1 = phi <vscale x 4 x i1> [ zeroinitializer, %vector.ph ], [ %19, %vector.body ]
  %avl = phi i64 [ %1, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = zext i32 %4 to i64
  %6 = sub nsw i64 0, %5
  %broadcast.splatinsert2 = insertelement <vscale x 4 x i64> poison, i64 %6, i64 0
  %broadcast.splat3 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert2, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %7 = sub i64 %n, %index
  %8 = add nsw i64 %7, -1
  %9 = getelementptr inbounds i64, ptr %a, i64 %8
  %10 = sub nuw nsw i64 %5, 1
  %11 = sub i64 0, %10
  %12 = getelementptr i64, ptr %9, i64 %11
  %vp.op.load = call <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr align 8 %12, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %13 = call <vscale x 4 x i64> @llvm.experimental.vp.reverse.nxv4i64(<vscale x 4 x i64> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %14 = getelementptr inbounds i64, ptr %b, i64 %8
  %15 = getelementptr i64, ptr %14, i64 %11
  %vp.op.load4 = call <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr align 8 %15, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %16 = call <vscale x 4 x i64> @llvm.experimental.vp.reverse.nxv4i64(<vscale x 4 x i64> %vp.op.load4, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %17 = icmp sgt <vscale x 4 x i64> %13, %16
  %18 = call <vscale x 4 x i64> @llvm.vp.merge.nxv4i64(<vscale x 4 x i1> %17, <vscale x 4 x i64> %vec.ind, <vscale x 4 x i64> %vec.phi, i32 %4)
  %19 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> %17, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %vec.phi1, i32 %4)
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %vec.ind.next = add nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat3
  %20 = icmp eq i64 %avl.next, 0
  br i1 %20, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  %21 = call i64 @llvm.vector.reduce.smin.nxv4i64(<vscale x 4 x i64> %18)
  %22 = add nsw i64 %21, -1
  %23 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %19)
  %24 = freeze i1 %23
  %rdx.select = select i1 %24, i64 %22, i64 %rdx.start
  br label %exit

exit:                                             ; preds = %middle.block
  ret i64 %rdx.select
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.experimental.vp.reverse.nxv4i64(<vscale x 4 x i64>, <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.vp.merge.nxv4i64(<vscale x 4 x i1>, <vscale x 4 x i64>, <vscale x 4 x i64>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.smin.nxv4i64(<vscale x 4 x i64>) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
