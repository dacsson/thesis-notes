; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopUnroll/RISCV/vector.ll
; Variant: riscv64_COMMON
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-unroll -mtriple=riscv64 -mcpu=sifive-p870 -S
; Original: RUN: opt -p loop-unroll -mtriple=riscv64 -mcpu=sifive-p870 -S %s | FileCheck %s --check-prefixes=COMMON,SIFIVE

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

; ModuleID = '/tmp/tmpulfhdfab.ll'
source_filename = "/tmp/tmpulfhdfab.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @reverse(ptr %dst, ptr %src, i64 %len) #0 {
entry:
  %0 = add i64 %len, -1
  %xtraiter = and i64 %len, 7
  %1 = icmp ult i64 %0, 7
  br i1 %1, label %for.body.epil.preheader, label %entry.new

entry.new:                                        ; preds = %entry
  %unroll_iter = sub i64 %len, %xtraiter
  br label %for.body

for.body:                                         ; preds = %for.body, %entry.new
  %iv = phi i64 [ 0, %entry.new ], [ %iv.next.7, %for.body ]
  %niter = phi i64 [ 0, %entry.new ], [ %niter.next.7, %for.body ]
  %2 = sub nsw i64 %len, %iv
  %arrayidx = getelementptr inbounds <4 x float>, ptr %src, i64 %2
  %3 = load <4 x float>, ptr %arrayidx, align 16
  %arrayidx2 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv
  store <4 x float> %3, ptr %arrayidx2, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %4 = sub nsw i64 %len, %iv.next
  %arrayidx.1 = getelementptr inbounds <4 x float>, ptr %src, i64 %4
  %5 = load <4 x float>, ptr %arrayidx.1, align 16
  %arrayidx2.1 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next
  store <4 x float> %5, ptr %arrayidx2.1, align 16
  %iv.next.1 = add nuw nsw i64 %iv, 2
  %6 = sub nsw i64 %len, %iv.next.1
  %arrayidx.2 = getelementptr inbounds <4 x float>, ptr %src, i64 %6
  %7 = load <4 x float>, ptr %arrayidx.2, align 16
  %arrayidx2.2 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.1
  store <4 x float> %7, ptr %arrayidx2.2, align 16
  %iv.next.2 = add nuw nsw i64 %iv, 3
  %8 = sub nsw i64 %len, %iv.next.2
  %arrayidx.3 = getelementptr inbounds <4 x float>, ptr %src, i64 %8
  %9 = load <4 x float>, ptr %arrayidx.3, align 16
  %arrayidx2.3 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.2
  store <4 x float> %9, ptr %arrayidx2.3, align 16
  %iv.next.3 = add nuw nsw i64 %iv, 4
  %10 = sub nsw i64 %len, %iv.next.3
  %arrayidx.4 = getelementptr inbounds <4 x float>, ptr %src, i64 %10
  %11 = load <4 x float>, ptr %arrayidx.4, align 16
  %arrayidx2.4 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.3
  store <4 x float> %11, ptr %arrayidx2.4, align 16
  %iv.next.4 = add nuw nsw i64 %iv, 5
  %12 = sub nsw i64 %len, %iv.next.4
  %arrayidx.5 = getelementptr inbounds <4 x float>, ptr %src, i64 %12
  %13 = load <4 x float>, ptr %arrayidx.5, align 16
  %arrayidx2.5 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.4
  store <4 x float> %13, ptr %arrayidx2.5, align 16
  %iv.next.5 = add nuw nsw i64 %iv, 6
  %14 = sub nsw i64 %len, %iv.next.5
  %arrayidx.6 = getelementptr inbounds <4 x float>, ptr %src, i64 %14
  %15 = load <4 x float>, ptr %arrayidx.6, align 16
  %arrayidx2.6 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.5
  store <4 x float> %15, ptr %arrayidx2.6, align 16
  %iv.next.6 = add nuw nsw i64 %iv, 7
  %16 = sub nsw i64 %len, %iv.next.6
  %arrayidx.7 = getelementptr inbounds <4 x float>, ptr %src, i64 %16
  %17 = load <4 x float>, ptr %arrayidx.7, align 16
  %arrayidx2.7 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.6
  store <4 x float> %17, ptr %arrayidx2.7, align 16
  %iv.next.7 = add nuw nsw i64 %iv, 8
  %niter.next.7 = add i64 %niter, 8
  %niter.ncmp.7 = icmp eq i64 %niter.next.7, %unroll_iter
  br i1 %niter.ncmp.7, label %exit.unr-lcssa, label %for.body

exit.unr-lcssa:                                   ; preds = %for.body
  %iv.unr = phi i64 [ %iv.next.7, %for.body ]
  %lcmp.mod = icmp ne i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body.epil.preheader, label %exit

for.body.epil.preheader:                          ; preds = %exit.unr-lcssa, %entry
  %iv.epil.init = phi i64 [ 0, %entry ], [ %iv.unr, %exit.unr-lcssa ]
  %lcmp.mod1 = icmp ne i64 %xtraiter, 0
  call void @llvm.assume(i1 %lcmp.mod1)
  br label %for.body.epil

for.body.epil:                                    ; preds = %for.body.epil.preheader
  %18 = sub nsw i64 %len, %iv.epil.init
  %arrayidx.epil = getelementptr inbounds <4 x float>, ptr %src, i64 %18
  %19 = load <4 x float>, ptr %arrayidx.epil, align 16
  %arrayidx2.epil = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.epil.init
  store <4 x float> %19, ptr %arrayidx2.epil, align 16
  %iv.next.epil = add nuw nsw i64 %iv.epil.init, 1
  %epil.iter.cmp = icmp ne i64 1, %xtraiter
  br i1 %epil.iter.cmp, label %for.body.epil.1, label %exit.epilog-lcssa

for.body.epil.1:                                  ; preds = %for.body.epil
  %20 = sub nsw i64 %len, %iv.next.epil
  %arrayidx.epil.1 = getelementptr inbounds <4 x float>, ptr %src, i64 %20
  %21 = load <4 x float>, ptr %arrayidx.epil.1, align 16
  %arrayidx2.epil.1 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.epil
  store <4 x float> %21, ptr %arrayidx2.epil.1, align 16
  %iv.next.epil.1 = add nuw nsw i64 %iv.epil.init, 2
  %epil.iter.cmp.1 = icmp ne i64 2, %xtraiter
  br i1 %epil.iter.cmp.1, label %for.body.epil.2, label %exit.epilog-lcssa

for.body.epil.2:                                  ; preds = %for.body.epil.1
  %22 = sub nsw i64 %len, %iv.next.epil.1
  %arrayidx.epil.2 = getelementptr inbounds <4 x float>, ptr %src, i64 %22
  %23 = load <4 x float>, ptr %arrayidx.epil.2, align 16
  %arrayidx2.epil.2 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.epil.1
  store <4 x float> %23, ptr %arrayidx2.epil.2, align 16
  %iv.next.epil.2 = add nuw nsw i64 %iv.epil.init, 3
  %epil.iter.cmp.2 = icmp ne i64 3, %xtraiter
  br i1 %epil.iter.cmp.2, label %for.body.epil.3, label %exit.epilog-lcssa

for.body.epil.3:                                  ; preds = %for.body.epil.2
  %24 = sub nsw i64 %len, %iv.next.epil.2
  %arrayidx.epil.3 = getelementptr inbounds <4 x float>, ptr %src, i64 %24
  %25 = load <4 x float>, ptr %arrayidx.epil.3, align 16
  %arrayidx2.epil.3 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.epil.2
  store <4 x float> %25, ptr %arrayidx2.epil.3, align 16
  %iv.next.epil.3 = add nuw nsw i64 %iv.epil.init, 4
  %epil.iter.cmp.3 = icmp ne i64 4, %xtraiter
  br i1 %epil.iter.cmp.3, label %for.body.epil.4, label %exit.epilog-lcssa

for.body.epil.4:                                  ; preds = %for.body.epil.3
  %26 = sub nsw i64 %len, %iv.next.epil.3
  %arrayidx.epil.4 = getelementptr inbounds <4 x float>, ptr %src, i64 %26
  %27 = load <4 x float>, ptr %arrayidx.epil.4, align 16
  %arrayidx2.epil.4 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.epil.3
  store <4 x float> %27, ptr %arrayidx2.epil.4, align 16
  %iv.next.epil.4 = add nuw nsw i64 %iv.epil.init, 5
  %epil.iter.cmp.4 = icmp ne i64 5, %xtraiter
  br i1 %epil.iter.cmp.4, label %for.body.epil.5, label %exit.epilog-lcssa

for.body.epil.5:                                  ; preds = %for.body.epil.4
  %28 = sub nsw i64 %len, %iv.next.epil.4
  %arrayidx.epil.5 = getelementptr inbounds <4 x float>, ptr %src, i64 %28
  %29 = load <4 x float>, ptr %arrayidx.epil.5, align 16
  %arrayidx2.epil.5 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.epil.4
  store <4 x float> %29, ptr %arrayidx2.epil.5, align 16
  %iv.next.epil.5 = add nuw nsw i64 %iv.epil.init, 6
  %epil.iter.cmp.5 = icmp ne i64 6, %xtraiter
  br i1 %epil.iter.cmp.5, label %for.body.epil.6, label %exit.epilog-lcssa

for.body.epil.6:                                  ; preds = %for.body.epil.5
  %30 = sub nsw i64 %len, %iv.next.epil.5
  %arrayidx.epil.6 = getelementptr inbounds <4 x float>, ptr %src, i64 %30
  %31 = load <4 x float>, ptr %arrayidx.epil.6, align 16
  %arrayidx2.epil.6 = getelementptr inbounds nuw <4 x float>, ptr %dst, i64 %iv.next.epil.5
  store <4 x float> %31, ptr %arrayidx2.epil.6, align 16
  br label %exit.epilog-lcssa

exit.epilog-lcssa:                                ; preds = %for.body.epil.6, %for.body.epil.5, %for.body.epil.4, %for.body.epil.3, %for.body.epil.2, %for.body.epil.1, %for.body.epil
  br label %exit

exit:                                             ; preds = %exit.unr-lcssa, %exit.epilog-lcssa
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
  %index = phi i64 [ 0, %entry ], [ %index.next.15, %vector.body ]
  %0 = getelementptr inbounds nuw float, ptr %src, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = getelementptr inbounds nuw float, ptr %dst, i64 %index
  %wide.load12 = load <4 x float>, ptr %1, align 4
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load, <4 x float> %wide.load12)
  store <4 x float> %2, ptr %1, align 4
  %index.next = add nuw nsw i64 %index, 4
  %3 = getelementptr inbounds nuw float, ptr %src, i64 %index.next
  %wide.load.1 = load <4 x float>, ptr %3, align 4
  %4 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next
  %wide.load12.1 = load <4 x float>, ptr %4, align 4
  %5 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.1, <4 x float> %wide.load12.1)
  store <4 x float> %5, ptr %4, align 4
  %index.next.1 = add nuw nsw i64 %index, 8
  %6 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.1
  %wide.load.2 = load <4 x float>, ptr %6, align 4
  %7 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.1
  %wide.load12.2 = load <4 x float>, ptr %7, align 4
  %8 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.2, <4 x float> %wide.load12.2)
  store <4 x float> %8, ptr %7, align 4
  %index.next.2 = add nuw nsw i64 %index, 12
  %9 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.2
  %wide.load.3 = load <4 x float>, ptr %9, align 4
  %10 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.2
  %wide.load12.3 = load <4 x float>, ptr %10, align 4
  %11 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.3, <4 x float> %wide.load12.3)
  store <4 x float> %11, ptr %10, align 4
  %index.next.3 = add nuw nsw i64 %index, 16
  %12 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.3
  %wide.load.4 = load <4 x float>, ptr %12, align 4
  %13 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.3
  %wide.load12.4 = load <4 x float>, ptr %13, align 4
  %14 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.4, <4 x float> %wide.load12.4)
  store <4 x float> %14, ptr %13, align 4
  %index.next.4 = add nuw nsw i64 %index, 20
  %15 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.4
  %wide.load.5 = load <4 x float>, ptr %15, align 4
  %16 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.4
  %wide.load12.5 = load <4 x float>, ptr %16, align 4
  %17 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.5, <4 x float> %wide.load12.5)
  store <4 x float> %17, ptr %16, align 4
  %index.next.5 = add nuw nsw i64 %index, 24
  %18 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.5
  %wide.load.6 = load <4 x float>, ptr %18, align 4
  %19 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.5
  %wide.load12.6 = load <4 x float>, ptr %19, align 4
  %20 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.6, <4 x float> %wide.load12.6)
  store <4 x float> %20, ptr %19, align 4
  %index.next.6 = add nuw nsw i64 %index, 28
  %21 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.6
  %wide.load.7 = load <4 x float>, ptr %21, align 4
  %22 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.6
  %wide.load12.7 = load <4 x float>, ptr %22, align 4
  %23 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.7, <4 x float> %wide.load12.7)
  store <4 x float> %23, ptr %22, align 4
  %index.next.7 = add nuw nsw i64 %index, 32
  %24 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.7
  %wide.load.8 = load <4 x float>, ptr %24, align 4
  %25 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.7
  %wide.load12.8 = load <4 x float>, ptr %25, align 4
  %26 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.8, <4 x float> %wide.load12.8)
  store <4 x float> %26, ptr %25, align 4
  %index.next.8 = add nuw nsw i64 %index, 36
  %27 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.8
  %wide.load.9 = load <4 x float>, ptr %27, align 4
  %28 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.8
  %wide.load12.9 = load <4 x float>, ptr %28, align 4
  %29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.9, <4 x float> %wide.load12.9)
  store <4 x float> %29, ptr %28, align 4
  %index.next.9 = add nuw nsw i64 %index, 40
  %30 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.9
  %wide.load.10 = load <4 x float>, ptr %30, align 4
  %31 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.9
  %wide.load12.10 = load <4 x float>, ptr %31, align 4
  %32 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.10, <4 x float> %wide.load12.10)
  store <4 x float> %32, ptr %31, align 4
  %index.next.10 = add nuw nsw i64 %index, 44
  %33 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.10
  %wide.load.11 = load <4 x float>, ptr %33, align 4
  %34 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.10
  %wide.load12.11 = load <4 x float>, ptr %34, align 4
  %35 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.11, <4 x float> %wide.load12.11)
  store <4 x float> %35, ptr %34, align 4
  %index.next.11 = add nuw nsw i64 %index, 48
  %36 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.11
  %wide.load.12 = load <4 x float>, ptr %36, align 4
  %37 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.11
  %wide.load12.12 = load <4 x float>, ptr %37, align 4
  %38 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.12, <4 x float> %wide.load12.12)
  store <4 x float> %38, ptr %37, align 4
  %index.next.12 = add nuw nsw i64 %index, 52
  %39 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.12
  %wide.load.13 = load <4 x float>, ptr %39, align 4
  %40 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.12
  %wide.load12.13 = load <4 x float>, ptr %40, align 4
  %41 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.13, <4 x float> %wide.load12.13)
  store <4 x float> %41, ptr %40, align 4
  %index.next.13 = add nuw nsw i64 %index, 56
  %42 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.13
  %wide.load.14 = load <4 x float>, ptr %42, align 4
  %43 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.13
  %wide.load12.14 = load <4 x float>, ptr %43, align 4
  %44 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.14, <4 x float> %wide.load12.14)
  store <4 x float> %44, ptr %43, align 4
  %index.next.14 = add nuw nsw i64 %index, 60
  %45 = getelementptr inbounds nuw float, ptr %src, i64 %index.next.14
  %wide.load.15 = load <4 x float>, ptr %45, align 4
  %46 = getelementptr inbounds nuw float, ptr %dst, i64 %index.next.14
  %wide.load12.15 = load <4 x float>, ptr %46, align 4
  %47 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %broadcast.splat, <4 x float> %wide.load.15, <4 x float> %wide.load12.15)
  store <4 x float> %47, ptr %46, align 4
  %index.next.15 = add nuw nsw i64 %index, 64
  %48 = icmp eq i64 %index.next.15, 1024
  br i1 %48, label %exit, label %vector.body

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
  %0 = sub i64 %n, %iv.scalar.loop.ph
  %1 = add i64 %n, -1
  %2 = sub i64 %1, %iv.scalar.loop.ph
  %xtraiter = and i64 %0, 7
  %lcmp.mod = icmp ne i64 %xtraiter, 0
  br i1 %lcmp.mod, label %scalar.remainder.prol.preheader, label %scalar.remainder.prol.loopexit

scalar.remainder.prol.preheader:                  ; preds = %scalar.remainder.preheader
  br label %scalar.remainder.prol

scalar.remainder.prol:                            ; preds = %scalar.remainder.prol.preheader
  %arrayidx.prol = getelementptr inbounds nuw i8, ptr %p, i64 %iv.scalar.loop.ph
  %scalar.load.prol = load i8, ptr %arrayidx.prol, align 1
  %add.prol = add i8 %scalar.load.prol, %splat.scalar
  store i8 %add.prol, ptr %arrayidx.prol, align 1
  %inc.prol = add nuw i64 %iv.scalar.loop.ph, 1
  %prol.iter.cmp = icmp ne i64 1, %xtraiter
  br i1 %prol.iter.cmp, label %scalar.remainder.prol.1, label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.1:                          ; preds = %scalar.remainder.prol
  %arrayidx.prol.1 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.prol
  %scalar.load.prol.1 = load i8, ptr %arrayidx.prol.1, align 1
  %add.prol.1 = add i8 %scalar.load.prol.1, %splat.scalar
  store i8 %add.prol.1, ptr %arrayidx.prol.1, align 1
  %inc.prol.1 = add nuw i64 %iv.scalar.loop.ph, 2
  %prol.iter.cmp.1 = icmp ne i64 2, %xtraiter
  br i1 %prol.iter.cmp.1, label %scalar.remainder.prol.2, label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.2:                          ; preds = %scalar.remainder.prol.1
  %arrayidx.prol.2 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.prol.1
  %scalar.load.prol.2 = load i8, ptr %arrayidx.prol.2, align 1
  %add.prol.2 = add i8 %scalar.load.prol.2, %splat.scalar
  store i8 %add.prol.2, ptr %arrayidx.prol.2, align 1
  %inc.prol.2 = add nuw i64 %iv.scalar.loop.ph, 3
  %prol.iter.cmp.2 = icmp ne i64 3, %xtraiter
  br i1 %prol.iter.cmp.2, label %scalar.remainder.prol.3, label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.3:                          ; preds = %scalar.remainder.prol.2
  %arrayidx.prol.3 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.prol.2
  %scalar.load.prol.3 = load i8, ptr %arrayidx.prol.3, align 1
  %add.prol.3 = add i8 %scalar.load.prol.3, %splat.scalar
  store i8 %add.prol.3, ptr %arrayidx.prol.3, align 1
  %inc.prol.3 = add nuw i64 %iv.scalar.loop.ph, 4
  %prol.iter.cmp.3 = icmp ne i64 4, %xtraiter
  br i1 %prol.iter.cmp.3, label %scalar.remainder.prol.4, label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.4:                          ; preds = %scalar.remainder.prol.3
  %arrayidx.prol.4 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.prol.3
  %scalar.load.prol.4 = load i8, ptr %arrayidx.prol.4, align 1
  %add.prol.4 = add i8 %scalar.load.prol.4, %splat.scalar
  store i8 %add.prol.4, ptr %arrayidx.prol.4, align 1
  %inc.prol.4 = add nuw i64 %iv.scalar.loop.ph, 5
  %prol.iter.cmp.4 = icmp ne i64 5, %xtraiter
  br i1 %prol.iter.cmp.4, label %scalar.remainder.prol.5, label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.5:                          ; preds = %scalar.remainder.prol.4
  %arrayidx.prol.5 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.prol.4
  %scalar.load.prol.5 = load i8, ptr %arrayidx.prol.5, align 1
  %add.prol.5 = add i8 %scalar.load.prol.5, %splat.scalar
  store i8 %add.prol.5, ptr %arrayidx.prol.5, align 1
  %inc.prol.5 = add nuw i64 %iv.scalar.loop.ph, 6
  %prol.iter.cmp.5 = icmp ne i64 6, %xtraiter
  br i1 %prol.iter.cmp.5, label %scalar.remainder.prol.6, label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.6:                          ; preds = %scalar.remainder.prol.5
  %arrayidx.prol.6 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.prol.5
  %scalar.load.prol.6 = load i8, ptr %arrayidx.prol.6, align 1
  %add.prol.6 = add i8 %scalar.load.prol.6, %splat.scalar
  store i8 %add.prol.6, ptr %arrayidx.prol.6, align 1
  %inc.prol.6 = add nuw i64 %iv.scalar.loop.ph, 7
  br label %scalar.remainder.prol.loopexit.unr-lcssa

scalar.remainder.prol.loopexit.unr-lcssa:         ; preds = %scalar.remainder.prol.6, %scalar.remainder.prol.5, %scalar.remainder.prol.4, %scalar.remainder.prol.3, %scalar.remainder.prol.2, %scalar.remainder.prol.1, %scalar.remainder.prol
  %iv.scalar.loop.unr.ph = phi i64 [ %inc.prol, %scalar.remainder.prol ], [ %inc.prol.1, %scalar.remainder.prol.1 ], [ %inc.prol.2, %scalar.remainder.prol.2 ], [ %inc.prol.3, %scalar.remainder.prol.3 ], [ %inc.prol.4, %scalar.remainder.prol.4 ], [ %inc.prol.5, %scalar.remainder.prol.5 ], [ %inc.prol.6, %scalar.remainder.prol.6 ]
  br label %scalar.remainder.prol.loopexit

scalar.remainder.prol.loopexit:                   ; preds = %scalar.remainder.prol.loopexit.unr-lcssa, %scalar.remainder.preheader
  %iv.scalar.loop.unr = phi i64 [ %iv.scalar.loop.ph, %scalar.remainder.preheader ], [ %iv.scalar.loop.unr.ph, %scalar.remainder.prol.loopexit.unr-lcssa ]
  %3 = icmp ult i64 %2, 7
  br i1 %3, label %exit.loopexit, label %scalar.remainder.preheader.new

scalar.remainder.preheader.new:                   ; preds = %scalar.remainder.prol.loopexit
  br label %scalar.remainder

scalar.remainder:                                 ; preds = %scalar.remainder, %scalar.remainder.preheader.new
  %iv.scalar.loop = phi i64 [ %iv.scalar.loop.unr, %scalar.remainder.preheader.new ], [ %inc.7, %scalar.remainder ]
  %arrayidx = getelementptr inbounds nuw i8, ptr %p, i64 %iv.scalar.loop
  %scalar.load = load i8, ptr %arrayidx, align 1
  %add = add i8 %scalar.load, %splat.scalar
  store i8 %add, ptr %arrayidx, align 1
  %inc = add nuw i64 %iv.scalar.loop, 1
  %arrayidx.1 = getelementptr inbounds nuw i8, ptr %p, i64 %inc
  %scalar.load.1 = load i8, ptr %arrayidx.1, align 1
  %add.1 = add i8 %scalar.load.1, %splat.scalar
  store i8 %add.1, ptr %arrayidx.1, align 1
  %inc.1 = add nuw i64 %iv.scalar.loop, 2
  %arrayidx.2 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.1
  %scalar.load.2 = load i8, ptr %arrayidx.2, align 1
  %add.2 = add i8 %scalar.load.2, %splat.scalar
  store i8 %add.2, ptr %arrayidx.2, align 1
  %inc.2 = add nuw i64 %iv.scalar.loop, 3
  %arrayidx.3 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.2
  %scalar.load.3 = load i8, ptr %arrayidx.3, align 1
  %add.3 = add i8 %scalar.load.3, %splat.scalar
  store i8 %add.3, ptr %arrayidx.3, align 1
  %inc.3 = add nuw i64 %iv.scalar.loop, 4
  %arrayidx.4 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.3
  %scalar.load.4 = load i8, ptr %arrayidx.4, align 1
  %add.4 = add i8 %scalar.load.4, %splat.scalar
  store i8 %add.4, ptr %arrayidx.4, align 1
  %inc.4 = add nuw i64 %iv.scalar.loop, 5
  %arrayidx.5 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.4
  %scalar.load.5 = load i8, ptr %arrayidx.5, align 1
  %add.5 = add i8 %scalar.load.5, %splat.scalar
  store i8 %add.5, ptr %arrayidx.5, align 1
  %inc.5 = add nuw i64 %iv.scalar.loop, 6
  %arrayidx.6 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.5
  %scalar.load.6 = load i8, ptr %arrayidx.6, align 1
  %add.6 = add i8 %scalar.load.6, %splat.scalar
  store i8 %add.6, ptr %arrayidx.6, align 1
  %inc.6 = add nuw i64 %iv.scalar.loop, 7
  %arrayidx.7 = getelementptr inbounds nuw i8, ptr %p, i64 %inc.6
  %scalar.load.7 = load i8, ptr %arrayidx.7, align 1
  %add.7 = add i8 %scalar.load.7, %splat.scalar
  store i8 %add.7, ptr %arrayidx.7, align 1
  %inc.7 = add nuw i64 %iv.scalar.loop, 8
  %exitcond.not.7 = icmp eq i64 %inc.7, %n
  br i1 %exitcond.not.7, label %exit.loopexit.unr-lcssa, label %scalar.remainder, !llvm.loop !3

exit.loopexit.unr-lcssa:                          ; preds = %scalar.remainder
  br label %exit.loopexit

exit.loopexit:                                    ; preds = %scalar.remainder.prol.loopexit, %exit.loopexit.unr-lcssa
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #4

attributes #0 = { "target-cpu"="sifive-p870" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-cpu"="sifive-p870" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-cpu"="sifive-p870" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) "target-cpu"="sifive-p870" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = distinct !{!2, !1}
!3 = distinct !{!3, !1}
