; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/repeated-address-store.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %dest) {
entry:
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store i32 1, ptr %inc3, align 2

  store i32 1, ptr %dest, align 4
  %inc1 = getelementptr inbounds i32, ptr %dest, i64 1
  store i32 1, ptr %inc1, align 2
  %inc2 = getelementptr inbounds i32, ptr %dest, i64 2
  store i32 1, ptr %inc2, align 2
  store i32 2, ptr %dest, align 2
  store i32 1, ptr %inc3, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpxl8459j7.ll'
source_filename = "/tmp/tmpxl8459j7.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @test(ptr %dest) #0 {
entry:
  %inc3 = getelementptr inbounds i32, ptr %dest, i64 3
  store <4 x i32> splat (i32 1), ptr %dest, align 4
  store i32 2, ptr %dest, align 2
  store i32 1, ptr %inc3, align 2
  ret void
}

attributes #0 = { "target-features"="+v" }
