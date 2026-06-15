; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/pr88802.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %p, i64 %a, i8 %b) {
entry:
  br label %for.cond

for.cond:
  %iv = phi i32 [ 0, %entry ], [ %add, %for.body ]
  %add = add i32 %iv, 1
  %cmp.slt = icmp slt i32 %iv, 2
  %shl = shl i64 %a, 48
  %ashr = ashr i64 %shl, 52
  %trunc.i32 = trunc i64 %ashr to i32
  br i1 %cmp.slt, label %cond.false, label %for.body

cond.false:
  %zext = zext i8 %b to i32
  br label %for.body

for.body:
  %cond = phi i32 [ %trunc.i32, %for.cond ], [ %zext, %cond.false ]
  %shl.i32 = shl i32 %cond, 8
  %trunc = trunc i32 %shl.i32 to i8
  store i8 %trunc, ptr %p, align 1
  %cmp = icmp slt i32 %iv, 8
  br i1 %cmp, label %for.cond, label %exit

exit:
  ret void
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpdf8aw9td.ll'
source_filename = "/tmp/tmpdf8aw9td.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test(ptr %p, i64 %a, i8 %b) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i8> poison, i8 %b, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i8> %broadcast.splatinsert, <vscale x 2 x i8> poison, <vscale x 2 x i32> zeroinitializer
  %0 = shl i64 %a, 48
  %broadcast.splatinsert1 = insertelement <vscale x 2 x i64> poison, i64 %0, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert1, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %1 = ashr <vscale x 2 x i64> %broadcast.splat2, splat (i64 52)
  %2 = trunc <vscale x 2 x i64> %1 to <vscale x 2 x i32>
  %3 = zext <vscale x 2 x i8> %broadcast.splat to <vscale x 2 x i32>
  %broadcast.splatinsert3 = insertelement <vscale x 2 x ptr> poison, ptr %p, i64 0
  %broadcast.splat4 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert3, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %4 = call <vscale x 2 x i32> @llvm.stepvector.nxv2i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i32> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ 9, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 2, i1 true)
  %broadcast.splatinsert5 = insertelement <vscale x 2 x i32> poison, i32 %5, i64 0
  %broadcast.splat6 = shufflevector <vscale x 2 x i32> %broadcast.splatinsert5, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %6 = icmp slt <vscale x 2 x i32> %vec.ind, splat (i32 2)
  %predphi = select <vscale x 2 x i1> %6, <vscale x 2 x i32> %3, <vscale x 2 x i32> %2
  %7 = shl <vscale x 2 x i32> %predphi, splat (i32 8)
  %8 = trunc <vscale x 2 x i32> %7 to <vscale x 2 x i8>
  call void @llvm.vp.scatter.nxv2i8.nxv2p0(<vscale x 2 x i8> %8, <vscale x 2 x ptr> align 1 %broadcast.splat4, <vscale x 2 x i1> splat (i1 true), i32 %5)
  %avl.next = sub nuw i32 %avl, %5
  %vec.ind.next = add <vscale x 2 x i32> %vec.ind, %broadcast.splat6
  %9 = icmp eq i32 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i32> @llvm.stepvector.nxv2i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i8.nxv2p0(<vscale x 2 x i8>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
