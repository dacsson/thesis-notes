; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/load-widening.ll
; Variant: riscv64_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=vector-combine -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -passes=vector-combine -S -mtriple=riscv64 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @fixed_load_scalable_src(ptr %p) {
entry:
  store <vscale x 4 x i16> zeroinitializer, ptr %p
  %0 = load <4 x i16>, ptr %p
  %1 = shufflevector <4 x i16> %0, <4 x i16> zeroinitializer, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpmgr6tvgh.ll'
source_filename = "/tmp/tmpmgr6tvgh.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @fixed_load_scalable_src(ptr %p) #0 {
entry:
  store <vscale x 4 x i16> zeroinitializer, ptr %p, align 8
  %0 = load <4 x i16>, ptr %p, align 8
  %1 = shufflevector <4 x i16> %0, <4 x i16> zeroinitializer, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  ret void
}

attributes #0 = { "target-features"="+v" }
