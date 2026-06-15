; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InstCombine/RISCV/riscv-vmv-v-x.ll
; Variant: riscv32_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p instcombine -mtriple=riscv32 -mattr=+v -S
; Original: RUN: opt -p instcombine -mtriple=riscv32 -mattr=+v -S %s | FileCheck %s --check-prefixes=CHECK,RV32

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <vscale x 2 x i32> @target_vl_one() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 4 x i16> @target_vl_two() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 4 x i16>
  ret <vscale x 4 x i16> %b
}

define <vscale x 2 x i32> @target_vl_32() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 128)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @small_scalar() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 3, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @negative_scalar() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 -4, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 8 x i8> @no_bitcast() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 4)
  ret <vscale x 8 x i8> %a
}

declare void @use.nxv2i32(<vscale x 2 x i32>)
declare void @use.nxv1i64(<vscale x 1 x i64>)

define void @bitcast_users_type_mismatch() {
  %vmv = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 4)
  %cast.1 = bitcast <vscale x 8 x i8> %vmv to <vscale x 2 x i32>
  %cast.2 = bitcast <vscale x 8 x i8> %vmv to <vscale x 1 x i64>
  call void @use.nxv2i32(<vscale x 2 x i32> %cast.1)
  call void @use.nxv1i64(<vscale x 1 x i64> %cast.2)
  ret void
}

define <vscale x 1 x i64> @bitcast_target_elt_type_too_large() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 1 x i64>
  ret <vscale x 1 x i64> %b
}

define <vscale x 64 x i1> @bitcast_target_elt_type_too_small() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 64 x i1>
  ret <vscale x 64 x i1> %b
}

define <vscale x 2 x i32> @passthru_non_poison(<vscale x 8 x i8> %x) {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> %x, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @scalar_non_constant(i8 %scalar) {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 %scalar, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @vl_non_constant(i64 %vl) {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 %vl)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 1 x i32> @vl_not_divisible() {
  %a = call <vscale x 4 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 4 x i8> poison, i8 85, i64 7)
  %b = bitcast <vscale x 4 x i8> %a to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %b
}

define <vscale x 1 x i64> @vector_elt_type_legality() {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8(<vscale x 8 x i8> poison, i8 85, i64 8)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 1 x i64>
  ret <vscale x 1 x i64> %b
}

define <vscale x 4 x float> @eq_num_elts() {
  %a = call <vscale x 4 x i32> @llvm.riscv.vmv.v.x.nxv4i32.i64(<vscale x 4 x i32> poison, i32 -1615569626, i64 2)
  %b = bitcast <vscale x 4 x i32> %a to <vscale x 4 x float>
  ret <vscale x 4 x float> %b
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpwnkuzvtt.ll'
source_filename = "/tmp/tmpwnkuzvtt.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define <vscale x 2 x i32> @target_vl_one() #0 {
  %1 = call <vscale x 2 x i32> @llvm.riscv.vmv.v.x.nxv2i32.i64(<vscale x 2 x i32> poison, i32 1431655765, i64 1)
  ret <vscale x 2 x i32> %1
}

define <vscale x 4 x i16> @target_vl_two() #0 {
  %1 = call <vscale x 4 x i16> @llvm.riscv.vmv.v.x.nxv4i16.i64(<vscale x 4 x i16> poison, i16 21845, i64 2)
  ret <vscale x 4 x i16> %1
}

define <vscale x 2 x i32> @target_vl_32() #0 {
  %1 = call <vscale x 2 x i32> @llvm.riscv.vmv.v.x.nxv2i32.i64(<vscale x 2 x i32> poison, i32 1431655765, i64 32)
  ret <vscale x 2 x i32> %1
}

define <vscale x 2 x i32> @small_scalar() #0 {
  %1 = call <vscale x 2 x i32> @llvm.riscv.vmv.v.x.nxv2i32.i64(<vscale x 2 x i32> poison, i32 50529027, i64 1)
  ret <vscale x 2 x i32> %1
}

define <vscale x 2 x i32> @negative_scalar() #0 {
  %1 = call <vscale x 2 x i32> @llvm.riscv.vmv.v.x.nxv2i32.i64(<vscale x 2 x i32> poison, i32 -50529028, i64 1)
  ret <vscale x 2 x i32> %1
}

define <vscale x 8 x i8> @no_bitcast() #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 85, i64 4)
  ret <vscale x 8 x i8> %a
}

declare void @use.nxv2i32(<vscale x 2 x i32>) #0

declare void @use.nxv1i64(<vscale x 1 x i64>) #0

define void @bitcast_users_type_mismatch() #0 {
  %vmv = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 85, i64 4)
  %cast.1 = bitcast <vscale x 8 x i8> %vmv to <vscale x 2 x i32>
  %cast.2 = bitcast <vscale x 8 x i8> %vmv to <vscale x 1 x i64>
  call void @use.nxv2i32(<vscale x 2 x i32> %cast.1)
  call void @use.nxv1i64(<vscale x 1 x i64> %cast.2)
  ret void
}

define <vscale x 1 x i64> @bitcast_target_elt_type_too_large() #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 1 x i64>
  ret <vscale x 1 x i64> %b
}

define <vscale x 64 x i1> @bitcast_target_elt_type_too_small() #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 64 x i1>
  ret <vscale x 64 x i1> %b
}

define <vscale x 2 x i32> @passthru_non_poison(<vscale x 8 x i8> %x) #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> %x, i8 85, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @scalar_non_constant(i8 %scalar) #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 %scalar, i64 4)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @vl_non_constant(i64 %vl) #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 85, i64 %vl)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %b
}

define <vscale x 1 x i32> @vl_not_divisible() #0 {
  %a = call <vscale x 4 x i8> @llvm.riscv.vmv.v.x.nxv4i8.i64(<vscale x 4 x i8> poison, i8 85, i64 7)
  %b = bitcast <vscale x 4 x i8> %a to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %b
}

define <vscale x 1 x i64> @vector_elt_type_legality() #0 {
  %a = call <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8> poison, i8 85, i64 8)
  %b = bitcast <vscale x 8 x i8> %a to <vscale x 1 x i64>
  ret <vscale x 1 x i64> %b
}

define <vscale x 4 x float> @eq_num_elts() #0 {
  %a = call <vscale x 4 x i32> @llvm.riscv.vmv.v.x.nxv4i32.i64(<vscale x 4 x i32> poison, i32 -1615569626, i64 2)
  %b = bitcast <vscale x 4 x i32> %a to <vscale x 4 x float>
  ret <vscale x 4 x float> %b
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.riscv.vmv.v.x.nxv4i32.i64(<vscale x 4 x i32>, i32, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 8 x i8> @llvm.riscv.vmv.v.x.nxv8i8.i64(<vscale x 8 x i8>, i8, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i8> @llvm.riscv.vmv.v.x.nxv4i8.i64(<vscale x 4 x i8>, i8, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i32> @llvm.riscv.vmv.v.x.nxv2i32.i64(<vscale x 2 x i32>, i32, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i16> @llvm.riscv.vmv.v.x.nxv4i16.i64(<vscale x 4 x i16>, i16, i64) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
