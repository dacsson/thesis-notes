; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/strided-unsupported-type.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -slp-threshold=-50 -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S < %s --passes=slp-vectorizer -slp-threshold=-50 -mtriple=riscv64-unknown-linux-gnu -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @loads() {
entry:
  %_M_value.imagp.i266 = getelementptr { fp128, fp128 }, ptr null, i64 0, i32 1
  %0 = load fp128, ptr null, align 16
  %cmp.i382 = fcmp une fp128 %0, 0xL00000000000000000000000000000000
  %1 = load fp128, ptr %_M_value.imagp.i266, align 16
  %cmp4.i385 = fcmp une fp128 %1, 0xL00000000000000000000000000000000
  call void null(i32 0, ptr null, i32 0)
  %cmp.i386 = fcmp une fp128 %0, 0xL00000000000000000000000000000000
  %cmp2.i388 = fcmp une fp128 %1, 0xL00000000000000000000000000000000
  ret void
}

define void @stores(ptr noalias %p) {
entry:
  %_M_value.imagp.i266 = getelementptr { fp128, fp128 }, ptr null, i64 0, i32 1
  %0 = load fp128, ptr null, align 16
  %1 = load fp128, ptr %_M_value.imagp.i266, align 16
  %p1 = getelementptr fp128, ptr %p, i64 1
  store fp128 %0, ptr %p1, align 16
  store fp128 %1, ptr %p, align 16
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpt_wwo4fu.ll'
source_filename = "/tmp/tmpt_wwo4fu.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @loads() #0 {
entry:
  %0 = load <2 x fp128>, ptr null, align 16
  %1 = fcmp une <2 x fp128> %0, zeroinitializer
  call void null(i32 0, ptr null, i32 0)
  %2 = fcmp une <2 x fp128> %0, zeroinitializer
  ret void
}

define void @stores(ptr noalias %p) #0 {
entry:
  %0 = load <2 x fp128>, ptr null, align 16
  %p1 = getelementptr fp128, ptr %p, i64 1
  %1 = extractelement <2 x fp128> %0, i32 0
  store fp128 %1, ptr %p1, align 16
  %2 = extractelement <2 x fp128> %0, i32 1
  store fp128 %2, ptr %p, align 16
  ret void
}

attributes #0 = { "target-features"="+v" }
