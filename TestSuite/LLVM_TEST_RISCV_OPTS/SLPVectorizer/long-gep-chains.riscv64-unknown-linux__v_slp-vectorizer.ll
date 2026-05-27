; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/long-gep-chains.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -S
; Original: RUN: opt -S -passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v < %s |  FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i64 @test(ptr %arg, i32 %arg1, i64 %i) {
bb:
  %i2 = getelementptr i8, ptr %arg, i64 %i
  %i3 = getelementptr i8, ptr %i2, i64 %i
  %i4 = getelementptr i8, ptr %i3, i64 %i
  %i5 = getelementptr i8, ptr %i4, i64 %i
  %i6 = getelementptr i8, ptr %i5, i64 %i
  %i7 = getelementptr i8, ptr %i6, i64 %i
  %i8 = getelementptr i8, ptr %i7, i64 %i
  %i9 = getelementptr i8, ptr %i8, i64 %i
  %i10 = getelementptr i8, ptr %i9, i64 %i
  %i11 = getelementptr i8, ptr %i10, i64 %i
  %i12 = getelementptr i8, ptr %i11, i64 %i
  %i13 = getelementptr i8, ptr %i12, i64 %i
  %i14 = getelementptr i8, ptr %i13, i64 %i
  %i140 = load i8, ptr %i14, align 1
  %i1412 = zext i8 %i140 to i32
  %i142 = mul i32 %arg1, %i1412
  %i143 = getelementptr i8, ptr %i13, i64 15
  %i144 = load i8, ptr %i143, align 1
  %i1453 = zext i8 %i144 to i32
  %i146 = mul i32 %arg1, %i1453
  %i147 = getelementptr i8, ptr %i13, i64 14
  %i148 = load i8, ptr %i147, align 1
  %i1494 = zext i8 %i148 to i32
  %i150 = mul i32 %arg1, %i1494
  %i151 = getelementptr i8, ptr %i13, i64 13
  %i152 = load i8, ptr %i151, align 1
  %i1535 = zext i8 %i152 to i32
  %i154 = mul i32 %arg1, %i1535
  %i1311 = or i32 %i142, %i146
  %i1312 = or i32 %i1311, %i150
  %i1313 = or i32 %i1312, %i154
  %i1536 = zext i32 %i1313 to i64
  ret i64 %i1536
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpew7_5h40.ll'
source_filename = "/tmp/tmpew7_5h40.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define i64 @test(ptr %arg, i32 %arg1, i64 %i) #0 {
bb:
  %i2 = getelementptr i8, ptr %arg, i64 %i
  %i3 = getelementptr i8, ptr %i2, i64 %i
  %i4 = getelementptr i8, ptr %i3, i64 %i
  %i5 = getelementptr i8, ptr %i4, i64 %i
  %i6 = getelementptr i8, ptr %i5, i64 %i
  %i7 = getelementptr i8, ptr %i6, i64 %i
  %i8 = getelementptr i8, ptr %i7, i64 %i
  %i9 = getelementptr i8, ptr %i8, i64 %i
  %i10 = getelementptr i8, ptr %i9, i64 %i
  %i11 = getelementptr i8, ptr %i10, i64 %i
  %i12 = getelementptr i8, ptr %i11, i64 %i
  %i13 = getelementptr i8, ptr %i12, i64 %i
  %i14 = getelementptr i8, ptr %i13, i64 %i
  %i140 = load i8, ptr %i14, align 1
  %i1412 = zext i8 %i140 to i32
  %i142 = mul i32 %arg1, %i1412
  %i143 = getelementptr i8, ptr %i13, i64 15
  %i144 = load i8, ptr %i143, align 1
  %i1453 = zext i8 %i144 to i32
  %i146 = mul i32 %arg1, %i1453
  %i147 = getelementptr i8, ptr %i13, i64 14
  %i148 = load i8, ptr %i147, align 1
  %i1494 = zext i8 %i148 to i32
  %i150 = mul i32 %arg1, %i1494
  %i151 = getelementptr i8, ptr %i13, i64 13
  %i152 = load i8, ptr %i151, align 1
  %i1535 = zext i8 %i152 to i32
  %i154 = mul i32 %arg1, %i1535
  %i1311 = or i32 %i142, %i146
  %i1312 = or i32 %i1311, %i150
  %i1313 = or i32 %i1312, %i154
  %i1536 = zext i32 %i1313 to i64
  ret i64 %i1536
}

attributes #0 = { "target-features"="+v" }
