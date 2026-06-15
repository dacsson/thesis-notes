; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/CodeGenPrepare/RISCV/cttz-ctlz.ll
; Variant: require<profile-summary>,function(codegenprepare)
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes='require<profile-summary>,function(codegenprepare)' -S
; Original: RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target triple = "riscv64-unknown-unknown"

; Check that despeculating count-zeros intrinsics doesn't crash when those
; intrinsics use scalable types.

define <vscale x 4 x i64> @cttz_nxv4i64(<vscale x 4 x i64> %x) {
  %z = call <vscale x 4 x i64> @llvm.cttz.nxv4i64(<vscale x 4 x i64> %x, i1 false)
  ret <vscale x 4 x i64> %z
}

define <vscale x 4 x i64> @ctlz_nxv4i64(<vscale x 4 x i64> %x) {
  %z = call <vscale x 4 x i64> @llvm.ctlz.nxv4i64(<vscale x 4 x i64> %x, i1 false)
  ret <vscale x 4 x i64> %z
}

declare <vscale x 4 x i64> @llvm.cttz.nxv4i64(<vscale x 4 x i64>, i1)
declare <vscale x 4 x i64> @llvm.ctlz.nxv4i64(<vscale x 4 x i64>, i1)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpeuq2d_vx.ll'
source_filename = "/tmp/tmpeuq2d_vx.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown"

define <vscale x 4 x i64> @cttz_nxv4i64(<vscale x 4 x i64> %x) {
  %z = call <vscale x 4 x i64> @llvm.cttz.nxv4i64(<vscale x 4 x i64> %x, i1 false)
  ret <vscale x 4 x i64> %z
}

define <vscale x 4 x i64> @ctlz_nxv4i64(<vscale x 4 x i64> %x) {
  %z = call <vscale x 4 x i64> @llvm.ctlz.nxv4i64(<vscale x 4 x i64> %x, i1 false)
  ret <vscale x 4 x i64> %z
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.cttz.nxv4i64(<vscale x 4 x i64>, i1 immarg) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.ctlz.nxv4i64(<vscale x 4 x i64>, i1 immarg) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
