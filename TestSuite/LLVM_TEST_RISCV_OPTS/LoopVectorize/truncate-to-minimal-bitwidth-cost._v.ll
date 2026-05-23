; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/truncate-to-minimal-bitwidth-cost.ll
; Variant: +v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mattr=+v -S
; Original: RUN: opt -p loop-vectorize -mattr=+v -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test_pr98413_zext_removed(ptr %src, ptr noalias %dst, i64 %x) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep.src, align 8
  %ext.l = zext i16 %l to i64
  %and = and i64 %x, %ext.l
  %trunc.and = trunc i64 %and to i8
  %gep.dst = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %trunc.and, ptr %gep.dst, align 1
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv, 96
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @test_pr98413_sext_removed(ptr %src, ptr noalias %dst, i64 %x) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep.src, align 8
  %ext.l = sext i16 %l to i64
  %and = and i64 %x, %ext.l
  %trunc.and = trunc i64 %and to i8
  %gep.dst = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %trunc.and, ptr %gep.dst, align 1
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv, 96
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

; Test case for https://github.com/llvm/llvm-project/issues/106641.
define void @truncate_to_i1_used_by_branch(i8 %x, ptr %dst) #0 {
entry:
  br label %loop.header

loop.header:
  %f.039 = phi i8  [ 0, %entry ], [ %add, %loop.latch ]
  %0 = or i8 23, %x
  %extract.t = trunc i8 %0 to i1
  br i1 %extract.t, label %then, label %loop.latch

then:
  store i8 0, ptr %dst, align 1
  br label %loop.latch

loop.latch:
  %add = add i8 %f.039, 1
  %conv = sext i8 %f.039 to i32
  %cmp = icmp slt i32 %conv, 8
  br i1 %cmp, label %loop.header, label %exit

exit:
  ret void
}

; Test case for https://github.com/llvm/llvm-project/issues/107171.
define i8 @icmp_ops_narrowed_to_i1() #1 {
entry:
  br label %loop

loop:
  %iv = phi i16 [ 0, %entry ], [ %iv.next, %loop ]
  %c = icmp eq i8 0, 0
  %ext = zext i1 %c to i64
  %shr = lshr i64 %ext, 1
  %trunc = trunc i64 %shr to i8
  %iv.next = add i16 %iv, 1
  %ec = icmp eq i16 %iv.next, 100
  br i1 %ec, label %exit, label %loop

exit:
  ret i8 %trunc
}

define void @icmp_only_first_op_truncated(ptr noalias %dst, i32 %x, i64 %N, i64 %v, ptr noalias %src) #1 {
entry:
  %t = trunc i64 %N to i32
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %t1 = trunc i64 %N to i32
  %c = icmp eq i32 %t1, %t
  br i1 %c, label %then, label %loop.latch

then:
  %idxprom = zext i32 %x to i64
  %arrayidx = getelementptr double, ptr %src, i64 %idxprom
  %retval = load double, ptr %arrayidx, align 8
  store double %retval, ptr %dst, align 8
  br label %loop.latch

loop.latch:
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, %v
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

; Test for https://github.com/llvm/llvm-project/issues/162688.
define void @test_minbws_for_trunc(i32 %n, ptr noalias %p1, ptr noalias %p2) {
entry:
  br label %loop

loop:
  %iv = phi i16 [ 0, %entry ], [ %iv.next, %loop ]
  %iv.ext = sext i16 %iv to i64
  %gep1 = getelementptr i32, ptr %p1, i64 %iv.ext
  %v1 = load i32, ptr %gep1, align 4
  %v1.trunc = trunc i32 %v1 to i16
  %gep2 = getelementptr [1 x [1 x i16]], ptr %p2, i64 %iv.ext
  store i16 %v1.trunc, ptr %gep2, align 2
  %v1.trunc.i8 = trunc i32 %v1 to i8
  %gep3 = getelementptr i8, ptr %p2, i64 %iv.ext
  store i8 %v1.trunc.i8, ptr %gep3, align 1
  %gep4 = getelementptr [1 x i64], ptr %p2, i64 %iv.ext
  store i64 0, ptr %gep4, align 8
  %iv.next = add i16 %iv, 4
  %iv.next.ext = sext i16 %iv.next to i32
  %cmp = icmp ne i32 %iv.next.ext, 1024
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

attributes #0 = { "target-features"="+64bit,+v,+zvl256b" }
attributes #1 = { "target-features"="+64bit,+v" }

;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp21ca0i9i.ll'
source_filename = "/tmp/tmp21ca0i9i.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test_pr98413_zext_removed(ptr %src, ptr noalias %dst, i64 %x) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %x, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %0 = trunc <vscale x 8 x i64> %broadcast.splat to <vscale x 8 x i8>
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 97, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %2 = getelementptr inbounds i16, ptr %src, i64 %index
  %vp.op.load = call <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr align 8 %2, <vscale x 8 x i1> splat (i1 true), i32 %1)
  %3 = trunc <vscale x 8 x i16> %vp.op.load to <vscale x 8 x i8>
  %4 = and <vscale x 8 x i8> %0, %3
  %5 = getelementptr inbounds i8, ptr %dst, i64 %index
  call void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8> %4, ptr align 1 %5, <vscale x 8 x i1> splat (i1 true), i32 %1)
  %6 = zext i32 %1 to i64
  %current.iteration.next = add nuw i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_pr98413_sext_removed(ptr %src, ptr noalias %dst, i64 %x) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %x, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %0 = trunc <vscale x 8 x i64> %broadcast.splat to <vscale x 8 x i8>
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 97, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %2 = getelementptr inbounds i16, ptr %src, i64 %index
  %vp.op.load = call <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr align 8 %2, <vscale x 8 x i1> splat (i1 true), i32 %1)
  %3 = trunc <vscale x 8 x i16> %vp.op.load to <vscale x 8 x i8>
  %4 = and <vscale x 8 x i8> %0, %3
  %5 = getelementptr inbounds i8, ptr %dst, i64 %index
  call void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8> %4, ptr align 1 %5, <vscale x 8 x i1> splat (i1 true), i32 %1)
  %6 = zext i32 %1 to i64
  %current.iteration.next = add nuw i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @truncate_to_i1_used_by_branch(i8 %x, ptr %dst) #1 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x ptr> poison, ptr %dst, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %avl = phi i32 [ 9, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  call void @llvm.vp.scatter.nxv4i8.nxv4p0(<vscale x 4 x i8> zeroinitializer, <vscale x 4 x ptr> align 1 %broadcast.splat, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %avl.next = sub nuw i32 %avl, %0
  %1 = icmp eq i32 %avl.next, 0
  br i1 %1, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i8 @icmp_ops_narrowed_to_i1() #2 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %iv = phi i16 [ 0, %entry ], [ %iv.next, %loop ]
  %c = icmp eq i8 0, 0
  %ext = zext i1 %c to i64
  %shr = lshr i64 %ext, 1
  %trunc = trunc i64 %shr to i8
  %iv.next = add i16 %iv, 1
  %ec = icmp eq i16 %iv.next, 100
  br i1 %ec, label %exit, label %loop

exit:                                             ; preds = %loop
  %trunc.lcssa = phi i8 [ %trunc, %loop ]
  ret i8 %trunc.lcssa
}

define void @icmp_only_first_op_truncated(ptr noalias %dst, i32 %x, i64 %N, i64 %v, ptr noalias %src) #2 {
entry:
  %t = trunc i64 %N to i32
  %0 = add i64 %v, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %N, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 2 x i32> poison, i32 %t, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x i32> %broadcast.splatinsert1, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %1 = trunc <vscale x 2 x i64> %broadcast.splat to <vscale x 2 x i32>
  %2 = icmp eq <vscale x 2 x i32> %1, %broadcast.splat2
  %3 = zext i32 %x to i64
  %4 = getelementptr double, ptr %src, i64 %3
  %broadcast.splatinsert5 = insertelement <vscale x 2 x ptr> poison, ptr %4, i64 0
  %broadcast.splat6 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert5, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <vscale x 2 x ptr> poison, ptr %dst, i64 0
  %broadcast.splat4 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert3, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %wide.masked.gather = call <vscale x 2 x double> @llvm.vp.gather.nxv2f64.nxv2p0(<vscale x 2 x ptr> align 8 %broadcast.splat6, <vscale x 2 x i1> %2, i32 %5)
  call void @llvm.vp.scatter.nxv2f64.nxv2p0(<vscale x 2 x double> %wide.masked.gather, <vscale x 2 x ptr> align 8 %broadcast.splat4, <vscale x 2 x i1> %2, i32 %5)
  %6 = zext i32 %5 to i64
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_minbws_for_trunc(i32 %n, ptr noalias %p1, ptr noalias %p2) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %iv = phi i16 [ 0, %entry ], [ %iv.next, %loop ]
  %iv.ext = sext i16 %iv to i64
  %gep1 = getelementptr i32, ptr %p1, i64 %iv.ext
  %v1 = load i32, ptr %gep1, align 4
  %v1.trunc = trunc i32 %v1 to i16
  %gep2 = getelementptr [1 x [1 x i16]], ptr %p2, i64 %iv.ext
  store i16 %v1.trunc, ptr %gep2, align 2
  %v1.trunc.i8 = trunc i32 %v1 to i8
  %gep3 = getelementptr i8, ptr %p2, i64 %iv.ext
  store i8 %v1.trunc.i8, ptr %gep3, align 1
  %gep4 = getelementptr [1 x i64], ptr %p2, i64 %iv.ext
  store i64 0, ptr %gep4, align 8
  %iv.next = add i16 %iv, 4
  %iv.next.ext = sext i16 %iv.next to i32
  %cmp = icmp ne i32 %iv.next.ext, 1024
  br i1 %cmp, label %loop, label %exit

exit:                                             ; preds = %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i8.p0(<vscale x 8 x i8>, ptr captures(none), <vscale x 8 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i8.nxv4p0(<vscale x 4 x i8>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x double> @llvm.vp.gather.nxv2f64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2f64.nxv2p0(<vscale x 2 x double>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #6

attributes #0 = { "target-features"="+v" }
attributes #1 = { "target-features"="+64bit,+v,+zvl256b,+v" }
attributes #2 = { "target-features"="+64bit,+v,+v" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #6 = { nocallback nofree nosync nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
