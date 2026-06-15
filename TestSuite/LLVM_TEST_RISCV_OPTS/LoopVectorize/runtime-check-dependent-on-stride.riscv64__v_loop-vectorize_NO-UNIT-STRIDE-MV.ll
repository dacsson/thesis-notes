; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/runtime-check-dependent-on-stride.ll
; Variant: riscv64_+v_loop-vectorize_NO-UNIT-STRIDE-MV
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=loop-vectorize -enable-mem-access-versioning=false -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+v -passes=loop-vectorize -S < %s -enable-mem-access-versioning=false | FileCheck %s --check-prefix=NO-UNIT-STRIDE-MV

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; TODO: Make sure that optimizations (unit-stride multiversioning) don't prohibit vectorization.

define void @foo(ptr %p, ptr %p.strided, i64 %n, i64 %stride) {
entry:
  %add = add nsw nuw i64 %stride, 2
  %mul = mul nsw nuw i64 %add, %add
  %out.offset = add i64 %mul, 16
  %out = getelementptr i64, ptr %p, i64 %out.offset
  br label %header

header:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %header ]
  %iv.next = add nsw i64 %iv, 1
  %idx = mul i64 %iv, %stride

  %gep.ld = getelementptr i64, ptr %p, i64 %iv
  %gep.st = getelementptr i64, ptr %out, i64 %iv
  %gep.strided = getelementptr i64, ptr %p.strided, i64 %idx

  %ld1 = load i64, ptr %gep.ld
  %ld2 = load i64, ptr %gep.strided
  %val = add i64 %ld1, %ld2
  store i64 %val, ptr %gep.st

  %exitcond = icmp slt i64 %iv.next, 64
  br i1 %exitcond, label %header, label %exit

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpp9qqunte.ll'
source_filename = "/tmp/tmpp9qqunte.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @foo(ptr %p, ptr %p.strided, i64 %n, i64 %stride) #0 {
entry:
  %add = add nuw nsw i64 %stride, 2
  %mul = mul nuw nsw i64 %add, %add
  %out.offset = add i64 %mul, 16
  %out = getelementptr i64, ptr %p, i64 %out.offset
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %0 = shl i64 %stride, 3
  %1 = mul i64 %stride, -8
  %scevgep = getelementptr i8, ptr %p.strided, i64 %0
  %2 = icmp slt i64 %0, 0
  %3 = select i1 %2, i64 %1, i64 %0
  %mul1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %3, i64 62)
  %mul.result = extractvalue { i64, i1 } %mul1, 0
  %mul.overflow = extractvalue { i64, i1 } %mul1, 1
  %4 = sub i64 0, %mul.result
  %5 = getelementptr i8, ptr %scevgep, i64 %mul.result
  %6 = getelementptr i8, ptr %scevgep, i64 %4
  %7 = icmp ult ptr %5, %scevgep
  %8 = icmp ugt ptr %6, %scevgep
  %9 = select i1 %2, i1 %8, i1 %7
  %10 = or i1 %9, %mul.overflow
  br i1 %10, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %11 = mul i64 %add, %add
  %12 = shl i64 %11, 3
  %13 = add i64 %12, 136
  %scevgep2 = getelementptr i8, ptr %p, i64 %13
  %14 = add i64 %12, 640
  %scevgep3 = getelementptr i8, ptr %p, i64 %14
  %scevgep4 = getelementptr i8, ptr %p, i64 8
  %scevgep5 = getelementptr i8, ptr %p, i64 512
  %15 = mul i64 %stride, 504
  %scevgep6 = getelementptr i8, ptr %p.strided, i64 %15
  %16 = shl i64 %stride, 3
  %scevgep7 = getelementptr i8, ptr %p.strided, i64 %16
  %17 = icmp ult ptr %scevgep6, %scevgep7
  %umin = select i1 %17, ptr %scevgep6, ptr %scevgep7
  %18 = icmp ugt ptr %scevgep6, %scevgep7
  %umax = select i1 %18, ptr %scevgep6, ptr %scevgep7
  %scevgep8 = getelementptr i8, ptr %umax, i64 8
  %bound0 = icmp ult ptr %scevgep2, %scevgep5
  %bound1 = icmp ult ptr %scevgep4, %scevgep3
  %found.conflict = and i1 %bound0, %bound1
  %bound09 = icmp ult ptr %scevgep2, %scevgep8
  %bound110 = icmp ult ptr %umin, %scevgep3
  %found.conflict11 = and i1 %bound09, %bound110
  %conflict.rdx = or i1 %found.conflict, %found.conflict11
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %stride, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %19 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %induction = add nsw <vscale x 2 x i64> splat (i64 1), %19
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %induction, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 63, %vector.ph ], [ %avl.next, %vector.body ]
  %20 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %21 = zext i32 %20 to i64
  %broadcast.splatinsert12 = insertelement <vscale x 2 x i64> poison, i64 %21, i64 0
  %broadcast.splat13 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert12, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %22 = add i64 1, %index
  %23 = mul <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %24 = getelementptr i64, ptr %p, i64 %22
  %25 = getelementptr i64, ptr %out, i64 %22
  %26 = getelementptr i64, ptr %p.strided, <vscale x 2 x i64> %23
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %24, <vscale x 2 x i1> splat (i1 true), i32 %20), !alias.scope !0
  %wide.masked.gather = call <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %26, <vscale x 2 x i1> splat (i1 true), i32 %20), !alias.scope !3
  %27 = add <vscale x 2 x i64> %vp.op.load, %wide.masked.gather
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %27, ptr align 8 %25, <vscale x 2 x i1> splat (i1 true), i32 %20), !alias.scope !5, !noalias !7
  %current.iteration.next = add nuw i64 %21, %index
  %avl.next = sub nuw i64 %avl, %21
  %vec.ind.next = add nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat13
  %28 = icmp eq i64 %avl.next, 0
  br i1 %28, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck
  br label %header

header:                                           ; preds = %scalar.ph, %header
  %iv = phi i64 [ 1, %scalar.ph ], [ %iv.next, %header ]
  %iv.next = add nsw i64 %iv, 1
  %idx = mul i64 %iv, %stride
  %gep.ld = getelementptr i64, ptr %p, i64 %iv
  %gep.st = getelementptr i64, ptr %out, i64 %iv
  %gep.strided = getelementptr i64, ptr %p.strided, i64 %idx
  %ld1 = load i64, ptr %gep.ld, align 8
  %ld2 = load i64, ptr %gep.strided, align 8
  %val = add i64 %ld1, %ld2
  store i64 %val, ptr %gep.st, align 8
  %exitcond = icmp slt i64 %iv.next, 64
  br i1 %exitcond, label %header, label %exit, !llvm.loop !11

exit:                                             ; preds = %middle.block, %header
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #6

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = !{!6}
!6 = distinct !{!6, !2}
!7 = !{!1, !4}
!8 = distinct !{!8, !9, !10}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = !{!"llvm.loop.unroll.runtime.disable"}
!11 = distinct !{!11, !9}
