; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/DivRemPairs/RISCV/div-rem-pairs.ll
; Variant: riscv64-unknown-unknown_div-rem-pairs
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=div-rem-pairs -mtriple=riscv64-unknown-unknown -S
; Original: RUN: opt < %s -passes=div-rem-pairs -S -mtriple=riscv64-unknown-unknown | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Do not hoist to the common predecessor block since we don't
; have a div-rem operation.

define i32 @no_domination(i1 %cmp, i32 %a, i32 %b) {
entry:
  br i1 %cmp, label %if, label %else

if:
  %div = sdiv i32 %a, %b
  br label %end

else:
  %rem = srem i32 %a, %b
  br label %end

end:
  %ret = phi i32 [ %div, %if ], [ %rem, %else ]
  ret i32 %ret
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpdnmc_lum.ll'
source_filename = "/tmp/tmpdnmc_lum.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown"

define i32 @no_domination(i1 %cmp, i32 %a, i32 %b) {
entry:
  br i1 %cmp, label %if, label %else

if:                                               ; preds = %entry
  %div = sdiv i32 %a, %b
  br label %end

else:                                             ; preds = %entry
  %rem = srem i32 %a, %b
  br label %end

end:                                              ; preds = %else, %if
  %ret = phi i32 [ %div, %if ], [ %rem, %else ]
  ret i32 %ret
}
