; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/PhaseOrdering/RISCV/any-of-vectorization.ll
; Variant: riscv64_+v_default<O2>,function(riscv-codegenprepare)
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple riscv64 -mattr=+v -p 'default<O2>,function(riscv-codegenprepare)' -S
; Original: RUN: opt -mtriple riscv64 -mattr=+v -p 'default<O2>,function(riscv-codegenprepare)' -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure we widen the vp.merge from LoopVectorizer to i8 in RISCVCodeGenPrepare

define i32 @f(ptr %p, i32 %n) {
entry:
  %skip = icmp eq i32 %n, 0
  br i1 %skip, label %exit, label %loop

loop:
  %iv = phi i32 [0, %entry], [%iv.next, %loop]
  %rdx = phi i32 [0, %entry], [%rdx.next, %loop]
  %gep = getelementptr i32, ptr %p, i32 %iv
  %x = load i32, ptr %gep
  %cmp = icmp eq i32 %x, 0
  %rdx.next = select i1 %cmp, i32 1, i32 %rdx
  %iv.next = add nsw i32 %iv, 1
  %ec = icmp eq i32 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  %res = phi i32 [0, %entry], [%rdx.next, %loop]
  ret i32 %res
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpqnvbdz__.ll'
source_filename = "/tmp/tmpqnvbdz__.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read)
define range(i32 0, 2) i32 @f(ptr readonly captures(none) %p, i32 %n) local_unnamed_addr #0 {
entry:
  %skip = icmp eq i32 %n, 0
  br i1 %skip, label %exit, label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = zext i32 %n to i64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %1 = phi <vscale x 4 x i8> [ zeroinitializer, %vector.ph ], [ %6, %vector.body ]
  %avl = phi i64 [ %0, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = tail call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %3 = getelementptr [4 x i8], ptr %p, i64 %index
  %vp.op.load = tail call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %4 = icmp eq <vscale x 4 x i32> %vp.op.load, zeroinitializer
  %5 = call <vscale x 4 x i8> @llvm.vp.merge.nxv4i8(<vscale x 4 x i1> %4, <vscale x 4 x i8> splat (i8 1), <vscale x 4 x i8> %1, i32 %2)
  %6 = freeze <vscale x 4 x i8> %5
  %7 = trunc <vscale x 4 x i8> %6 to <vscale x 4 x i1>
  %8 = zext i32 %2 to i64
  %current.iteration.next = add nuw i64 %index, %8
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %exit.loopexit, label %vector.body, !llvm.loop !0

exit.loopexit:                                    ; preds = %vector.body
  %10 = tail call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %7)
  %rdx.select = zext i1 %10 to i32
  br label %exit

exit:                                             ; preds = %exit.loopexit, %entry
  %res = phi i32 [ 0, %entry ], [ %rdx.select, %exit.loopexit ]
  ret i32 %res
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vp.merge.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i8> @llvm.vp.merge.nxv4i8(<vscale x 4 x i1>, <vscale x 4 x i8>, <vscale x 4 x i8>, i32) #1

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: read) "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
