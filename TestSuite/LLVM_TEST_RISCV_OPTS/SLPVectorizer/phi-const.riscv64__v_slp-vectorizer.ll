; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/phi-const.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v -riscv-v-slp-max-vf=0 -S
; Original: RUN: opt -passes=slp-vectorizer -S < %s -mtriple=riscv64 -mattr=+v  -riscv-v-slp-max-vf=0 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; These shouldn't be vectorized as the cost of materializing the constants as
; vectors should outweigh the scalar cost

define void @f(ptr %p, i1 %c) {
  %p.0 = getelementptr i8, ptr %p
  %p.1 = getelementptr i8, ptr %p, i32 1
  br i1 %c, label %a, label %b
a:
  br label %d
b:
  br label %d
d:
  %x = phi i8 [1, %a], [-1, %b]
  %y = phi i8 [-1, %a], [1, %b]
  store i8 %x, ptr %p.0
  store i8 %y, ptr %p.1
  ret void
}

define void @g(ptr %p, i1 %c) {
  %p.0 = getelementptr i8, ptr %p
  %p.1 = getelementptr i8, ptr %p, i32 1
  br i1 %c, label %a, label %b
a:
  br label %d
b:
  br label %d
d:
  %x = phi i8 [1, %a], [-1, %b]
  %y = phi i8 [-1, %a], [1, %b]
  %x.add = add i8 %x, 1
  %y.add = add i8 %y, 1
  store i8 %x.add, ptr %p.0
  store i8 %y.add, ptr %p.1
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp80npw0a8.ll'
source_filename = "/tmp/tmp80npw0a8.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @f(ptr %p, i1 %c) #0 {
  %p.0 = getelementptr i8, ptr %p
  br i1 %c, label %a, label %b

a:                                                ; preds = %0
  br label %d

b:                                                ; preds = %0
  br label %d

d:                                                ; preds = %b, %a
  %1 = phi <2 x i8> [ <i8 1, i8 -1>, %a ], [ <i8 -1, i8 1>, %b ]
  store <2 x i8> %1, ptr %p.0, align 1
  ret void
}

define void @g(ptr %p, i1 %c) #0 {
  %p.0 = getelementptr i8, ptr %p
  br i1 %c, label %a, label %b

a:                                                ; preds = %0
  br label %d

b:                                                ; preds = %0
  br label %d

d:                                                ; preds = %b, %a
  %1 = phi <2 x i8> [ <i8 1, i8 -1>, %a ], [ <i8 -1, i8 1>, %b ]
  %2 = add <2 x i8> %1, splat (i8 1)
  store <2 x i8> %2, ptr %p.0, align 1
  ret void
}

attributes #0 = { "target-features"="+v" }
