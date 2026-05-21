; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/CodeGenPrepare/RISCV/and-mask-sink.ll
; Variant: riscv64_require<profile-summary>,function(codegenprepare)
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes='require<profile-summary>,function(codegenprepare)' -mtriple=riscv64 -S
; Original: RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' -mtriple=riscv64 %s  | FileCheck --check-prefixes=CHECK,NOZBS %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@A = global i32 zeroinitializer

; And should be sunk when Zbs is present and the mask doesn't fit in ANDI's
; immediate.
define i32 @and_sink1(i32 %a, i1 %c) {
  %and = and i32 %a, 2048
  br label %bb0
bb0:
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A
  br i1 %cmp, label %bb0, label %bb2
bb2:
  ret i32 0
}

; Don't sink when the mask has more than 1 bit set.
define i32 @and_sink2(i32 %a) {
  %and = and i32 %a, 2049
  br label %bb0
bb0:
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A
  br i1 %cmp, label %bb0, label %bb2
bb2:
  ret i32 0
}

; Don't sink when the mask fits in ANDI's immediate.
define i32 @and_sink3(i32 %a) {
  %and = and i32 %a, 1024
  br label %bb0
bb0:
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A
  br i1 %cmp, label %bb0, label %bb2
bb2:
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp9o11lamn.ll'
source_filename = "/tmp/tmp9o11lamn.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

@A = global i32 0

define i32 @and_sink1(i32 %a, i1 %c) {
  %and = and i32 %a, 2048
  br label %bb0

bb0:                                              ; preds = %bb0, %0
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A, align 4
  br i1 %cmp, label %bb0, label %bb2

bb2:                                              ; preds = %bb0
  ret i32 0
}

define i32 @and_sink2(i32 %a) {
  %and = and i32 %a, 2049
  br label %bb0

bb0:                                              ; preds = %bb0, %0
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A, align 4
  br i1 %cmp, label %bb0, label %bb2

bb2:                                              ; preds = %bb0
  ret i32 0
}

define i32 @and_sink3(i32 %a) {
  %and = and i32 %a, 1024
  br label %bb0

bb0:                                              ; preds = %bb0, %0
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A, align 4
  br i1 %cmp, label %bb0, label %bb2

bb2:                                              ; preds = %bb0
  ret i32 0
}
