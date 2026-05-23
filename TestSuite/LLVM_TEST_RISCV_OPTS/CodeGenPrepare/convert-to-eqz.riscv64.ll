; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/CodeGenPrepare/RISCV/convert-to-eqz.ll
; Variant: riscv64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -codegenprepare -mtriple=riscv64 -S
; Original: RUN: opt -codegenprepare -S -mtriple=riscv64 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i8 @hoist_add(i8 %x) {
entry:
  %cmp = icmp eq i8 %x, -1
  br i1 %cmp, label %exit, label %if.then

if.then:
  %inc = add nuw nsw i8 %x, 1
  br label %exit

exit:
  %retval = phi i8 [ %inc, %if.then ], [ -1, %entry ]
  ret i8 %retval
}

define i8 @hoist_lshr(i8 %x) {
entry:
  %cmp = icmp ult i8 %x, 8
  br i1 %cmp, label %exit, label %if.then

if.then:
  %inc = lshr exact i8 %x, 3
  br label %exit

exit:
  %retval = phi i8 [ %inc, %if.then ], [ -1, %entry ]
  ret i8 %retval
}

define i8 @nomove_add(i8 %x) {
entry:
  %inc = add nuw nsw i8 %x, 1
  %cmp = icmp eq i8 %x, -1
  br i1 %cmp, label %exit, label %if.then

if.then:
  br label %exit

exit:
  %retval = phi i8 [ %inc, %if.then ], [ -1, %entry ]
  ret i8 %retval
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp8w08htva.ll'
source_filename = "/tmp/tmp8w08htva.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i8 @hoist_add(i8 %x) {
entry:
  %inc = add i8 %x, 1
  %0 = icmp eq i8 %inc, 0
  br i1 %0, label %exit, label %if.then

if.then:                                          ; preds = %entry
  br label %exit

exit:                                             ; preds = %if.then, %entry
  %retval = phi i8 [ %inc, %if.then ], [ -1, %entry ]
  ret i8 %retval
}

define i8 @hoist_lshr(i8 %x) {
entry:
  %inc = lshr i8 %x, 3
  %0 = icmp eq i8 %inc, 0
  br i1 %0, label %exit, label %if.then

if.then:                                          ; preds = %entry
  br label %exit

exit:                                             ; preds = %if.then, %entry
  %retval = phi i8 [ %inc, %if.then ], [ -1, %entry ]
  ret i8 %retval
}

define i8 @nomove_add(i8 %x) {
entry:
  %inc = add i8 %x, 1
  %0 = icmp eq i8 %inc, 0
  br i1 %0, label %exit, label %if.then

if.then:                                          ; preds = %entry
  br label %exit

exit:                                             ; preds = %if.then, %entry
  %retval = phi i8 [ %inc, %if.then ], [ -1, %entry ]
  ret i8 %retval
}
