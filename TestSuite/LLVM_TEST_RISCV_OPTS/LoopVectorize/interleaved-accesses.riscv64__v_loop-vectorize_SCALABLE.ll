; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/interleaved-accesses.ll
; Variant: riscv64_+v_loop-vectorize_SCALABLE
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=on -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=on -mtriple=riscv64 -mattr=+v -S | FileCheck %s --check-prefix=SCALABLE

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @load_store_factor2_i32(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = shl i64 %i, 1
  %q0 = getelementptr i32, ptr %p, i64 %offset0
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset1
  %x1 = load i32, ptr %q1
  %y1 = add i32 %x1, 2
  store i32 %y1, ptr %q1

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor2_i64(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = shl i64 %i, 1
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor3_i32(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = mul i64 %i, 3
  %q0 = getelementptr i32, ptr %p, i64 %offset0
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset1
  %x1 = load i32, ptr %q1
  %y1 = add i32 %x1, 2
  store i32 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i32, ptr %p, i64 %offset2
  %x2 = load i32, ptr %q2
  %y2 = add i32 %x2, 3
  store i32 %y2, ptr %q2

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor3_i64(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = mul i64 %i, 3
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i64, ptr %p, i64 %offset2
  %x2 = load i64, ptr %q2
  %y2 = add i64 %x2, 3
  store i64 %y2, ptr %q2

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor4(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = mul i64 %i, 4
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i64, ptr %p, i64 %offset2
  %x2 = load i64, ptr %q2
  %y2 = add i64 %x2, 3
  store i64 %y2, ptr %q2

  %offset3 = add i64 %offset2, 1
  %q3 = getelementptr i64, ptr %p, i64 %offset3
  %x3 = load i64, ptr %q3
  %y3 = add i64 %x3, 4
  store i64 %y3, ptr %q3

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor5(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = mul i64 %i, 5
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i64, ptr %p, i64 %offset2
  %x2 = load i64, ptr %q2
  %y2 = add i64 %x2, 3
  store i64 %y2, ptr %q2

  %offset3 = add i64 %offset2, 1
  %q3 = getelementptr i64, ptr %p, i64 %offset3
  %x3 = load i64, ptr %q3
  %y3 = add i64 %x3, 4
  store i64 %y3, ptr %q3

  %offset4 = add i64 %offset3, 1
  %q4 = getelementptr i64, ptr %p, i64 %offset4
  %x4 = load i64, ptr %q4
  %y4 = add i64 %x4, 5
  store i64 %y4, ptr %q4

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor6(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = mul i64 %i, 6
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i64, ptr %p, i64 %offset2
  %x2 = load i64, ptr %q2
  %y2 = add i64 %x2, 3
  store i64 %y2, ptr %q2

  %offset3 = add i64 %offset2, 1
  %q3 = getelementptr i64, ptr %p, i64 %offset3
  %x3 = load i64, ptr %q3
  %y3 = add i64 %x3, 4
  store i64 %y3, ptr %q3

  %offset4 = add i64 %offset3, 1
  %q4 = getelementptr i64, ptr %p, i64 %offset4
  %x4 = load i64, ptr %q4
  %y4 = add i64 %x4, 5
  store i64 %y4, ptr %q4

  %offset5 = add i64 %offset4, 1
  %q5 = getelementptr i64, ptr %p, i64 %offset5
  %x5 = load i64, ptr %q5
  %y5 = add i64 %x5, 6
  store i64 %y5, ptr %q5

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor7(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = mul i64 %i, 7
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i64, ptr %p, i64 %offset2
  %x2 = load i64, ptr %q2
  %y2 = add i64 %x2, 3
  store i64 %y2, ptr %q2

  %offset3 = add i64 %offset2, 1
  %q3 = getelementptr i64, ptr %p, i64 %offset3
  %x3 = load i64, ptr %q3
  %y3 = add i64 %x3, 4
  store i64 %y3, ptr %q3

  %offset4 = add i64 %offset3, 1
  %q4 = getelementptr i64, ptr %p, i64 %offset4
  %x4 = load i64, ptr %q4
  %y4 = add i64 %x4, 5
  store i64 %y4, ptr %q4

  %offset5 = add i64 %offset4, 1
  %q5 = getelementptr i64, ptr %p, i64 %offset5
  %x5 = load i64, ptr %q5
  %y5 = add i64 %x5, 6
  store i64 %y5, ptr %q5

  %offset6 = add i64 %offset5, 1
  %q6 = getelementptr i64, ptr %p, i64 %offset6
  %x6 = load i64, ptr %q6
  %y6 = add i64 %x6, 7
  store i64 %y6, ptr %q6

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @load_store_factor8(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = shl i64 %i, 3
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0
  %y0 = add i64 %x0, 1
  store i64 %y0, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1
  %y1 = add i64 %x1, 2
  store i64 %y1, ptr %q1

  %offset2 = add i64 %offset1, 1
  %q2 = getelementptr i64, ptr %p, i64 %offset2
  %x2 = load i64, ptr %q2
  %y2 = add i64 %x2, 3
  store i64 %y2, ptr %q2

  %offset3 = add i64 %offset2, 1
  %q3 = getelementptr i64, ptr %p, i64 %offset3
  %x3 = load i64, ptr %q3
  %y3 = add i64 %x3, 4
  store i64 %y3, ptr %q3

  %offset4 = add i64 %offset3, 1
  %q4 = getelementptr i64, ptr %p, i64 %offset4
  %x4 = load i64, ptr %q4
  %y4 = add i64 %x4, 5
  store i64 %y4, ptr %q4

  %offset5 = add i64 %offset4, 1
  %q5 = getelementptr i64, ptr %p, i64 %offset5
  %x5 = load i64, ptr %q5
  %y5 = add i64 %x5, 6
  store i64 %y5, ptr %q5

  %offset6 = add i64 %offset5, 1
  %q6 = getelementptr i64, ptr %p, i64 %offset6
  %x6 = load i64, ptr %q6
  %y6 = add i64 %x6, 7
  store i64 %y6, ptr %q6

  %offset7 = add i64 %offset6, 1
  %q7 = getelementptr i64, ptr %p, i64 %offset7
  %x7 = load i64, ptr %q7
  %y7 = add i64 %x7, 8
  store i64 %y7, ptr %q7

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @combine_load_factor2_i32(ptr noalias %p, ptr noalias %q) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = shl i64 %i, 1
  %q0 = getelementptr i32, ptr %p, i64 %offset0
  %x0 = load i32, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset1
  %x1 = load i32, ptr %q1

  %res = add i32 %x0, %x1

  %dst = getelementptr i32, ptr %q, i64 %i
  store i32 %res, ptr %dst

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @combine_load_factor2_i64(ptr noalias %p, ptr noalias %q) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset0 = shl i64 %i, 1
  %q0 = getelementptr i64, ptr %p, i64 %offset0
  %x0 = load i64, ptr %q0

  %offset1 = add i64 %offset0, 1
  %q1 = getelementptr i64, ptr %p, i64 %offset1
  %x1 = load i64, ptr %q1

  %res = add i64 %x0, %x1

  %dst = getelementptr i64, ptr %q, i64 %i
  store i64 %res, ptr %dst

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6027dk9b.ll'
source_filename = "/tmp/tmp6027dk9b.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store_factor2_i32(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = shl i64 %index, 1
  %2 = getelementptr i32, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 2
  %wide.vp.load = call <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr align 4 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %wide.vp.load)
  %3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %4 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %5 = add <vscale x 4 x i32> %3, splat (i32 1)
  %6 = add <vscale x 4 x i32> %4, splat (i32 2)
  %interleave.evl1 = mul nuw nsw i32 %0, 2
  %interleaved.vec = call <vscale x 8 x i32> @llvm.vector.interleave2.nxv8i32(<vscale x 4 x i32> %5, <vscale x 4 x i32> %6)
  call void @llvm.vp.store.nxv8i32.p0(<vscale x 8 x i32> %interleaved.vec, ptr align 4 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl1)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor2_i64(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = shl i64 %index, 1
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 2
  %wide.vp.load = call <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr align 8 %2, <vscale x 4 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 1
  %5 = add <vscale x 2 x i64> %3, splat (i64 1)
  %6 = add <vscale x 2 x i64> %4, splat (i64 2)
  %interleave.evl1 = mul nuw nsw i32 %0, 2
  %interleaved.vec = call <vscale x 4 x i64> @llvm.vector.interleave2.nxv4i64(<vscale x 2 x i64> %5, <vscale x 2 x i64> %6)
  call void @llvm.vp.store.nxv4i64.p0(<vscale x 4 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 4 x i1> splat (i1 true), i32 %interleave.evl1)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor3_i32(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = mul i64 %index, 3
  %2 = getelementptr i32, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 3
  %wide.vp.load = call <vscale x 12 x i32> @llvm.vp.load.nxv12i32.p0(ptr align 4 %2, <vscale x 12 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave3.nxv12i32(<vscale x 12 x i32> %wide.vp.load)
  %3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %4 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %5 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 2
  %6 = add <vscale x 4 x i32> %3, splat (i32 1)
  %7 = add <vscale x 4 x i32> %4, splat (i32 2)
  %8 = add <vscale x 4 x i32> %5, splat (i32 3)
  %interleave.evl1 = mul nuw nsw i32 %0, 3
  %interleaved.vec = call <vscale x 12 x i32> @llvm.vector.interleave3.nxv12i32(<vscale x 4 x i32> %6, <vscale x 4 x i32> %7, <vscale x 4 x i32> %8)
  call void @llvm.vp.store.nxv12i32.p0(<vscale x 12 x i32> %interleaved.vec, ptr align 4 %2, <vscale x 12 x i1> splat (i1 true), i32 %interleave.evl1)
  %9 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %9, %index
  %avl.next = sub nuw i64 %avl, %9
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor3_i64(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = mul i64 %index, 3
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 3
  %wide.vp.load = call <vscale x 6 x i64> @llvm.vp.load.nxv6i64.p0(ptr align 8 %2, <vscale x 6 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave3.nxv6i64(<vscale x 6 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 1
  %5 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 2
  %6 = add <vscale x 2 x i64> %3, splat (i64 1)
  %7 = add <vscale x 2 x i64> %4, splat (i64 2)
  %8 = add <vscale x 2 x i64> %5, splat (i64 3)
  %interleave.evl1 = mul nuw nsw i32 %0, 3
  %interleaved.vec = call <vscale x 6 x i64> @llvm.vector.interleave3.nxv6i64(<vscale x 2 x i64> %6, <vscale x 2 x i64> %7, <vscale x 2 x i64> %8)
  call void @llvm.vp.store.nxv6i64.p0(<vscale x 6 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 6 x i1> splat (i1 true), i32 %interleave.evl1)
  %9 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %9, %index
  %avl.next = sub nuw i64 %avl, %9
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor4(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = shl i64 %index, 2
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 4
  %wide.vp.load = call <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(ptr align 8 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave4.nxv8i64(<vscale x 8 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 1
  %5 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 2
  %6 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 3
  %7 = add <vscale x 2 x i64> %3, splat (i64 1)
  %8 = add <vscale x 2 x i64> %4, splat (i64 2)
  %9 = add <vscale x 2 x i64> %5, splat (i64 3)
  %10 = add <vscale x 2 x i64> %6, splat (i64 4)
  %interleave.evl1 = mul nuw nsw i32 %0, 4
  %interleaved.vec = call <vscale x 8 x i64> @llvm.vector.interleave4.nxv8i64(<vscale x 2 x i64> %7, <vscale x 2 x i64> %8, <vscale x 2 x i64> %9, <vscale x 2 x i64> %10)
  call void @llvm.vp.store.nxv8i64.p0(<vscale x 8 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl1)
  %11 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %11, %index
  %avl.next = sub nuw i64 %avl, %11
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor5(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 1, i1 true)
  %1 = mul i64 %index, 5
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 5
  %wide.vp.load = call <vscale x 5 x i64> @llvm.vp.load.nxv5i64.p0(ptr align 8 %2, <vscale x 5 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave5.nxv5i64(<vscale x 5 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 1
  %5 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 2
  %6 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 3
  %7 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 4
  %8 = add <vscale x 1 x i64> %3, splat (i64 1)
  %9 = add <vscale x 1 x i64> %4, splat (i64 2)
  %10 = add <vscale x 1 x i64> %5, splat (i64 3)
  %11 = add <vscale x 1 x i64> %6, splat (i64 4)
  %12 = add <vscale x 1 x i64> %7, splat (i64 5)
  %interleave.evl1 = mul nuw nsw i32 %0, 5
  %interleaved.vec = call <vscale x 5 x i64> @llvm.vector.interleave5.nxv5i64(<vscale x 1 x i64> %8, <vscale x 1 x i64> %9, <vscale x 1 x i64> %10, <vscale x 1 x i64> %11, <vscale x 1 x i64> %12)
  call void @llvm.vp.store.nxv5i64.p0(<vscale x 5 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 5 x i1> splat (i1 true), i32 %interleave.evl1)
  %13 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %13, %index
  %avl.next = sub nuw i64 %avl, %13
  %14 = icmp eq i64 %avl.next, 0
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor6(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 1, i1 true)
  %1 = mul i64 %index, 6
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 6
  %wide.vp.load = call <vscale x 6 x i64> @llvm.vp.load.nxv6i64.p0(ptr align 8 %2, <vscale x 6 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave6.nxv6i64(<vscale x 6 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 1
  %5 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 2
  %6 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 3
  %7 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 4
  %8 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 5
  %9 = add <vscale x 1 x i64> %3, splat (i64 1)
  %10 = add <vscale x 1 x i64> %4, splat (i64 2)
  %11 = add <vscale x 1 x i64> %5, splat (i64 3)
  %12 = add <vscale x 1 x i64> %6, splat (i64 4)
  %13 = add <vscale x 1 x i64> %7, splat (i64 5)
  %14 = add <vscale x 1 x i64> %8, splat (i64 6)
  %interleave.evl1 = mul nuw nsw i32 %0, 6
  %interleaved.vec = call <vscale x 6 x i64> @llvm.vector.interleave6.nxv6i64(<vscale x 1 x i64> %9, <vscale x 1 x i64> %10, <vscale x 1 x i64> %11, <vscale x 1 x i64> %12, <vscale x 1 x i64> %13, <vscale x 1 x i64> %14)
  call void @llvm.vp.store.nxv6i64.p0(<vscale x 6 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 6 x i1> splat (i1 true), i32 %interleave.evl1)
  %15 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %15, %index
  %avl.next = sub nuw i64 %avl, %15
  %16 = icmp eq i64 %avl.next, 0
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor7(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 1, i1 true)
  %1 = mul i64 %index, 7
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 7
  %wide.vp.load = call <vscale x 7 x i64> @llvm.vp.load.nxv7i64.p0(ptr align 8 %2, <vscale x 7 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave7.nxv7i64(<vscale x 7 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 1
  %5 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 2
  %6 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 3
  %7 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 4
  %8 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 5
  %9 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 6
  %10 = add <vscale x 1 x i64> %3, splat (i64 1)
  %11 = add <vscale x 1 x i64> %4, splat (i64 2)
  %12 = add <vscale x 1 x i64> %5, splat (i64 3)
  %13 = add <vscale x 1 x i64> %6, splat (i64 4)
  %14 = add <vscale x 1 x i64> %7, splat (i64 5)
  %15 = add <vscale x 1 x i64> %8, splat (i64 6)
  %16 = add <vscale x 1 x i64> %9, splat (i64 7)
  %interleave.evl1 = mul nuw nsw i32 %0, 7
  %interleaved.vec = call <vscale x 7 x i64> @llvm.vector.interleave7.nxv7i64(<vscale x 1 x i64> %10, <vscale x 1 x i64> %11, <vscale x 1 x i64> %12, <vscale x 1 x i64> %13, <vscale x 1 x i64> %14, <vscale x 1 x i64> %15, <vscale x 1 x i64> %16)
  call void @llvm.vp.store.nxv7i64.p0(<vscale x 7 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 7 x i1> splat (i1 true), i32 %interleave.evl1)
  %17 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %17, %index
  %avl.next = sub nuw i64 %avl, %17
  %18 = icmp eq i64 %avl.next, 0
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @load_store_factor8(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 1, i1 true)
  %1 = shl i64 %index, 3
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 8
  %wide.vp.load = call <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(ptr align 8 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave8.nxv8i64(<vscale x 8 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 1
  %5 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 2
  %6 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 3
  %7 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 4
  %8 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 5
  %9 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 6
  %10 = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } %strided.vec, 7
  %11 = add <vscale x 1 x i64> %3, splat (i64 1)
  %12 = add <vscale x 1 x i64> %4, splat (i64 2)
  %13 = add <vscale x 1 x i64> %5, splat (i64 3)
  %14 = add <vscale x 1 x i64> %6, splat (i64 4)
  %15 = add <vscale x 1 x i64> %7, splat (i64 5)
  %16 = add <vscale x 1 x i64> %8, splat (i64 6)
  %17 = add <vscale x 1 x i64> %9, splat (i64 7)
  %18 = add <vscale x 1 x i64> %10, splat (i64 8)
  %interleave.evl1 = mul nuw nsw i32 %0, 8
  %interleaved.vec = call <vscale x 8 x i64> @llvm.vector.interleave8.nxv8i64(<vscale x 1 x i64> %11, <vscale x 1 x i64> %12, <vscale x 1 x i64> %13, <vscale x 1 x i64> %14, <vscale x 1 x i64> %15, <vscale x 1 x i64> %16, <vscale x 1 x i64> %17, <vscale x 1 x i64> %18)
  call void @llvm.vp.store.nxv8i64.p0(<vscale x 8 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl1)
  %19 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %19, %index
  %avl.next = sub nuw i64 %avl, %19
  %20 = icmp eq i64 %avl.next, 0
  br i1 %20, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @combine_load_factor2_i32(ptr noalias %p, ptr noalias %q) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = shl i64 %index, 1
  %2 = getelementptr i32, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 2
  %wide.vp.load = call <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr align 4 %2, <vscale x 8 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %wide.vp.load)
  %3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %4 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %5 = add <vscale x 4 x i32> %3, %4
  %6 = getelementptr i32, ptr %q, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %5, ptr align 4 %6, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @combine_load_factor2_i64(ptr noalias %p, ptr noalias %q) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = shl i64 %index, 1
  %2 = getelementptr i64, ptr %p, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 2
  %wide.vp.load = call <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr align 8 %2, <vscale x 4 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 1
  %5 = add <vscale x 2 x i64> %3, %4
  %6 = getelementptr i64, ptr %q, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %5, ptr align 8 %6, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr captures(none), <vscale x 8 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i32> @llvm.vector.interleave2.nxv8i32(<vscale x 4 x i32>, <vscale x 4 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i32.p0(<vscale x 8 x i32>, ptr captures(none), <vscale x 8 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.vector.interleave2.nxv4i64(<vscale x 2 x i64>, <vscale x 2 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i64.p0(<vscale x 4 x i64>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 12 x i32> @llvm.vp.load.nxv12i32.p0(ptr captures(none), <vscale x 12 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave3.nxv12i32(<vscale x 12 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 12 x i32> @llvm.vector.interleave3.nxv12i32(<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv12i32.p0(<vscale x 12 x i32>, ptr captures(none), <vscale x 12 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 6 x i64> @llvm.vp.load.nxv6i64.p0(ptr captures(none), <vscale x 6 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave3.nxv6i64(<vscale x 6 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 6 x i64> @llvm.vector.interleave3.nxv6i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv6i64.p0(<vscale x 6 x i64>, ptr captures(none), <vscale x 6 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(ptr captures(none), <vscale x 8 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave4.nxv8i64(<vscale x 8 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i64> @llvm.vector.interleave4.nxv8i64(<vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8i64.p0(<vscale x 8 x i64>, ptr captures(none), <vscale x 8 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 5 x i64> @llvm.vp.load.nxv5i64.p0(ptr captures(none), <vscale x 5 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave5.nxv5i64(<vscale x 5 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 5 x i64> @llvm.vector.interleave5.nxv5i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv5i64.p0(<vscale x 5 x i64>, ptr captures(none), <vscale x 5 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave6.nxv6i64(<vscale x 6 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 6 x i64> @llvm.vector.interleave6.nxv6i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 7 x i64> @llvm.vp.load.nxv7i64.p0(ptr captures(none), <vscale x 7 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave7.nxv7i64(<vscale x 7 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 7 x i64> @llvm.vector.interleave7.nxv7i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv7i64.p0(<vscale x 7 x i64>, ptr captures(none), <vscale x 7 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.vector.deinterleave8.nxv8i64(<vscale x 8 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i64> @llvm.vector.interleave8.nxv8i64(<vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

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
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1, !2}
!12 = distinct !{!12, !1, !2}
