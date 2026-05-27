; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-complex-mask.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=NO-VP

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

; ModuleID = '/tmp/tmpixxsv5gm.ll'
source_filename = "/tmp/tmpixxsv5gm.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test(i64 %n, ptr noalias %src0, ptr noalias %src1, ptr noalias %src2, ptr noalias %dst, i1 %c1, i1 %c2, i1 %c3) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %n, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 %n, %3
  %n.vec = sub i64 %n, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 4 x i1> poison, i1 %c1, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i1> %broadcast.splatinsert, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %4 = xor <vscale x 4 x i1> %broadcast.splat, splat (i1 true)
  %5 = xor i1 %c2, true
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i1> poison, i1 %5, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert1, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %6 = or <vscale x 4 x i1> %broadcast.splat, %broadcast.splat2
  %7 = select <vscale x 4 x i1> %4, <vscale x 4 x i1> %6, <vscale x 4 x i1> zeroinitializer
  %8 = or <vscale x 4 x i1> %broadcast.splat, %7
  %broadcast.splatinsert3 = insertelement <vscale x 4 x i1> poison, i1 %c3, i64 0
  %broadcast.splat4 = shufflevector <vscale x 4 x i1> %broadcast.splatinsert3, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %9 = getelementptr i32, ptr %src0, i64 %index
  %wide.masked.load = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr align 4 %9, <vscale x 4 x i1> %broadcast.splat, <vscale x 4 x i32> poison)
  %predphi = select <vscale x 4 x i1> %7, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %wide.masked.load
  %10 = getelementptr i32, ptr %src1, i64 %index
  %wide.masked.load5 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr align 4 %10, <vscale x 4 x i1> %8, <vscale x 4 x i32> poison)
  %11 = add <vscale x 4 x i32> %wide.masked.load5, %predphi
  %predphi6 = select <vscale x 4 x i1> %8, <vscale x 4 x i32> %11, <vscale x 4 x i32> zeroinitializer
  %12 = getelementptr i32, ptr %src2, i64 %index
  %wide.masked.load7 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr align 4 %12, <vscale x 4 x i1> %broadcast.splat4, <vscale x 4 x i32> poison)
  %13 = add <vscale x 4 x i32> %wide.masked.load7, %predphi6
  %predphi8 = select i1 %c3, <vscale x 4 x i32> %13, <vscale x 4 x i32> %predphi6
  %14 = getelementptr inbounds i32, ptr %dst, i64 %index
  store <vscale x 4 x i32> %predphi8, ptr %14, align 4
  %index.next = add nuw i64 %index, %3
  %15 = icmp eq i64 %index.next, %n.vec
  br i1 %15, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %latch
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %latch ]
  br i1 %c1, label %load.v0, label %check.cond1

check.cond1:                                      ; preds = %loop
  %not.c2 = xor i1 %c2, true
  %cond1 = or i1 %c1, %not.c2
  br i1 %cond1, label %load.v1, label %load.v2.check

load.v0:                                          ; preds = %loop
  %gep0 = getelementptr inbounds i32, ptr %src0, i64 %iv
  %v0 = load i32, ptr %gep0, align 4
  br label %load.v1

load.v1:                                          ; preds = %load.v0, %check.cond1
  %val0 = phi i32 [ %v0, %load.v0 ], [ 0, %check.cond1 ]
  %gep1 = getelementptr inbounds i32, ptr %src1, i64 %iv
  %v1 = load i32, ptr %gep1, align 4
  %val1 = add i32 %v1, %val0
  br label %load.v2.check

load.v2.check:                                    ; preds = %load.v1, %check.cond1
  %val2 = phi i32 [ %val1, %load.v1 ], [ 0, %check.cond1 ]
  br i1 %c3, label %load.v2, label %latch

load.v2:                                          ; preds = %load.v2.check
  %gep2 = getelementptr inbounds i32, ptr %src2, i64 %iv
  %v2 = load i32, ptr %gep2, align 4
  %val3 = add i32 %v2, %val2
  br label %latch

latch:                                            ; preds = %load.v2, %load.v2.check
  %result = phi i32 [ %val3, %load.v2 ], [ %val2, %load.v2.check ]
  %out = getelementptr inbounds i32, ptr %dst, i64 %iv
  store i32 %result, ptr %out, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, %n
  br i1 %exitcond, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %middle.block, %latch
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, <vscale x 4 x i32>) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
