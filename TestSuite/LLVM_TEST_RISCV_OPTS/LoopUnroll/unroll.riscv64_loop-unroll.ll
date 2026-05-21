; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopUnroll/RISCV/unroll.ll
; Variant: riscv64_loop-unroll
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -passes=loop-unroll -mcpu=sifive-s76 -S
; Original: RUN: opt %s -S -mtriple=riscv64 -passes=loop-unroll -mcpu=sifive-s76 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define dso_local void @saxpy(float %a, ptr %x, ptr %y) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %x, i64 %indvars.iv
  %0 = load float, ptr %arrayidx, align 4
  %mul = fmul fast float %0, %a
  %arrayidx2 = getelementptr inbounds float, ptr %y, i64 %indvars.iv
  %1 = load float, ptr %arrayidx2, align 4
  %add = fadd fast float %mul, %1
  store float %add, ptr %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 64
  br i1 %exitcond.not, label %exit_loop, label %for.body

exit_loop:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpj1wm0k1y.ll'
source_filename = "/tmp/tmpj1wm0k1y.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define dso_local void @saxpy(float %a, ptr %x, ptr %y) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.15, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %x, i64 %indvars.iv
  %0 = load float, ptr %arrayidx, align 4
  %mul = fmul fast float %0, %a
  %arrayidx2 = getelementptr inbounds float, ptr %y, i64 %indvars.iv
  %1 = load float, ptr %arrayidx2, align 4
  %add = fadd fast float %mul, %1
  store float %add, ptr %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx.1 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next
  %2 = load float, ptr %arrayidx.1, align 4
  %mul.1 = fmul fast float %2, %a
  %arrayidx2.1 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next
  %3 = load float, ptr %arrayidx2.1, align 4
  %add.1 = fadd fast float %mul.1, %3
  store float %add.1, ptr %arrayidx2.1, align 4
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %arrayidx.2 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.1
  %4 = load float, ptr %arrayidx.2, align 4
  %mul.2 = fmul fast float %4, %a
  %arrayidx2.2 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.1
  %5 = load float, ptr %arrayidx2.2, align 4
  %add.2 = fadd fast float %mul.2, %5
  store float %add.2, ptr %arrayidx2.2, align 4
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3
  %arrayidx.3 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.2
  %6 = load float, ptr %arrayidx.3, align 4
  %mul.3 = fmul fast float %6, %a
  %arrayidx2.3 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.2
  %7 = load float, ptr %arrayidx2.3, align 4
  %add.3 = fadd fast float %mul.3, %7
  store float %add.3, ptr %arrayidx2.3, align 4
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %arrayidx.4 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.3
  %8 = load float, ptr %arrayidx.4, align 4
  %mul.4 = fmul fast float %8, %a
  %arrayidx2.4 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.3
  %9 = load float, ptr %arrayidx2.4, align 4
  %add.4 = fadd fast float %mul.4, %9
  store float %add.4, ptr %arrayidx2.4, align 4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5
  %arrayidx.5 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.4
  %10 = load float, ptr %arrayidx.5, align 4
  %mul.5 = fmul fast float %10, %a
  %arrayidx2.5 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.4
  %11 = load float, ptr %arrayidx2.5, align 4
  %add.5 = fadd fast float %mul.5, %11
  store float %add.5, ptr %arrayidx2.5, align 4
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv, 6
  %arrayidx.6 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.5
  %12 = load float, ptr %arrayidx.6, align 4
  %mul.6 = fmul fast float %12, %a
  %arrayidx2.6 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.5
  %13 = load float, ptr %arrayidx2.6, align 4
  %add.6 = fadd fast float %mul.6, %13
  store float %add.6, ptr %arrayidx2.6, align 4
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv, 7
  %arrayidx.7 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.6
  %14 = load float, ptr %arrayidx.7, align 4
  %mul.7 = fmul fast float %14, %a
  %arrayidx2.7 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.6
  %15 = load float, ptr %arrayidx2.7, align 4
  %add.7 = fadd fast float %mul.7, %15
  store float %add.7, ptr %arrayidx2.7, align 4
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv, 8
  %arrayidx.8 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.7
  %16 = load float, ptr %arrayidx.8, align 4
  %mul.8 = fmul fast float %16, %a
  %arrayidx2.8 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.7
  %17 = load float, ptr %arrayidx2.8, align 4
  %add.8 = fadd fast float %mul.8, %17
  store float %add.8, ptr %arrayidx2.8, align 4
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv, 9
  %arrayidx.9 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.8
  %18 = load float, ptr %arrayidx.9, align 4
  %mul.9 = fmul fast float %18, %a
  %arrayidx2.9 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.8
  %19 = load float, ptr %arrayidx2.9, align 4
  %add.9 = fadd fast float %mul.9, %19
  store float %add.9, ptr %arrayidx2.9, align 4
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv, 10
  %arrayidx.10 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.9
  %20 = load float, ptr %arrayidx.10, align 4
  %mul.10 = fmul fast float %20, %a
  %arrayidx2.10 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.9
  %21 = load float, ptr %arrayidx2.10, align 4
  %add.10 = fadd fast float %mul.10, %21
  store float %add.10, ptr %arrayidx2.10, align 4
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv, 11
  %arrayidx.11 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.10
  %22 = load float, ptr %arrayidx.11, align 4
  %mul.11 = fmul fast float %22, %a
  %arrayidx2.11 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.10
  %23 = load float, ptr %arrayidx2.11, align 4
  %add.11 = fadd fast float %mul.11, %23
  store float %add.11, ptr %arrayidx2.11, align 4
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv, 12
  %arrayidx.12 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.11
  %24 = load float, ptr %arrayidx.12, align 4
  %mul.12 = fmul fast float %24, %a
  %arrayidx2.12 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.11
  %25 = load float, ptr %arrayidx2.12, align 4
  %add.12 = fadd fast float %mul.12, %25
  store float %add.12, ptr %arrayidx2.12, align 4
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv, 13
  %arrayidx.13 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.12
  %26 = load float, ptr %arrayidx.13, align 4
  %mul.13 = fmul fast float %26, %a
  %arrayidx2.13 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.12
  %27 = load float, ptr %arrayidx2.13, align 4
  %add.13 = fadd fast float %mul.13, %27
  store float %add.13, ptr %arrayidx2.13, align 4
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv, 14
  %arrayidx.14 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.13
  %28 = load float, ptr %arrayidx.14, align 4
  %mul.14 = fmul fast float %28, %a
  %arrayidx2.14 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.13
  %29 = load float, ptr %arrayidx2.14, align 4
  %add.14 = fadd fast float %mul.14, %29
  store float %add.14, ptr %arrayidx2.14, align 4
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv, 15
  %arrayidx.15 = getelementptr inbounds float, ptr %x, i64 %indvars.iv.next.14
  %30 = load float, ptr %arrayidx.15, align 4
  %mul.15 = fmul fast float %30, %a
  %arrayidx2.15 = getelementptr inbounds float, ptr %y, i64 %indvars.iv.next.14
  %31 = load float, ptr %arrayidx2.15, align 4
  %add.15 = fadd fast float %mul.15, %31
  store float %add.15, ptr %arrayidx2.15, align 4
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv, 16
  %exitcond.not.15 = icmp eq i64 %indvars.iv.next.15, 64
  br i1 %exitcond.not.15, label %exit_loop, label %for.body

exit_loop:                                        ; preds = %for.body
  ret void
}

attributes #0 = { "target-cpu"="sifive-s76" }
