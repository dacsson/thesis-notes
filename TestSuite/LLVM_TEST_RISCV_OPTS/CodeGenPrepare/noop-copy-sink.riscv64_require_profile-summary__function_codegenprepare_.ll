; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/CodeGenPrepare/RISCV/noop-copy-sink.ll
; Variant: riscv64_require<profile-summary>,function(codegenprepare)
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes='require<profile-summary>,function(codegenprepare)' -mtriple=riscv64 -S
; Original: RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' -mtriple=riscv64 %s  | FileCheck --check-prefixes=CHECK %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i16 @sink_trunc1(i64 %a) {
  %trunc = trunc i64 %a to i16
  br label %fnend

fnend:
  ret i16 %trunc
}

; The flags on the original trunc should be preserved.
define i16 @sink_trunc2(i64 %a) {
  %trunc = trunc nuw nsw i64 %a to i16
  br label %fnend

fnend:
  ret i16 %trunc
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpakiagv3v.ll'
source_filename = "/tmp/tmpakiagv3v.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i16 @sink_trunc1(i64 %a) {
fnend:
  %0 = trunc i64 %a to i16
  ret i16 %0
}

define i16 @sink_trunc2(i64 %a) {
fnend:
  %0 = trunc nuw nsw i64 %a to i16
  ret i16 %0
}
