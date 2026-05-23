; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopStrengthReduce/RISCV/many-geps.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -loop-reduce -S
; Original: RUN: opt < %s -loop-reduce -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

; This test was added as example motivation for the changes in #89927, which
; causes LSR to drop solutions if deemed to be less profitable than the
; starting point. At the time of adding this test, LSR's search heuristics
; best identified solution was an unprofitable one. This could of course
; change with future LSR improvements.

%struct = type { i64, i32, i32, i32, i32, i32, i32, i32, i32, i64, i32, i64, i64, i32, i64 }

define i32 @main() {
0:
  %call = tail call ptr null(i64 0)
  br label %2

1:
  %load = load i32, ptr %call, align 4
  ret i32 0

2:
  %phi = phi i64 [ 0, %0 ], [ %add, %2 ]
  %getelementptr = getelementptr %struct, ptr %call, i64 %phi
  %getelementptr3 = getelementptr i8, ptr %getelementptr, i64 8
  store i32 0, ptr %getelementptr3, align 8
  %getelementptr4 = getelementptr i8, ptr %getelementptr, i64 12
  store i32 0, ptr %getelementptr4, align 4
  %getelementptr5 = getelementptr i8, ptr %getelementptr, i64 16
  store i32 0, ptr %getelementptr5, align 8
  %getelementptr6 = getelementptr i8, ptr %getelementptr, i64 20
  store i32 0, ptr %getelementptr6, align 4
  %getelementptr7 = getelementptr i8, ptr %getelementptr, i64 24
  store i32 0, ptr %getelementptr7, align 8
  %getelementptr8 = getelementptr i8, ptr %getelementptr, i64 28
  store i32 0, ptr %getelementptr8, align 4
  %getelementptr9 = getelementptr i8, ptr %getelementptr, i64 32
  store i32 0, ptr %getelementptr9, align 8
  %getelementptr10 = getelementptr i8, ptr %getelementptr, i64 36
  store i32 0, ptr %getelementptr10, align 4
  %getelementptr11 = getelementptr i8, ptr %getelementptr, i64 40
  store i64 0, ptr %getelementptr11, align 8
  %getelementptr12 = getelementptr i8, ptr %getelementptr, i64 48
  store i32 0, ptr %getelementptr12, align 8
  %getelementptr13 = getelementptr i8, ptr %getelementptr, i64 72
  store i32 0, ptr %getelementptr13, align 8
  %getelementptr14 = getelementptr i8, ptr %getelementptr, i64 80
  store i64 0, ptr %getelementptr14, align 8
  %add = add i64 %phi, 1
  br label %2
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6dqoyin3.ll'
source_filename = "/tmp/tmp6dqoyin3.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

define i32 @main() {
  %call = tail call ptr null(i64 0)
  br label %2

1:                                                ; No predecessors!
  %load = load i32, ptr %call, align 4
  ret i32 0

2:                                                ; preds = %2, %0
  %lsr.iv30 = phi i64 [ %lsr.iv.next31, %2 ], [ 8, %0 ]
  %lsr.iv27 = phi i64 [ %lsr.iv.next28, %2 ], [ 12, %0 ]
  %lsr.iv24 = phi i64 [ %lsr.iv.next25, %2 ], [ 16, %0 ]
  %lsr.iv21 = phi i64 [ %lsr.iv.next22, %2 ], [ 20, %0 ]
  %lsr.iv18 = phi i64 [ %lsr.iv.next19, %2 ], [ 24, %0 ]
  %lsr.iv15 = phi i64 [ %lsr.iv.next16, %2 ], [ 28, %0 ]
  %lsr.iv12 = phi i64 [ %lsr.iv.next13, %2 ], [ 32, %0 ]
  %lsr.iv9 = phi i64 [ %lsr.iv.next10, %2 ], [ 36, %0 ]
  %lsr.iv4 = phi i64 [ %lsr.iv.next5, %2 ], [ 40, %0 ]
  %lsr.iv1 = phi i64 [ %lsr.iv.next2, %2 ], [ 48, %0 ]
  %lsr.iv = phi i64 [ %lsr.iv.next, %2 ], [ 72, %0 ]
  %scevgep32 = getelementptr i8, ptr %call, i64 %lsr.iv30
  store i32 0, ptr %scevgep32, align 8
  %scevgep29 = getelementptr i8, ptr %call, i64 %lsr.iv27
  store i32 0, ptr %scevgep29, align 4
  %scevgep26 = getelementptr i8, ptr %call, i64 %lsr.iv24
  store i32 0, ptr %scevgep26, align 8
  %scevgep23 = getelementptr i8, ptr %call, i64 %lsr.iv21
  store i32 0, ptr %scevgep23, align 4
  %scevgep20 = getelementptr i8, ptr %call, i64 %lsr.iv18
  store i32 0, ptr %scevgep20, align 8
  %scevgep17 = getelementptr i8, ptr %call, i64 %lsr.iv15
  store i32 0, ptr %scevgep17, align 4
  %scevgep14 = getelementptr i8, ptr %call, i64 %lsr.iv12
  store i32 0, ptr %scevgep14, align 8
  %scevgep11 = getelementptr i8, ptr %call, i64 %lsr.iv9
  store i32 0, ptr %scevgep11, align 4
  %scevgep6 = getelementptr i8, ptr %call, i64 %lsr.iv4
  store i64 0, ptr %scevgep6, align 8
  %scevgep3 = getelementptr i8, ptr %call, i64 %lsr.iv1
  store i32 0, ptr %scevgep3, align 8
  %scevgep = getelementptr i8, ptr %call, i64 %lsr.iv
  store i32 0, ptr %scevgep, align 8
  %scevgep7 = getelementptr i8, ptr %call, i64 %lsr.iv4
  %scevgep8 = getelementptr i8, ptr %scevgep7, i64 40
  store i64 0, ptr %scevgep8, align 8
  %lsr.iv.next = add i64 %lsr.iv, 88
  %lsr.iv.next2 = add i64 %lsr.iv1, 88
  %lsr.iv.next5 = add i64 %lsr.iv4, 88
  %lsr.iv.next10 = add i64 %lsr.iv9, 88
  %lsr.iv.next13 = add i64 %lsr.iv12, 88
  %lsr.iv.next16 = add i64 %lsr.iv15, 88
  %lsr.iv.next19 = add i64 %lsr.iv18, 88
  %lsr.iv.next22 = add i64 %lsr.iv21, 88
  %lsr.iv.next25 = add i64 %lsr.iv24, 88
  %lsr.iv.next28 = add i64 %lsr.iv27, 88
  %lsr.iv.next31 = add i64 %lsr.iv30, 88
  br label %2
}
