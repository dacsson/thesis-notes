; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/PreISelIntrinsicLowering/RISCV/memset-pattern.ll
; Variant: riscv64_pre-isel-intrinsic-lowering
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -passes=pre-isel-intrinsic-lowering -S
; Original: RUN: opt -mtriple=riscv64 -passes=pre-isel-intrinsic-lowering -S -o - %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @memset_pattern_i128_1(ptr %a, i128 %value) nounwind {
  tail call void @llvm.experimental.memset.pattern(ptr %a, i128 %value, i64 1, i1 0)
  ret void
}

define void @memset_pattern_i128_16(ptr %a, i128 %value) nounwind {
  tail call void @llvm.experimental.memset.pattern(ptr %a, i128 %value, i64 16, i1 0)
  ret void
}

define void @memset_pattern_i127_x(ptr %a, i127 %value, i64 %x) nounwind {
  tail call void @llvm.experimental.memset.pattern(ptr %a, i127 %value, i64 %x, i1 0)
  ret void
}

define void @memset_pattern_i128_x(ptr %a, i128 %value, i64 %x) nounwind {
  tail call void @llvm.experimental.memset.pattern(ptr %a, i128 %value, i64 %x, i1 0)
  ret void
}

define void @memset_pattern_i256_x(ptr %a, i256 %value, i64 %x) nounwind {
  tail call void @llvm.experimental.memset.pattern(ptr %a, i256 %value, i64 %x, i1 0)
  ret void
}

; The common alignment of the allocation of the pattern stride (its allocation
; size) and the destination pointer should be used.
define void @memset_pattern_i15_x_alignment(ptr %a, i15 %value, i64 %x) nounwind {
  call void @llvm.experimental.memset.pattern(ptr align 1 %a, i15 %value, i64 %x, i1 0)
  call void @llvm.experimental.memset.pattern(ptr align 2 %a, i15 %value, i64 %x, i1 0)
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp0oapdi14.ll'
source_filename = "/tmp/tmp0oapdi14.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nounwind
define void @memset_pattern_i128_1(ptr %a, i128 %value) #0 {
  br label %memset.pattern-expansion-main-body

memset.pattern-expansion-main-body:               ; preds = %0, %memset.pattern-expansion-main-body
  %loop-index = phi i64 [ 0, %0 ], [ %2, %memset.pattern-expansion-main-body ]
  %1 = getelementptr inbounds i128, ptr %a, i64 %loop-index
  store i128 %value, ptr %1, align 1
  %2 = add i64 %loop-index, 1
  %3 = icmp ult i64 %2, 1
  br i1 %3, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-post-expansion:                    ; preds = %memset.pattern-expansion-main-body
  ret void
}

; Function Attrs: nounwind
define void @memset_pattern_i128_16(ptr %a, i128 %value) #0 {
  br label %memset.pattern-expansion-main-body

memset.pattern-expansion-main-body:               ; preds = %0, %memset.pattern-expansion-main-body
  %loop-index = phi i64 [ 0, %0 ], [ %2, %memset.pattern-expansion-main-body ]
  %1 = getelementptr inbounds i128, ptr %a, i64 %loop-index
  store i128 %value, ptr %1, align 1
  %2 = add i64 %loop-index, 1
  %3 = icmp ult i64 %2, 16
  br i1 %3, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-post-expansion:                    ; preds = %memset.pattern-expansion-main-body
  ret void
}

; Function Attrs: nounwind
define void @memset_pattern_i127_x(ptr %a, i127 %value, i64 %x) #0 {
  %1 = icmp ne i64 %x, 0
  br i1 %1, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-expansion-main-body:               ; preds = %0, %memset.pattern-expansion-main-body
  %loop-index = phi i64 [ 0, %0 ], [ %3, %memset.pattern-expansion-main-body ]
  %2 = getelementptr inbounds i127, ptr %a, i64 %loop-index
  store i127 %value, ptr %2, align 1
  %3 = add i64 %loop-index, 1
  %4 = icmp ult i64 %3, %x
  br i1 %4, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-post-expansion:                    ; preds = %0, %memset.pattern-expansion-main-body
  ret void
}

; Function Attrs: nounwind
define void @memset_pattern_i128_x(ptr %a, i128 %value, i64 %x) #0 {
  %1 = icmp ne i64 %x, 0
  br i1 %1, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-expansion-main-body:               ; preds = %0, %memset.pattern-expansion-main-body
  %loop-index = phi i64 [ 0, %0 ], [ %3, %memset.pattern-expansion-main-body ]
  %2 = getelementptr inbounds i128, ptr %a, i64 %loop-index
  store i128 %value, ptr %2, align 1
  %3 = add i64 %loop-index, 1
  %4 = icmp ult i64 %3, %x
  br i1 %4, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-post-expansion:                    ; preds = %0, %memset.pattern-expansion-main-body
  ret void
}

; Function Attrs: nounwind
define void @memset_pattern_i256_x(ptr %a, i256 %value, i64 %x) #0 {
  %1 = icmp ne i64 %x, 0
  br i1 %1, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-expansion-main-body:               ; preds = %0, %memset.pattern-expansion-main-body
  %loop-index = phi i64 [ 0, %0 ], [ %3, %memset.pattern-expansion-main-body ]
  %2 = getelementptr inbounds i256, ptr %a, i64 %loop-index
  store i256 %value, ptr %2, align 1
  %3 = add i64 %loop-index, 1
  %4 = icmp ult i64 %3, %x
  br i1 %4, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-post-expansion:                    ; preds = %0, %memset.pattern-expansion-main-body
  ret void
}

; Function Attrs: nounwind
define void @memset_pattern_i15_x_alignment(ptr %a, i15 %value, i64 %x) #0 {
  %1 = icmp ne i64 %x, 0
  br i1 %1, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-expansion-main-body:               ; preds = %0, %memset.pattern-expansion-main-body
  %loop-index = phi i64 [ 0, %0 ], [ %3, %memset.pattern-expansion-main-body ]
  %2 = getelementptr inbounds i15, ptr %a, i64 %loop-index
  store i15 %value, ptr %2, align 1
  %3 = add i64 %loop-index, 1
  %4 = icmp ult i64 %3, %x
  br i1 %4, label %memset.pattern-expansion-main-body, label %memset.pattern-post-expansion

memset.pattern-post-expansion:                    ; preds = %0, %memset.pattern-expansion-main-body
  %5 = icmp ne i64 %x, 0
  br i1 %5, label %memset.pattern-expansion-main-body2, label %memset.pattern-post-expansion1

memset.pattern-expansion-main-body2:              ; preds = %memset.pattern-post-expansion, %memset.pattern-expansion-main-body2
  %loop-index3 = phi i64 [ 0, %memset.pattern-post-expansion ], [ %7, %memset.pattern-expansion-main-body2 ]
  %6 = getelementptr inbounds i15, ptr %a, i64 %loop-index3
  store i15 %value, ptr %6, align 2
  %7 = add i64 %loop-index3, 1
  %8 = icmp ult i64 %7, %x
  br i1 %8, label %memset.pattern-expansion-main-body2, label %memset.pattern-post-expansion1

memset.pattern-post-expansion1:                   ; preds = %memset.pattern-post-expansion, %memset.pattern-expansion-main-body2
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.memset.pattern.p0.i15.i64(ptr writeonly captures(none), i15, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.memset.pattern.p0.i256.i64(ptr writeonly captures(none), i256, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.memset.pattern.p0.i128.i64(ptr writeonly captures(none), i128, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.memset.pattern.p0.i127.i64(ptr writeonly captures(none), i127, i64, i1 immarg) #1

attributes #0 = { nounwind }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
