; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopIdiom/RISCV/memset-pattern.ll
; Variant: riscv64_loop-idiom_CHECK-INTRIN
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-idiom -mtriple=riscv64 -loop-idiom-force-memset-pattern-intrinsic -S
; Original: RUN: opt -passes=loop-idiom -mtriple=riscv64 -loop-idiom-force-memset-pattern-intrinsic < %s -S  | FileCheck -check-prefix=CHECK-INTRIN %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define dso_local void @double_memset(ptr nocapture %p) {
entry:
  br label %for.body

for.cond.cleanup:
  ret void

for.body:
  %i.07 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %ptr1 = getelementptr inbounds double, ptr %p, i64 %i.07
  store double 3.14159e+00, ptr %ptr1, align 1
  %inc = add nuw nsw i64 %i.07, 1
  %exitcond.not = icmp eq i64 %inc, 16
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpxjjup5fh.ll'
source_filename = "/tmp/tmpxjjup5fh.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define dso_local void @double_memset(ptr captures(none) %p) {
entry:
  call void @llvm.experimental.memset.pattern.p0.f64.i64(ptr align 1 %p, double 3.141590e+00, i64 16, i1 false)
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %for.body, %entry
  %i.07 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %ptr1 = getelementptr inbounds double, ptr %p, i64 %i.07
  %inc = add nuw nsw i64 %i.07, 1
  %exitcond.not = icmp eq i64 %inc, 16
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.memset.pattern.p0.f64.i64(ptr writeonly captures(none), double, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
