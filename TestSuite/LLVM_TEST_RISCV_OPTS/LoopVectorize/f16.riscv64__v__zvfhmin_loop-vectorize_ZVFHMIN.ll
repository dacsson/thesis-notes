; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/f16.ll
; Variant: riscv64_+v,+zvfhmin_loop-vectorize_ZVFHMIN
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v,+zvfhmin -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v,+zvfhmin -S | FileCheck %s -check-prefix=ZVFHMIN

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @fadd(ptr noalias %a, ptr noalias %b, i64 %n) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%i.next, %loop]
  %a.gep = getelementptr half, ptr %a, i64 %i
  %b.gep = getelementptr half, ptr %b, i64 %i
  %x = load half, ptr %a.gep
  %y = load half, ptr %b.gep
  %z = fadd half %x, %y
  store half %z, ptr %a.gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp87_1ws_y.ll'
source_filename = "/tmp/tmp87_1ws_y.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @fadd(ptr noalias %a, ptr noalias %b, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 8, i1 true)
  %1 = getelementptr half, ptr %a, i64 %index
  %2 = getelementptr half, ptr %b, i64 %index
  %vp.op.load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %vp.op.load1 = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr align 2 %2, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %3 = fadd <vscale x 8 x half> %vp.op.load, %vp.op.load1
  call void @llvm.vp.store.nxv8f16.p0(<vscale x 8 x half> %3, ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8f16.p0(<vscale x 8 x half>, ptr captures(none), <vscale x 8 x i1>, i32) #3

attributes #0 = { "target-features"="+v,+zvfhmin" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
