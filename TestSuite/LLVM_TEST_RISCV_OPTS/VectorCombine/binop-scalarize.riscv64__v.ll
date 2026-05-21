; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/binop-scalarize.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p vector-combine -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -S -p vector-combine -mtriple=riscv64 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <4 x i32> @add_constant_load(ptr %p) {
  %x = load i32, ptr %p
  %ins = insertelement <4 x i32> poison, i32 %x, i32 0
  %v = add <4 x i32> %ins, splat (i32 42)
  ret <4 x i32> %v
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6in6z8ng.ll'
source_filename = "/tmp/tmp6in6z8ng.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <4 x i32> @add_constant_load(ptr %p) #0 {
  %x = load i32, ptr %p, align 4
  %v.scalar = add i32 %x, 42
  %v = insertelement <4 x i32> poison, i32 %v.scalar, i64 0
  ret <4 x i32> %v
}

attributes #0 = { "target-features"="+v" }
