; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/ordered-reduction.ll
; Variant: loop-vectorize_CHECK-ORDERED_1
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -force-ordered-reductions=true -hints-allow-reordering=false -S
; Original: RUN: opt -passes=loop-vectorize -force-ordered-reductions=true -hints-allow-reordering=false -S < %s | FileCheck %s --check-prefix=CHECK-ORDERED

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



target triple = "riscv64"

define float @fadd(ptr noalias nocapture readonly %a, i64 %n) #0 {
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

attributes #0 = { "target-features"="+f,+v" }
!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 4}
!2 = !{!"llvm.loop.interleave.count", i32 1}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpj7yyl2kt.ll'
source_filename = "/tmp/tmpj7yyl2kt.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define float @fadd(ptr noalias readonly captures(none) %a, i64 %n) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 4
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 4
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi float [ 0.000000e+00, %vector.ph ], [ %1, %vector.body ]
  %0 = getelementptr inbounds float, ptr %a, i64 %index
  %wide.load = load <4 x float>, ptr %0, align 4
  %1 = call float @llvm.vector.reduce.fadd.v4f32(float %vec.phi, <4 x float> %wide.load)
  %index.next = add nuw i64 %index, 4
  %2 = icmp eq i64 %index.next, %n.vec
  br i1 %2, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.merge.rdx = phi float [ %1, %middle.block ], [ 0.000000e+00, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %3 = load float, ptr %arrayidx, align 4
  %add = fadd float %3, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  %add.lcssa = phi float [ %add, %for.body ], [ %1, %middle.block ]
  ret float %add.lcssa
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.v4f32(float, <4 x float>) #1

attributes #0 = { "target-features"="+f,+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
