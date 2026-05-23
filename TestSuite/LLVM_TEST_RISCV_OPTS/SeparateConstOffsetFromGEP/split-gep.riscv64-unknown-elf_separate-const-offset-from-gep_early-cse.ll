; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SeparateConstOffsetFromGEP/RISCV/split-gep.ll
; Variant: riscv64-unknown-elf_separate-const-offset-from-gep,early-cse
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-unknown-elf -passes='separate-const-offset-from-gep,early-cse' -S
; Original: RUN: opt < %s -mtriple=riscv64-unknown-elf -passes='separate-const-offset-from-gep,early-cse'  -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Several tests for separate-const-offset-from-gep. The transformation
; heavily relies on TargetTransformInfo, so we put these tests under
; target-specific folders.

; Simple case when GEPs should be optimized.
define i64 @test1(ptr %array, i64 %i, i64 %j)  {
entry:
  %add = add nsw i64 %i, 5
  %gep = getelementptr inbounds i64, ptr %array, i64 %add
  store i64 %j, ptr %gep
  %add2 = add nsw i64 %i, 6
  %gep2 = getelementptr inbounds i64, ptr %array, i64 %add2
  store i64 %j, ptr %gep2
  %add3 = add nsw i64 %i, 35
  %gep3 = getelementptr inbounds i64, ptr %array, i64 %add3
  store i64 %add, ptr %gep3
  ret i64 undef
}

; Optimize GEPs when there sext instructions are needed to cast index value to expected type.
define i32 @test2(ptr %array, i32 %i, i32 %j) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %array, i64 %sext
  store i32 %j, ptr %gep
  %add3 = add nsw i32 %i, 6
  %sext4 = sext i32 %add3 to i64
  %gep5 = getelementptr inbounds i32, ptr %array, i64 %sext4
  store i32 %j, ptr %gep5
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds i32, ptr %array, i64 %sext7
  store i32 %add, ptr %gep8
  ret i32 undef
}

; No need to modify because all values are also used in other expressions.
; Modification doesn't decrease register pressure.
define i32 @test3(ptr %array, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %array, i64 %sext
  store i32 %add, ptr %gep
  %add3 = add nsw i32 %i, 6
  %sext4 = sext i32 %add3 to i64
  %gep5 = getelementptr inbounds i32, ptr %array, i64 %sext4
  store i32 %add3, ptr %gep5
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds i32, ptr %array, i64 %sext7
  store i32 %add6, ptr %gep8
  ret i32 undef
}

; Optimized GEPs for multidimensional array with same base
define i32 @test4(ptr %array2, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext, i64 %sext
  store i32 %i, ptr %gep
  %add3 = add nsw i32 %i, 6
  %sext4 = sext i32 %add3 to i64
  %gep5 = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext, i64 %sext4
  store i32 %add, ptr %gep5
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext, i64 %sext7
  store i32 %i, ptr %gep8
  ret i32 undef
}

; Don't optimize GEPs for multidimensional array with same base because RISC-V doesn't support the addressing mode
define i32 @test5(ptr %array2, i32 %i, i64 %j) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext, i64 %sext
  store i32 %add, ptr %gep
  %add3 = add nsw i32 %i, 6
  %sext4 = sext i32 %add3 to i64
  %gep5 = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext4, i64 %j
  store i32 %i, ptr %gep5
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext7, i64 %j
  store i32 %i, ptr %gep8
  ret i32 undef
}

; No need to optimize GEPs, because there is critical amount with non-constant offsets.
define i64 @test6(ptr %array, i64 %i, i64 %j) {
entry:
  %add = add nsw i64 %i, 5
  %gep = getelementptr inbounds i64, ptr %array, i64 %j
  store i64 %add, ptr %gep
  %add3 = add nsw i64 %i, 6
  %gep5 = getelementptr inbounds i64, ptr %array, i64 %add3
  store i64 %i, ptr %gep5
  %add6 = add nsw i64 %i, 35
  %gep8 = getelementptr inbounds i64, ptr %array, i64 %i
  store i64 %i, ptr %gep8
  ret i64 undef
}

; No need to optimize GEPs, because the base variable is different.
define i32 @test7(ptr %array, i32 %i, i32 %j, i32 %k) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %array, i64 %sext
  store i32 %add, ptr %gep
  %add3 = add nsw i32 %k, 6
  %sext4 = sext i32 %add3 to i64
  %gep5 = getelementptr inbounds i32, ptr %array, i64 %sext4
  store i32 %i, ptr %gep5
  %add6 = add nsw i32 %j, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds i32, ptr %array, i64 %sext7
  store i32 %i, ptr %gep8
  ret i32 undef
}

; No need to optimize GEPs, because the base of GEP instructions is different.
define i32 @test8(ptr %array, ptr %array2, ptr %array3, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %array, i64 %sext
  store i32 %add, ptr %gep
  %add3 = add nsw i32 %i, 6
  %sext4 = sext i32 %add3 to i64
  %gep5 = getelementptr inbounds i32, ptr %array2, i64 %sext4
  store i32 %i, ptr %gep5
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds i32, ptr %array3, i64 %sext7
  store i32 %i, ptr %gep8
  ret i32 undef
}

; No need to optimize GEPs of multidimensional array, because the base of GEP instructions is different.
define i32 @test9(ptr %array, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %sext = sext i32 %add to i64
  %gep = getelementptr inbounds [50 x i32], ptr %array, i64 0, i64 %sext
  store i32 %add, ptr %gep
  %add3 = add nsw i32 %i, 6
  %sext4 = sext i32 %add3 to i64
  %int = sext i32 %i to i64
  %gep5 = getelementptr inbounds [50 x i32], ptr %array, i64 %int, i64 %sext4
  store i32 %i, ptr %gep5
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds [50 x i32], ptr %array, i64 %sext4, i64 %sext7
  store i32 %i, ptr %gep8
  ret i32 undef
}

; Case where inbounds can't be preserved despite the fact that %shr is positive -
; byte offset (%shr * 8) is negative, so the GEP with %shr index can be outside of
; bounds of the allocated object.
define i64 @test_inbounds1(ptr %arr, i64 %x) {
entry:
  %min = tail call i64 @llvm.umin.i64(i64 %x, i64 4)
  %xor = xor i64 %min, -1
  %shr = lshr i64 %xor, 1
  %sub = add nsw i64 %shr, -9223372036854775803
  %gep = getelementptr inbounds nuw [6 x i64], ptr %arr, i64 0, i64 %sub
  %res = load i64, ptr %gep, align 8
  ret i64 %res
}

; The same case as above - inbounds attribute can't be preserved due to negative
; GEP index (%sub).
define i64 @test_inbounds2(ptr %arr, i64 %x) {
entry:
  %min = tail call i64 @llvm.umin.i64(i64 %x, i64 4)
  %shr = lshr i64 %min, 1
  %sub = sub nsw nuw i64 4, %shr
  %gep = getelementptr inbounds nuw [6 x i64], ptr %arr, i64 0, i64 %sub
  %res = load i64, ptr %gep, align 8
  ret i64 %res
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmphb3up9qa.ll'
source_filename = "/tmp/tmphb3up9qa.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown-elf"

define i64 @test1(ptr %array, i64 %i, i64 %j) {
entry:
  %add = add nsw i64 %i, 5
  %0 = getelementptr i64, ptr %array, i64 %i
  %gep4 = getelementptr i8, ptr %0, i64 40
  store i64 %j, ptr %gep4, align 8
  %gep26 = getelementptr i8, ptr %0, i64 48
  store i64 %j, ptr %gep26, align 8
  %gep38 = getelementptr i8, ptr %0, i64 280
  store i64 %add, ptr %gep38, align 8
  ret i64 undef
}

define i32 @test2(ptr %array, i32 %i, i32 %j) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr i32, ptr %array, i64 %0
  %gep2 = getelementptr i8, ptr %1, i64 20
  store i32 %j, ptr %gep2, align 4
  %gep54 = getelementptr i8, ptr %1, i64 24
  store i32 %j, ptr %gep54, align 4
  %gep86 = getelementptr i8, ptr %1, i64 140
  store i32 %add, ptr %gep86, align 4
  ret i32 undef
}

define i32 @test3(ptr %array, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr i32, ptr %array, i64 %0
  %gep2 = getelementptr i8, ptr %1, i64 20
  store i32 %add, ptr %gep2, align 4
  %add3 = add nsw i32 %i, 6
  %gep54 = getelementptr i8, ptr %1, i64 24
  store i32 %add3, ptr %gep54, align 4
  %add6 = add nsw i32 %i, 35
  %gep86 = getelementptr i8, ptr %1, i64 140
  store i32 %add6, ptr %gep86, align 4
  ret i32 undef
}

define i32 @test4(ptr %array2, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr [50 x i32], ptr %array2, i64 %0, i64 %0
  %gep3 = getelementptr i8, ptr %1, i64 1020
  store i32 %i, ptr %gep3, align 4
  %gep56 = getelementptr i8, ptr %1, i64 1024
  store i32 %add, ptr %gep56, align 4
  %gep89 = getelementptr i8, ptr %1, i64 1140
  store i32 %i, ptr %gep89, align 4
  ret i32 undef
}

define i32 @test5(ptr %array2, i32 %i, i64 %j) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr [50 x i32], ptr %array2, i64 %0, i64 %0
  %gep3 = getelementptr i8, ptr %1, i64 1020
  store i32 %add, ptr %gep3, align 4
  %2 = getelementptr [50 x i32], ptr %array2, i64 %0, i64 %j
  %gep55 = getelementptr i8, ptr %2, i64 1200
  store i32 %i, ptr %gep55, align 4
  %add6 = add nsw i32 %i, 35
  %sext7 = sext i32 %add6 to i64
  %gep8 = getelementptr inbounds [50 x i32], ptr %array2, i64 %sext7, i64 %j
  store i32 %i, ptr %gep8, align 4
  ret i32 undef
}

define i64 @test6(ptr %array, i64 %i, i64 %j) {
entry:
  %add = add nsw i64 %i, 5
  %gep = getelementptr inbounds i64, ptr %array, i64 %j
  store i64 %add, ptr %gep, align 8
  %0 = getelementptr i64, ptr %array, i64 %i
  %gep52 = getelementptr i8, ptr %0, i64 48
  store i64 %i, ptr %gep52, align 8
  store i64 %i, ptr %0, align 8
  ret i64 undef
}

define i32 @test7(ptr %array, i32 %i, i32 %j, i32 %k) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr i32, ptr %array, i64 %0
  %gep2 = getelementptr i8, ptr %1, i64 20
  store i32 %add, ptr %gep2, align 4
  %2 = sext i32 %k to i64
  %3 = getelementptr i32, ptr %array, i64 %2
  %gep54 = getelementptr i8, ptr %3, i64 24
  store i32 %i, ptr %gep54, align 4
  %4 = sext i32 %j to i64
  %5 = getelementptr i32, ptr %array, i64 %4
  %gep86 = getelementptr i8, ptr %5, i64 140
  store i32 %i, ptr %gep86, align 4
  ret i32 undef
}

define i32 @test8(ptr %array, ptr %array2, ptr %array3, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr i32, ptr %array, i64 %0
  %gep2 = getelementptr i8, ptr %1, i64 20
  store i32 %add, ptr %gep2, align 4
  %2 = getelementptr i32, ptr %array2, i64 %0
  %gep54 = getelementptr i8, ptr %2, i64 24
  store i32 %i, ptr %gep54, align 4
  %3 = getelementptr i32, ptr %array3, i64 %0
  %gep86 = getelementptr i8, ptr %3, i64 140
  store i32 %i, ptr %gep86, align 4
  ret i32 undef
}

define i32 @test9(ptr %array, i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %0 = sext i32 %i to i64
  %1 = getelementptr [50 x i32], ptr %array, i64 0, i64 %0
  %gep2 = getelementptr i8, ptr %1, i64 20
  store i32 %add, ptr %gep2, align 4
  %2 = getelementptr [50 x i32], ptr %array, i64 %0, i64 %0
  %gep54 = getelementptr i8, ptr %2, i64 24
  store i32 %i, ptr %gep54, align 4
  %gep87 = getelementptr i8, ptr %2, i64 1340
  store i32 %i, ptr %gep87, align 4
  ret i32 undef
}

define i64 @test_inbounds1(ptr %arr, i64 %x) {
entry:
  %min = tail call i64 @llvm.umin.i64(i64 %x, i64 4)
  %xor = xor i64 %min, -1
  %shr = lshr i64 %xor, 1
  %0 = getelementptr [6 x i64], ptr %arr, i64 0, i64 %shr
  %gep2 = getelementptr i8, ptr %0, i64 40
  %res = load i64, ptr %gep2, align 8
  ret i64 %res
}

define i64 @test_inbounds2(ptr %arr, i64 %x) {
entry:
  %min = tail call i64 @llvm.umin.i64(i64 %x, i64 4)
  %shr = lshr i64 %min, 1
  %sub1 = sub i64 0, %shr
  %0 = getelementptr [6 x i64], ptr %arr, i64 0, i64 %sub1
  %gep2 = getelementptr i8, ptr %0, i64 32
  %res = load i64, ptr %gep2, align 8
  ret i64 %res
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #0

attributes #0 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
