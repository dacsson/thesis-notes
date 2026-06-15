; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/blocks-with-dead-instructions.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -S
; Original: RUN: opt -p loop-vectorize -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @block_with_dead_inst_1(ptr %src, i64 %N) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i16 [ 1, %entry ], [ %xor, %loop.latch ]
  %xor = xor i16 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %then, label %loop.latch

then:
  %dead.gep = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

loop.latch:
  store i16 %xor, ptr %gep
  %iv.next = add nsw i64 %iv, 3
  %1 = icmp eq i64 %iv.next, %N
  br i1 %1, label %exit, label %loop.header

exit:
  ret void
}

define void @block_with_dead_inst_2(ptr %src) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i16 [ 0, %entry ], [ %xor, %loop.latch ]
  %xor = xor i16 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %loop.latch, label %else

else:
  %dead.gep = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

loop.latch:
  store i16 %xor, ptr %gep
  %iv.next = add nsw i64 %iv, 3
  %ec = icmp eq i64 %iv.next, 1000
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @multiple_blocks_with_dead_insts_3(ptr %src) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i16 [ 0, %entry ], [ %xor, %loop.latch ]
  %xor = xor i16 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %then, label %else

then:
  %dead.gep.1 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

else:
  %dead.gep.2 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

loop.latch:
  store i16 %xor, ptr %gep
  %iv.next = add nsw i64 %iv, 3
  %ec = icmp eq i64 %iv.next, 1000
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @multiple_blocks_with_dead_insts_4(ptr %src, i64 %N) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i16 [ 1, %entry ], [ %xor, %loop.latch ]
  %xor = xor i16 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %then, label %else

then:
  br label %then.1

then.1:
  %dead.gep.1 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

else:
  %dead.gep.2 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

loop.latch:
  store i16 %xor, ptr %gep
  %iv.next = add nsw i64 %iv, 3
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @multiple_blocks_with_dead_inst_multiple_successors_5(ptr %src) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i16 [ 1, %entry ], [ %xor, %loop.latch ]
  %xor = xor i16 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %then, label %else

then:
  br label %then.1

then.1:
  %dead.gep.1 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

else:
  br label %else.2

else.2:
  %dead.gep.2 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

loop.latch:
  store i16 %xor, ptr %gep
  %iv.next = add nsw i64 %iv, 3
  %ec = icmp eq i64 %iv.next, 1000
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @multiple_blocks_with_dead_inst_multiple_successors_6(ptr %src, i1 %ic, i64 %N) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i16 [ 1, %entry ], [ %xor, %loop.latch ]
  %xor = xor i16 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %then, label %else

then:
  br i1 %ic, label %then.1, label %else

then.1:
  %dead.gep.1 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

else:
  br label %else.2

else.2:
  %dead.gep.2 = getelementptr i64, ptr %src, i64 %iv
  br label %loop.latch

loop.latch:
  store i16 %xor, ptr %gep
  %iv.next = add nsw i64 %iv, 3
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @empty_block_with_phi_1(ptr %src, i64 %N) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i32 [ 1, %entry ], [ %xor, %loop.latch ]
  %xor = xor i32 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %then, label %loop.latch

then:
  br label %loop.latch

loop.latch:
  %p = phi i16 [ %l, %loop.header ], [ 99, %then ]
  store i16 %p, ptr %gep
  %iv.next = add nsw i64 %iv, 1
  %1 = icmp eq i64 %iv.next, %N
  br i1 %1, label %exit, label %loop.header

exit:
  ret void
}

define void @empty_block_with_phi_2(ptr %src, i64 %N) #0 {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %xor1315 = phi i32 [ 1, %entry ], [ %xor, %loop.latch ]
  %xor = xor i32 0, 0
  %gep = getelementptr i16, ptr %src, i64 %iv
  %l = load i16, ptr %gep, align 2
  %c = icmp eq i16 %l, 0
  br i1 %c, label %loop.latch, label %else

else:
  br label %loop.latch

loop.latch:
  %p = phi i16 [ %l, %loop.header ], [ 99, %else ]
  store i16 %p, ptr %gep
  %iv.next = add nsw i64 %iv, 1
  %1 = icmp eq i64 %iv.next, %N
  br i1 %1, label %exit, label %loop.header

exit:
  ret void
}

; Test case for https://github.com/llvm/llvm-project/issues/100591.
define void @dead_load_in_block(ptr %dst, ptr %src, i8 %N, i64 %x) #0 {
entry:
  %N.ext = zext i8 %N to i64
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %l.0 = load i32, ptr %src, align 4
  %c.0 = icmp eq i32 %l.0, 0
  br i1 %c.0, label %loop.latch , label %then

then:
  %gep.src.x = getelementptr i32, ptr %src, i64 %x
  %l.dead = load i32, ptr %gep.src.x, align 4
  br label %loop.latch

loop.latch:
  %gep.dst = getelementptr i32, ptr %dst, i64 %iv
  store i32 0, ptr %gep.dst, align 4
  %iv.next = add i64 %iv, 3
  %cmp = icmp ult i64 %iv, %N.ext
  br i1 %cmp, label %loop.header, label %exit

exit:
  ret void
}

attributes #0 = { "target-features"="+64bit,+v" }
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6r50pwda.ll'
source_filename = "/tmp/tmp6r50pwda.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @block_with_dead_inst_1(ptr %src, i64 %N) #0 {
entry:
  %0 = add i64 %N, -3
  %1 = udiv i64 %0, 3
  %2 = add nuw nsw i64 %1, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %3 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %4 = mul nsw <vscale x 8 x i64> %3, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %2, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %6 = zext i32 %5 to i64
  %7 = mul nsw i64 3, %6
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %7, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %8 = getelementptr i16, ptr %src, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %8, <vscale x 8 x i1> splat (i1 true), i32 %5)
  %avl.next = sub nuw i64 %avl, %6
  %vec.ind.next = add nsw <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @block_with_dead_inst_2(ptr %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %1 = mul nsw <vscale x 8 x i64> %0, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 333, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %3 = zext i32 %2 to i64
  %4 = mul nsw i64 3, %3
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %5 = getelementptr i16, ptr %src, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %5, <vscale x 8 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i64 %avl, %3
  %vec.ind.next = add nsw <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @multiple_blocks_with_dead_insts_3(ptr %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %1 = mul nsw <vscale x 8 x i64> %0, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 333, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %3 = zext i32 %2 to i64
  %4 = mul nsw i64 3, %3
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %5 = getelementptr i16, ptr %src, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %5, <vscale x 8 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i64 %avl, %3
  %vec.ind.next = add nsw <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @multiple_blocks_with_dead_insts_4(ptr %src, i64 %N) #0 {
entry:
  %0 = add i64 %N, -3
  %1 = udiv i64 %0, 3
  %2 = add nuw nsw i64 %1, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %3 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %4 = mul nsw <vscale x 8 x i64> %3, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %2, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %6 = zext i32 %5 to i64
  %7 = mul nsw i64 3, %6
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %7, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %8 = getelementptr i16, ptr %src, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %8, <vscale x 8 x i1> splat (i1 true), i32 %5)
  %avl.next = sub nuw i64 %avl, %6
  %vec.ind.next = add nsw <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @multiple_blocks_with_dead_inst_multiple_successors_5(ptr %src) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %1 = mul nsw <vscale x 8 x i64> %0, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 333, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %3 = zext i32 %2 to i64
  %4 = mul nsw i64 3, %3
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %5 = getelementptr i16, ptr %src, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %5, <vscale x 8 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i64 %avl, %3
  %vec.ind.next = add nsw <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @multiple_blocks_with_dead_inst_multiple_successors_6(ptr %src, i1 %ic, i64 %N) #0 {
entry:
  %0 = add i64 %N, -3
  %1 = udiv i64 %0, 3
  %2 = add nuw nsw i64 %1, 1
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %3 = call <vscale x 8 x i64> @llvm.stepvector.nxv8i64()
  %4 = mul nsw <vscale x 8 x i64> %3, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 8 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %2, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %6 = zext i32 %5 to i64
  %7 = mul nsw i64 3, %6
  %broadcast.splatinsert = insertelement <vscale x 8 x i64> poison, i64 %7, i64 0
  %broadcast.splat = shufflevector <vscale x 8 x i64> %broadcast.splatinsert, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %8 = getelementptr i16, ptr %src, <vscale x 8 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x ptr> align 2 %8, <vscale x 8 x i1> splat (i1 true), i32 %5)
  %avl.next = sub nuw i64 %avl, %6
  %vec.ind.next = add nsw <vscale x 8 x i64> %vec.ind, %broadcast.splat
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @empty_block_with_phi_1(ptr %src, i64 %N) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr i16, ptr %src, i64 %index
  %vp.op.load = call <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = icmp eq <vscale x 8 x i16> %vp.op.load, zeroinitializer
  %predphi = select <vscale x 8 x i1> %2, <vscale x 8 x i16> splat (i16 99), <vscale x 8 x i16> %vp.op.load
  call void @llvm.vp.store.nxv8i16.p0(<vscale x 8 x i16> %predphi, ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @empty_block_with_phi_2(ptr %src, i64 %N) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr i16, ptr %src, i64 %index
  %vp.op.load = call <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = icmp eq <vscale x 8 x i16> %vp.op.load, zeroinitializer
  %predphi = select <vscale x 8 x i1> %2, <vscale x 8 x i16> %vp.op.load, <vscale x 8 x i16> splat (i16 99)
  call void @llvm.vp.store.nxv8i16.p0(<vscale x 8 x i16> %predphi, ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @dead_load_in_block(ptr %dst, ptr %src, i8 %N, i64 %x) #0 {
entry:
  %N.ext = zext i8 %N to i64
  %umin7 = call i64 @llvm.umin.i64(i64 %N.ext, i64 1)
  %0 = sub i64 %N.ext, %umin7
  %1 = udiv i64 %0, 3
  %2 = add i64 %umin7, %1
  %3 = add i64 %2, 1
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %umin = call i64 @llvm.umin.i64(i64 %N.ext, i64 1)
  %4 = sub i64 %N.ext, %umin
  %5 = udiv i64 %4, 3
  %6 = add i64 %umin, %5
  %7 = mul i64 %6, 12
  %8 = add i64 %7, 4
  %scevgep = getelementptr i8, ptr %dst, i64 %8
  %9 = shl i64 %x, 2
  %scevgep1 = getelementptr i8, ptr %src, i64 %9
  %10 = add i64 %9, 4
  %scevgep2 = getelementptr i8, ptr %src, i64 %10
  %scevgep3 = getelementptr i8, ptr %src, i64 4
  %bound0 = icmp ult ptr %dst, %scevgep2
  %bound1 = icmp ult ptr %scevgep1, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  %bound04 = icmp ult ptr %dst, %scevgep3
  %bound15 = icmp ult ptr %src, %scevgep
  %found.conflict6 = and i1 %bound04, %bound15
  %conflict.rdx = or i1 %found.conflict, %found.conflict6
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %11 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %12 = mul <vscale x 4 x i64> %11, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %12, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %3, %vector.ph ], [ %avl.next, %vector.body ]
  %13 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %14 = zext i32 %13 to i64
  %15 = mul i64 3, %14
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %15, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %16 = getelementptr i32, ptr %dst, <vscale x 4 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x ptr> align 4 %16, <vscale x 4 x i1> splat (i1 true), i32 %13), !alias.scope !10, !noalias !13
  %avl.next = sub nuw i64 %avl, %14
  %vec.ind.next = add <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %17 = icmp eq i64 %avl.next, 0
  br i1 %17, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop.header

loop.header:                                      ; preds = %scalar.ph, %loop.latch
  %iv = phi i64 [ 0, %scalar.ph ], [ %iv.next, %loop.latch ]
  %l.0 = load i32, ptr %src, align 4
  %c.0 = icmp eq i32 %l.0, 0
  br i1 %c.0, label %loop.latch, label %then

then:                                             ; preds = %loop.header
  %gep.src.x = getelementptr i32, ptr %src, i64 %x
  %l.dead = load i32, ptr %gep.src.x, align 4
  br label %loop.latch

loop.latch:                                       ; preds = %then, %loop.header
  %gep.dst = getelementptr i32, ptr %dst, i64 %iv
  store i32 0, ptr %gep.dst, align 4
  %iv.next = add i64 %iv, 3
  %cmp = icmp ult i64 %iv, %N.ext
  br i1 %cmp, label %loop.header, label %exit, !llvm.loop !17

exit:                                             ; preds = %middle.block, %loop.latch
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 8 x i64> @llvm.stepvector.nxv8i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv8i16.nxv8p0(<vscale x 8 x i16>, <vscale x 8 x ptr>, <vscale x 8 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i16.p0(<vscale x 8 x i16>, ptr captures(none), <vscale x 8 x i1>, i32) #5

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+64bit,+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #6 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

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
!10 = !{!11}
!11 = distinct !{!11, !12}
!12 = distinct !{!12, !"LVerDomain"}
!13 = !{!14, !15}
!14 = distinct !{!14, !12}
!15 = distinct !{!15, !12}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !1}
