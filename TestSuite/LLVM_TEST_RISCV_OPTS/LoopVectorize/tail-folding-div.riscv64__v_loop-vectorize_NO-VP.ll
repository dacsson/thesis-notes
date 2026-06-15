; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-div.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @test_sdiv(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %1 = load i64, ptr %b.gep
  %2 = sdiv i64 %0, %1
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_sdiv_divisor_invariant_nonconst(ptr noalias %a, i64 %b, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %2 = sdiv i64 %0, %b
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_sdiv_both_invariant_nonconst(ptr noalias %a, i64 %b, i64 %b2, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %2 = sdiv i64 %b, %b2
  %3 = add i64 %0, %2
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %3, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_sdiv_divisor_invariant_minusone(ptr noalias %a, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %2 = sdiv i64 %0, -1
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_sdiv_divisor_invariant_safeimm(ptr noalias %a, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %2 = sdiv i64 %0, 3
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_udiv(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %1 = load i64, ptr %b.gep
  %2 = udiv i64 %0, %1
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_srem(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %1 = load i64, ptr %b.gep
  %2 = srem i64 %0, %1
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

define void @test_urem(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
loop.preheader:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %loop.preheader ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %0 = load i64, ptr %a.gep
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %1 = load i64, ptr %b.gep
  %2 = urem i64 %0, %1
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %2, ptr %c.gep
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}
;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpiuhri1vc.ll'
source_filename = "/tmp/tmpiuhri1vc.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test_sdiv(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = getelementptr i64, ptr %b, i64 %index
  %wide.load1 = load <vscale x 2 x i64>, ptr %5, align 8
  %6 = sdiv <vscale x 2 x i64> %wide.load, %wide.load1
  %7 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %6, ptr %7, align 8
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %9 = load i64, ptr %a.gep, align 8
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %10 = load i64, ptr %b.gep, align 8
  %11 = sdiv i64 %9, %10
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %11, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_sdiv_divisor_invariant_nonconst(ptr noalias %a, i64 %b, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %b, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = sdiv <vscale x 2 x i64> %wide.load, %broadcast.splat
  %6 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %5, ptr %6, align 8
  %index.next = add nuw i64 %index, %3
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %8 = load i64, ptr %a.gep, align 8
  %9 = sdiv i64 %8, %b
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %9, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !5

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_sdiv_both_invariant_nonconst(ptr noalias %a, i64 %b, i64 %b2, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %4 = sdiv i64 %b, %b2
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %5 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %5, align 8
  %6 = add <vscale x 2 x i64> %wide.load, %broadcast.splat
  %7 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %6, ptr %7, align 8
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %9 = load i64, ptr %a.gep, align 8
  %10 = sdiv i64 %b, %b2
  %11 = add i64 %9, %10
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %11, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !7

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_sdiv_divisor_invariant_minusone(ptr noalias %a, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = sdiv <vscale x 2 x i64> %wide.load, splat (i64 -1)
  %6 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %5, ptr %6, align 8
  %index.next = add nuw i64 %index, %3
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %8 = load i64, ptr %a.gep, align 8
  %9 = sdiv i64 %8, -1
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %9, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !9

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_sdiv_divisor_invariant_safeimm(ptr noalias %a, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = sdiv <vscale x 2 x i64> %wide.load, splat (i64 3)
  %6 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %5, ptr %6, align 8
  %index.next = add nuw i64 %index, %3
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %8 = load i64, ptr %a.gep, align 8
  %9 = sdiv i64 %8, 3
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %9, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !11

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_udiv(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = getelementptr i64, ptr %b, i64 %index
  %wide.load1 = load <vscale x 2 x i64>, ptr %5, align 8
  %6 = udiv <vscale x 2 x i64> %wide.load, %wide.load1
  %7 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %6, ptr %7, align 8
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %9 = load i64, ptr %a.gep, align 8
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %10 = load i64, ptr %b.gep, align 8
  %11 = udiv i64 %9, %10
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %11, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !13

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_srem(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = getelementptr i64, ptr %b, i64 %index
  %wide.load1 = load <vscale x 2 x i64>, ptr %5, align 8
  %6 = srem <vscale x 2 x i64> %wide.load, %wide.load1
  %7 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %6, ptr %7, align 8
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %9 = load i64, ptr %a.gep, align 8
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %10 = load i64, ptr %b.gep, align 8
  %11 = srem i64 %9, %10
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %11, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !15

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @test_urem(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i64, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  %5 = getelementptr i64, ptr %b, i64 %index
  %wide.load1 = load <vscale x 2 x i64>, ptr %5, align 8
  %6 = urem <vscale x 2 x i64> %wide.load, %wide.load1
  %7 = getelementptr i64, ptr %c, i64 %index
  store <vscale x 2 x i64> %6, ptr %7, align 8
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %a.gep = getelementptr i64, ptr %a, i64 %iv
  %9 = load i64, ptr %a.gep, align 8
  %b.gep = getelementptr i64, ptr %b, i64 %iv
  %10 = load i64, ptr %b.gep, align 8
  %11 = urem i64 %9, %10
  %c.gep = getelementptr i64, ptr %c, i64 %iv
  store i64 %11, ptr %c.gep, align 8
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !17

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !2, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !2, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !2, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !2, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !2, !1}
