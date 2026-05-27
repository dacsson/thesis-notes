; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/short-trip-count.ll
; Variant: riscv64_+zve32x_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+zve32x -passes=loop-vectorize -S
; Original: RUN: opt -S -mtriple=riscv64 -mattr=+zve32x -passes=loop-vectorize < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @small_trip_count_min_vlen_128(ptr nocapture %a) vscale_range(4,1024) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %a, i32 %iv
  %v = load i32, ptr %gep, align 4
  %add = add nsw i32 %v, 1
  store i32 %add, ptr %gep, align 4
  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv, 3
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

define void @small_trip_count_min_vlen_32(ptr nocapture %a) vscale_range(1,1024) {
entry:
  br label %loop

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %a, i32 %iv
  %v = load i32, ptr %gep, align 4
  %add = add nsw i32 %v, 1
  store i32 %add, ptr %gep, align 4
  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv, 3
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp5pzajq94.ll'
source_filename = "/tmp/tmp5pzajq94.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: vscale_range(4,1024)
define void @small_trip_count_min_vlen_128(ptr captures(none) %a) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %a, i32 %iv
  %v = load i32, ptr %gep, align 4
  %add = add nsw i32 %v, 1
  store i32 %add, ptr %gep, align 4
  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv, 3
  br i1 %cond, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

; Function Attrs: vscale_range(1,1024)
define void @small_trip_count_min_vlen_32(ptr captures(none) %a) #1 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %a, i32 %iv
  %v = load i32, ptr %gep, align 4
  %add = add nsw i32 %v, 1
  store i32 %add, ptr %gep, align 4
  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv, 3
  br i1 %cond, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

attributes #0 = { vscale_range(4,1024) "target-features"="+zve32x" }
attributes #1 = { vscale_range(1,1024) "target-features"="+zve32x" }
