; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/truncate-to-minimal-bitwidth-evl-crash.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure we don't crash when transforming a VPWidenCastRecipe created without
; an underlying value to an EVL recipe. This occurs in this test via
; VPlanTransforms::truncateToMinimalBitwidths

define void @truncate_to_minimal_bitwidths_widen_cast_recipe(ptr %src) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr i8, ptr %src, i64 %iv
  %0 = load i8, ptr %gep.src, align 1
  %conv = zext i8 %0 to i32
  %mul16 = mul i32 0, %conv
  %shr35 = lshr i32 %mul16, 1
  %conv36 = trunc i32 %shr35 to i8
  store i8 %conv36, ptr null, align 1
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, 8
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

; Test case for https://github.com/llvm/llvm-project/issues/162374.
define void @truncate_i16_to_i8_cse(ptr noalias %src, ptr noalias %dst) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %count = phi i32 [ 0, %entry ], [ %count.next, %loop ]
  %val = load i16, ptr %src, align 2
  %val.zext = zext i16 %val to i64
  %val.trunc.zext = trunc i64 %val.zext to i8
  store i8 %val.trunc.zext, ptr null, align 1
  %val.trunc = trunc i16 %val to i8
  store i8 %val.trunc, ptr %dst, align 1
  %count.next = add i32 %count, 1
  %exitcond = icmp eq i32 %count.next, 0
  %iv.next = add i64 %iv, 1
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpqt29svna.ll'
source_filename = "/tmp/tmpqt29svna.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @truncate_to_minimal_bitwidths_widen_cast_recipe(ptr %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %avl = phi i64 [ 9, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  call void @llvm.vp.scatter.nxv8i8.nxv8p0(<vscale x 8 x i8> zeroinitializer, <vscale x 8 x ptr> align 1 splat (ptr null), <vscale x 8 x i1> splat (i1 true), i32 %0)
  %1 = zext i32 %0 to i64
  %avl.next = sub nuw i64 %avl, %1
  %2 = icmp eq i64 %avl.next, 0
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @truncate_i16_to_i8_cse(ptr noalias %src, ptr noalias %dst) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 4294967296, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 3
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = load i16, ptr %src, align 2
  %broadcast.splatinsert = insertelement <vscale x 8 x i16> poison, i16 %3, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i16> %broadcast.splatinsert, <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
  %4 = trunc <vscale x 8 x i16> %broadcast.splat to <vscale x 8 x i8>
  %5 = call i32 @llvm.vscale.i32()
  %6 = mul nuw i32 %5, 8
  %7 = sub i32 %6, 1
  %8 = extractelement <vscale x 8 x i8> %4, i32 %7
  store i8 %8, ptr null, align 1
  store i8 %8, ptr %dst, align 1
  %index.next = add nuw i64 %index, %2
  %9 = icmp eq i64 %index.next, 4294967296
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br i1 true, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ 4294967296, %middle.block ], [ 0, %entry ]
  %bc.resume.val1 = phi i32 [ 0, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %count = phi i32 [ %bc.resume.val1, %scalar.ph ], [ %count.next, %loop ]
  %val = load i16, ptr %src, align 2
  %val.zext = zext i16 %val to i64
  %val.trunc.zext = trunc i64 %val.zext to i8
  store i8 %val.trunc.zext, ptr null, align 1
  %val.trunc = trunc i16 %val to i8
  store i8 %val.trunc, ptr %dst, align 1
  %count.next = add i32 %count, 1
  %exitcond = icmp eq i32 %count.next, 0
  %iv.next = add i64 %iv, 1
  br i1 %exitcond, label %exit, label %loop, !llvm.loop !4

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i8.nxv8p0(<vscale x 8 x i8>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !2, !1}
