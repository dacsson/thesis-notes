; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopDataPrefetch/RISCV/basic.ll
; Variant: riscv64_loop-data-prefetch
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -cache-line-size=64 -prefetch-distance=64 -passes=loop-data-prefetch -S
; Original: RUN: opt -mtriple=riscv64 -cache-line-size=64 -prefetch-distance=64  -passes=loop-data-prefetch -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @foo(ptr nocapture %a, ptr nocapture readonly %b) {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds double, ptr %b, i64 %indvars.iv
  %0 = load double, ptr %arrayidx, align 8
  %add = fadd double %0, 1.000000e+00
  %arrayidx2 = getelementptr inbounds double, ptr %a, i64 %indvars.iv
  store double %add, ptr %arrayidx2, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1600
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp96txb0pw.ll'
source_filename = "/tmp/tmp96txb0pw.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @foo(ptr captures(none) %a, ptr readonly captures(none) %b) {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw nsw i64 %indvars.iv, 3
  %1 = add i64 %0, 64
  %scevgep1 = getelementptr i8, ptr %a, i64 %1
  %2 = shl nuw nsw i64 %indvars.iv, 3
  %3 = add i64 %2, 64
  %scevgep = getelementptr i8, ptr %b, i64 %3
  %arrayidx = getelementptr inbounds double, ptr %b, i64 %indvars.iv
  call void @llvm.prefetch.p0(ptr %scevgep, i32 0, i32 3, i32 1)
  %4 = load double, ptr %arrayidx, align 8
  %add = fadd double %4, 1.000000e+00
  %arrayidx2 = getelementptr inbounds double, ptr %a, i64 %indvars.iv
  call void @llvm.prefetch.p0(ptr %scevgep1, i32 1, i32 3, i32 1)
  store double %add, ptr %arrayidx2, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1600
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @llvm.prefetch.p0(ptr readonly captures(none), i32 immarg, i32 immarg, i32 immarg) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite) }
