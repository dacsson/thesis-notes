; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/dead-ops-cost.ll
; Variant: riscv64-linux-gnu_+v,+f
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64-linux-gnu -mattr=+v,+f -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64-linux-gnu -mattr=+v,+f -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"

; Test with a dead load in the loop, from
; https://github.com/llvm/llvm-project/issues/99701
define void @dead_load(ptr %p, i16 %start) {
entry:
  %start.ext = sext i16 %start to i64
  br label %loop

loop:
  %iv = phi i64 [ %start.ext, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr i16, ptr %p, i64 %iv
  store i16 0, ptr %gep, align 2
  %l = load i16, ptr %gep, align 2
  %iv.next = add i64 %iv, 3
  %cmp = icmp slt i64 %iv, 111
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; Test case for https://github.com/llvm/llvm-project/issues/100464.
; Loop with a live-out %l and scalar epilogue required due to an interleave
; group. As the scalar epilogue is required the live-out is fed from the scalar
; epilogue and dead in the vector loop.
define i8 @dead_live_out_due_to_scalar_epilogue_required(ptr %src, ptr %dst) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %idxprom = sext i32 %iv to i64
  %gep.src = getelementptr i8, ptr %src, i64 %idxprom
  %l = load i8, ptr %gep.src, align 1
  %gep.dst = getelementptr i8, ptr %dst, i64 %idxprom
  store i8 0, ptr %gep.dst, align 1
  %iv.next = add i32 %iv, 4
  %cmp = icmp ult i32 %iv, 1001
  br i1 %cmp, label %loop, label %exit

exit:
  %r = phi i8 [ %l, %loop ]
  ret i8 %r
}


; Test case for https://github.com/llvm/llvm-project/issues/106780.
define i32 @cost_of_exit_branch_and_cond_insts(ptr %a, ptr %b, i1 %c, i16 %x) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c, label %then, label %loop.exiting

then:
  %gep = getelementptr inbounds i32, ptr %b, i32 %iv
  store i1 false, ptr %a, align 1
  store i32 0, ptr %gep, align 4
  br label %loop.exiting

loop.exiting:
  %iv.next = add i32 %iv, 1
  %umax = tail call i16 @llvm.umax.i16(i16 %x, i16 111)
  %umax.ext = zext i16 %umax to i32
  %sub = sub i32 770, %umax.ext
  %ec = icmp slt i32 %iv, %sub
  br i1 %ec, label %loop.latch, label %exit

loop.latch:
  br label %loop.header

exit:
  br label %return

return:
  ret i32 0
}

; Test case for https://github.com/llvm/llvm-project/issues/107473.
define void @test_phi_in_latch_redundant(ptr %dst, i32 %a) {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 false, label %loop.latch, label %then

then:
  %not.a = xor i32 %a, -1
  br label %loop.latch

loop.latch:
  %p = phi i32 [ %not.a, %then ], [ 0, %loop.header ]
  %gep = getelementptr i32, ptr %dst, i64 %iv
  store i32 %p, ptr %gep, align 4
  %iv.next = add i64 %iv, 9
  %ec = icmp slt i64 %iv, 322
  br i1 %ec, label %loop.header, label %exit

exit:
  ret void
}

; Test for https://github.com/llvm/llvm-project/issues/108098.
define void @gather_interleave_group_with_dead_insert_pos(i64 %N, ptr noalias %src, ptr noalias %dst) #0 {
entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep.src.0 = getelementptr i8, ptr %src, i64 %iv
  %l.dead = load i8, ptr %gep.src.0, align 1
  %iv.1 = add i64 %iv, 1
  %gep.src.1 = getelementptr i8, ptr %src, i64 %iv.1
  %l.1 = load i8, ptr %gep.src.1, align 1
  %ext  = zext i8 %l.1 to i32
  %gep.dst = getelementptr i32, ptr %dst, i64 %iv
  store i32 %ext, ptr %gep.dst, align 4
  %iv.next = add nsw i64 %iv, 2
  %ec = icmp slt i64 %iv, %N
  br i1 %ec, label %loop, label %exit

exit:
  ret void
}

attributes #0 = { "target-features"="+64bit,+v" }

;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6nldxm18.ll'
source_filename = "/tmp/tmp6nldxm18.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @dead_load(ptr %p, i16 %start) #0 {
entry:
  %start.ext = sext i16 %start to i64
  %smax = call i64 @llvm.smax.i64(i64 %start.ext, i64 111)
  %0 = sub i64 %smax, %start.ext
  %umin = call i64 @llvm.umin.i64(i64 %0, i64 1)
  %1 = sub i64 %smax, %umin
  %2 = sub i64 %1, %start.ext
  %3 = udiv i64 %2, 3
  %4 = add i64 %umin, %3
  %5 = add i64 %4, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %6 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %start.ext, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %7 = mul <vscale x 8 x i64> %6, splat (i64 3)
  %induction = add <vscale x 8 x i64> %broadcast.splat, %7
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %induction, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %5, %vector.ph ], [ %avl.next, %vector.body ]
  %8 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %9 = zext i32 %8 to i64
  %10 = mul i64 3, %9
  %broadcast.splatinsert1 = insertelement <vscale x 8 x i64> poison, i64 %10, i64 0
  %broadcast.splat2 = shufflevector <vscale x 8 x i64> %broadcast.splatinsert1, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %11 = getelementptr i16, ptr %p, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %11, <vscale x 8 x i1> splat (i1 true), i32 %8)
  %avl.next = sub nuw i64 %avl, %9
  %vec.ind.next = add <vscale x 8 x i64> %vec.ind, %broadcast.splat2
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i8 @dead_live_out_due_to_scalar_epilogue_required(ptr %src, ptr %dst) #0 {
entry:
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %dst, i64 1005
  %scevgep1 = getelementptr i8, ptr %src, i64 1005
  %bound0 = icmp ult ptr %dst, %scevgep1
  %bound1 = icmp ult ptr %src, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %0 = call <vscale x 16 x i32> @llvm.stepvector.nxv16i32()
  %1 = mul <vscale x 16 x i32> %0, splat (i32 4)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 16 x i32> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ 252, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 16, i1 true)
  %3 = shl i32 %2, 2
  %broadcast.splatinsert = insertelement <vscale x 16 x i32> poison, i32 %3, i64 0
  %broadcast.splat = shufflevector <vscale x 16 x i32> %broadcast.splatinsert, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %4 = sext <vscale x 16 x i32> %vec.ind to <vscale x 16 x i64>
  %5 = getelementptr i8, ptr %src, <vscale x 16 x i64> %4
  %wide.masked.gather = call <vscale x 16 x i8> @llvm.vp.gather.nxv16i8.nxv16p0(<vscale x 16 x ptr> align 1 %5, <vscale x 16 x i1> splat (i1 true), i32 %2), !alias.scope !3
  %6 = getelementptr i8, ptr %dst, <vscale x 16 x i64> %4
  call void @llvm.vp.scatter.nxv16i8.nxv16p0(<vscale x 16 x i8> zeroinitializer, <vscale x 16 x ptr> align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %2), !alias.scope !6, !noalias !3
  %avl.next = sub nuw i32 %avl, %2
  %vec.ind.next = add <vscale x 16 x i32> %vec.ind, %broadcast.splat
  %7 = icmp eq i32 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %8 = zext i32 %2 to i64
  %9 = sub i64 %8, 1
  %10 = extractelement <vscale x 16 x i8> %wide.masked.gather, i64 %9
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i32 [ 0, %scalar.ph ], [ %iv.next, %loop ]
  %idxprom = sext i32 %iv to i64
  %gep.src = getelementptr i8, ptr %src, i64 %idxprom
  %l = load i8, ptr %gep.src, align 1
  %gep.dst = getelementptr i8, ptr %dst, i64 %idxprom
  store i8 0, ptr %gep.dst, align 1
  %iv.next = add i32 %iv, 4
  %cmp = icmp ult i32 %iv, 1001
  br i1 %cmp, label %loop, label %exit, !llvm.loop !9

exit:                                             ; preds = %middle.block, %loop
  %r = phi i8 [ %l, %loop ], [ %10, %middle.block ]
  ret i8 %r
}

define i32 @cost_of_exit_branch_and_cond_insts(ptr %a, ptr %b, i1 %c, i16 %x) #1 {
entry:
  %0 = zext i16 %x to i32
  %umax3 = call i32 @llvm.umax.i32(i32 %0, i32 111)
  %1 = sub i32 770, %umax3
  %smax4 = call i32 @llvm.smax.i32(i32 %1, i32 0)
  %2 = add nuw nsw i32 %smax4, 1
  %min.iters.check = icmp ule i32 %2, 19
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %a, i64 1
  %3 = zext i16 %x to i32
  %umax1 = call i32 @llvm.umax.i32(i32 %3, i32 111)
  %4 = sub i32 770, %umax1
  %smax = call i32 @llvm.smax.i32(i32 %4, i32 0)
  %5 = zext nneg i32 %smax to i64
  %6 = shl nuw nsw i64 %5, 2
  %7 = add nuw nsw i64 %6, 4
  %scevgep2 = getelementptr i8, ptr %b, i64 %7
  %bound0 = icmp ult ptr %a, %scevgep2
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.mod.vf = urem i32 %2, 8
  %8 = icmp eq i32 %n.mod.vf, 0
  %9 = select i1 %8, i32 8, i32 %n.mod.vf
  %n.vec = sub i32 %2, %9
  %broadcast.splatinsert = insertelement <8 x i1> poison, i1 %c, i64 0
  %broadcast.splat = shufflevector <8 x i1> %broadcast.splatinsert, <8 x i1> poison, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %pred.store.continue18, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %pred.store.continue18 ]
  %10 = getelementptr i32, ptr %b, i32 %index
  br i1 %c, label %pred.store.if, label %pred.store.continue

pred.store.if:                                    ; preds = %vector.body
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue

pred.store.continue:                              ; preds = %pred.store.if, %vector.body
  br i1 %c, label %pred.store.if5, label %pred.store.continue6

pred.store.if5:                                   ; preds = %pred.store.continue
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue6

pred.store.continue6:                             ; preds = %pred.store.if5, %pred.store.continue
  br i1 %c, label %pred.store.if7, label %pred.store.continue8

pred.store.if7:                                   ; preds = %pred.store.continue6
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue8

pred.store.continue8:                             ; preds = %pred.store.if7, %pred.store.continue6
  br i1 %c, label %pred.store.if9, label %pred.store.continue10

pred.store.if9:                                   ; preds = %pred.store.continue8
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue10

pred.store.continue10:                            ; preds = %pred.store.if9, %pred.store.continue8
  br i1 %c, label %pred.store.if11, label %pred.store.continue12

pred.store.if11:                                  ; preds = %pred.store.continue10
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue12

pred.store.continue12:                            ; preds = %pred.store.if11, %pred.store.continue10
  br i1 %c, label %pred.store.if13, label %pred.store.continue14

pred.store.if13:                                  ; preds = %pred.store.continue12
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue14

pred.store.continue14:                            ; preds = %pred.store.if13, %pred.store.continue12
  br i1 %c, label %pred.store.if15, label %pred.store.continue16

pred.store.if15:                                  ; preds = %pred.store.continue14
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue16

pred.store.continue16:                            ; preds = %pred.store.if15, %pred.store.continue14
  br i1 %c, label %pred.store.if17, label %pred.store.continue18

pred.store.if17:                                  ; preds = %pred.store.continue16
  store i1 false, ptr %a, align 1, !alias.scope !10, !noalias !13
  br label %pred.store.continue18

pred.store.continue18:                            ; preds = %pred.store.if17, %pred.store.continue16
  call void @llvm.masked.store.v8i32.p0(<8 x i32> zeroinitializer, ptr align 4 %10, <8 x i1> %broadcast.splat), !alias.scope !13
  %index.next = add nuw i32 %index, 8
  %11 = icmp eq i32 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !15

middle.block:                                     ; preds = %pred.store.continue18
  br label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i32 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop.header

loop.header:                                      ; preds = %scalar.ph, %loop.latch
  %iv = phi i32 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop.latch ]
  br i1 %c, label %then, label %loop.exiting

then:                                             ; preds = %loop.header
  %gep = getelementptr inbounds i32, ptr %b, i32 %iv
  store i1 false, ptr %a, align 1
  store i32 0, ptr %gep, align 4
  br label %loop.exiting

loop.exiting:                                     ; preds = %then, %loop.header
  %iv.next = add i32 %iv, 1
  %umax = tail call i16 @llvm.umax.i16(i16 %x, i16 111)
  %umax.ext = zext i16 %umax to i32
  %sub = sub i32 770, %umax.ext
  %ec = icmp slt i32 %iv, %sub
  br i1 %ec, label %loop.latch, label %exit

loop.latch:                                       ; preds = %loop.exiting
  br label %loop.header, !llvm.loop !16

exit:                                             ; preds = %loop.exiting
  br label %return

return:                                           ; preds = %exit
  ret i32 0
}

define void @test_phi_in_latch_redundant(ptr %dst, i32 %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = xor i32 %a, -1
  %broadcast.splatinsert1 = insertelement <vscale x 4 x i32> poison, i32 %0, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x i32> %broadcast.splatinsert1, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %1 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %2 = mul <vscale x 4 x i64> %1, splat (i64 9)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %2, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 37, %vector.ph ], [ %avl.next, %vector.body ]
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %4 = zext i32 %3 to i64
  %5 = mul i64 9, %4
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %5, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %6 = getelementptr i32, ptr %dst, <vscale x 4 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %broadcast.splat2, <vscale x 4 x ptr> align 4 %6, <vscale x 4 x i1> splat (i1 true), i32 %3)
  %avl.next = sub nuw i64 %avl, %4
  %vec.ind.next = add <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !17

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @gather_interleave_group_with_dead_insert_pos(i64 %N, ptr noalias %src, ptr noalias %dst) #1 {
entry:
  %smax = call i64 @llvm.smax.i64(i64 %N, i64 0)
  %0 = add nuw i64 %smax, 1
  %1 = lshr i64 %0, 1
  %2 = add nuw nsw i64 %1, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %3 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %4 = mul nsw <vscale x 4 x i64> %3, splat (i64 2)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %2, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %6 = zext i32 %5 to i64
  %7 = shl nsw i64 %6, 1
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %7, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %8 = shl i64 %index, 1
  %9 = add i64 %8, 1
  %10 = getelementptr i8, ptr %src, i64 %9
  %broadcast.splatinsert1 = insertelement <vscale x 4 x ptr> poison, ptr %10, i64 0
  %broadcast.splat2 = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert1, <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
  %wide.masked.gather = call <vscale x 4 x i8> @llvm.vp.gather.nxv4i8.nxv4p0(<vscale x 4 x ptr> align 1 %broadcast.splat2, <vscale x 4 x i1> splat (i1 true), i32 %5)
  %11 = zext <vscale x 4 x i8> %wide.masked.gather to <vscale x 4 x i32>
  %12 = getelementptr i32, ptr %dst, <vscale x 4 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %11, <vscale x 4 x ptr> align 4 %12, <vscale x 4 x i1> splat (i1 true), i32 %5)
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %vec.ind.next = add nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %13 = icmp eq i64 %avl.next, 0
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.umax.i16(i16, i16) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 8 x i64> @llvm.stepvector.nxv8i64() #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 16 x i32> @llvm.stepvector.nxv16i32() #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 16 x i8> @llvm.vp.gather.nxv16i8.nxv16p0(<vscale x 16 x ptr>, <vscale x 16 x i1>, i32) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv16i8.nxv16p0(<vscale x 16 x i8>, <vscale x 16 x ptr>, <vscale x 16 x i1>, i32) #6

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v8i32.p0(<8 x i32>, ptr captures(none), <8 x i1>) #8

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #4

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i8> @llvm.vp.gather.nxv4i8.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #7

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { "target-features"="+64bit,+v,+v,+f" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = !{!4}
!4 = distinct !{!4, !5}
!5 = distinct !{!5, !"LVerDomain"}
!6 = !{!7}
!7 = distinct !{!7, !5}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1}
!10 = !{!11}
!11 = distinct !{!11, !12}
!12 = distinct !{!12, !"LVerDomain"}
!13 = !{!14}
!14 = distinct !{!14, !12}
!15 = distinct !{!15, !1, !2}
!16 = distinct !{!16, !1}
!17 = distinct !{!17, !1, !2}
!18 = distinct !{!18, !1, !2}
