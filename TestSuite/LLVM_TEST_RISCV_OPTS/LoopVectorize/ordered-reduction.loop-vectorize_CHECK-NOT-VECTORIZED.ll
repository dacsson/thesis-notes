; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/ordered-reduction.ll
; Variant: loop-vectorize_CHECK-NOT-VECTORIZED
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -force-ordered-reductions=false -hints-allow-reordering=false -S
; Original: RUN: opt -passes=loop-vectorize -force-ordered-reductions=false -hints-allow-reordering=false -S < %s | FileCheck %s --check-prefix=CHECK-NOT-VECTORIZED

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

; ModuleID = '/tmp/tmpo0d0n8sh.ll'
source_filename = "/tmp/tmpo0d0n8sh.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define float @fadd(ptr noalias readonly captures(none) %a, i64 %n) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0.000000e+00, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %add = fadd float %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:                                          ; preds = %for.body
  %add.lcssa = phi float [ %add, %for.body ]
  ret float %add.lcssa
}

attributes #0 = { "target-features"="+f,+v" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 4}
!2 = !{!"llvm.loop.interleave.count", i32 1}
