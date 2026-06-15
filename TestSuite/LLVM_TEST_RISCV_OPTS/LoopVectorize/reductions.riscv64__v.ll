; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/reductions.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S
; Original: RUN: opt < %s -p loop-vectorize -mtriple riscv64 -mattr=+v -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Reduction can be vectorized

; ADD

define i32 @add(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi i32 [ 2, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %add
}

define i32 @sub(ptr %a, i64 %n) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %rdx = phi i32 [ 1024, %entry ], [ %sub, %loop ]
  %gep = getelementptr i32, ptr %a, i64 %iv
  %x = load i32, ptr %gep
  %sub = sub i32 %rdx, %x
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, %n
  br i1 %done, label %exit, label %loop

exit:
  ret i32 %sub
}

define i32 @addsub(ptr %a, ptr %b, i64 %n) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %rdx = phi i32 [ 0, %entry ], [ %sub, %loop ]
  %gep.a = getelementptr i32, ptr %a, i64 %iv
  %x = load i32, ptr %gep.a
  %add = add i32 %rdx, %x
  %gep.b = getelementptr i32, ptr %b, i64 %iv
  %y = load i32, ptr %gep.b
  %sub = sub i32 %add, %y
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, %n
  br i1 %done, label %exit, label %loop

exit:
  ret i32 %sub
}


; OR

define i32 @or(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi i32 [ 2, %entry ], [ %or, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %or = or i32 %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %or
}

; AND

define i32 @and(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi i32 [ 2, %entry ], [ %and, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %and = and i32 %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %and
}

; XOR

define i32 @xor(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi i32 [ 2, %entry ], [ %xor, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %xor = xor i32 %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %xor
}

; SMIN

define i32 @smin(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.010 = phi i32 [ 2, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp slt i32 %0, %sum.010
  %.sroa.speculated = select i1 %cmp.i, i32 %0, i32 %sum.010
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %.sroa.speculated
}

; UMAX

define i32 @umax(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.010 = phi i32 [ 2, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp.i = icmp ugt i32 %0, %sum.010
  %.sroa.speculated = select i1 %cmp.i, i32 %0, i32 %sum.010
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %.sroa.speculated
}

; FADD (FAST)

define float @fadd_fast(ptr noalias nocapture readonly %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0.000000e+00, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %add = fadd fast float %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret float %add
}

define half @fadd_fast_half_zvfh(ptr noalias nocapture readonly %a, i64 %n) "target-features"="+zvfh" {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ 0.000000e+00, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %0 = load half, ptr %arrayidx, align 4
  %add = fadd fast half %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret half %add
}

define half @fadd_fast_half_zvfhmin(ptr noalias nocapture readonly %a, i64 %n) "target-features"="+zvfhmin" {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ 0.000000e+00, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %0 = load half, ptr %arrayidx, align 4
  %add = fadd fast half %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret half %add
}

define bfloat @fadd_fast_bfloat(ptr noalias nocapture readonly %a, i64 %n) "target-features"="+zvfbfmin" {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi bfloat [ 0.000000e+00, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds bfloat, ptr %a, i64 %iv
  %0 = load bfloat, ptr %arrayidx, align 4
  %add = fadd fast bfloat %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret bfloat %add
}

; FMIN (FAST)

define float @fmin_fast(ptr noalias nocapture readonly %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0.000000e+00, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %cmp.i = fcmp nnan nsz olt float %0, %sum.07
  %.sroa.speculated = select nnan nsz i1 %cmp.i, float %0, float %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret float %.sroa.speculated
}

define half @fmin_fast_half_zvfhmin(ptr noalias nocapture readonly %a, i64 %n) #0 {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ 0.000000e+00, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %0 = load half, ptr %arrayidx, align 4
  %cmp.i = fcmp nnan nsz olt half %0, %sum.07
  %.sroa.speculated = select nnan nsz i1 %cmp.i, half %0, half %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret half %.sroa.speculated
}

define bfloat @fmin_fast_bfloat_zvfbfmin(ptr noalias nocapture readonly %a, i64 %n) #1 {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi bfloat [ 0.000000e+00, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds bfloat, ptr %a, i64 %iv
  %0 = load bfloat, ptr %arrayidx, align 4
  %cmp.i = fcmp nnan nsz olt bfloat %0, %sum.07
  %.sroa.speculated = select nnan nsz i1 %cmp.i, bfloat %0, bfloat %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret bfloat %.sroa.speculated
}

; FMAX (FAST)

define float @fmax_fast(ptr noalias nocapture readonly %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0.000000e+00, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %cmp.i = fcmp fast ogt float %0, %sum.07
  %.sroa.speculated = select nnan nsz i1 %cmp.i, float %0, float %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret float %.sroa.speculated
}

define half @fmax_fast_half_zvfhmin(ptr noalias nocapture readonly %a, i64 %n) #0 {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ 0.000000e+00, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %0 = load half, ptr %arrayidx, align 4
  %cmp.i = fcmp fast ogt half %0, %sum.07
  %.sroa.speculated = select nnan nsz i1 %cmp.i, half %0, half %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret half %.sroa.speculated
}

define bfloat @fmax_fast_bfloat_zvfbfmin(ptr noalias nocapture readonly %a, i64 %n) #1 {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi bfloat [ 0.000000e+00, %entry ], [ %.sroa.speculated, %for.body ]
  %arrayidx = getelementptr inbounds bfloat, ptr %a, i64 %iv
  %0 = load bfloat, ptr %arrayidx, align 4
  %cmp.i = fcmp fast ogt bfloat %0, %sum.07
  %.sroa.speculated = select nnan nsz i1 %cmp.i, bfloat %0, bfloat %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret bfloat %.sroa.speculated
}

; Reduction cannot be vectorized

; MUL

define i32 @mul(ptr nocapture %a, ptr nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi i32 [ 2, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %mul = mul nsw i32 %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %mul
}

; Note: This test was added to ensure we always check the legality of reductions before checking for memory dependencies
define i32 @memory_dependence(ptr noalias nocapture %a, ptr noalias nocapture readonly %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %i = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %sum = phi i32 [ %mul, %for.body ], [ 2, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %i
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i64 %i
  %1 = load i32, ptr %arrayidx1, align 4
  %add = add nsw i32 %1, %0
  %add2 = add nuw nsw i64 %i, 32
  %arrayidx3 = getelementptr inbounds i32, ptr %a, i64 %add2
  store i32 %add, ptr %arrayidx3, align 4
  %mul = mul nsw i32 %1, %sum
  %inc = add nuw nsw i64 %i, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i32 %mul
}

define float @fmuladd(ptr %a, ptr %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0.000000e+00, %entry ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds float, ptr %b, i64 %iv
  %1 = load float, ptr %arrayidx2, align 4
  %muladd = tail call reassoc float @llvm.fmuladd.f32(float %0, float %1, float %sum.07)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret float %muladd
}

define half @fmuladd_f16_zvfh(ptr %a, ptr %b, i64 %n) "target-features"="+zvfh" {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ 0.000000e+00, %entry ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %0 = load half, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds half, ptr %b, i64 %iv
  %1 = load half, ptr %arrayidx2, align 4
  %muladd = tail call reassoc half @llvm.fmuladd.f16(half %0, half %1, half %sum.07)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret half %muladd
}


; We can't scalably vectorize reductions of f16 with zvfhmin or bf16 with zvfbfmin, so make sure we use fixed-length vectors instead.

define half @fmuladd_f16_zvfhmin(ptr %a, ptr %b, i64 %n) "target-features"="+zvfhmin" {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ 0.000000e+00, %entry ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %0 = load half, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds half, ptr %b, i64 %iv
  %1 = load half, ptr %arrayidx2, align 4
  %muladd = tail call reassoc half @llvm.fmuladd.f16(half %0, half %1, half %sum.07)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret half %muladd
}

define bfloat @fmuladd_bf16(ptr %a, ptr %b, i64 %n) "target-features"="+zvfbfmin" {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi bfloat [ 0.000000e+00, %entry ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds bfloat, ptr %a, i64 %iv
  %0 = load bfloat, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds bfloat, ptr %b, i64 %iv
  %1 = load bfloat, ptr %arrayidx2, align 4
  %muladd = tail call reassoc bfloat @llvm.fmuladd.bf16(bfloat %0, bfloat %1, bfloat %sum.07)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret bfloat %muladd
}


attributes #0 = { "target-features"="+zfhmin,+zvfhmin"}
attributes #1 = { "target-features"="+zfbfmin,+zvfbfmin"}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpk_p1tp02.ll'
source_filename = "/tmp/tmpk_p1tp02.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @add(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ insertelement (<vscale x 4 x i32> zeroinitializer, i32 2, i32 0), %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %2, <vscale x 4 x i32> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %6 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %3)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %6
}

define i32 @sub(ptr %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ insertelement (<vscale x 4 x i32> zeroinitializer, i32 1024, i32 0), %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = sub <vscale x 4 x i32> %vec.phi, %vp.op.load
  %3 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %2, <vscale x 4 x i32> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  %6 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %3)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %6
}

define i32 @addsub(ptr %a, ptr %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ zeroinitializer, %vector.ph ], [ %5, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 4 x i32> %vec.phi, %vp.op.load
  %3 = getelementptr i32, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %4 = sub <vscale x 4 x i32> %2, %vp.op.load1
  %5 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %4, <vscale x 4 x i32> %vec.phi, i32 %0)
  %6 = zext i32 %0 to i64
  %current.iteration.next = add i64 %6, %index
  %avl.next = sub nuw i64 %avl, %6
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %8 = call i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32> %5)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %8
}

define i32 @or(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ insertelement (<vscale x 4 x i32> zeroinitializer, i32 2, i32 0), %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = or <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %2, <vscale x 4 x i32> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %6 = call i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32> %3)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %6
}

define i32 @and(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ insertelement (<vscale x 4 x i32> splat (i32 -1), i32 2, i32 0), %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = and <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %2, <vscale x 4 x i32> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %6 = call i32 @llvm.vector.reduce.and.nxv4i32(<vscale x 4 x i32> %3)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %6
}

define i32 @xor(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ insertelement (<vscale x 4 x i32> zeroinitializer, i32 2, i32 0), %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = xor <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %2, <vscale x 4 x i32> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %6 = call i32 @llvm.vector.reduce.xor.nxv4i32(<vscale x 4 x i32> %3)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %6
}

define i32 @smin(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ splat (i32 2), %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp slt <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.smin.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define i32 @umax(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x i32> [ splat (i32 2), %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = icmp ugt <vscale x 4 x i32> %vp.op.load, %vec.phi
  %3 = select <vscale x 4 x i1> %2, <vscale x 4 x i32> %vp.op.load, <vscale x 4 x i32> %vec.phi
  %4 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %3, <vscale x 4 x i32> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.umax.nxv4i32(<vscale x 4 x i32> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i32 %7
}

define float @fadd_fast(ptr noalias readonly captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fadd fast <vscale x 4 x float> %vp.op.load, %vec.phi
  %3 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %2, <vscale x 4 x float> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %6 = call fast float @llvm.vector.reduce.fadd.nxv4f32(float 0.000000e+00, <vscale x 4 x float> %3)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %6
}

define half @fadd_fast_half_zvfh(ptr noalias readonly captures(none) %a, i64 %n) #1 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 8 x half> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr inbounds half, ptr %a, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = fadd fast <vscale x 8 x half> %vp.op.load, %vec.phi
  %3 = call <vscale x 8 x half> @llvm.vp.merge.nxv8f16(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x half> %2, <vscale x 8 x half> %vec.phi, i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  %6 = call fast half @llvm.vector.reduce.fadd.nxv8f16(half 0.000000e+00, <vscale x 8 x half> %3)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret half %6
}

define half @fadd_fast_half_zvfhmin(ptr noalias readonly captures(none) %a, i64 %n) #2 {
entry:
  %min.iters.check = icmp ult i64 %n, 32
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 32
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x half> [ zeroinitializer, %vector.ph ], [ %2, %vector.body ]
  %vec.phi1 = phi <16 x half> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds half, ptr %a, i64 %index
  %1 = getelementptr inbounds half, ptr %0, i64 16
  %wide.load = load <16 x half>, ptr %0, align 4
  %wide.load2 = load <16 x half>, ptr %1, align 4
  %2 = fadd fast <16 x half> %wide.load, %vec.phi
  %3 = fadd fast <16 x half> %wide.load2, %vec.phi1
  %index.next = add nuw i64 %index, 32
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %bin.rdx = fadd fast <16 x half> %3, %2
  %5 = call fast half @llvm.vector.reduce.fadd.v16f16(half 0.000000e+00, <16 x half> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi half [ %5, %middle.block ], [ 0.000000e+00, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %6 = load half, ptr %arrayidx, align 4
  %add = fadd fast half %6, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !13

for.end:                                          ; preds = %middle.block, %for.body
  %add.lcssa = phi half [ %add, %for.body ], [ %5, %middle.block ]
  ret half %add.lcssa
}

define bfloat @fadd_fast_bfloat(ptr noalias readonly captures(none) %a, i64 %n) #3 {
entry:
  %min.iters.check = icmp ult i64 %n, 32
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 32
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x bfloat> [ zeroinitializer, %vector.ph ], [ %2, %vector.body ]
  %vec.phi1 = phi <16 x bfloat> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds bfloat, ptr %a, i64 %index
  %1 = getelementptr inbounds bfloat, ptr %0, i64 16
  %wide.load = load <16 x bfloat>, ptr %0, align 4
  %wide.load2 = load <16 x bfloat>, ptr %1, align 4
  %2 = fadd fast <16 x bfloat> %wide.load, %vec.phi
  %3 = fadd fast <16 x bfloat> %wide.load2, %vec.phi1
  %index.next = add nuw i64 %index, 32
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %bin.rdx = fadd fast <16 x bfloat> %3, %2
  %5 = call fast bfloat @llvm.vector.reduce.fadd.v16bf16(bfloat 0.000000e+00, <16 x bfloat> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi bfloat [ %5, %middle.block ], [ 0.000000e+00, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %sum.07 = phi bfloat [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds bfloat, ptr %a, i64 %iv
  %6 = load bfloat, ptr %arrayidx, align 4
  %add = fadd fast bfloat %6, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !15

for.end:                                          ; preds = %middle.block, %for.body
  %add.lcssa = phi bfloat [ %add, %for.body ], [ %5, %middle.block ]
  ret bfloat %add.lcssa
}

define float @fmin_fast(ptr noalias readonly captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp nnan nsz olt <vscale x 4 x float> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 4 x i1> %2, <vscale x 4 x float> %vp.op.load, <vscale x 4 x float> %vec.phi
  %4 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %3, <vscale x 4 x float> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %7 = call nnan nsz float @llvm.vector.reduce.fmin.nxv4f32(<vscale x 4 x float> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %7
}

define half @fmin_fast_half_zvfhmin(ptr noalias readonly captures(none) %a, i64 %n) #4 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 8 x half> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr inbounds half, ptr %a, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = fcmp nnan nsz olt <vscale x 8 x half> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 8 x i1> %2, <vscale x 8 x half> %vp.op.load, <vscale x 8 x half> %vec.phi
  %4 = call <vscale x 8 x half> @llvm.vp.merge.nxv8f16(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x half> %3, <vscale x 8 x half> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !17

middle.block:                                     ; preds = %vector.body
  %7 = call nnan nsz half @llvm.vector.reduce.fmin.nxv8f16(<vscale x 8 x half> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret half %7
}

define bfloat @fmin_fast_bfloat_zvfbfmin(ptr noalias readonly captures(none) %a, i64 %n) #5 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 8 x bfloat> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr inbounds bfloat, ptr %a, i64 %index
  %vp.op.load = call <vscale x 8 x bfloat> @llvm.vp.load.nxv8bf16.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = fcmp nnan nsz olt <vscale x 8 x bfloat> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 8 x i1> %2, <vscale x 8 x bfloat> %vp.op.load, <vscale x 8 x bfloat> %vec.phi
  %4 = call <vscale x 8 x bfloat> @llvm.vp.merge.nxv8bf16(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x bfloat> %3, <vscale x 8 x bfloat> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  %7 = call nnan nsz bfloat @llvm.vector.reduce.fmin.nxv8bf16(<vscale x 8 x bfloat> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret bfloat %7
}

define float @fmax_fast(ptr noalias readonly captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast ogt <vscale x 4 x float> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 4 x i1> %2, <vscale x 4 x float> %vp.op.load, <vscale x 4 x float> %vec.phi
  %4 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %3, <vscale x 4 x float> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !19

middle.block:                                     ; preds = %vector.body
  %7 = call fast float @llvm.vector.reduce.fmax.nxv4f32(<vscale x 4 x float> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %7
}

define half @fmax_fast_half_zvfhmin(ptr noalias readonly captures(none) %a, i64 %n) #4 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 8 x half> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr inbounds half, ptr %a, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast ogt <vscale x 8 x half> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 8 x i1> %2, <vscale x 8 x half> %vp.op.load, <vscale x 8 x half> %vec.phi
  %4 = call <vscale x 8 x half> @llvm.vp.merge.nxv8f16(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x half> %3, <vscale x 8 x half> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  %7 = call fast half @llvm.vector.reduce.fmax.nxv8f16(<vscale x 8 x half> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret half %7
}

define bfloat @fmax_fast_bfloat_zvfbfmin(ptr noalias readonly captures(none) %a, i64 %n) #5 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 8 x bfloat> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr inbounds bfloat, ptr %a, i64 %index
  %vp.op.load = call <vscale x 8 x bfloat> @llvm.vp.load.nxv8bf16.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = fcmp fast ogt <vscale x 8 x bfloat> %vp.op.load, %vec.phi
  %3 = select nnan nsz <vscale x 8 x i1> %2, <vscale x 8 x bfloat> %vp.op.load, <vscale x 8 x bfloat> %vec.phi
  %4 = call <vscale x 8 x bfloat> @llvm.vp.merge.nxv8bf16(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x bfloat> %3, <vscale x 8 x bfloat> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !21

middle.block:                                     ; preds = %vector.body
  %7 = call fast bfloat @llvm.vector.reduce.fmax.nxv8bf16(<vscale x 8 x bfloat> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret bfloat %7
}

define i32 @mul(ptr captures(none) %a, ptr readonly captures(none) %b, i64 %n) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 16
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 16
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x i32> [ <i32 2, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, %vector.ph ], [ %2, %vector.body ]
  %vec.phi1 = phi <8 x i32> [ splat (i32 1), %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds i32, ptr %a, i64 %index
  %1 = getelementptr inbounds i32, ptr %0, i64 8
  %wide.load = load <8 x i32>, ptr %0, align 4
  %wide.load2 = load <8 x i32>, ptr %1, align 4
  %2 = mul <8 x i32> %wide.load, %vec.phi
  %3 = mul <8 x i32> %wide.load2, %vec.phi1
  %index.next = add nuw i64 %index, 16
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  %bin.rdx = mul <8 x i32> %3, %2
  %5 = call i32 @llvm.vector.reduce.mul.v8i32(<8 x i32> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %5, %middle.block ], [ 2, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %sum.07 = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %6 = load i32, ptr %arrayidx, align 4
  %mul = mul nsw i32 %6, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !23

for.end:                                          ; preds = %middle.block, %for.body
  %mul.lcssa = phi i32 [ %mul, %for.body ], [ %5, %middle.block ]
  ret i32 %mul.lcssa
}

define i32 @memory_dependence(ptr noalias captures(none) %a, ptr noalias readonly captures(none) %b, i64 %n) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 8
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 8
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x i32> [ <i32 2, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, %vector.ph ], [ %5, %vector.body ]
  %0 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <8 x i32>, ptr %0, align 4
  %1 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load1 = load <8 x i32>, ptr %1, align 4
  %2 = add nsw <8 x i32> %wide.load1, %wide.load
  %3 = add nuw nsw i64 %index, 32
  %4 = getelementptr inbounds i32, ptr %a, i64 %3
  store <8 x i32> %2, ptr %4, align 4
  %5 = mul <8 x i32> %wide.load1, %vec.phi
  %index.next = add nuw i64 %index, 8
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !24

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.vector.reduce.mul.v8i32(<8 x i32> %5)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi i32 [ %7, %middle.block ], [ 2, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %i = phi i64 [ %inc, %for.body ], [ %bc.resume.val, %scalar.ph ]
  %sum = phi i32 [ %mul, %for.body ], [ %bc.merge.rdx, %scalar.ph ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %i
  %8 = load i32, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i64 %i
  %9 = load i32, ptr %arrayidx1, align 4
  %add = add nsw i32 %9, %8
  %add2 = add nuw nsw i64 %i, 32
  %arrayidx3 = getelementptr inbounds i32, ptr %a, i64 %add2
  store i32 %add, ptr %arrayidx3, align 4
  %mul = mul nsw i32 %9, %sum
  %inc = add nuw nsw i64 %i, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !25

for.end:                                          ; preds = %middle.block, %for.body
  %mul.lcssa = phi i32 [ %mul, %for.body ], [ %7, %middle.block ]
  ret i32 %mul.lcssa
}

define float @fmuladd(ptr %a, ptr %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 4 x float> [ insertelement (<vscale x 4 x float> splat (float -0.000000e+00), float 0.000000e+00, i32 0), %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr inbounds float, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %2, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %3 = call reassoc <vscale x 4 x float> @llvm.fmuladd.nxv4f32(<vscale x 4 x float> %vp.op.load, <vscale x 4 x float> %vp.op.load1, <vscale x 4 x float> %vec.phi)
  %4 = call <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x float> %3, <vscale x 4 x float> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !26

middle.block:                                     ; preds = %vector.body
  %7 = call reassoc float @llvm.vector.reduce.fadd.nxv4f32(float -0.000000e+00, <vscale x 4 x float> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %7
}

define half @fmuladd_f16_zvfh(ptr %a, ptr %b, i64 %n) #1 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 8 x half> [ insertelement (<vscale x 8 x half> splat (half -0.000000e+00), half 0.000000e+00, i32 0), %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr inbounds half, ptr %a, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 4 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr inbounds half, ptr %b, i64 %index
  %vp.op.load1 = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 4 %2, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %3 = call reassoc <vscale x 8 x half> @llvm.fmuladd.nxv8f16(<vscale x 8 x half> %vp.op.load, <vscale x 8 x half> %vp.op.load1, <vscale x 8 x half> %vec.phi)
  %4 = call <vscale x 8 x half> @llvm.vp.merge.nxv8f16(<vscale x 8 x i1> splat (i1 true), <vscale x 8 x half> %3, <vscale x 8 x half> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !27

middle.block:                                     ; preds = %vector.body
  %7 = call reassoc half @llvm.vector.reduce.fadd.nxv8f16(half -0.000000e+00, <vscale x 8 x half> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret half %7
}

define half @fmuladd_f16_zvfhmin(ptr %a, ptr %b, i64 %n) #2 {
entry:
  %min.iters.check = icmp ult i64 %n, 32
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 32
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x half> [ <half 0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00, half -0.000000e+00>, %vector.ph ], [ %4, %vector.body ]
  %vec.phi1 = phi <16 x half> [ splat (half -0.000000e+00), %vector.ph ], [ %5, %vector.body ]
  %0 = getelementptr inbounds half, ptr %a, i64 %index
  %1 = getelementptr inbounds half, ptr %0, i64 16
  %wide.load = load <16 x half>, ptr %0, align 4
  %wide.load2 = load <16 x half>, ptr %1, align 4
  %2 = getelementptr inbounds half, ptr %b, i64 %index
  %3 = getelementptr inbounds half, ptr %2, i64 16
  %wide.load3 = load <16 x half>, ptr %2, align 4
  %wide.load4 = load <16 x half>, ptr %3, align 4
  %4 = call reassoc <16 x half> @llvm.fmuladd.v16f16(<16 x half> %wide.load, <16 x half> %wide.load3, <16 x half> %vec.phi)
  %5 = call reassoc <16 x half> @llvm.fmuladd.v16f16(<16 x half> %wide.load2, <16 x half> %wide.load4, <16 x half> %vec.phi1)
  %index.next = add nuw i64 %index, 32
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %bin.rdx = fadd reassoc <16 x half> %5, %4
  %7 = call reassoc half @llvm.vector.reduce.fadd.v16f16(half -0.000000e+00, <16 x half> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi half [ %7, %middle.block ], [ 0.000000e+00, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %sum.07 = phi half [ %bc.merge.rdx, %scalar.ph ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds half, ptr %a, i64 %iv
  %8 = load half, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds half, ptr %b, i64 %iv
  %9 = load half, ptr %arrayidx2, align 4
  %muladd = tail call reassoc half @llvm.fmuladd.f16(half %8, half %9, half %sum.07)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !29

for.end:                                          ; preds = %middle.block, %for.body
  %muladd.lcssa = phi half [ %muladd, %for.body ], [ %7, %middle.block ]
  ret half %muladd.lcssa
}

define bfloat @fmuladd_bf16(ptr %a, ptr %b, i64 %n) #3 {
entry:
  %min.iters.check = icmp ult i64 %n, 32
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 32
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x bfloat> [ <bfloat 0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00, bfloat -0.000000e+00>, %vector.ph ], [ %4, %vector.body ]
  %vec.phi1 = phi <16 x bfloat> [ splat (bfloat -0.000000e+00), %vector.ph ], [ %5, %vector.body ]
  %0 = getelementptr inbounds bfloat, ptr %a, i64 %index
  %1 = getelementptr inbounds bfloat, ptr %0, i64 16
  %wide.load = load <16 x bfloat>, ptr %0, align 4
  %wide.load2 = load <16 x bfloat>, ptr %1, align 4
  %2 = getelementptr inbounds bfloat, ptr %b, i64 %index
  %3 = getelementptr inbounds bfloat, ptr %2, i64 16
  %wide.load3 = load <16 x bfloat>, ptr %2, align 4
  %wide.load4 = load <16 x bfloat>, ptr %3, align 4
  %4 = call reassoc <16 x bfloat> @llvm.fmuladd.v16bf16(<16 x bfloat> %wide.load, <16 x bfloat> %wide.load3, <16 x bfloat> %vec.phi)
  %5 = call reassoc <16 x bfloat> @llvm.fmuladd.v16bf16(<16 x bfloat> %wide.load2, <16 x bfloat> %wide.load4, <16 x bfloat> %vec.phi1)
  %index.next = add nuw i64 %index, 32
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !30

middle.block:                                     ; preds = %vector.body
  %bin.rdx = fadd reassoc <16 x bfloat> %5, %4
  %7 = call reassoc bfloat @llvm.vector.reduce.fadd.v16bf16(bfloat -0.000000e+00, <16 x bfloat> %bin.rdx)
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi bfloat [ %7, %middle.block ], [ 0.000000e+00, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %sum.07 = phi bfloat [ %bc.merge.rdx, %scalar.ph ], [ %muladd, %for.body ]
  %arrayidx = getelementptr inbounds bfloat, ptr %a, i64 %iv
  %8 = load bfloat, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds bfloat, ptr %b, i64 %iv
  %9 = load bfloat, ptr %arrayidx2, align 4
  %muladd = tail call reassoc bfloat @llvm.fmuladd.bf16(bfloat %8, bfloat %9, bfloat %sum.07)
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !31

for.end:                                          ; preds = %middle.block, %for.body
  %muladd.lcssa = phi bfloat [ %muladd, %for.body ], [ %7, %middle.block ]
  ret bfloat %muladd.lcssa
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare bfloat @llvm.fmuladd.bf16(bfloat, bfloat, bfloat) #6

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.fmuladd.f16(half, half, half) #6

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>, i32) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.nxv4i32(<vscale x 4 x i32>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.nxv4i32(<vscale x 4 x i32>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.and.nxv4i32(<vscale x 4 x i32>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.xor.nxv4i32(<vscale x 4 x i32>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smin.nxv4i32(<vscale x 4 x i32>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.umax.nxv4i32(<vscale x 4 x i32>) #9

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.vp.merge.nxv4f32(<vscale x 4 x i1>, <vscale x 4 x float>, <vscale x 4 x float>, i32) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.nxv4f32(float, <vscale x 4 x float>) #9

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x half> @llvm.vp.merge.nxv8f16(<vscale x 8 x i1>, <vscale x 8 x half>, <vscale x 8 x half>, i32) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.vector.reduce.fadd.nxv8f16(half, <vscale x 8 x half>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.vector.reduce.fadd.v16f16(half, <16 x half>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare bfloat @llvm.vector.reduce.fadd.v16bf16(bfloat, <16 x bfloat>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fmin.nxv4f32(<vscale x 4 x float>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.vector.reduce.fmin.nxv8f16(<vscale x 8 x half>) #9

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x bfloat> @llvm.vp.load.nxv8bf16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x bfloat> @llvm.vp.merge.nxv8bf16(<vscale x 8 x i1>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, i32) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare bfloat @llvm.vector.reduce.fmin.nxv8bf16(<vscale x 8 x bfloat>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fmax.nxv4f32(<vscale x 4 x float>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.vector.reduce.fmax.nxv8f16(<vscale x 8 x half>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare bfloat @llvm.vector.reduce.fmax.nxv8bf16(<vscale x 8 x bfloat>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.mul.v8i32(<8 x i32>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.fmuladd.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x half> @llvm.fmuladd.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x half> @llvm.fmuladd.v16f16(<16 x half>, <16 x half>, <16 x half>) #9

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x bfloat> @llvm.fmuladd.v16bf16(<16 x bfloat>, <16 x bfloat>, <16 x bfloat>) #9

attributes #0 = { "target-features"="+v" }
attributes #1 = { "target-features"="+zvfh,+v" }
attributes #2 = { "target-features"="+zvfhmin,+v" }
attributes #3 = { "target-features"="+zvfbfmin,+v" }
attributes #4 = { "target-features"="+zfhmin,+zvfhmin,+v" }
attributes #5 = { "target-features"="+zfbfmin,+zvfbfmin,+v" }
attributes #6 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #9 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

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
!13 = distinct !{!13, !2, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !2, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !1, !2}
!18 = distinct !{!18, !1, !2}
!19 = distinct !{!19, !1, !2}
!20 = distinct !{!20, !1, !2}
!21 = distinct !{!21, !1, !2}
!22 = distinct !{!22, !1, !2}
!23 = distinct !{!23, !2, !1}
!24 = distinct !{!24, !1, !2}
!25 = distinct !{!25, !2, !1}
!26 = distinct !{!26, !1, !2}
!27 = distinct !{!27, !1, !2}
!28 = distinct !{!28, !1, !2}
!29 = distinct !{!29, !2, !1}
!30 = distinct !{!30, !1, !2}
!31 = distinct !{!31, !2, !1}
