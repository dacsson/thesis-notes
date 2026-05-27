; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/interleaved-accesses.ll
; Variant: riscv64_+v_loop-vectorize_FIXED
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=off -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=off -mtriple=riscv64 -mattr=+v -S | FileCheck %s --check-prefix=FIXED

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

; ModuleID = '/tmp/tmp2vfrsbr7.ll'
source_filename = "/tmp/tmp2vfrsbr7.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store_factor2_i32(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %1 = getelementptr i32, ptr %p, i64 %0
  %wide.vec = load <16 x i32>, ptr %1, align 4
  %strided.vec = shufflevector <16 x i32> %wide.vec, <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %strided.vec1 = shufflevector <16 x i32> %wide.vec, <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %2 = add <8 x i32> %strided.vec, splat (i32 1)
  %3 = add <8 x i32> %strided.vec1, splat (i32 2)
  %4 = shufflevector <8 x i32> %2, <8 x i32> %3, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i32> %4, <16 x i32> poison, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  store <16 x i32> %interleaved.vec, ptr %1, align 4
  %index.next = add nuw i64 %index, 8
  %5 = icmp eq i64 %index.next, 1024
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <8 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <8 x i64> %wide.vec, <8 x i64> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %strided.vec1 = shufflevector <8 x i64> %wide.vec, <8 x i64> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %2 = add <4 x i64> %strided.vec, splat (i64 1)
  %3 = add <4 x i64> %strided.vec1, splat (i64 2)
  %4 = shufflevector <4 x i64> %2, <4 x i64> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %interleaved.vec = shufflevector <8 x i64> %4, <8 x i64> poison, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  store <8 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 4
  %5 = icmp eq i64 %index.next, 1024
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !3

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 3
  %1 = getelementptr i32, ptr %p, i64 %0
  %wide.vec = load <24 x i32>, ptr %1, align 4
  %strided.vec = shufflevector <24 x i32> %wide.vec, <24 x i32> poison, <8 x i32> <i32 0, i32 3, i32 6, i32 9, i32 12, i32 15, i32 18, i32 21>
  %strided.vec1 = shufflevector <24 x i32> %wide.vec, <24 x i32> poison, <8 x i32> <i32 1, i32 4, i32 7, i32 10, i32 13, i32 16, i32 19, i32 22>
  %strided.vec2 = shufflevector <24 x i32> %wide.vec, <24 x i32> poison, <8 x i32> <i32 2, i32 5, i32 8, i32 11, i32 14, i32 17, i32 20, i32 23>
  %2 = add <8 x i32> %strided.vec, splat (i32 1)
  %3 = add <8 x i32> %strided.vec1, splat (i32 2)
  %4 = add <8 x i32> %strided.vec2, splat (i32 3)
  %5 = shufflevector <8 x i32> %2, <8 x i32> %3, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %6 = shufflevector <8 x i32> %4, <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %7 = shufflevector <16 x i32> %5, <16 x i32> %6, <24 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %interleaved.vec = shufflevector <24 x i32> %7, <24 x i32> poison, <24 x i32> <i32 0, i32 8, i32 16, i32 1, i32 9, i32 17, i32 2, i32 10, i32 18, i32 3, i32 11, i32 19, i32 4, i32 12, i32 20, i32 5, i32 13, i32 21, i32 6, i32 14, i32 22, i32 7, i32 15, i32 23>
  store <24 x i32> %interleaved.vec, ptr %1, align 4
  %index.next = add nuw i64 %index, 8
  %8 = icmp eq i64 %index.next, 1024
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !4

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 3
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <12 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %strided.vec1 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %strided.vec2 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  %2 = add <4 x i64> %strided.vec, splat (i64 1)
  %3 = add <4 x i64> %strided.vec1, splat (i64 2)
  %4 = add <4 x i64> %strided.vec2, splat (i64 3)
  %5 = shufflevector <4 x i64> %2, <4 x i64> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %6 = shufflevector <4 x i64> %4, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %7 = shufflevector <8 x i64> %5, <8 x i64> %6, <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %interleaved.vec = shufflevector <12 x i64> %7, <12 x i64> poison, <12 x i32> <i32 0, i32 4, i32 8, i32 1, i32 5, i32 9, i32 2, i32 6, i32 10, i32 3, i32 7, i32 11>
  store <12 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 4
  %8 = icmp eq i64 %index.next, 1024
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !5

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 2
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <16 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %strided.vec1 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %strided.vec2 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %strided.vec3 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  %2 = add <4 x i64> %strided.vec, splat (i64 1)
  %3 = add <4 x i64> %strided.vec1, splat (i64 2)
  %4 = add <4 x i64> %strided.vec2, splat (i64 3)
  %5 = add <4 x i64> %strided.vec3, splat (i64 4)
  %6 = shufflevector <4 x i64> %2, <4 x i64> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %7 = shufflevector <4 x i64> %4, <4 x i64> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %8 = shufflevector <8 x i64> %6, <8 x i64> %7, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i64> %8, <16 x i64> poison, <16 x i32> <i32 0, i32 4, i32 8, i32 12, i32 1, i32 5, i32 9, i32 13, i32 2, i32 6, i32 10, i32 14, i32 3, i32 7, i32 11, i32 15>
  store <16 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 4
  %9 = icmp eq i64 %index.next, 1024
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !6

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 5
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <10 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <10 x i64> %wide.vec, <10 x i64> poison, <2 x i32> <i32 0, i32 5>
  %strided.vec1 = shufflevector <10 x i64> %wide.vec, <10 x i64> poison, <2 x i32> <i32 1, i32 6>
  %strided.vec2 = shufflevector <10 x i64> %wide.vec, <10 x i64> poison, <2 x i32> <i32 2, i32 7>
  %strided.vec3 = shufflevector <10 x i64> %wide.vec, <10 x i64> poison, <2 x i32> <i32 3, i32 8>
  %strided.vec4 = shufflevector <10 x i64> %wide.vec, <10 x i64> poison, <2 x i32> <i32 4, i32 9>
  %2 = add <2 x i64> %strided.vec, splat (i64 1)
  %3 = add <2 x i64> %strided.vec1, splat (i64 2)
  %4 = add <2 x i64> %strided.vec2, splat (i64 3)
  %5 = add <2 x i64> %strided.vec3, splat (i64 4)
  %6 = add <2 x i64> %strided.vec4, splat (i64 5)
  %7 = shufflevector <2 x i64> %2, <2 x i64> %3, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %8 = shufflevector <2 x i64> %4, <2 x i64> %5, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %9 = shufflevector <4 x i64> %7, <4 x i64> %8, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %10 = shufflevector <2 x i64> %6, <2 x i64> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %11 = shufflevector <8 x i64> %9, <8 x i64> %10, <10 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>
  %interleaved.vec = shufflevector <10 x i64> %11, <10 x i64> poison, <10 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 1, i32 3, i32 5, i32 7, i32 9>
  store <10 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 2
  %12 = icmp eq i64 %index.next, 1024
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !7

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 6
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <12 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 0, i32 6>
  %strided.vec1 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 1, i32 7>
  %strided.vec2 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 2, i32 8>
  %strided.vec3 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 3, i32 9>
  %strided.vec4 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 4, i32 10>
  %strided.vec5 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 5, i32 11>
  %2 = add <2 x i64> %strided.vec, splat (i64 1)
  %3 = add <2 x i64> %strided.vec1, splat (i64 2)
  %4 = add <2 x i64> %strided.vec2, splat (i64 3)
  %5 = add <2 x i64> %strided.vec3, splat (i64 4)
  %6 = add <2 x i64> %strided.vec4, splat (i64 5)
  %7 = add <2 x i64> %strided.vec5, splat (i64 6)
  %8 = shufflevector <2 x i64> %2, <2 x i64> %3, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %9 = shufflevector <2 x i64> %4, <2 x i64> %5, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %10 = shufflevector <2 x i64> %6, <2 x i64> %7, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %11 = shufflevector <4 x i64> %8, <4 x i64> %9, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %12 = shufflevector <4 x i64> %10, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %13 = shufflevector <8 x i64> %11, <8 x i64> %12, <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %interleaved.vec = shufflevector <12 x i64> %13, <12 x i64> poison, <12 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11>
  store <12 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 2
  %14 = icmp eq i64 %index.next, 1024
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !8

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 7
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <14 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 0, i32 7>
  %strided.vec1 = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 1, i32 8>
  %strided.vec2 = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 2, i32 9>
  %strided.vec3 = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 3, i32 10>
  %strided.vec4 = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 4, i32 11>
  %strided.vec5 = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 5, i32 12>
  %strided.vec6 = shufflevector <14 x i64> %wide.vec, <14 x i64> poison, <2 x i32> <i32 6, i32 13>
  %2 = add <2 x i64> %strided.vec, splat (i64 1)
  %3 = add <2 x i64> %strided.vec1, splat (i64 2)
  %4 = add <2 x i64> %strided.vec2, splat (i64 3)
  %5 = add <2 x i64> %strided.vec3, splat (i64 4)
  %6 = add <2 x i64> %strided.vec4, splat (i64 5)
  %7 = add <2 x i64> %strided.vec5, splat (i64 6)
  %8 = add <2 x i64> %strided.vec6, splat (i64 7)
  %9 = shufflevector <2 x i64> %2, <2 x i64> %3, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %10 = shufflevector <2 x i64> %4, <2 x i64> %5, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %11 = shufflevector <2 x i64> %6, <2 x i64> %7, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %12 = shufflevector <4 x i64> %9, <4 x i64> %10, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %13 = shufflevector <2 x i64> %8, <2 x i64> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %14 = shufflevector <4 x i64> %11, <4 x i64> %13, <6 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>
  %15 = shufflevector <6 x i64> %14, <6 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 poison, i32 poison>
  %16 = shufflevector <8 x i64> %12, <8 x i64> %15, <14 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13>
  %interleaved.vec = shufflevector <14 x i64> %16, <14 x i64> poison, <14 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13>
  store <14 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 2
  %17 = icmp eq i64 %index.next, 1024
  br i1 %17, label %middle.block, label %vector.body, !llvm.loop !9

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 3
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <16 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 0, i32 8>
  %strided.vec1 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 1, i32 9>
  %strided.vec2 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 2, i32 10>
  %strided.vec3 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 3, i32 11>
  %strided.vec4 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 4, i32 12>
  %strided.vec5 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 5, i32 13>
  %strided.vec6 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 6, i32 14>
  %strided.vec7 = shufflevector <16 x i64> %wide.vec, <16 x i64> poison, <2 x i32> <i32 7, i32 15>
  %2 = add <2 x i64> %strided.vec, splat (i64 1)
  %3 = add <2 x i64> %strided.vec1, splat (i64 2)
  %4 = add <2 x i64> %strided.vec2, splat (i64 3)
  %5 = add <2 x i64> %strided.vec3, splat (i64 4)
  %6 = add <2 x i64> %strided.vec4, splat (i64 5)
  %7 = add <2 x i64> %strided.vec5, splat (i64 6)
  %8 = add <2 x i64> %strided.vec6, splat (i64 7)
  %9 = add <2 x i64> %strided.vec7, splat (i64 8)
  %10 = shufflevector <2 x i64> %2, <2 x i64> %3, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %11 = shufflevector <2 x i64> %4, <2 x i64> %5, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %12 = shufflevector <2 x i64> %6, <2 x i64> %7, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %13 = shufflevector <2 x i64> %8, <2 x i64> %9, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %14 = shufflevector <4 x i64> %10, <4 x i64> %11, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %15 = shufflevector <4 x i64> %12, <4 x i64> %13, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %16 = shufflevector <8 x i64> %14, <8 x i64> %15, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i64> %16, <16 x i64> poison, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  store <16 x i64> %interleaved.vec, ptr %1, align 8
  %index.next = add nuw i64 %index, 2
  %17 = icmp eq i64 %index.next, 1024
  br i1 %17, label %middle.block, label %vector.body, !llvm.loop !10

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %1 = getelementptr i32, ptr %p, i64 %0
  %wide.vec = load <16 x i32>, ptr %1, align 4
  %strided.vec = shufflevector <16 x i32> %wide.vec, <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %strided.vec1 = shufflevector <16 x i32> %wide.vec, <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %2 = add <8 x i32> %strided.vec, %strided.vec1
  %3 = getelementptr i32, ptr %q, i64 %index
  store <8 x i32> %2, ptr %3, align 4
  %index.next = add nuw i64 %index, 8
  %4 = icmp eq i64 %index.next, 1024
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !11

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
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %1 = getelementptr i64, ptr %p, i64 %0
  %wide.vec = load <8 x i64>, ptr %1, align 8
  %strided.vec = shufflevector <8 x i64> %wide.vec, <8 x i64> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %strided.vec1 = shufflevector <8 x i64> %wide.vec, <8 x i64> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %2 = add <4 x i64> %strided.vec, %strided.vec1
  %3 = getelementptr i64, ptr %q, i64 %index
  store <4 x i64> %2, ptr %3, align 8
  %index.next = add nuw i64 %index, 4
  %4 = icmp eq i64 %index.next, 1024
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

attributes #0 = { "target-features"="+v" }

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
