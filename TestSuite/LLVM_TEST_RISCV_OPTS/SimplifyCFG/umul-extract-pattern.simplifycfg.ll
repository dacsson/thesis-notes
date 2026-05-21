; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SimplifyCFG/RISCV/umul-extract-pattern.ll
; Variant: simplifycfg
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S
; Original: RUN: opt -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

target triple = "riscv64-unknown-unknown-elf"

define i16 @basicScenario(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  br i1 %cmp.not, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %entry
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %y, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %result = phi i1 [ false, %entry ], [ %mul.ov, %land.rhs ]
  %conv = zext i1 %result to i16
  ret i16 %conv
}

define i16 @samePatternTwice(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  br i1 %cmp.not, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %entry
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %y, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  %mul2 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %y, i64 %x)
  %mul.ov2 = extractvalue { i64, i1 } %mul2, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %result1 = phi i1 [ false, %entry ], [ %mul.ov, %land.rhs ]
  %result2 = phi i1 [ false, %entry ], [ %mul.ov2, %land.rhs ]
  %conv1 = zext i1 %result1 to i16
  %conv2 = zext i1 %result2 to i16
  %toRet = add nsw i16 %conv1, %conv2
  ret i16 %toRet
}

define i16 @stillHoistNotTooExpensive(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  br i1 %cmp.not, label %land.end, label %land.rhs

land.rhs:                                   ; preds = %entry
  %add = add nsw i64 %y, %x
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %add, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %result = phi i1 [ false, %entry ], [ %mul.ov, %land.rhs ]
  %conv = zext i1 %result to i16
  ret i16 %conv
}

define i16 @noHoistTooExpensive(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  br i1 %cmp.not, label %land.end, label %land.rhs

land.rhs:                                   ; preds = %entry
  %add = add nsw i64 %y, %x
  %add2 = add nsw i64 %y, %add
  %add3 = add nsw i64 %add, %add2
  %add4 = add nsw i64 %add2, %add3
  %add5 = add nsw i64 %add3, %add4
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %add5, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %result = phi i1 [ false, %entry ], [ %mul.ov, %land.rhs ]
  %conv = zext i1 %result to i16
  ret i16 %conv
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpmpux9ptm.ll'
source_filename = "/tmp/tmpmpux9ptm.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown-elf"

define i16 @basicScenario(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %y, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  %result = select i1 %cmp.not, i1 false, i1 %mul.ov
  %conv = zext i1 %result to i16
  ret i16 %conv
}

define i16 @samePatternTwice(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %y, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  %mul2 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %y, i64 %x)
  %mul.ov2 = extractvalue { i64, i1 } %mul2, 1
  %result1 = select i1 %cmp.not, i1 false, i1 %mul.ov
  %result2 = select i1 %cmp.not, i1 false, i1 %mul.ov2
  %conv1 = zext i1 %result1 to i16
  %conv2 = zext i1 %result2 to i16
  %toRet = add nsw i16 %conv1, %conv2
  ret i16 %toRet
}

define i16 @stillHoistNotTooExpensive(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  %add = add nsw i64 %y, %x
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %add, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  %result = select i1 %cmp.not, i1 false, i1 %mul.ov
  %conv = zext i1 %result to i16
  ret i16 %conv
}

define i16 @noHoistTooExpensive(i64 %x, i64 %y) {
entry:
  %cmp.not = icmp eq i64 %y, 0
  br i1 %cmp.not, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %entry
  %add = add nsw i64 %y, %x
  %add2 = add nsw i64 %y, %add
  %add3 = add nsw i64 %add, %add2
  %add4 = add nsw i64 %add2, %add3
  %add5 = add nsw i64 %add3, %add4
  %mul = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %add5, i64 %x)
  %mul.ov = extractvalue { i64, i1 } %mul, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %result = phi i1 [ false, %entry ], [ %mul.ov, %land.rhs ]
  %conv = zext i1 %result to i16
  ret i16 %conv
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #0

attributes #0 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
