; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/lmul.ll
; Variant: riscv64_+v_loop-vectorize_LMUL2
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v --riscv-v-register-bit-width-lmul=2 -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v -S --riscv-v-register-bit-width-lmul=2 | FileCheck %s -check-prefix=LMUL2

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @load_store(ptr %p) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %q = getelementptr inbounds i64, ptr %p, i64 %iv
  %v = load i64, ptr %q
  %w = add i64 %v, 1
  store i64 %w, ptr %q
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpv0at2o58.ll'
source_filename = "/tmp/tmpv0at2o58.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 2 x i64> %vp.op.load, splat (i64 1)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
