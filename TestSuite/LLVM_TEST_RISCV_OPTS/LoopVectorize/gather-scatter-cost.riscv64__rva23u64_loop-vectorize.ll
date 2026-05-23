; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/gather-scatter-cost.ll
; Variant: riscv64_+rva23u64_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+rva23u64 -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+rva23u64 -S | FileCheck %s -check-prefixes=CHECK,RVA23

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @predicated_uniform_load(ptr %src, i32 %n, ptr %dst, i1 %cond) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %cond, label %loop.then, label %loop.else

loop.then:
  br label %loop.latch

loop.else:
  %0 = load i32, ptr %src, align 4
  br label %loop.latch

loop.latch:
  %store = phi i32 [%0, %loop.else], [0, %loop.then]
  store i32 %store, ptr %dst, align 4
  %iv.next = add i32 %iv, 1
  %exitcond = icmp sgt i32 %iv, %n
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @predicated_strided_store(ptr %start) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %0 = mul i64 %iv, 7
  %add.ptr = getelementptr i8, ptr %start, i64 %0
  store i8 0, ptr %add.ptr, align 1
  %iv.next = add i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 585
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @store_to_addr_generated_from_invariant_addr(ptr noalias %p0, ptr noalias %p1, ptr noalias %p2, ptr %p3, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %arrayidx11 = getelementptr i32, ptr %p1, i64 %iv
  store ptr %p0, ptr %arrayidx11, align 8
  %0 = load i64, ptr %p2, align 4
  %bits_to_go = getelementptr i8, ptr %p3, i64 %0
  store i32 0, ptr %bits_to_go, align 4
  store i32 0, ptr %bits_to_go, align 4
  store i8 0, ptr %bits_to_go, align 1
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

; Test for https://github.com/llvm/llvm-project/issues/169948.
define i8 @mixed_gather_scatters(ptr %A, ptr %B, ptr %C) #0 {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %accum = phi i8 [ 0, %entry ], [ %or.4, %loop ]
  %ptr.0 = load ptr, ptr %A, align 8
  %val.0 = load i64, ptr %ptr.0, align 8
  %cmp.0 = icmp sgt i64 %val.0, 0
  %ext.0 = zext i1 %cmp.0 to i8
  %or.0 = or i8 %accum, %ext.0
  %ptr.1 = load ptr, ptr %B, align 8
  %val.1 = load i64, ptr %ptr.1, align 8
  %cmp.1 = icmp sgt i64 %val.1, 0
  %ext.1 = zext i1 %cmp.1 to i8
  %or.1 = or i8 %or.0, %ext.1
  %or.2 = or i8 %or.1, 1
  %ptr.4 = load ptr, ptr %C, align 8
  %val.4 = load i64, ptr %ptr.4, align 8
  %cmp.4 = icmp sgt i64 %val.4, 0
  %ext.4 = zext i1 %cmp.4 to i8
  %or.4 = or i8 %or.2, %ext.4
  %iv.next = add i32 %iv, 1
  %exitcond = icmp eq i32 %iv, 9
  br i1 %exitcond, label %exit, label %loop

exit:
  ret i8 %or.4
}

attributes #0 = { "target-features"="+zve64x,+zvl256b" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_z5l80u4.ll'
source_filename = "/tmp/tmp_z5l80u4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @predicated_uniform_load(ptr %src, i32 %n, ptr %dst, i1 %cond) #0 {
entry:
  %0 = sext i32 %n to i64
  %1 = add nsw i64 %0, 1
  %smax2 = call i64 @llvm.smax.i64(i64 %1, i64 0)
  %2 = trunc i64 %smax2 to i32
  %3 = add nuw i32 %2, 1
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %4 = sext i32 %n to i64
  %5 = add nsw i64 %4, 1
  %smax = call i64 @llvm.smax.i64(i64 %5, i64 0)
  %6 = trunc i64 %smax to i32
  %7 = icmp slt i32 %6, 0
  %8 = icmp ugt i64 %smax, 4294967295
  %9 = or i1 %7, %8
  br i1 %9, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %scevgep = getelementptr i8, ptr %dst, i64 4
  %scevgep1 = getelementptr i8, ptr %src, i64 4
  %bound0 = icmp ult ptr %dst, %scevgep1
  %bound1 = icmp ult ptr %src, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %cond, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %10 = xor <vscale x 4 x i1> %broadcast.splat, splat (i1 true)
  %broadcast.splatinsert3 = insertelement <vscale x 4 x ptr> poison, ptr %src, i64 0
  %broadcast.splat4 = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert3, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  %broadcast.splatinsert5 = insertelement <vscale x 4 x ptr> poison, ptr %dst, i64 0
  %broadcast.splat6 = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert5, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %avl = phi i32 [ %3, %vector.ph ], [ %avl.next, %vector.body ]
  %11 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 4, i1 true)
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %broadcast.splat4, <vscale x 4 x i1> %10, i32 %11), !alias.scope !0
  %predphi = select i1 %cond, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %wide.masked.gather
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %predphi, <vscale x 4 x ptr> align 4 %broadcast.splat6, <vscale x 4 x i1> splat (i1 true), i32 %11), !alias.scope !3, !noalias !0
  %avl.next = sub nuw i32 %avl, %11
  %12 = icmp eq i32 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop.latch
  %iv = phi i32 [ 0, %scalar.ph ], [ %iv.next, %loop.latch ]
  br i1 %cond, label %loop.then, label %loop.else

loop.then:                                        ; preds = %loop
  br label %loop.latch

loop.else:                                        ; preds = %loop
  %13 = load i32, ptr %src, align 4
  br label %loop.latch

loop.latch:                                       ; preds = %loop.else, %loop.then
  %store = phi i32 [ %13, %loop.else ], [ 0, %loop.then ]
  store i32 %store, ptr %dst, align 4
  %iv.next = add i32 %iv, 1
  %exitcond = icmp sgt i32 %iv, %n
  br i1 %exitcond, label %exit, label %loop, !llvm.loop !8

exit:                                             ; preds = %middle.block, %loop.latch
  ret void
}

define void @predicated_strided_store(ptr %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 586, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %3 = mul <vscale x 8 x i64> %vec.ind, splat (i64 7)
  %4 = getelementptr i8, ptr %start, <vscale x 8 x i64> %3
  call void @llvm.vp.scatter.nxv8i8.nxv8p0(<vscale x 8 x i8> zeroinitializer, <vscale x 8 x ptr> align 1 %4, <vscale x 8 x i1> splat (i1 true), i32 %1)
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @store_to_addr_generated_from_invariant_addr(ptr noalias %p0, ptr noalias %p1, ptr noalias %p2, ptr %p3, i64 %N) #0 {
entry:
  %0 = add i64 %N, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %p0, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %1 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %3 = zext i32 %2 to i64
  %broadcast.splatinsert1 = insertelement <vscale x 2 x i64> poison, i64 %3, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert1, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %4 = getelementptr i32, ptr %p1, <vscale x 2 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv2p0.nxv2p0(<vscale x 2 x ptr> %broadcast.splat, <vscale x 2 x ptr> align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %2)
  %5 = load i64, ptr %p2, align 4
  %6 = getelementptr i8, ptr %p3, i64 %5
  %broadcast.splatinsert3 = insertelement <vscale x 2 x ptr> poison, ptr %6, i64 0
  %broadcast.splat4 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert3, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  call void @llvm.vp.scatter.nxv2i32.nxv2p0(<vscale x 2 x i32> zeroinitializer, <vscale x 2 x ptr> align 4 %broadcast.splat4, <vscale x 2 x i1> splat (i1 true), i32 %2)
  call void @llvm.vp.scatter.nxv2i32.nxv2p0(<vscale x 2 x i32> zeroinitializer, <vscale x 2 x ptr> align 4 %broadcast.splat4, <vscale x 2 x i1> splat (i1 true), i32 %2)
  call void @llvm.vp.scatter.nxv2i8.nxv2p0(<vscale x 2 x i8> zeroinitializer, <vscale x 2 x ptr> align 1 %broadcast.splat4, <vscale x 2 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i64 %avl, %3
  %vec.ind.next = add <vscale x 2 x i64> %vec.ind, %broadcast.splat2
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i8 @mixed_gather_scatters(ptr %A, ptr %B, ptr %C) #1 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.phi = phi <vscale x 2 x i8> [ zeroinitializer, %vector.ph ], [ %14, %vector.body ]
  %avl = phi i32 [ 10, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 2, i1 true)
  %1 = load ptr, ptr %A, align 8
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %1, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %wide.masked.gather = call <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = icmp sgt <vscale x 2 x i64> %wide.masked.gather, zeroinitializer
  %3 = zext <vscale x 2 x i1> %2 to <vscale x 2 x i8>
  %4 = or <vscale x 2 x i8> %vec.phi, %3
  %5 = load ptr, ptr %B, align 8
  %broadcast.splatinsert1 = insertelement <vscale x 2 x ptr> poison, ptr %5, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert1, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %wide.masked.gather3 = call <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %broadcast.splat2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %6 = icmp sgt <vscale x 2 x i64> %wide.masked.gather3, zeroinitializer
  %7 = zext <vscale x 2 x i1> %6 to <vscale x 2 x i8>
  %8 = or <vscale x 2 x i8> %4, %7
  %9 = or <vscale x 2 x i8> %8, splat (i8 1)
  %10 = load ptr, ptr %C, align 8
  %broadcast.splatinsert4 = insertelement <vscale x 2 x ptr> poison, ptr %10, i64 0
  %broadcast.splat5 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert4, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %wide.masked.gather6 = call <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %broadcast.splat5, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %11 = icmp sgt <vscale x 2 x i64> %wide.masked.gather6, zeroinitializer
  %12 = zext <vscale x 2 x i1> %11 to <vscale x 2 x i8>
  %13 = or <vscale x 2 x i8> %9, %12
  %14 = call <vscale x 2 x i8> @llvm.vp.merge.nxv2i8(<vscale x 2 x i1> splat (i1 true), <vscale x 2 x i8> %13, <vscale x 2 x i8> %vec.phi, i32 %0)
  %avl.next = sub nuw i32 %avl, %0
  %15 = icmp eq i32 %avl.next, 0
  br i1 %15, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  %16 = call i8 @llvm.vector.reduce.or.nxv2i8(<vscale x 2 x i8> %14)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i8 %16
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 8 x i64> @llvm.stepvector.nxv8i64() #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i8.nxv8p0(<vscale x 8 x i8>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #6

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2p0.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i32.nxv2p0(<vscale x 2 x i32>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i8.nxv2p0(<vscale x 2 x i8>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i8> @llvm.vp.merge.nxv2i8(<vscale x 2 x i1>, <vscale x 2 x i8>, <vscale x 2 x i8>, i32) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.or.nxv2i8(<vscale x 2 x i8>) #2

attributes #0 = { "target-features"="+rva23u64" }
attributes #1 = { "target-features"="+zve64x,+zvl256b,+rva23u64" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.isvectorized", i32 1}
!7 = !{!"llvm.loop.unroll.runtime.disable"}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6, !7}
!10 = distinct !{!10, !6, !7}
!11 = distinct !{!11, !6, !7}
