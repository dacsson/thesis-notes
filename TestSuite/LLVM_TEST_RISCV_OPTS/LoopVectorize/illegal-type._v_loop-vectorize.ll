; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/illegal-type.ll
; Variant: +v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mattr=+v -force-vector-width=4 -scalable-vectorization=on -S
; Original: RUN: opt < %s -passes=loop-vectorize -mattr=+v -force-vector-width=4 -scalable-vectorization=on -S 2>&1 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

target triple = "riscv64-linux-gnu"

define void @loop_i128(ptr nocapture %ptr, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, ptr %ptr, i64 %iv
  %0 = load i128, ptr %arrayidx, align 16
  %add = add nsw i128 %0, 42
  store i128 %add, ptr %arrayidx, align 16
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @loop_f128(ptr nocapture %ptr, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds fp128, ptr %ptr, i64 %iv
  %0 = load fp128, ptr %arrayidx, align 16
  %add = fsub fp128 %0, 0xL00000000000000008000000000000000
  store fp128 %add, ptr %arrayidx, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @loop_invariant_i128(ptr nocapture %ptr, i128 %val, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, ptr %ptr, i64 %iv
  store i128 %val, ptr %arrayidx, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @uniform_store_i1(ptr noalias %dst, ptr noalias %start, i64 %N) {
entry:
  br label %for.body

for.body:
  %first.sroa = phi ptr [ %incdec.ptr, %for.body ], [ %start, %entry ]
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i64 %iv, 1
  %incdec.ptr = getelementptr inbounds i64, ptr %first.sroa, i64 1
  %cmp.not = icmp eq ptr %incdec.ptr, %start
  store i1 %cmp.not, ptr %dst
  %cmp = icmp ult i64 %iv, %N
  br i1 %cmp, label %for.body, label %end, !llvm.loop !0

end:
  ret void
}

define void @loop_fixed_width_i128(ptr nocapture %ptr, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, ptr %ptr, i64 %iv
  %0 = load i128, ptr %arrayidx, align 16
  %add = add nsw i128 %0, 42
  store i128 %add, ptr %arrayidx, align 16
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmps4r9lb9s.ll'
source_filename = "/tmp/tmps4r9lb9s.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-linux-gnu"

define void @loop_i128(ptr captures(none) %ptr, i64 %N) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, ptr %ptr, i64 %iv
  %0 = load i128, ptr %arrayidx, align 16
  %add = add nsw i128 %0, 42
  store i128 %add, ptr %arrayidx, align 16
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:                                          ; preds = %for.body
  ret void
}

define void @loop_f128(ptr captures(none) %ptr, i64 %N) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds fp128, ptr %ptr, i64 %iv
  %0 = load fp128, ptr %arrayidx, align 16
  %add = fsub fp128 %0, -0.000000e+00
  store fp128 %add, ptr %arrayidx, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:                                          ; preds = %for.body
  ret void
}

define void @loop_invariant_i128(ptr captures(none) %ptr, i128 %val, i64 %N) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, ptr %ptr, i64 %iv
  store i128 %val, ptr %arrayidx, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:                                          ; preds = %for.body
  ret void
}

define void @uniform_store_i1(ptr noalias %dst, ptr noalias %start, i64 %N) #0 {
entry:
  %0 = add i64 %N, 1
  %min.iters.check = icmp ult i64 %0, 32
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %0, 32
  %n.vec = sub i64 %0, %n.mod.vf
  %1 = shl i64 %n.vec, 3
  %2 = getelementptr i8, ptr %start, i64 %1
  %broadcast.splatinsert = insertelement <32 x ptr> poison, ptr %start, i64 0
  %broadcast.splat = shufflevector <32 x ptr> %broadcast.splatinsert, <32 x ptr> poison, <32 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %pointer.phi = phi ptr [ %start, %vector.ph ], [ %ptr.ind, %vector.body ]
  %vector.gep = getelementptr i8, ptr %pointer.phi, <32 x i64> <i64 0, i64 8, i64 16, i64 24, i64 32, i64 40, i64 48, i64 56, i64 64, i64 72, i64 80, i64 88, i64 96, i64 104, i64 112, i64 120, i64 128, i64 136, i64 144, i64 152, i64 160, i64 168, i64 176, i64 184, i64 192, i64 200, i64 208, i64 216, i64 224, i64 232, i64 240, i64 248>
  %3 = getelementptr inbounds i64, <32 x ptr> %vector.gep, i64 1
  %4 = icmp eq <32 x ptr> %3, %broadcast.splat
  %5 = extractelement <32 x i1> %4, i64 31
  store i1 %5, ptr %dst, align 1
  %index.next = add nuw i64 %index, 32
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 256
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !2

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %0, %n.vec
  br i1 %cmp.n, label %end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi ptr [ %2, %middle.block ], [ %start, %entry ]
  %bc.resume.val1 = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %first.sroa = phi ptr [ %incdec.ptr, %for.body ], [ %bc.resume.val, %scalar.ph ]
  %iv = phi i64 [ %iv.next, %for.body ], [ %bc.resume.val1, %scalar.ph ]
  %iv.next = add i64 %iv, 1
  %incdec.ptr = getelementptr inbounds i64, ptr %first.sroa, i64 1
  %cmp.not = icmp eq ptr %incdec.ptr, %start
  store i1 %cmp.not, ptr %dst, align 1
  %cmp = icmp ult i64 %iv, %N
  br i1 %cmp, label %for.body, label %end, !llvm.loop !5

end:                                              ; preds = %middle.block, %for.body
  ret void
}

define void @loop_fixed_width_i128(ptr captures(none) %ptr, i64 %N) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, ptr %ptr, i64 %iv
  %0 = load i128, ptr %arrayidx, align 16
  %add = add nsw i128 %0, 42
  store i128 %add, ptr %arrayidx, align 16
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

attributes #0 = { "target-features"="+v" }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}
!2 = distinct !{!2, !3, !4}
!3 = !{!"llvm.loop.isvectorized", i32 1}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
!5 = distinct !{!5, !4, !3}
