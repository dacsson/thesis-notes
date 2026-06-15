; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/CodeGenPrepare/RISCV/fpclass-test.ll
; Variant: riscv64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -codegenprepare -mtriple=riscv64 -S
; Original: RUN: opt -codegenprepare -S -mtriple=riscv64 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i1 @test_is_inf_or_nan(double %arg) {
  %abs = tail call double @llvm.fabs.f64(double %arg)
  %ret = fcmp ueq double %abs, 0x7FF0000000000000
  ret i1 %ret
}

define i1 @test_is_not_inf_or_nan(double %arg) {
  %abs = tail call double @llvm.fabs.f64(double %arg)
  %ret = fcmp one double %abs, 0x7FF0000000000000
  ret i1 %ret
}

define i1 @test_is_inf(double %arg) {
  %abs = tail call double @llvm.fabs.f64(double %arg)
  %ret = fcmp oeq double %abs, 0x7FF0000000000000
  ret i1 %ret
}

define i1 @test_is_not_inf(double %arg) {
  %abs = tail call double @llvm.fabs.f64(double %arg)
  %ret = fcmp une double %abs, 0x7FF0000000000000
  ret i1 %ret
}

define <vscale x 4 x i1> @test_vec_is_inf_or_nan(<vscale x 4 x double> %arg) {
  %abs = tail call <vscale x 4 x double> @llvm.fabs.nxv4f64(<vscale x 4 x double> %arg)
  %ret = fcmp ueq <vscale x 4 x double> %abs, splat (double 0x7FF0000000000000)
  ret <vscale x 4 x i1> %ret
}

define <vscale x 4 x i1> @test_vec_is_not_inf_or_nan(<vscale x 4 x double> %arg) {
  %abs = tail call <vscale x 4 x double> @llvm.fabs.nxv4f64(<vscale x 4 x double> %arg)
  %ret = fcmp one <vscale x 4 x double> %abs, splat (double 0x7FF0000000000000)
  ret <vscale x 4 x i1> %ret
}

define <vscale x 4 x i1> @test_vec_is_inf(<vscale x 4 x double> %arg) {
  %abs = tail call <vscale x 4 x double> @llvm.fabs.nxv4f64(<vscale x 4 x double> %arg)
  %ret = fcmp oeq <vscale x 4 x double> %abs, splat (double 0x7FF0000000000000)
  ret <vscale x 4 x i1> %ret
}

define <vscale x 4 x i1> @test_vec_is_not_inf(<vscale x 4 x double> %arg) {
  %abs = tail call <vscale x 4 x double> @llvm.fabs.nxv4f64(<vscale x 4 x double> %arg)
  %ret = fcmp une <vscale x 4 x double> %abs, splat (double 0x7FF0000000000000)
  ret <vscale x 4 x i1> %ret
}

define i1 @test_fp128_is_inf_or_nan(fp128 %arg) {
  %abs = tail call fp128 @llvm.fabs.f128(fp128 %arg)
  %ret = fcmp ueq fp128 %abs, 0xL00000000000000007FFF000000000000
  ret i1 %ret
}

define i1 @test_fp128_is_not_inf_or_nan(fp128 %arg) {
  %abs = tail call fp128 @llvm.fabs.f128(fp128 %arg)
  %ret = fcmp one fp128 %abs, 0xL00000000000000007FFF000000000000
  ret i1 %ret
}

define i1 @test_fp128_is_inf(fp128 %arg) {
  %abs = tail call fp128 @llvm.fabs.f128(fp128 %arg)
  %ret = fcmp oeq fp128 %abs, 0xL00000000000000007FFF000000000000
  ret i1 %ret
}

define i1 @test_fp128_is_not_inf(fp128 %arg) {
  %abs = tail call fp128 @llvm.fabs.f128(fp128 %arg)
  %ret = fcmp une fp128 %abs, 0xL00000000000000007FFF000000000000
  ret i1 %ret
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp838_s85x.ll'
source_filename = "/tmp/tmp838_s85x.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i1 @test_is_inf_or_nan(double %arg) {
  %1 = call i1 @llvm.is.fpclass.f64(double %arg, i32 519)
  ret i1 %1
}

define i1 @test_is_not_inf_or_nan(double %arg) {
  %1 = call i1 @llvm.is.fpclass.f64(double %arg, i32 504)
  ret i1 %1
}

define i1 @test_is_inf(double %arg) {
  %1 = call i1 @llvm.is.fpclass.f64(double %arg, i32 516)
  ret i1 %1
}

define i1 @test_is_not_inf(double %arg) {
  %1 = call i1 @llvm.is.fpclass.f64(double %arg, i32 507)
  ret i1 %1
}

define <vscale x 4 x i1> @test_vec_is_inf_or_nan(<vscale x 4 x double> %arg) {
  %1 = call <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double> %arg, i32 519)
  ret <vscale x 4 x i1> %1
}

define <vscale x 4 x i1> @test_vec_is_not_inf_or_nan(<vscale x 4 x double> %arg) {
  %1 = call <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double> %arg, i32 504)
  ret <vscale x 4 x i1> %1
}

define <vscale x 4 x i1> @test_vec_is_inf(<vscale x 4 x double> %arg) {
  %1 = call <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double> %arg, i32 516)
  ret <vscale x 4 x i1> %1
}

define <vscale x 4 x i1> @test_vec_is_not_inf(<vscale x 4 x double> %arg) {
  %1 = call <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double> %arg, i32 507)
  ret <vscale x 4 x i1> %1
}

define i1 @test_fp128_is_inf_or_nan(fp128 %arg) {
  %1 = call i1 @llvm.is.fpclass.f128(fp128 %arg, i32 519)
  ret i1 %1
}

define i1 @test_fp128_is_not_inf_or_nan(fp128 %arg) {
  %1 = call i1 @llvm.is.fpclass.f128(fp128 %arg, i32 504)
  ret i1 %1
}

define i1 @test_fp128_is_inf(fp128 %arg) {
  %1 = call i1 @llvm.is.fpclass.f128(fp128 %arg, i32 516)
  ret i1 %1
}

define i1 @test_fp128_is_not_inf(fp128 %arg) {
  %1 = call i1 @llvm.is.fpclass.f128(fp128 %arg, i32 507)
  ret i1 %1
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare fp128 @llvm.fabs.f128(fp128) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x double> @llvm.fabs.nxv4f64(<vscale x 4 x double>) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.is.fpclass.f64(double, i32 immarg) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double>, i32 immarg) #0

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.is.fpclass.f128(fp128, i32 immarg) #0

attributes #0 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
