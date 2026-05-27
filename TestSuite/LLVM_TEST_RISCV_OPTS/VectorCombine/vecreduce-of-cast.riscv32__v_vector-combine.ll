; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/vecreduce-of-cast.ll
; Variant: riscv32_+v_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=vector-combine -mtriple=riscv32 -mattr=+v -S
; Original: RUN: opt < %s -passes=vector-combine -S -mtriple=riscv32 -mattr=+v | FileCheck  %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Fold reduce(cast(X)) -> trunc(cast(X)) if more cost efficient

define i32 @reduce_add_trunc_v8i64_to_v8i32(<8 x i64> %a0)  {
  %tr = trunc <8 x i64> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %tr)
  ret i32 %red
}

define i16 @reduce_add_trunc_v8i64_to_v8i16(<8 x i64> %a0)  {
  %tr = trunc <8 x i64> %a0 to <8 x i16>
  %red = tail call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %tr)
  ret i16 %red
}

define i8 @reduce_add_trunc_v8i64_to_v8i8(<8 x i64> %a0)  {
  %tr = trunc <8 x i64> %a0 to <8 x i8>
  %red = tail call i8 @llvm.vector.reduce.add.v8i8(<8 x i8> %tr)
  ret i8 %red
}

define i8 @reduce_or_trunc_v8i32_i8(<8 x i32> %a0)  {
  %tr = trunc <8 x i32> %a0 to <8 x i8>
  %red = tail call i8 @llvm.vector.reduce.or.v8i32(<8 x i8> %tr)
  ret i8 %red
}

define i8 @reduce_xor_trunc_v16i64_i8(<16 x i64> %a0)  {
  %tr = trunc <16 x i64> %a0 to <16 x i8>
  %red = tail call i8 @llvm.vector.reduce.xor.v16i8(<16 x i8> %tr)
  ret i8 %red
}

define i16 @reduce_mul_trunc_v8i64_i16(<8 x i64> %a0)  {
  %tr = trunc <8 x i64> %a0 to <8 x i16>
  %red = tail call i16 @llvm.vector.reduce.mul.v8i16(<8 x i16> %tr)
  ret i16 %red
}

define i32 @reduce_or_sext_v8i8_to_v8i32(<8 x i8> %a0)  {
  %tr = sext <8 x i8> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> %tr)
  ret i32 %red
}

define i32 @reduce_or_sext_v8i16_to_v8i32(<8 x i16> %a0)  {
  %tr = sext <8 x i16> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> %tr)
  ret i32 %red
}

define i32 @reduce_or_zext_v8i8_to_v8i32(<8 x i8> %a0)  {
  %tr = zext <8 x i8> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> %tr)
  ret i32 %red
}

define i32 @reduce_or_zext_v8i16_to_v8i32(<8 x i16> %a0)  {
  %tr = zext <8 x i16> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> %tr)
  ret i32 %red
}

; Negative case - narrowing the reduce (to i8) is illegal.
; TODO: We could narrow to i16 instead.
define i32 @reduce_add_trunc_v8i8_to_v8i32(<8 x i8> %a0)  {
  %tr = zext <8 x i8> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %tr)
  ret i32 %red
}


declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>)
declare i8 @llvm.vector.reduce.add.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.or.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.xor.v16i8(<16 x i8>)
declare i16 @llvm.vector.reduce.and.v16i16(<16 x i16>)
declare i16 @llvm.vector.reduce.mul.v8i16(<8 x i16>)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpon09puhi.ll'
source_filename = "/tmp/tmpon09puhi.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define i32 @reduce_add_trunc_v8i64_to_v8i32(<8 x i64> %a0) #0 {
  %1 = call i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %a0)
  %red = trunc i64 %1 to i32
  ret i32 %red
}

define i16 @reduce_add_trunc_v8i64_to_v8i16(<8 x i64> %a0) #0 {
  %1 = call i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %a0)
  %red = trunc i64 %1 to i16
  ret i16 %red
}

define i8 @reduce_add_trunc_v8i64_to_v8i8(<8 x i64> %a0) #0 {
  %1 = call i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %a0)
  %red = trunc i64 %1 to i8
  ret i8 %red
}

define i8 @reduce_or_trunc_v8i32_i8(<8 x i32> %a0) #0 {
  %1 = call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> %a0)
  %red = trunc i32 %1 to i8
  ret i8 %red
}

define i8 @reduce_xor_trunc_v16i64_i8(<16 x i64> %a0) #0 {
  %1 = call i64 @llvm.vector.reduce.xor.v16i64(<16 x i64> %a0)
  %red = trunc i64 %1 to i8
  ret i8 %red
}

define i16 @reduce_mul_trunc_v8i64_i16(<8 x i64> %a0) #0 {
  %tr = trunc <8 x i64> %a0 to <8 x i16>
  %red = tail call i16 @llvm.vector.reduce.mul.v8i16(<8 x i16> %tr)
  ret i16 %red
}

define i32 @reduce_or_sext_v8i8_to_v8i32(<8 x i8> %a0) #0 {
  %1 = call i8 @llvm.vector.reduce.or.v8i8(<8 x i8> %a0)
  %red = sext i8 %1 to i32
  ret i32 %red
}

define i32 @reduce_or_sext_v8i16_to_v8i32(<8 x i16> %a0) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> %a0)
  %red = sext i16 %1 to i32
  ret i32 %red
}

define i32 @reduce_or_zext_v8i8_to_v8i32(<8 x i8> %a0) #0 {
  %1 = call i8 @llvm.vector.reduce.or.v8i8(<8 x i8> %a0)
  %red = zext i8 %1 to i32
  ret i32 %red
}

define i32 @reduce_or_zext_v8i16_to_v8i32(<8 x i16> %a0) #0 {
  %1 = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> %a0)
  %red = zext i16 %1 to i32
  ret i32 %red
}

define i32 @reduce_add_trunc_v8i8_to_v8i32(<8 x i8> %a0) #0 {
  %tr = zext <8 x i8> %a0 to <8 x i32>
  %red = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %tr)
  ret i32 %red
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.add.v8i8(<8 x i8>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.or.v8i8(<8 x i8>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.vector.reduce.xor.v16i8(<16 x i8>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.and.v16i16(<16 x i16>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.mul.v8i16(<8 x i16>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.or.v8i32(<8 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v8i64(<8 x i64>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.xor.v16i64(<16 x i64>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.vector.reduce.or.v8i16(<8 x i16>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
