; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/struct-gep.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v -riscv-v-slp-max-vf=0 -S
; Original: RUN: opt < %s -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v  -riscv-v-slp-max-vf=0 -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; This shouldn't be vectorized as the extra address computation required for the
; vector store make it unprofitable (vle/vse don't have an offset in their
; addressing modes)

%struct.2i32 = type { i32, i32 }

define void @splat_store_v2i32(ptr %dest, i64 %i) {
entry:
  %p1 = getelementptr %struct.2i32, ptr %dest, i64 %i, i32 0
  store i32 1, ptr %p1
  %p2 = getelementptr %struct.2i32, ptr %dest, i64 %i, i32 1
  store i32 1, ptr %p2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp77swtun8.ll'
source_filename = "/tmp/tmp77swtun8.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

%struct.2i32 = type { i32, i32 }

define void @splat_store_v2i32(ptr %dest, i64 %i) #0 {
entry:
  %p1 = getelementptr %struct.2i32, ptr %dest, i64 %i, i32 0
  store i32 1, ptr %p1, align 4
  %p2 = getelementptr %struct.2i32, ptr %dest, i64 %i, i32 1
  store i32 1, ptr %p2, align 4
  ret void
}

attributes #0 = { "target-features"="+v" }
