; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-ordered-reduction.ll
; Variant: riscv64_+v,+f_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -force-ordered-reductions=true -hints-allow-reordering=false -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v,+f -S
; Original: RUN: opt -passes=loop-vectorize  -force-ordered-reductions=true -hints-allow-reordering=false  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v,+f -S < %s| FileCheck %s --check-prefix=IF-EVL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define float @fadd(ptr noalias nocapture readonly %a, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0.000000e+00, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %add = fadd float %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %add
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmprzhl__6d.ll'
source_filename = "/tmp/tmprzhl__6d.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define float @fadd(ptr noalias readonly captures(none) %a, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi float [ 0.000000e+00, %vector.ph ], [ %2, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds float, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = call float @llvm.vp.reduce.fadd.nxv4f32(float %vec.phi, <vscale x 4 x float> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret float %2
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vp.reduce.fadd.nxv4f32(float, <vscale x 4 x float>, <vscale x 4 x i1>, i32) #1

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
