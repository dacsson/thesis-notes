; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/riscv-unroll.ll
; Variant: riscv32_+v_loop-vectorize_LMUL2
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -force-target-max-vector-interleave=1 -mtriple=riscv32 -mattr=+v -scalable-vectorization=off -riscv-v-register-bit-width-lmul=2 -S
; Original: RUN: opt < %s -passes=loop-vectorize -force-target-max-vector-interleave=1 -mtriple=riscv32 -mattr=+v -scalable-vectorization=off -riscv-v-register-bit-width-lmul=2 -S | FileCheck %s --check-prefix=LMUL2

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define ptr @array_add(ptr noalias nocapture readonly %a, ptr noalias nocapture readonly %b, ptr %c, i32 %size) {
entry:
  %cmp10 = icmp sgt i32 %size, 0
  br i1 %cmp10, label %for.body.preheader, label %for.end

for.body.preheader:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %b, i64 %indvars.iv
  %1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %1, %0
  %arrayidx4 = getelementptr inbounds i32, ptr %c, i64 %indvars.iv
  store i32 %add, ptr %arrayidx4, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %size
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:
  br label %for.end

for.end:
  ret ptr %c
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp1kwr1r_w.ll'
source_filename = "/tmp/tmp1kwr1r_w.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define ptr @array_add(ptr noalias readonly captures(none) %a, ptr noalias readonly captures(none) %b, ptr %c, i32 %size) #0 {
entry:
  %cmp10 = icmp sgt i32 %size, 0
  br i1 %cmp10, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %0 = zext i32 %size to i64
  %min.iters.check = icmp ult i64 %0, 8
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.mod.vf = urem i64 %0, 8
  %n.vec = sub i64 %0, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <8 x i32>, ptr %1, align 4
  %2 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load1 = load <8 x i32>, ptr %2, align 4
  %3 = add nsw <8 x i32> %wide.load1, %wide.load
  %4 = getelementptr inbounds i32, ptr %c, i64 %index
  store <8 x i32> %3, ptr %4, align 4
  %index.next = add nuw i64 %index, 8
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %0, %n.vec
  br i1 %cmp.n, label %for.end.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %for.body.preheader, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %for.body.preheader ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ %bc.resume.val, %scalar.ph ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %indvars.iv
  %6 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %b, i64 %indvars.iv
  %7 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %7, %6
  %arrayidx4 = getelementptr inbounds i32, ptr %c, i64 %indvars.iv
  store i32 %add, ptr %arrayidx4, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %size
  br i1 %exitcond, label %for.end.loopexit, label %for.body, !llvm.loop !3

for.end.loopexit:                                 ; preds = %middle.block, %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret ptr %c
}

attributes #0 = { "target-features"="+v" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
