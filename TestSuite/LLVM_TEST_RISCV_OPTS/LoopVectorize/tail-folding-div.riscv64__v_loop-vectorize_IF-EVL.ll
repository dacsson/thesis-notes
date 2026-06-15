; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-div.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s --check-prefix=IF-EVL

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

; ModuleID = '/tmp/tmp83mkea02.ll'
source_filename = "/tmp/tmp83mkea02.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test_sdiv(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr i64, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = call <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %vp.op.load1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %3, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_sdiv_divisor_invariant_nonconst(ptr noalias %a, i64 %b, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %b, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = call <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_sdiv_both_invariant_nonconst(ptr noalias %a, i64 %b, i64 %b2, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %b, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <vscale x 2 x i64> poison, i64 %b2, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert1, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = call <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64> %broadcast.splat, <vscale x 2 x i64> %broadcast.splat2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = add <vscale x 2 x i64> %vp.op.load, %2
  %4 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %3, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_sdiv_divisor_invariant_minusone(ptr noalias %a, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = call <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> splat (i64 -1), <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_sdiv_divisor_invariant_safeimm(ptr noalias %a, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = sdiv <vscale x 2 x i64> %vp.op.load, splat (i64 3)
  %3 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_udiv(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr i64, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = call <vscale x 2 x i64> @llvm.vp.udiv.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %vp.op.load1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %3, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_srem(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr i64, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = call <vscale x 2 x i64> @llvm.vp.srem.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %vp.op.load1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %3, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_urem(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
loop.preheader:
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr i64, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = call <vscale x 2 x i64> @llvm.vp.urem.nxv2i64(<vscale x 2 x i64> %vp.op.load, <vscale x 2 x i64> %vp.op.load1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = getelementptr i64, ptr %c, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %3, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.sdiv.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.udiv.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.srem.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.urem.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1, !2}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1, !2}
