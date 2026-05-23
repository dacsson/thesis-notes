; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopUnroll/RISCV/vector.ll
; Variant: riscv64_+v,+f_COMMON
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-unroll -mtriple riscv64 -mattr=+v,+f -S
; Original: RUN: opt -p loop-unroll -mtriple riscv64 -mattr=+v,+f -S %s | FileCheck %s --check-prefixes=COMMON,CHECK

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @reverse(ptr %dst, ptr %src, i64 %len) {
entry:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %1 = sub nsw i64 %len, %iv
  %arrayidx = getelementptr inbounds <4 x float>, ptr %src, i64 %1
  %2 = load <4 x float>, ptr %arrayidx, align 16
  %arrayidx2 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv
  store <4 x float> %2, ptr %arrayidx2, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %len
  br i1 %exitcond.not, label %exit, label %for.body

exit:                                 ; preds = %for.body, %entry
  ret void
}


define void @saxpy_tripcount8_full_unroll(ptr %dst, ptr %src, float %a) {
entry:
  %broadcast.splatinsert = insertelement <4 x float> poison, float %a, i64 0
  %broadcast.splat = shufflevector <4 x float> %broadcast.splatinsert, <4 x float> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds nuw float, ptr %src, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = getelementptr inbounds nuw float, ptr %dst, i64 %index
  %wide.load12 = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %2, ptr %1, align 4
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 8
  br i1 %3, label %exit, label %vector.body

exit:                                 ; preds = %vector.body
  ret void
}


define void @saxpy_tripcount1K_av0(ptr %dst, ptr %src, float %a) {
entry:
  %broadcast.splatinsert = insertelement <4 x float> poison, float %a, i64 0
  %broadcast.splat = shufflevector <4 x float> %broadcast.splatinsert, <4 x float> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds nuw float, ptr %src, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = getelementptr inbounds nuw float, ptr %dst, i64 %index
  %wide.load12 = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %2, ptr %1, align 4
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}


define void @saxpy_tripcount1K_av1(ptr %dst, ptr %src, float %a) {
entry:
  %broadcast.splatinsert = insertelement <4 x float> poison, float %a, i64 0
  %broadcast.splat = shufflevector <4 x float> %broadcast.splatinsert, <4 x float> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds nuw float, ptr %src, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = getelementptr inbounds nuw float, ptr %dst, i64 %index
  %wide.load12 = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %2, ptr %1, align 4
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %exit, label %vector.body, !llvm.loop !0

exit:                                 ; preds = %vector.body
  ret void
}

; On SiFive we should runtime unroll the scalar epilogue loop, but not the
; vector loop.
define void @scalar_epilogue(ptr %p, i8 %splat.scalar, i64 %n) {
entry:
  %min.iters.check = icmp ult i64 %n, 32
  br i1 %min.iters.check, label %scalar.remainder, label %vector.ph

vector.ph:
  %n.vec = and i64 %n, -32
  %broadcast.splatinsert = insertelement <16 x i8> poison, i8 %splat.scalar, i64 0
  %broadcast.splat = shufflevector <16 x i8> %broadcast.splatinsert, <16 x i8> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %vector.ph ], [ %iv.next, %vector.body ]
  %gep.p.iv = getelementptr inbounds nuw i8, ptr %p, i64 %iv
  %gep.p.iv.16 = getelementptr inbounds nuw i8, ptr %gep.p.iv, i64 16
  %wide.load = load <16 x i8>, ptr %gep.p.iv, align 1
  %wide.load.2 = load <16 x i8>, ptr %gep.p.iv.16, align 1
  %add.broadcast = add <16 x i8> %wide.load, %broadcast.splat
  %add.broadcast.2 = add <16 x i8> %wide.load.2, %broadcast.splat
  store <16 x i8> %add.broadcast, ptr %gep.p.iv, align 1
  store <16 x i8> %add.broadcast.2, ptr %gep.p.iv.16, align 1
  %iv.next = add nuw i64 %iv, 32
  %exit.cond = icmp eq i64 %iv.next, %n.vec
  br i1 %exit.cond, label %middle.block, label %vector.body, !llvm.loop !2

middle.block:
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.remainder

scalar.remainder:
  %iv.scalar.loop = phi i64 [ %inc, %scalar.remainder ], [ %n.vec, %middle.block ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds nuw i8, ptr %p, i64 %iv.scalar.loop
  %scalar.load = load i8, ptr %arrayidx, align 1
  %add = add i8 %scalar.load, %splat.scalar
  store i8 %add, ptr %arrayidx, align 1
  %inc = add nuw i64 %iv.scalar.loop, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %exit, label %scalar.remainder, !llvm.loop !3

exit:
  ret void
}

define void @vector_operands(ptr %p, i64 %n) {
entry:
  br label %vector.body

vector.body:
  %evl.based.iv = phi i64 [ 0, %entry ], [ %index.evl.next, %vector.body ]
  %avl = phi i64 [ %n, %entry ], [ %avl.next, %vector.body ]
  %vl = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %addr = getelementptr i64, ptr %p, i64 %evl.based.iv
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> splat (i64 0), ptr align 8 %addr, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  %vl.zext = zext i32 %vl to i64
  %index.evl.next = add nuw i64 %vl.zext, %evl.based.iv
  %avl.next = sub nuw i64 %avl, %vl.zext
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %exit, label %vector.body, !llvm.loop !2

exit:
  ret void
}

!0 = !{!0, !1}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = distinct !{!2, !1}
!3 = distinct !{!3, !1}

;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmprsfzytzt.ll'
source_filename = "/tmp/tmprsfzytzt.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @reverse(ptr %dst, ptr %src, i64 %len) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %0 = sub nsw i64 %len, %iv
  %arrayidx = getelementptr inbounds <4 x float>, ptr %src, i64 %0
  %1 = load <4 x float>, ptr %arrayidx, align 16
  %arrayidx2 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv
  store <4 x float> %1, ptr %arrayidx2, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %len
  br i1 %exitcond.not, label %exit, label %for.body

exit:                                             ; preds = %for.body
  ret void
}

define void @saxpy_tripcount8_full_unroll(ptr %dst, ptr %src, float %a) #0 {
entry:
  %broadcast.splatinsert = insertelement <4 x float> poison, float %a, i64 0
  %broadcast.splat = shufflevector <4 x float> %broadcast.splatinsert, <4 x float> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %entry
  %wide.load = load <4 x float>, ptr %src, align 4
  %wide.load12 = load <4 x float>, ptr %dst, align 4
  %0 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %0, ptr %dst, align 4
  %1 = getelementptr inbounds nuw float, ptr %src, i64 4
  %wide.load.1 = load <4 x float>, ptr %1, align 4
  %2 = getelementptr inbounds nuw float, ptr %dst, i64 4
  %wide.load12.1 = load <4 x float>, ptr %2, align 4
  %3 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.1, <4 x float> %wide.load12.1)
  store <4 x float> %3, ptr %2, align 4
  ret void
}

define void @saxpy_tripcount1K_av0(ptr %dst, ptr %src, float %a) #0 {
entry:
  %broadcast.splatinsert = insertelement <4 x float> poison, float %a, i64 0
  %broadcast.splat = shufflevector <4 x float> %broadcast.splatinsert, <4 x float> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds nuw float, ptr %src, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = getelementptr inbounds nuw float, ptr %dst, i64 %index
  %wide.load12 = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %2, ptr %1, align 4
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @saxpy_tripcount1K_av1(ptr %dst, ptr %src, float %a) #0 {
entry:
  %broadcast.splatinsert = insertelement <4 x float> poison, float %a, i64 0
  %broadcast.splat = shufflevector <4 x float> %broadcast.splatinsert, <4 x float> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds nuw float, ptr %src, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = getelementptr inbounds nuw float, ptr %dst, i64 %index
  %wide.load12 = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %2, ptr %1, align 4
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %exit, label %vector.body, !llvm.loop !0

exit:                                             ; preds = %vector.body
  ret void
}

define void @scalar_epilogue(ptr %p, i8 %splat.scalar, i64 %n) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 32
  br i1 %min.iters.check, label %scalar.remainder.preheader, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.vec = and i64 %n, -32
  %broadcast.splatinsert = insertelement <16 x i8> poison, i8 %splat.scalar, i64 0
  %broadcast.splat = shufflevector <16 x i8> %broadcast.splatinsert, <16 x i8> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %iv = phi i64 [ 0, %vector.ph ], [ %iv.next, %vector.body ]
  %gep.p.iv = getelementptr inbounds nuw i8, ptr %p, i64 %iv
  %gep.p.iv.16 = getelementptr inbounds nuw i8, ptr %gep.p.iv, i64 16
  %wide.load = load <16 x i8>, ptr %gep.p.iv, align 1
  %wide.load.2 = load <16 x i8>, ptr %gep.p.iv.16, align 1
  %add.broadcast = add <16 x i8> %wide.load, %broadcast.splat
  %add.broadcast.2 = add <16 x i8> %wide.load.2, %broadcast.splat
  store <16 x i8> %add.broadcast, ptr %gep.p.iv, align 1
  store <16 x i8> %add.broadcast.2, ptr %gep.p.iv.16, align 1
  %iv.next = add nuw i64 %iv, 32
  %exit.cond = icmp eq i64 %iv.next, %n.vec
  br i1 %exit.cond, label %middle.block, label %vector.body, !llvm.loop !2

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.remainder.preheader

scalar.remainder.preheader:                       ; preds = %entry, %middle.block
  %iv.scalar.loop.ph = phi i64 [ 0, %entry ], [ %n.vec, %middle.block ]
  br label %scalar.remainder

scalar.remainder:                                 ; preds = %scalar.remainder.preheader, %scalar.remainder
  %iv.scalar.loop = phi i64 [ %inc, %scalar.remainder ], [ %iv.scalar.loop.ph, %scalar.remainder.preheader ]
  %arrayidx = getelementptr inbounds nuw i8, ptr %p, i64 %iv.scalar.loop
  %scalar.load = load i8, ptr %arrayidx, align 1
  %add = add i8 %scalar.load, %splat.scalar
  store i8 %add, ptr %arrayidx, align 1
  %inc = add nuw i64 %iv.scalar.loop, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %exit.loopexit, label %scalar.remainder, !llvm.loop !3

exit.loopexit:                                    ; preds = %scalar.remainder
  br label %exit

exit:                                             ; preds = %exit.loopexit, %middle.block
  ret void
}

define void @vector_operands(ptr %p, i64 %n) #0 {
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %evl.based.iv = phi i64 [ 0, %entry ], [ %index.evl.next, %vector.body ]
  %avl = phi i64 [ %n, %entry ], [ %avl.next, %vector.body ]
  %vl = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %addr = getelementptr i64, ptr %p, i64 %evl.based.iv
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> zeroinitializer, ptr align 8 %addr, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  %vl.zext = zext i32 %vl to i64
  %index.evl.next = add nuw i64 %vl.zext, %evl.based.iv
  %avl.next = sub nuw i64 %avl, %vl.zext
  %0 = icmp eq i64 %avl.next, 0
  br i1 %0, label %exit, label %vector.body, !llvm.loop !2

exit:                                             ; preds = %vector.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) "target-features"="+v,+f" }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = distinct !{!2, !1}
!3 = distinct !{!3, !1}
