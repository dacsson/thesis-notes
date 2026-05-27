; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/CodeGenPrepare/RISCV/and-mask-sink.ll
; Variant: riscv32_+zbs_require<profile-summary>,function(codegenprepare)
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes='require<profile-summary>,function(codegenprepare)' -mtriple=riscv32 -mattr=+zbs -S
; Original: RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' -mtriple=riscv32 -mattr=+zbs %s  | FileCheck --check-prefixes=CHECK,ZBS %s

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

; ModuleID = '/tmp/tmp97d0rk2k.ll'
source_filename = "/tmp/tmp97d0rk2k.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

@A = global i32 0

define i32 @and_sink1(i32 %a, i1 %c) #0 {
  br label %bb0

bb0:                                              ; preds = %bb0, %0
  %1 = and i32 %a, 2048
  %cmp = icmp eq i32 %1, 0
  store i32 0, ptr @A, align 4
  br i1 %cmp, label %bb0, label %bb2

bb2:                                              ; preds = %bb0
  ret i32 0
}

define i32 @and_sink2(i32 %a) #0 {
  %and = and i32 %a, 2049
  br label %bb0

bb0:                                              ; preds = %bb0, %0
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A, align 4
  br i1 %cmp, label %bb0, label %bb2

bb2:                                              ; preds = %bb0
  ret i32 0
}

define i32 @and_sink3(i32 %a) #0 {
  %and = and i32 %a, 1024
  br label %bb0

bb0:                                              ; preds = %bb0, %0
  %cmp = icmp eq i32 %and, 0
  store i32 0, ptr @A, align 4
  br i1 %cmp, label %bb0, label %bb2

bb2:                                              ; preds = %bb0
  ret i32 0
}

attributes #0 = { "target-features"="+zbs" }
