; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/divrem.ll
; Variant: riscv64-linux-gnu_+v,+f,+m_loop-vectorize_FIXED
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=off -mtriple riscv64-linux-gnu -mattr=+v,+f,+m -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=off -mtriple riscv64-linux-gnu -mattr=+v,+f,+m -S 2>%t | FileCheck --check-prefix=FIXED %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Tests specific to div/rem handling - both predicated and not

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

define void @vector_udiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = udiv i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @vector_sdiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = sdiv i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @vector_urem(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = urem i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @vector_srem(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %divrem = srem i64 %elem, %v
  store i64 %divrem, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_udiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %v, 0
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = udiv i64 %elem, %v
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_sdiv(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %v, 0
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = sdiv i64 %elem, %v
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_udiv_by_constant(ptr noalias nocapture %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %elem, 42
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = udiv i64 %elem, 27
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_sdiv_by_constant(ptr noalias nocapture %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %c = icmp ne i64 %elem, 42
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = sdiv i64 %elem, 27
  br label %latch
latch:
  %phi = phi i64 [%elem, %for.body], [%divrem, %do_op]
  store i64 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @predicated_sdiv_by_minus_one(ptr noalias nocapture %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %iv
  %elem = load i8, ptr %arrayidx
  %c = icmp ne i8 %elem, 128
  br i1 %c, label %do_op, label %latch
do_op:
  %divrem = sdiv i8 %elem, -1 ;; UB if %elem = INT_MIN
  br label %latch
latch:
  %phi = phi i8 [%elem, %for.body], [%divrem, %do_op]
  store i8 %phi, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; Test for https://github.com/llvm/llvm-project/issues/159402. For invariant divisors,
; selects can be introduced outside the vector loop and their cost should not be
; considered for each loop iteration.
define void @udiv_sdiv_with_invariant_divisors(i8 %x, i16 %y, i1 %c, ptr %p) {
entry:
  br label %loop.header

loop.header:
  %iv = phi i16 [ -12, %entry ], [ %iv.next, %loop.latch ]
  %narrow.iv = phi i8 [ -12, %entry ], [ %iv.next.trunc, %loop.latch ]
  br i1 %c, label %loop.latch, label %then

then:
  %ud = udiv i8 %narrow.iv, %x
  %ud.ext = zext i8 %ud to i16
  %sd = sdiv i16 %ud.ext, %y
  %sd.ext = sext i16 %sd to i32
  br label %loop.latch

loop.latch:
  %merge = phi i32 [ 0, %loop.header ], [ %sd.ext, %then ]
  store i32 %merge, ptr %p, align 4
  %iv.next = add nsw i16 %iv, 1
  %ec = icmp eq i16 %iv.next, 0
  %iv.next.trunc = trunc i16 %iv.next to i8
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpzulbwp8g.ll'
source_filename = "/tmp/tmpzulbwp8g.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @vector_udiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 8
  %1 = udiv <4 x i64> %wide.load, %broadcast.splat
  store <4 x i64> %1, ptr %0, align 8
  %index.next = add nuw i64 %index, 4
  %2 = icmp eq i64 %index.next, 1024
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_sdiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 8
  %1 = sdiv <4 x i64> %wide.load, %broadcast.splat
  store <4 x i64> %1, ptr %0, align 8
  %index.next = add nuw i64 %index, 4
  %2 = icmp eq i64 %index.next, 1024
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_urem(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 8
  %1 = urem <4 x i64> %wide.load, %broadcast.splat
  store <4 x i64> %1, ptr %0, align 8
  %index.next = add nuw i64 %index, 4
  %2 = icmp eq i64 %index.next, 1024
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_srem(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 8
  %1 = srem <4 x i64> %wide.load, %broadcast.splat
  store <4 x i64> %1, ptr %0, align 8
  %index.next = add nuw i64 %index, 4
  %2 = icmp eq i64 %index.next, 1024
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_udiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  %0 = icmp ne <4 x i64> %broadcast.splat, zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %1, align 8
  %2 = call <4 x i64> @llvm.masked.udiv.v4i64(<4 x i64> %wide.load, <4 x i64> %broadcast.splat, <4 x i1> %0)
  %3 = extractelement <4 x i1> %0, i64 0
  %predphi = select i1 %3, <4 x i64> %2, <4 x i64> %wide.load
  store <4 x i64> %predphi, ptr %1, align 8
  %index.next = add nuw i64 %index, 4
  %4 = icmp eq i64 %index.next, 1024
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_sdiv(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> poison, <4 x i32> zeroinitializer
  %0 = icmp ne <4 x i64> %broadcast.splat, zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %1, align 8
  %2 = call <4 x i64> @llvm.masked.sdiv.v4i64(<4 x i64> %wide.load, <4 x i64> %broadcast.splat, <4 x i1> %0)
  %3 = extractelement <4 x i1> %0, i64 0
  %predphi = select i1 %3, <4 x i64> %2, <4 x i64> %wide.load
  store <4 x i64> %predphi, ptr %1, align 8
  %index.next = add nuw i64 %index, 4
  %4 = icmp eq i64 %index.next, 1024
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_udiv_by_constant(ptr noalias captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 8
  %1 = icmp ne <4 x i64> %wide.load, splat (i64 42)
  %2 = udiv <4 x i64> %wide.load, splat (i64 27)
  %predphi = select <4 x i1> %1, <4 x i64> %2, <4 x i64> %wide.load
  store <4 x i64> %predphi, ptr %0, align 8
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_sdiv_by_constant(ptr noalias captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i64, ptr %a, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 8
  %1 = icmp ne <4 x i64> %wide.load, splat (i64 42)
  %2 = sdiv <4 x i64> %wide.load, splat (i64 27)
  %predphi = select <4 x i1> %1, <4 x i64> %2, <4 x i64> %wide.load
  store <4 x i64> %predphi, ptr %0, align 8
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @predicated_sdiv_by_minus_one(ptr noalias captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i8, ptr %a, i64 %index
  %wide.load = load <32 x i8>, ptr %0, align 1
  %1 = icmp ne <32 x i8> %wide.load, splat (i8 -128)
  %2 = call <32 x i8> @llvm.masked.sdiv.v32i8(<32 x i8> %wide.load, <32 x i8> splat (i8 -1), <32 x i1> %1)
  %predphi = select <32 x i1> %1, <32 x i8> %2, <32 x i8> %wide.load
  store <32 x i8> %predphi, ptr %0, align 1
  %index.next = add nuw i64 %index, 32
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @udiv_sdiv_with_invariant_divisors(i8 %x, i16 %y, i1 %c, ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <4 x i1> poison, i1 %c, i64 0
  %broadcast.splat = shufflevector <4 x i1> %broadcast.splatinsert, <4 x i1> poison, <4 x i32> zeroinitializer
  %0 = xor <4 x i1> %broadcast.splat, splat (i1 true)
  %broadcast.splatinsert1 = insertelement <4 x i8> poison, i8 %x, i64 0
  %broadcast.splat2 = shufflevector <4 x i8> %broadcast.splatinsert1, <4 x i8> poison, <4 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <4 x i16> poison, i16 %y, i64 0
  %broadcast.splat4 = shufflevector <4 x i16> %broadcast.splatinsert3, <4 x i16> poison, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i8> [ <i8 -12, i8 -11, i8 -10, i8 -9>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %1 = call <4 x i8> @llvm.masked.udiv.v4i8(<4 x i8> %vec.ind, <4 x i8> %broadcast.splat2, <4 x i1> %0)
  %2 = zext <4 x i8> %1 to <4 x i16>
  %3 = call <4 x i16> @llvm.masked.sdiv.v4i16(<4 x i16> %2, <4 x i16> %broadcast.splat4, <4 x i1> %0)
  %4 = sext <4 x i16> %3 to <4 x i32>
  %predphi = select i1 %c, <4 x i32> zeroinitializer, <4 x i32> %4
  %5 = extractelement <4 x i32> %predphi, i64 3
  store i32 %5, ptr %p, align 4
  %index.next = add nuw i32 %index, 4
  %vec.ind.next = add <4 x i8> %vec.ind, splat (i8 4)
  %6 = icmp eq i32 %index.next, 12
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x i64> @llvm.masked.udiv.v4i64(<4 x i64>, <4 x i64>, <4 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x i64> @llvm.masked.sdiv.v4i64(<4 x i64>, <4 x i64>, <4 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <32 x i8> @llvm.masked.sdiv.v32i8(<32 x i8>, <32 x i8>, <32 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x i8> @llvm.masked.udiv.v4i8(<4 x i8>, <4 x i8>, <4 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x i16> @llvm.masked.sdiv.v4i16(<4 x i16>, <4 x i16>, <4 x i1>) #1

attributes #0 = { "target-features"="+v,+f,+m" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }

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
