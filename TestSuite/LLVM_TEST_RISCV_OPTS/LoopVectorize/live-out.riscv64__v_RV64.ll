; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/live-out.ll
; Variant: riscv64_+v_RV64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -vplan-verify-each -S
; Original: RUN: opt < %s -S -p loop-vectorize -mtriple riscv64 -mattr=+v -vplan-verify-each | FileCheck %s --check-prefix=RV64

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure that we generate a VPInstruction::LastActiveLane that matches the
; targets index type, i.e. i64 on RV64 and i32 on RV32.  Otherwise on rv32 with
; zve32x we return an invalid cost for cttz.elts with scalable VFs.

define i32 @live_out(ptr %p, i64 %n) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %gep = getelementptr i32, ptr %p, i64 %iv
  %ld = load i32, ptr %gep
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  %ret = phi i32 [ %ld, %loop ]
  ret i32 %ret
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpue0kxmfz.ll'
source_filename = "/tmp/tmpue0kxmfz.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @live_out(ptr %p, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr i32, ptr %p, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = zext i32 %0 to i64
  %current.iteration.next = add i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %4 = sub i64 %2, 1
  %5 = extractelement <vscale x 4 x i32> %vp.op.load, i64 %4
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %5
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
