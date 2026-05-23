; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/fold-tail-low-trip-count.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck --check-prefix=IF-EVL %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @low_trip_count_small(i32 %x, ptr %dst) {
entry:
  %smax = call i32 @llvm.smax.i32(i32 %x, i32 1)
  %umin = call i32 @llvm.umin.i32(i32 %smax, i32 4)
  br label %loop

loop:
  %ptr = phi ptr [ %dst, %entry ], [ %ptr.next, %loop ]
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %ptr.next = getelementptr i8, ptr %ptr, i64 1
  store i8 0, ptr %ptr.next
  %iv.next = add i32 %iv, 1
  %exitcond = icmp eq i32 %iv.next, %umin
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}


define ptr @low_trip_count_small_with_live_out(i32 %x, ptr %dst) {
entry:
  %smax = call i32 @llvm.smax.i32(i32 %x, i32 1)
  %umin = call i32 @llvm.umin.i32(i32 %smax, i32 4)
  br label %loop

loop:
  %ptr = phi ptr [ %dst, %entry ], [ %ptr.next, %loop ]
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %ptr.next = getelementptr i8, ptr %ptr, i64 1
  store i8 0, ptr %ptr.next
  %iv.next = add i32 %iv, 1
  %exitcond = icmp eq i32 %iv.next, %umin
  br i1 %exitcond, label %exit, label %loop

exit:
  ret ptr %ptr.next
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6iwqw9f6.ll'
source_filename = "/tmp/tmp6iwqw9f6.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @low_trip_count_small(i32 %x, ptr %dst) #0 {
entry:
  %smax = call i32 @llvm.smax.i32(i32 %x, i32 1)
  %umin = call i32 @llvm.umin.i32(i32 %smax, i32 4)
  br label %loop

loop:                                             ; preds = %loop, %entry
  %ptr = phi ptr [ %dst, %entry ], [ %ptr.next, %loop ]
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %ptr.next = getelementptr i8, ptr %ptr, i64 1
  store i8 0, ptr %ptr.next, align 1
  %iv.next = add i32 %iv, 1
  %exitcond = icmp eq i32 %iv.next, %umin
  br i1 %exitcond, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define ptr @low_trip_count_small_with_live_out(i32 %x, ptr %dst) #0 {
entry:
  %smax = call i32 @llvm.smax.i32(i32 %x, i32 1)
  %umin = call i32 @llvm.umin.i32(i32 %smax, i32 4)
  br label %loop

loop:                                             ; preds = %loop, %entry
  %ptr = phi ptr [ %dst, %entry ], [ %ptr.next, %loop ]
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %ptr.next = getelementptr i8, ptr %ptr, i64 1
  store i8 0, ptr %ptr.next, align 1
  %iv.next = add i32 %iv, 1
  %exitcond = icmp eq i32 %iv.next, %umin
  br i1 %exitcond, label %exit, label %loop

exit:                                             ; preds = %loop
  %ptr.next.lcssa = phi ptr [ %ptr.next, %loop ]
  ret ptr %ptr.next.lcssa
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
