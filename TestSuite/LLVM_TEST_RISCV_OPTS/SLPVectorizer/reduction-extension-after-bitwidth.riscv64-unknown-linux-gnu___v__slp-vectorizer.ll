; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reduction-extension-after-bitwidth.ll
; Variant: riscv64-unknown-linux-gnu_"+v"_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-unknown-linux-gnu -mattr="+v" --passes=slp-vectorizer -S
; Original: RUN: opt -S -mtriple=riscv64-unknown-linux-gnu -mattr="+v" --passes=slp-vectorizer < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test(ptr %0, ptr %1) {
entry:
  %zext.0 = zext i8 1 to i32
  %zext.1 = zext i8 1 to i32
  %zext.2 = zext i8 1 to i32
  %zext.3 = zext i8 1 to i32
  %select.zext.0 = select i1 false, i32 -1, i32 %zext.0
  %select.zext.1 = select i1 false, i32 0, i32 %zext.1
  %select.zext.2 = select i1 false, i32 0, i32 %zext.2
  %select.zext.3 = select i1 false, i32 0, i32 %zext.3

  %load.5 = load i32, ptr %1, align 4

  %and.0 = and i32 %load.5, %select.zext.0
  %and.1 = and i32 %and.0, %select.zext.1
  %and.2 = and i32 %and.1, %select.zext.2
  %and.3 = and i32 %and.2, %select.zext.3

  ret i32 %and.3
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp7_3j1fr0.ll'
source_filename = "/tmp/tmp7_3j1fr0.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @test(ptr %0, ptr %1) #0 {
entry:
  %load.5 = load i32, ptr %1, align 4
  %2 = call i8 @llvm.vector.reduce.and.v4i8(<4 x i8> splat (i8 1))
  %3 = sext i8 %2 to i32
  %op.rdx = and i32 %3, %load.5
  ret i32 %op.rdx
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.and.v4i8(<4 x i8>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
