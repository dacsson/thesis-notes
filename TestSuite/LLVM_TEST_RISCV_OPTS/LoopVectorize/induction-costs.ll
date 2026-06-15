; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/induction-costs.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -S
; Original: RUN: opt -p loop-vectorize -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

; Test case for https://github.com/llvm/llvm-project/issues/106417.
define void @skip_free_iv_truncate(i16 %x, ptr %A) #0 {
entry:
  %x.i32 = sext i16 %x to i32
  %x.i64 = sext i16 %x to i64
  %invariant.gep = getelementptr i8, ptr %A, i64 -8
  br label %loop

loop:
  %iv = phi i64 [ %x.i64, %entry ], [ %iv.next, %loop ]
  %iv.conv = phi i32 [ %x.i32, %entry ], [ %5, %loop ]
  %gep.i64 = getelementptr i64, ptr %A, i64 %iv
  %2 = load i64, ptr %gep.i64, align 8
  %3 = sext i32 %iv.conv to i64
  %gep.conv = getelementptr i64, ptr %invariant.gep, i64 %3
  %4 = load i64, ptr %gep.conv, align 8
  %gep.i16 = getelementptr i16, ptr %A, i64 %iv
  store i16 0, ptr %gep.i16, align 2
  %iv.next = add i64 %iv, 3
  %5 = trunc i64 %iv.next to i32
  %c = icmp slt i64 %iv, 99
  br i1 %c, label %loop, label %exit

exit:
  ret void
}

define void @test_3_inductions(ptr noalias %dst, ptr noalias %src, i64 %n) #1 {
entry:
  br label %loop

loop:
  %iv.0 = phi i32 [ 1, %entry ], [ %iv.0.next, %loop ]
  %iv.1 = phi i64 [ 0, %entry ], [ %iv.1.next, %loop ]
  %iv.2 = phi i32 [ 0, %entry ], [ %iv.2.next, %loop ]
  %iv.or = or i32 %iv.2, %iv.0
  %iv.or.ext = sext i32 %iv.or to i64
  %gep.src = getelementptr i8, ptr %src, i64 %iv.or.ext
  store ptr %gep.src, ptr %dst, align 8
  %iv.0.next = add i32 %iv.0, 2
  %iv.1.next = add i64 %iv.1, 1
  %iv.2.next = add i32 %iv.2, 2
  %ec = icmp eq i64 %iv.1, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @redundant_iv_trunc_for_cse(ptr noalias %src, ptr noalias %dst, i64 %n) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep.src = getelementptr inbounds i32, ptr %src, i64 %iv
  %l = load i32, ptr %gep.src
  %c.0 = icmp eq i32 %l, 0
  %trunc.iv = trunc i64 %iv to i32
  br i1 %c.0, label %then, label %loop.latch

then:
  %trunc.iv.2  = trunc i64 %iv to i32
  %shl.iv = shl i32 %trunc.iv.2, 16
  br label %loop.latch

loop.latch:
  %p = phi i32 [ %shl.iv, %then ], [ %trunc.iv, %loop.header ]
  %trunc.p = trunc i32 %p to i8
  %gep.dst = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %trunc.p, ptr %gep.dst, align 1
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, %n
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}



attributes #0 = { "target-features"="+64bit,+v,+zvl256b" }
attributes #1 = { "target-cpu"="sifive-p670" }
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp61qbk4cq.ll'
source_filename = "/tmp/tmp61qbk4cq.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @skip_free_iv_truncate(i16 %x, ptr %A) #0 {
entry:
  %x.i32 = sext i16 %x to i32
  %x.i64 = sext i16 %x to i64
  %invariant.gep = getelementptr i8, ptr %A, i64 -8
  %smax9 = call i64 @llvm.smax.i64(i64 %x.i64, i64 99)
  %0 = sub i64 %smax9, %x.i64
  %umin10 = call i64 @llvm.umin.i64(i64 %0, i64 1)
  %1 = sub i64 %smax9, %umin10
  %2 = sub i64 %1, %x.i64
  %3 = udiv i64 %2, 3
  %4 = add i64 %umin10, %3
  %5 = add i64 %4, 1
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %6 = shl nsw i64 %x.i64, 1
  %scevgep = getelementptr i8, ptr %A, i64 %6
  %smax = call i64 @llvm.smax.i64(i64 %x.i64, i64 99)
  %7 = sub i64 %smax, %x.i64
  %umin = call i64 @llvm.umin.i64(i64 %7, i64 1)
  %8 = sub i64 %smax, %umin
  %9 = sub i64 %8, %x.i64
  %10 = udiv i64 %9, 3
  %11 = add i64 %umin, %10
  %12 = mul i64 %11, 6
  %13 = add i64 %12, %6
  %14 = add i64 %13, 2
  %scevgep1 = getelementptr i8, ptr %A, i64 %14
  %15 = shl nsw i64 %x.i64, 3
  %scevgep2 = getelementptr i8, ptr %A, i64 %15
  %16 = mul i64 %11, 24
  %17 = add i64 %16, %15
  %18 = add i64 %17, 8
  %scevgep3 = getelementptr i8, ptr %A, i64 %18
  %19 = add nsw i64 %15, -8
  %scevgep4 = getelementptr i8, ptr %A, i64 %19
  %scevgep5 = getelementptr i8, ptr %A, i64 %17
  %bound0 = icmp ult ptr %scevgep, %scevgep3
  %bound1 = icmp ult ptr %scevgep2, %scevgep1
  %found.conflict = and i1 %bound0, %bound1
  %bound06 = icmp ult ptr %scevgep, %scevgep5
  %bound17 = icmp ult ptr %scevgep4, %scevgep1
  %found.conflict8 = and i1 %bound06, %bound17
  %conflict.rdx = or i1 %found.conflict, %found.conflict8
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %20 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %x.i64, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %21 = mul <vscale x 8 x i64> %20, splat (i64 3)
  %induction = add <vscale x 8 x i64> %broadcast.splat, %21
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %induction, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %5, %vector.ph ], [ %avl.next, %vector.body ]
  %22 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %23 = zext i32 %22 to i64
  %24 = mul i64 3, %23
  %broadcast.splatinsert11 = insertelement <vscale x 8 x i64> poison, i64 %24, i64 0
  %broadcast.splat12 = shufflevector <vscale x 8 x i64> %broadcast.splatinsert11, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %25 = getelementptr i16, ptr %A, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %25, <vscale x 8 x i1> splat (i1 true), i32 %22), !alias.scope !0, !noalias !3
  %avl.next = sub nuw i64 %avl, %23
  %vec.ind.next = add <vscale x 8 x i64> %vec.ind, %broadcast.splat12
  %26 = icmp eq i64 %avl.next, 0
  br i1 %26, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %x.i64, %scalar.ph ], [ %iv.next, %loop ]
  %iv.conv = phi i32 [ %x.i32, %scalar.ph ], [ %30, %loop ]
  %gep.i64 = getelementptr i64, ptr %A, i64 %iv
  %27 = load i64, ptr %gep.i64, align 8
  %28 = sext i32 %iv.conv to i64
  %gep.conv = getelementptr i64, ptr %invariant.gep, i64 %28
  %29 = load i64, ptr %gep.conv, align 8
  %gep.i16 = getelementptr i16, ptr %A, i64 %iv
  store i16 0, ptr %gep.i16, align 2
  %iv.next = add i64 %iv, 3
  %30 = trunc i64 %iv.next to i32
  %c = icmp slt i64 %iv, 99
  br i1 %c, label %loop, label %exit, !llvm.loop !9

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_3_inductions(ptr noalias %dst, ptr noalias %src, i64 %n) #1 {
entry:
  %0 = add i64 %n, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %dst, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %1 = call <vscale x 2 x i32> @llvm.stepvector.nxv2i32()
  %2 = mul <vscale x 2 x i32> %1, splat (i32 2)
  %induction = add <vscale x 2 x i32> splat (i32 1), %2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i32> [ %induction, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.ind1 = phi <vscale x 2 x i32> [ %2, %vector.ph ], [ %vec.ind.next4, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %4 = shl i32 %3, 1
  %broadcast.splatinsert2 = insertelement <vscale x 2 x i32> poison, i32 %4, i64 0
  %broadcast.splat3 = shufflevector <vscale x 2 x i32> %broadcast.splatinsert2, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %5 = or <vscale x 2 x i32> %vec.ind1, %vec.ind
  %6 = sext <vscale x 2 x i32> %5 to <vscale x 2 x i64>
  %7 = getelementptr i8, ptr %src, <vscale x 2 x i64> %6
  call void @llvm.vp.scatter.nxv2p0.nxv2p0(<vscale x 2 x ptr> %7, <vscale x 2 x ptr> align 8 %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %3)
  %8 = zext i32 %3 to i64
  %avl.next = sub nuw i64 %avl, %8
  %vec.ind.next = add <vscale x 2 x i32> %vec.ind, %broadcast.splat3
  %vec.ind.next4 = add <vscale x 2 x i32> %vec.ind1, %broadcast.splat3
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @redundant_iv_trunc_for_cse(ptr noalias %src, ptr noalias %dst, i64 %n) #0 {
entry:
  %0 = add i64 %n, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %1 = call <vscale x 4 x i32> @llvm.stepvector.nxv4i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i32> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.ind1 = phi <vscale x 4 x i32> [ %1, %vector.ph ], [ %vec.ind.next2, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %3 = getelementptr inbounds i32, ptr %src, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %4 = icmp eq <vscale x 4 x i32> %vp.op.load, zeroinitializer
  %5 = shl <vscale x 4 x i32> %vec.ind1, splat (i32 16)
  %predphi = select <vscale x 4 x i1> %4, <vscale x 4 x i32> %5, <vscale x 4 x i32> %vec.ind
  %6 = trunc <vscale x 4 x i32> %predphi to <vscale x 4 x i8>
  %7 = getelementptr inbounds i8, ptr %dst, i64 %index
  call void @llvm.vp.store.nxv4i8.p0(<vscale x 4 x i8> %6, ptr align 1 %7, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %8 = zext i32 %2 to i64
  %current.iteration.next = add i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %vec.ind.next = add <vscale x 4 x i32> %vec.ind, %broadcast.splat
  %vec.ind.next2 = add <vscale x 4 x i32> %vec.ind1, %broadcast.splat
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 8 x i64> @llvm.stepvector.nxv8i64() #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i32> @llvm.stepvector.nxv2i32() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2p0.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.stepvector.nxv4i32() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i8.p0(<vscale x 4 x i8>, ptr captures(none), <vscale x 4 x i1>, i32) #7

attributes #0 = { "target-features"="+64bit,+v,+zvl256b" }
attributes #1 = { "target-cpu"="sifive-p670" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nocallback nofree nosync nounwind willreturn }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4, !5}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !2}
!6 = distinct !{!6, !7, !8}
!7 = !{!"llvm.loop.isvectorized", i32 1}
!8 = !{!"llvm.loop.unroll.runtime.disable"}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7, !8}
!11 = distinct !{!11, !7, !8}
