; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-no-masking.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



; No need to emit predicated vector code if the vector instructions with masking are not required.
define i32 @no_masking() {
entry:
  br label %body

body:
  %p = phi i32 [ 1, %entry ], [ %inc, %body ]
  %inc = add i32 %p, 1
  %cmp = icmp eq i32 %inc, 0
  br i1 %cmp, label %end, label %body

end:
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp68w1i2br.ll'
source_filename = "/tmp/tmp68w1i2br.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @no_masking() #0 {
entry:
  br label %body

body:                                             ; preds = %body, %entry
  %p = phi i32 [ 1, %entry ], [ %inc, %body ]
  %inc = add i32 %p, 1
  %cmp = icmp eq i32 %inc, 0
  br i1 %cmp, label %end, label %body

end:                                              ; preds = %body
  ret i32 0
}

attributes #0 = { "target-features"="+v" }
