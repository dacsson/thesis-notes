; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-bin-unary-ops-args.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s --check-prefix=IF-EVL

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

; ModuleID = '/tmp/tmp6oyy69zb.ll'
source_filename = "/tmp/tmp6oyy69zb.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test_and(ptr captures(none) %a, ptr readonly captures(none) %b) #0 {
loop.preheader:
  %a2 = ptrtoaddr ptr %a to i64
  %b1 = ptrtoaddr ptr %b to i64
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = and <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = and i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = or <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = or i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = xor <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = xor i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = shl <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = shl i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = lshr <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = lshr i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = ashr <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = ashr i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = add <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = add i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = sub <vscale x 16 x i8> %vp.op.load, splat (i8 1)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = sub i8 %9, 1
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = mul <vscale x 16 x i8> %vp.op.load, splat (i8 3)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = mul i8 %9, 3
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = sdiv <vscale x 16 x i8> %vp.op.load, splat (i8 3)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = sdiv i8 %9, 3
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = udiv <vscale x 16 x i8> %vp.op.load, splat (i8 3)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = udiv i8 %9, 3
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = srem <vscale x 16 x i8> %vp.op.load, splat (i8 3)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !24

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = srem i8 %9, 3
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 16
  %2 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %2, %1
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %4 = getelementptr inbounds i8, ptr %a, i64 %index
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %4, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %5 = urem <vscale x 16 x i8> %vp.op.load, splat (i8 3)
  %6 = getelementptr inbounds i8, ptr %b, i64 %index
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %5, ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %3)
  %7 = zext i32 %3 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !26

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %len
  %9 = load i8, ptr %arrayidx, align 1
  %tmp = urem i8 %9, 3
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 4
  %2 = mul i64 %1, 4
  %3 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %3, %2
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %6 = fadd fast <vscale x 4 x float> %vp.op.load, splat (float 3.000000e+00)
  %7 = getelementptr inbounds float, ptr %b, i64 %index
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %6, ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = zext i32 %4 to i64
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %10 = load float, ptr %arrayidx, align 4
  %tmp = fadd fast float %10, 3.000000e+00
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 4
  %2 = mul i64 %1, 4
  %3 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %3, %2
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %6 = fsub fast <vscale x 4 x float> %vp.op.load, splat (float 3.000000e+00)
  %7 = getelementptr inbounds float, ptr %b, i64 %index
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %6, ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = zext i32 %4 to i64
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !30

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %10 = load float, ptr %arrayidx, align 4
  %tmp = fsub fast float %10, 3.000000e+00
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 4
  %2 = mul i64 %1, 4
  %3 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %3, %2
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %6 = fmul fast <vscale x 4 x float> %vp.op.load, splat (float 3.000000e+00)
  %7 = getelementptr inbounds float, ptr %b, i64 %index
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %6, ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = zext i32 %4 to i64
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !32

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %10 = load float, ptr %arrayidx, align 4
  %tmp = fmul fast float %10, 3.000000e+00
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 4
  %2 = mul i64 %1, 4
  %3 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %3, %2
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %6 = fdiv fast <vscale x 4 x float> %vp.op.load, splat (float 3.000000e+00)
  %7 = getelementptr inbounds float, ptr %b, i64 %index
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %6, ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = zext i32 %4 to i64
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !34

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %10 = load float, ptr %arrayidx, align 4
  %tmp = fdiv fast float %10, 3.000000e+00
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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %loop.preheader
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 4
  %2 = mul i64 %1, 4
  %3 = sub i64 %b1, %a2
  %diff.check = icmp ult i64 %3, %2
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %6 = fneg fast <vscale x 4 x float> %vp.op.load
  %7 = getelementptr inbounds float, ptr %b, i64 %index
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %6, ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = zext i32 %4 to i64
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !36

middle.block:                                     ; preds = %vector.body
  br label %finish.loopexit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %len = phi i64 [ %dec, %loop ], [ 0, %scalar.ph ]
  %dec = add nsw i64 %len, 1
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %len
  %10 = load float, ptr %arrayidx, align 4
  %tmp = fneg fast float %10
  %arrayidx1 = getelementptr inbounds float, ptr %b, i64 %len
  store float %tmp, ptr %arrayidx1, align 4
  %.not = icmp eq i64 %dec, 100
  br i1 %.not, label %finish.loopexit, label %loop, !llvm.loop !37

finish.loopexit:                                  ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr captures(none), <vscale x 16 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8>, ptr captures(none), <vscale x 16 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float>, ptr captures(none), <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

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
