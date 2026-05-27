; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/lmul.ll
; Variant: riscv64_+v_loop-vectorize_LMUL1
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v --riscv-v-register-bit-width-lmul=1 -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v -S --riscv-v-register-bit-width-lmul=1 | FileCheck %s -check-prefix=LMUL1

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

; ModuleID = '/tmp/tmprfyany87.ll'
source_filename = "/tmp/tmprfyany87.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store(ptr %p) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %min.iters.check = icmp ult i64 1024, %0
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i64, ptr %p, i64 %index
  %wide.load = load <vscale x 1 x i64>, ptr %1, align 8
  %2 = add <vscale x 1 x i64> %wide.load, splat (i64 1)
  store <vscale x 1 x i64> %2, ptr %1, align 8
  %index.next = add nuw i64 %index, %0
  %3 = icmp eq i64 %index.next, 1024
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br i1 true, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %q = getelementptr inbounds i64, ptr %p, i64 %iv
  %v = load i64, ptr %q, align 8
  %w = add i64 %v, 1
  store i64 %w, ptr %q, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
