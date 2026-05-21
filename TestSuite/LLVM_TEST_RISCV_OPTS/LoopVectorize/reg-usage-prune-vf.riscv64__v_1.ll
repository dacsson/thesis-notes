; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/reg-usage-prune-vf.ll
; Variant: riscv64_+v_1
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -vectorizer-consider-reg-pressure=true -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64 -mattr=+v -vectorizer-consider-reg-pressure=true -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @f(ptr noalias %p0, ptr noalias %p1, ptr noalias %p2) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %wide.iv.0 = phi i64 [ 0, %entry ], [ %wide.iv.0.next, %loop ]
  %wide.iv.1 = phi i64 [ 0, %entry ], [ %wide.iv.1.next, %loop ]
  %wide.iv.2 = phi i64 [ 0, %entry ], [ %wide.iv.2.next, %loop ]

  %wide.iv.0.sub = sub i64 %wide.iv.0, 1
  %a.gep0 = getelementptr i8, ptr %p0, i64 %wide.iv.0.sub
  %a = load i8, ptr %a.gep0

  %wide.iv.1.sub = sub i64 %wide.iv.1, 1
  %b.gep0 = getelementptr i8, ptr %p0, i64 %wide.iv.1.sub
  %b = load i8, ptr %b.gep0

  %wide.iv.2.sub = sub i64 %wide.iv.2, 1
  %c.gep0 = getelementptr i8, ptr %p0, i64 %wide.iv.2.sub
  %c = load i8, ptr %c.gep0

  %iv.mul = mul i64 %iv, 3
  %base = getelementptr i8, ptr %p1, i64 %iv.mul

  %a.gep1 = getelementptr i8, ptr %base, i8 0
  store i8 %a, ptr %a.gep1

  %b.gep1 = getelementptr i8, ptr %base, i8 1
  store i8 %b, ptr %b.gep1

  %c.gep1 = getelementptr i8, ptr %base, i8 2
  store i8 %c, ptr %c.gep1

  %iv.next = add i64 %iv, 1
  %wide.iv.0.next = add i64 %wide.iv.0, 2
  %wide.iv.1.next = add i64 %wide.iv.1, 3
  %wide.iv.2.next = add i64 %wide.iv.2, 4
  %done = icmp eq i64 %iv, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpy2vy7w2y.ll'
source_filename = "/tmp/tmpy2vy7w2y.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @f(ptr noalias %p0, ptr noalias %p1, ptr noalias %p2) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %1 = mul <vscale x 4 x i64> %0, splat (i64 2)
  %2 = mul <vscale x 4 x i64> %0, splat (i64 3)
  %3 = mul <vscale x 4 x i64> %0, splat (i64 4)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.ind1 = phi <vscale x 4 x i64> [ %2, %vector.ph ], [ %vec.ind.next9, %vector.body ]
  %vec.ind2 = phi <vscale x 4 x i64> [ %3, %vector.ph ], [ %vec.ind.next10, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = zext i32 %4 to i64
  %6 = shl i64 %5, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %6, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %7 = mul i64 3, %5
  %broadcast.splatinsert3 = insertelement <vscale x 4 x i64> poison, i64 %7, i64 0
  %broadcast.splat4 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert3, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %8 = shl i64 %5, 1
  %broadcast.splatinsert5 = insertelement <vscale x 4 x i64> poison, i64 %8, i64 0
  %broadcast.splat6 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert5, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %9 = sub <vscale x 4 x i64> %vec.ind, splat (i64 1)
  %10 = getelementptr i8, ptr %p0, <vscale x 4 x i64> %9
  %wide.masked.gather = call <vscale x 4 x i8> @llvm.vp.gather.nxv4i8.nxv4p0(<vscale x 4 x ptr> align 1 %10, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %11 = sub <vscale x 4 x i64> %vec.ind1, splat (i64 1)
  %12 = getelementptr i8, ptr %p0, <vscale x 4 x i64> %11
  %wide.masked.gather7 = call <vscale x 4 x i8> @llvm.vp.gather.nxv4i8.nxv4p0(<vscale x 4 x ptr> align 1 %12, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %13 = sub <vscale x 4 x i64> %vec.ind2, splat (i64 1)
  %14 = getelementptr i8, ptr %p0, <vscale x 4 x i64> %13
  %wide.masked.gather8 = call <vscale x 4 x i8> @llvm.vp.gather.nxv4i8.nxv4p0(<vscale x 4 x ptr> align 1 %14, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %15 = mul i64 %index, 3
  %16 = getelementptr i8, ptr %p1, i64 %15
  %17 = getelementptr i8, ptr %16, i8 0
  %interleave.evl = mul nuw nsw i32 %4, 3
  %interleaved.vec = call <vscale x 12 x i8> @llvm.vector.interleave3.nxv12i8(<vscale x 4 x i8> %wide.masked.gather, <vscale x 4 x i8> %wide.masked.gather7, <vscale x 4 x i8> %wide.masked.gather8)
  call void @llvm.vp.store.nxv12i8.p0(<vscale x 12 x i8> %interleaved.vec, ptr align 1 %17, <vscale x 12 x i1> splat (i1 true), i32 %interleave.evl)
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %vec.ind.next = add <vscale x 4 x i64> %vec.ind, %broadcast.splat6
  %vec.ind.next9 = add <vscale x 4 x i64> %vec.ind1, %broadcast.splat4
  %vec.ind.next10 = add <vscale x 4 x i64> %vec.ind2, %broadcast.splat
  %18 = icmp eq i64 %avl.next, 0
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i8> @llvm.vp.gather.nxv4i8.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 12 x i8> @llvm.vector.interleave3.nxv12i8(<vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv12i8.p0(<vscale x 12 x i8>, ptr captures(none), <vscale x 12 x i1>, i32) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
