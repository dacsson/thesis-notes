; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/type-info-cache-evl-crash.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; This test tries to recreate the conditions for a crash that occurred when the
; VPTypeAnalysis cache wasn't cleared after a recipe was erased and clobbered
; with a new one.

define void @type_info_cache_clobber(ptr %dstv, ptr %src, i64 %wide.trip.count) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %arrayidx13 = getelementptr i8, ptr %src, i64 %iv
  %0 = load i8, ptr %arrayidx13, align 1
  %conv14 = zext i8 %0 to i32
  %mul21.neg = mul i32 %conv14, 0
  %add33 = ashr i32 %conv14, 0
  %shr = or i32 %add33, 0
  %tobool.not.i = icmp ult i32 %conv14, 0
  %cond.i = select i1 %tobool.not.i, i32 %shr, i32 0
  %conv.i = trunc i32 %cond.i to i8
  store i8 %conv.i, ptr %dstv, align 1
  %conv36 = trunc i32 %mul21.neg to i16
  store i16 %conv36, ptr null, align 2
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, %wide.trip.count
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpdtu8352f.ll'
source_filename = "/tmp/tmpdtu8352f.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @type_info_cache_clobber(ptr %dstv, ptr %src, i64 %wide.trip.count) #0 {
entry:
  %0 = add i64 %wide.trip.count, 1
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %dstv, i64 1
  %1 = add i64 %wide.trip.count, 1
  %scevgep1 = getelementptr i8, ptr %src, i64 %1
  %bound0 = icmp ult ptr %dstv, %scevgep1
  %bound1 = icmp ult ptr %src, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %broadcast.splatinsert = insertelement <vscale x 8 x ptr> poison, ptr %dstv, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x ptr> %broadcast.splatinsert, <vscale x 8 x ptr> poison, <vscale x 8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %3 = getelementptr i8, ptr %src, i64 %index
  %vp.op.load = call <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr align 1 %3, <vscale x 8 x i1> splat (i1 true), i32 %2), !alias.scope !0
  %4 = zext <vscale x 8 x i8> %vp.op.load to <vscale x 8 x i32>
  %5 = ashr <vscale x 8 x i32> %4, zeroinitializer
  %6 = icmp ult <vscale x 8 x i32> %4, zeroinitializer
  %7 = select <vscale x 8 x i1> %6, <vscale x 8 x i32> %5, <vscale x 8 x i32> zeroinitializer
  %8 = trunc <vscale x 8 x i32> %7 to <vscale x 8 x i8>
  call void @llvm.vp.scatter.nxv8i8.nxv8p0(<vscale x 8 x i8> %8, <vscale x 8 x ptr> align 1 %broadcast.splat, <vscale x 8 x i1> splat (i1 true), i32 %2), !alias.scope !3, !noalias !0
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 splat (ptr null), <vscale x 8 x i1> splat (i1 true), i32 %2)
  %9 = zext i32 %2 to i64
  %current.iteration.next = add i64 %9, %index
  %avl.next = sub nuw i64 %avl, %9
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ 0, %scalar.ph ], [ %iv.next, %loop ]
  %arrayidx13 = getelementptr i8, ptr %src, i64 %iv
  %11 = load i8, ptr %arrayidx13, align 1
  %conv14 = zext i8 %11 to i32
  %mul21.neg = mul i32 %conv14, 0
  %add33 = ashr i32 %conv14, 0
  %shr = or i32 %add33, 0
  %tobool.not.i = icmp ult i32 %conv14, 0
  %cond.i = select i1 %tobool.not.i, i32 %shr, i32 0
  %conv.i = trunc i32 %cond.i to i8
  store i8 %conv.i, ptr %dstv, align 1
  %conv36 = trunc i32 %mul21.neg to i16
  store i16 %conv36, ptr null, align 2
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, %wide.trip.count
  br i1 %ec, label %exit, label %loop, !llvm.loop !8

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr captures(none), <vscale x 8 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i8.nxv8p0(<vscale x 8 x i8>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.isvectorized", i32 1}
!7 = !{!"llvm.loop.unroll.runtime.disable"}
!8 = distinct !{!8, !6}
