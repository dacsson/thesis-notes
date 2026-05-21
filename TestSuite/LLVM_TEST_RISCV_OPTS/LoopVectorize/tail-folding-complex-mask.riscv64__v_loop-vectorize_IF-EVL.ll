; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-complex-mask.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=IF-EVL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @test(i64 %n, ptr noalias %src0, ptr noalias %src1, ptr noalias %src2, ptr noalias %dst, i1 %c1, i1 %c2, i1 %c3) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  br i1 %c1, label %load.v0, label %check.cond1

check.cond1:
  %not.c2 = xor i1 %c2, true
  %cond1 = or i1 %c1, %not.c2
  br i1 %cond1, label %load.v1, label %load.v2.check

load.v0:
  %gep0 = getelementptr inbounds i32, ptr %src0, i64 %iv
  %v0 = load i32, ptr %gep0, align 4
  br label %load.v1

load.v1:
  %val0 = phi i32 [ %v0, %load.v0 ], [ 0, %check.cond1 ]
  %gep1 = getelementptr inbounds i32, ptr %src1, i64 %iv
  %v1 = load i32, ptr %gep1, align 4
  %val1 = add i32 %v1, %val0
  br label %load.v2.check

load.v2.check:
  %val2 = phi i32 [ %val1, %load.v1 ], [ 0, %check.cond1 ]
  br i1 %c3, label %load.v2, label %latch

load.v2:
  %gep2 = getelementptr inbounds i32, ptr %src2, i64 %iv
  %v2 = load i32, ptr %gep2, align 4
  %val3 = add i32 %v2, %val2
  br label %latch

latch:
  %result = phi i32 [ %val3, %load.v2 ], [ %val2, %load.v2.check ]
  %out = getelementptr inbounds i32, ptr %dst, i64 %iv
  store i32 %result, ptr %out, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, %n
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpxxbfdvgu.ll'
source_filename = "/tmp/tmpxxbfdvgu.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test(i64 %n, ptr noalias %src0, ptr noalias %src1, ptr noalias %src2, ptr noalias %dst, i1 %c1, i1 %c2, i1 %c3) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %0 = xor <vscale x 4 x i1> %broadcast.splat, splat (i1 true)
  %1 = xor i1 %c2, true
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i1> poison, i1 %1, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert1, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %2 = or <vscale x 4 x i1> %broadcast.splat, %broadcast.splat2
  %3 = select <vscale x 4 x i1> %0, <vscale x 4 x i1> %2, <vscale x 4 x i1> zeroinitializer
  %4 = or <vscale x 4 x i1> %broadcast.splat, %3
  %broadcast.splatinsert3 = insertelement <vscale x 4 x i1> poison, i1 %c3, i64 0
  %broadcast.splat4 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert3, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %6 = getelementptr i32, ptr %src0, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %6, <vscale x 4 x i1> %broadcast.splat, i32 %5)
  %7 = call <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i1> %4, <vscale x 4 x i1> zeroinitializer, i32 %5)
  %predphi = select <vscale x 4 x i1> %3, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %vp.op.load
  %8 = getelementptr i32, ptr %src1, i64 %index
  %vp.op.load5 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %8, <vscale x 4 x i1> %4, i32 %5)
  %9 = add <vscale x 4 x i32> %vp.op.load5, %predphi
  %predphi6 = select <vscale x 4 x i1> %7, <vscale x 4 x i32> %9, <vscale x 4 x i32> zeroinitializer
  %10 = getelementptr i32, ptr %src2, i64 %index
  %vp.op.load7 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %10, <vscale x 4 x i1> %broadcast.splat4, i32 %5)
  %11 = add <vscale x 4 x i32> %vp.op.load7, %predphi6
  %predphi8 = select i1 %c3, <vscale x 4 x i32> %11, <vscale x 4 x i32> %predphi6
  %12 = getelementptr inbounds i32, ptr %dst, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %predphi8, ptr align 4 %12, <vscale x 4 x i1> splat (i1 true), i32 %5)
  %13 = zext i32 %5 to i64
  %current.iteration.next = add i64 %13, %index
  %avl.next = sub nuw i64 %avl, %13
  %14 = icmp eq i64 %avl.next, 0
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
