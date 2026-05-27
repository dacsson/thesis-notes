; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/scalable-type-to-vect.ll
; Variant: riscv64-unknown-unknown_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-unknown -mattr=+v -S
; Original: RUN: opt -S -passes=slp-vectorizer -mtriple=riscv64-unknown-unknown -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define { <vscale x 2 x i32>, <vscale x 2 x i32> } @foo() {
entry:
  %0 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } zeroinitializer, <vscale x 2 x i32> zeroinitializer, 0
  ret { <vscale x 2 x i32>, <vscale x 2 x i32> } zeroinitializer
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpvyz8jaei.ll'
source_filename = "/tmp/tmpvyz8jaei.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown"

define { <vscale x 2 x i32>, <vscale x 2 x i32> } @foo() #0 {
entry:
  %0 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } zeroinitializer, <vscale x 2 x i32> zeroinitializer, 0
  ret { <vscale x 2 x i32>, <vscale x 2 x i32> } zeroinitializer
}

attributes #0 = { "target-features"="+v" }
