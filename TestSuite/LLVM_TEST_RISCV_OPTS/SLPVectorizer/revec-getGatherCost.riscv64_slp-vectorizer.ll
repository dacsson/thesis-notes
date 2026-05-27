; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/revec-getGatherCost.ll
; Variant: riscv64_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mcpu=sifive-x280 -passes=slp-vectorizer -slp-revec -slp-max-reg-size=1024 -slp-threshold=-20 -pass-remarks-output= -S
; Original: RUN: opt -mtriple=riscv64 -mcpu=sifive-x280 -passes=slp-vectorizer -S -slp-revec -slp-max-reg-size=1024 -slp-threshold=-20 -pass-remarks-output=%t %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @test1(<4 x float> %load6, <4 x float> %load7, <4 x float> %load8, <4 x float> %load17, <4 x float> %fmuladd7, <4 x float> %fmuladd16, ptr %out_ptr) {
entry:
  %vext165.i = shufflevector <4 x float> %load6, <4 x float> %load7, <4 x i32> <i32 2, i32 3, i32 4, i32 5>
  %vext309.i = shufflevector <4 x float> %load7, <4 x float> %load8, <4 x i32> <i32 2, i32 3, i32 4, i32 5>
  %fmuladd8 = tail call noundef <4 x float> @llvm.fmuladd.v4f32(<4 x float> %vext165.i, <4 x float> %load17, <4 x float> %fmuladd7)
  %fmuladd17 = tail call noundef <4 x float> @llvm.fmuladd.v4f32(<4 x float> %vext309.i, <4 x float> %load17, <4 x float> %fmuladd16)
  %add.ptr.i.i = getelementptr inbounds i8, ptr %out_ptr, i64 16
  store <4 x float> %fmuladd8, ptr %out_ptr, align 4
  store <4 x float> %fmuladd17, ptr %add.ptr.i.i, align 4
  ret void
}

declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>)


define void @test2(<8 x float> %load6, <8 x float> %load7, <8 x float> %load8, <8 x float> %load17, <8 x float> %fmuladd7, <8 x float> %fmuladd16, ptr %out_ptr) {
entry:
  %vext165.i = shufflevector <8 x float> %load6, <8 x float> %load7, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %vext309.i = shufflevector <8 x float> %load7, <8 x float> %load8, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %fmuladd8 = tail call noundef <8 x float> @llvm.fmuladd.v8f32(<8 x float> %vext165.i, <8 x float> %load17, <8 x float> %fmuladd7)
  %fmuladd17 = tail call noundef <8 x float> @llvm.fmuladd.v8f32(<8 x float> %vext309.i, <8 x float> %load17, <8 x float> %fmuladd16)
  %add.ptr.i.i = getelementptr inbounds i8, ptr %out_ptr, i64 32
  store <8 x float> %fmuladd8, ptr %out_ptr, align 4
  store <8 x float> %fmuladd17, ptr %add.ptr.i.i, align 4
  ret void
}

declare <8 x float> @llvm.fmuladd.v8f32(<8 x float>, <8 x float>, <8 x float>)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp1aqlub74.ll'
source_filename = "/tmp/tmp1aqlub74.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test1(<4 x float> %load6, <4 x float> %load7, <4 x float> %load8, <4 x float> %load17, <4 x float> %fmuladd7, <4 x float> %fmuladd16, ptr %out_ptr) #0 {
entry:
  %vext165.i = shufflevector <4 x float> %load6, <4 x float> %load7, <4 x i32> <i32 2, i32 3, i32 4, i32 5>
  %vext309.i = shufflevector <4 x float> %load7, <4 x float> %load8, <4 x i32> <i32 2, i32 3, i32 4, i32 5>
  %0 = shufflevector <4 x float> %vext165.i, <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %1 = shufflevector <4 x float> %vext309.i, <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %2 = shufflevector <8 x float> %0, <8 x float> %1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  %3 = shufflevector <4 x float> %load17, <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <4 x float> %fmuladd7, <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %5 = shufflevector <4 x float> %fmuladd16, <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %6 = shufflevector <8 x float> %4, <8 x float> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  %7 = call <8 x float> @llvm.fmuladd.v8f32(<8 x float> %2, <8 x float> %3, <8 x float> %6)
  store <8 x float> %7, ptr %out_ptr, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

define void @test2(<8 x float> %load6, <8 x float> %load7, <8 x float> %load8, <8 x float> %load17, <8 x float> %fmuladd7, <8 x float> %fmuladd16, ptr %out_ptr) #0 {
entry:
  %vext165.i = shufflevector <8 x float> %load6, <8 x float> %load7, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %vext309.i = shufflevector <8 x float> %load7, <8 x float> %load8, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %0 = shufflevector <8 x float> %vext165.i, <8 x float> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %1 = shufflevector <8 x float> %vext309.i, <8 x float> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %2 = shufflevector <16 x float> %0, <16 x float> %1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %3 = shufflevector <8 x float> %load17, <8 x float> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %4 = shufflevector <8 x float> %fmuladd7, <8 x float> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %5 = shufflevector <8 x float> %fmuladd16, <8 x float> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %6 = shufflevector <16 x float> %4, <16 x float> %5, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %7 = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> %2, <16 x float> %3, <16 x float> %6)
  store <16 x float> %7, ptr %out_ptr, align 4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.fmuladd.v8f32(<8 x float>, <8 x float>, <8 x float>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x float> @llvm.fmuladd.v16f32(<16 x float>, <16 x float>, <16 x float>) #2

attributes #0 = { "target-cpu"="sifive-x280" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-cpu"="sifive-x280" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
