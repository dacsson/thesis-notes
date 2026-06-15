; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopStrengthReduce/RISCV/icmp-zero.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -loop-reduce -S
; Original: RUN: opt < %s -loop-reduce -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"


define void @icmp_zero(i64 %N, ptr %p) {
entry:
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %N
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_nonzero_con(i64 %N, ptr %p) {
entry:
  %urem = urem i64 %N, 16
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_invariant(i64 %N, i64 %M, ptr %p) {
entry:
  %urem = urem i64 %N, %M
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

; We have to be careful here as SCEV can only compute a subtraction from
; two pointers with the same base.  If we hide %end inside a unknown, we
; can no longer compute the subtract.
define void @icmp_zero_urem_invariant_ptr(i64 %N, i64 %M, ptr %p) {
entry:
  %urem = urem i64 %N, %M
  %end = getelementptr i64, ptr %p, i64 %urem
  br label %vector.body

vector.body:
  %iv = phi ptr [ %p, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = getelementptr i64, ptr %iv, i64 1
  %done = icmp eq ptr %iv.next, %end
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

; Negative test - We can not hoist because we don't know value of %M.
define void @icmp_zero_urem_nohoist(i64 %N, i64 %M, ptr %p) {
entry:
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %urem = urem i64 %N, %M
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_nonzero(i64 %N, i64 %M, ptr %p) {
entry:
  %nonzero = add nuw i64 %M, 1
  %urem = urem i64 %N, %nonzero
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_vscale(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %urem = urem i64 %N, %vscale
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_vscale_mul8(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %mul = mul nuw nsw i64 %vscale, 8
  %urem = urem i64 %N, %mul
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}


define void @icmp_zero_urem_vscale_mul64(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %mul = mul nuw nsw i64 %vscale, 64
  %urem = urem i64 %N, %mul
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_vscale_shl3(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %shl = shl i64 %vscale, 3
  %urem = urem i64 %N, %shl
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

define void @icmp_zero_urem_vscale_shl6(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %shl = shl i64 %vscale, 6
  %urem = urem i64 %N, %shl
  br label %vector.body

vector.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p
  %iv.next = add i64 %iv, 2
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:
  ret void
}

; Loop invariant does not neccessarily mean dominating the loop.  Forming
; an ICmpZero from this example would be illegal even though the operands
; to the compare are loop invariant.
define void @loop_invariant_definition(i64 %arg) {
entry:
  br label %t1

t1:                                                ; preds = %1, %0
  %t2 = phi i64 [ %t3, %t1 ], [ 0, %entry ]
  %t3 = add nuw i64 %t2, 1
  br i1 true, label %t4, label %t1

t4:                                                ; preds = %1
  %t5 = trunc i64 %t2 to i32
  %t6 = add i32 %t5, 1
  %t7 = icmp eq i32 %t5, %t6
  ret void
}

declare i64 @llvm.vscale.i64()

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpvn7bozor.ll'
source_filename = "/tmp/tmpvn7bozor.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

define void @icmp_zero(i64 %N, ptr %p) {
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %N, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_nonzero_con(i64 %N, ptr %p) {
entry:
  %urem = urem i64 %N, 16
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_invariant(i64 %N, i64 %M, ptr %p) {
entry:
  %urem = urem i64 %N, %M
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_invariant_ptr(i64 %N, i64 %M, ptr %p) {
entry:
  %urem = urem i64 %N, %M
  %end = getelementptr i64, ptr %p, i64 %urem
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %iv = phi ptr [ %p, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p, align 8
  %iv.next = getelementptr i64, ptr %iv, i64 1
  %done = icmp eq ptr %iv.next, %end
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_nohoist(i64 %N, i64 %M, ptr %p) {
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %vector.body ]
  store i64 0, ptr %p, align 8
  %iv.next = add i64 %iv, 2
  %urem = urem i64 %N, %M
  %done = icmp eq i64 %iv.next, %urem
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_nonzero(i64 %N, i64 %M, ptr %p) {
entry:
  %nonzero = add nuw i64 %M, 1
  %urem = urem i64 %N, %nonzero
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_vscale(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %urem = urem i64 %N, %vscale
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_vscale_mul8(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %mul = mul nuw nsw i64 %vscale, 8
  %urem = urem i64 %N, %mul
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_vscale_mul64(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %mul = mul nuw nsw i64 %vscale, 64
  %urem = urem i64 %N, %mul
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_vscale_shl3(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %shl = shl i64 %vscale, 3
  %urem = urem i64 %N, %shl
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @icmp_zero_urem_vscale_shl6(i64 %N, ptr %p) {
entry:
  %vscale = call i64 @llvm.vscale.i64()
  %shl = shl i64 %vscale, 6
  %urem = urem i64 %N, %shl
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %urem, %entry ]
  store i64 0, ptr %p, align 8
  %lsr.iv.next = add i64 %lsr.iv, -2
  %done = icmp eq i64 %lsr.iv.next, 0
  br i1 %done, label %exit, label %vector.body

exit:                                             ; preds = %vector.body
  ret void
}

define void @loop_invariant_definition(i64 %arg) {
entry:
  br label %t1

t1:                                               ; preds = %t1, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %t1 ], [ -1, %entry ]
  %lsr.iv.next = add nsw i64 %lsr.iv, 1
  br i1 true, label %t4, label %t1

t4:                                               ; preds = %t1
  %t5 = trunc i64 %lsr.iv.next to i32
  %t6 = add i32 %t5, 1
  %t7 = icmp eq i32 %t5, %t6
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
