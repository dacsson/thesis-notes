; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-bin-unary-ops-args.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================




define void @test_and(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = and i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_or(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = or i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_xor(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = xor i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_shl(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_lshr(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = lshr i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_ashr(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = ashr i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_add(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = add i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_sub(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = sub i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_mul(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = mul i8 %0, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_sdiv(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = sdiv i8 %0, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_udiv(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = udiv i8 %0, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_srem(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = srem i8 %0, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_urem(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %0 = load i8, ptr %arrayidx, align 1
  %tmp = urem i8 %0, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

; Floating point tests

define void @test_fadd(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = fadd fast float %0, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_fsub(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = fsub fast float %0, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_fmul(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = fmul fast float %0, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_fdiv(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = fdiv fast float %0, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_frem(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = frem fast float %0, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}

define void @test_fneg(ptr nocapture %a, ptr nocapture readonly %b) {
loop.preheader:
  br label %loop

loop:
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = fneg fast float %0
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:
  ret void
}
;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpx266r0vr.ll'
source_filename = "/tmp/tmpx266r0vr.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test_and(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = and <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = and i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !3

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_or(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = or <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = or i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !5

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_xor(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = xor <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = xor i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !7

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_shl(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = shl <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = shl i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !9

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_lshr(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = lshr <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = lshr i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !11

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_ashr(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = ashr <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = ashr i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !13

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_add(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = add <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = add i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !15

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_sub(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = sub <vscale x 16 x i8> %wide.load, splat (i8 1)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = sub i8 %11, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !17

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_mul(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = mul <vscale x 16 x i8> %wide.load, splat (i8 3)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = mul i8 %11, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !19

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_sdiv(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = sdiv <vscale x 16 x i8> %wide.load, splat (i8 3)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = sdiv i8 %11, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !21

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_udiv(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = udiv <vscale x 16 x i8> %wide.load, splat (i8 3)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = udiv i8 %11, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !23

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_srem(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = srem <vscale x 16 x i8> %wide.load, splat (i8 3)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !24

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = srem i8 %11, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !25

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_urem(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 32)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 16
  %4 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %4, %3
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %5 = call i64 @llvm.vscale.i64()
  %6 = shl nuw i64 %5, 4
  %n.mod.vf = urem i64 100, %6
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <vscale x 16 x i8>, ptr %7, align 1
  %8 = urem <vscale x 16 x i8> %wide.load, splat (i8 3)
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  store <vscale x 16 x i8> %8, ptr %9, align 1
  %index.next = add nuw i64 %index, %6
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !26

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %11 = load i8, ptr %arrayidx, align 1
  %tmp = urem i8 %11, 3
  %arrayidx1 = getelementptr inbounds i8, ptr %b, i64 %len
  store i8 %tmp, ptr %arrayidx1, align 1
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !27

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_fadd(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 100, %7
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fadd fast <vscale x 4 x float> %wide.load, splat (float 3.000000e+00)
  %10 = getelementptr inbounds float, ptr %b, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %12 = load float, ptr %arrayidx, align 4
  %tmp = fadd fast float %12, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !29

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_fsub(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 100, %7
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fsub fast <vscale x 4 x float> %wide.load, splat (float 3.000000e+00)
  %10 = getelementptr inbounds float, ptr %b, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !30

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %12 = load float, ptr %arrayidx, align 4
  %tmp = fsub fast float %12, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !31

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_fmul(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 100, %7
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fmul fast <vscale x 4 x float> %wide.load, splat (float 3.000000e+00)
  %10 = getelementptr inbounds float, ptr %b, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !32

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %12 = load float, ptr %arrayidx, align 4
  %tmp = fmul fast float %12, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !33

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_fdiv(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 100, %7
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fdiv fast <vscale x 4 x float> %wide.load, splat (float 3.000000e+00)
  %10 = getelementptr inbounds float, ptr %b, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !34

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %12 = load float, ptr %arrayidx, align 4
  %tmp = fdiv fast float %12, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !35

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

define void @test_frem(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  br label %loop

loop:                                             ; preds = %loop, %loop.preheader
  %len = phi i64 [ %dec, %loop ], [ 0, %loop.preheader ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %0 = load float, ptr %arrayidx, align 4
  %tmp = frem fast float %0, 3.000000e+00
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop

finish.loopexit:                                  ; preds = %loop
  ret void
}

define void @test_fneg(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 100, %7
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %a, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fneg fast <vscale x 4 x float> %wide.load
  %10 = getelementptr inbounds float, ptr %b, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !36

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %finish.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %loop.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ %bc.resume.val, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %12 = load float, ptr %arrayidx, align 4
  %tmp = fneg fast float %12
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !37

finish.loopexit:                                  ; preds = %middle.block, %loop
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
!3 = distinct !{!3, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !1}
!18 = distinct !{!18, !1, !2}
!19 = distinct !{!19, !1}
!20 = distinct !{!20, !1, !2}
!21 = distinct !{!21, !1}
!22 = distinct !{!22, !1, !2}
!23 = distinct !{!23, !1}
!24 = distinct !{!24, !1, !2}
!25 = distinct !{!25, !1}
!26 = distinct !{!26, !1, !2}
!27 = distinct !{!27, !1}
!28 = distinct !{!28, !1, !2}
!29 = distinct !{!29, !1}
!30 = distinct !{!30, !1, !2}
!31 = distinct !{!31, !1}
!32 = distinct !{!32, !1, !2}
!33 = distinct !{!33, !1}
!34 = distinct !{!34, !1, !2}
!35 = distinct !{!35, !1}
!36 = distinct !{!36, !1, !2}
!37 = distinct !{!37, !1}
