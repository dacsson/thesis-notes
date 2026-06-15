; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopStrengthReduce/RISCV/lsr-cost-compare.ll
; Variant: loop-reduce,loop-term-fold
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-reduce,loop-term-fold -S
; Original: RUN: opt < %s -passes=loop-reduce,loop-term-fold -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

; a[] = 1.0
define void @test1(ptr %a) {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %t15 = phi i64 [ 0, %entry ], [ %t20, %loop ]
  %t19 = getelementptr inbounds [32000 x float], ptr %a, i64 0, i64 %t15
  store float 1.0, ptr %t19, align 4
  %t20 = add nuw nsw i64 %t15, 1
  %t21 = icmp eq i64 %t20, 32000
  br i1 %t21, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

; Same as test1, but with a use of a added outside the loop
define void @test2(ptr %a) {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %t15 = phi i64 [ 0, %entry ], [ %t20, %loop ]
  %t19 = getelementptr inbounds [32000 x float], ptr %a, i64 0, i64 %t15
  store float 1.0, ptr %t19, align 4
  %t20 = add nuw nsw i64 %t15, 1
  %t21 = icmp eq i64 %t20, 32000
  br i1 %t21, label %exit, label %loop

exit:                                             ; preds = %loop
  call void @use(ptr %a)
  ret void
}

; b[] = a[] + 1.0
define void @test3(ptr %a, ptr %b) {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %t15 = phi i64 [ 0, %entry ], [ %t20, %loop ]
  %t16 = getelementptr inbounds [32000 x float], ptr %a, i64 0, i64 %t15
  %t17 = load float, ptr %t16, align 4
  %t18 = fadd float %t17, 1.000000e+00
  %t19 = getelementptr inbounds [32000 x float], ptr %b, i64 0, i64 %t15
  store float %t18, ptr %t19, align 4
  %t20 = add nuw nsw i64 %t15, 1
  %t21 = icmp eq i64 %t20, 32000
  br i1 %t21, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

; Same as test3, but with a use of both a and b outside the loop
define void @test4(ptr %a, ptr %b) {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %t15 = phi i64 [ 0, %entry ], [ %t20, %loop ]
  %t16 = getelementptr inbounds [32000 x float], ptr %a, i64 0, i64 %t15
  %t17 = load float, ptr %t16, align 4
  %t18 = fadd float %t17, 1.000000e+00
  %t19 = getelementptr inbounds [32000 x float], ptr %b, i64 0, i64 %t15
  store float %t18, ptr %t19, align 4
  %t20 = add nuw nsw i64 %t15, 1
  %t21 = icmp eq i64 %t20, 32000
  br i1 %t21, label %exit, label %loop

exit:                                             ; preds = %loop
  call void @use(ptr %a)
  call void @use(ptr %b)
  ret void
}

declare void @use(ptr)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpq9ykhra6.ll'
source_filename = "/tmp/tmpq9ykhra6.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

define void @test1(ptr %a) {
entry:
  %scevgep2 = getelementptr i8, ptr %a, i64 128000
  br label %loop

loop:                                             ; preds = %loop, %entry
  %lsr.iv1 = phi ptr [ %scevgep, %loop ], [ %a, %entry ]
  store float 1.000000e+00, ptr %lsr.iv1, align 4
  %scevgep = getelementptr i8, ptr %lsr.iv1, i64 4
  %lsr_fold_term_cond.replaced_term_cond = icmp eq ptr %scevgep, %scevgep2
  br i1 %lsr_fold_term_cond.replaced_term_cond, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @test2(ptr %a) {
entry:
  %scevgep2 = getelementptr i8, ptr %a, i64 128000
  br label %loop

loop:                                             ; preds = %loop, %entry
  %lsr.iv1 = phi ptr [ %scevgep, %loop ], [ %a, %entry ]
  store float 1.000000e+00, ptr %lsr.iv1, align 4
  %scevgep = getelementptr i8, ptr %lsr.iv1, i64 4
  %lsr_fold_term_cond.replaced_term_cond = icmp eq ptr %scevgep, %scevgep2
  br i1 %lsr_fold_term_cond.replaced_term_cond, label %exit, label %loop

exit:                                             ; preds = %loop
  call void @use(ptr %a)
  ret void
}

define void @test3(ptr %a, ptr %b) {
entry:
  %scevgep4 = getelementptr i8, ptr %b, i64 128000
  br label %loop

loop:                                             ; preds = %loop, %entry
  %lsr.iv2 = phi ptr [ %scevgep3, %loop ], [ %a, %entry ]
  %lsr.iv1 = phi ptr [ %scevgep, %loop ], [ %b, %entry ]
  %t17 = load float, ptr %lsr.iv2, align 4
  %t18 = fadd float %t17, 1.000000e+00
  store float %t18, ptr %lsr.iv1, align 4
  %scevgep = getelementptr i8, ptr %lsr.iv1, i64 4
  %scevgep3 = getelementptr i8, ptr %lsr.iv2, i64 4
  %lsr_fold_term_cond.replaced_term_cond = icmp eq ptr %scevgep, %scevgep4
  br i1 %lsr_fold_term_cond.replaced_term_cond, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @test4(ptr %a, ptr %b) {
entry:
  %scevgep4 = getelementptr i8, ptr %b, i64 128000
  br label %loop

loop:                                             ; preds = %loop, %entry
  %lsr.iv2 = phi ptr [ %scevgep3, %loop ], [ %a, %entry ]
  %lsr.iv1 = phi ptr [ %scevgep, %loop ], [ %b, %entry ]
  %t17 = load float, ptr %lsr.iv2, align 4
  %t18 = fadd float %t17, 1.000000e+00
  store float %t18, ptr %lsr.iv1, align 4
  %scevgep = getelementptr i8, ptr %lsr.iv1, i64 4
  %scevgep3 = getelementptr i8, ptr %lsr.iv2, i64 4
  %lsr_fold_term_cond.replaced_term_cond = icmp eq ptr %scevgep, %scevgep4
  br i1 %lsr_fold_term_cond.replaced_term_cond, label %exit, label %loop

exit:                                             ; preds = %loop
  call void @use(ptr %a)
  call void @use(ptr %b)
  ret void
}

declare void @use(ptr)
