; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/scalable-vf-hint.ll
; Variant: riscv64_+m,+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+m,+v -passes=loop-vectorize -riscv-v-vector-bits-max=512 -scalable-vectorization=on -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+m,+v -passes=loop-vectorize  -riscv-v-vector-bits-max=512 -S -scalable-vectorization=on < %s 2>&1  | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; void test(int *a, int *b, int N) {
;   #pragma clang loop vectorize(enable) vectorize_width(2, scalable)
;   for (int i=0; i<N; ++i) {
;     a[i + 64] = a[i] + b[i];
;   }
; }
define void @test(ptr %a, ptr %b) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %b, i64 %iv
  %1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %1, %0
  %2 = add nuw nsw i64 %iv, 64
  %arrayidx5 = getelementptr inbounds i32, ptr %a, i64 %2
  store i32 %add, ptr %arrayidx5, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !6

exit:
  ret void
}

!6 = !{!6, !7, !8}
!7 = !{!"llvm.loop.vectorize.width", i32 2}
!8 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp39xb01xu.ll'
source_filename = "/tmp/tmp39xb01xu.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @test(ptr %a, ptr %b) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %a, i64 4352
  %scevgep1 = getelementptr i8, ptr %b, i64 4096
  %bound0 = icmp ult ptr %a, %scevgep1
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %2 = shl nuw i64 %0, 1
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds i32, ptr %a, i64 %index
  %wide.load = load <vscale x 2 x i32>, ptr %3, align 4, !alias.scope !0, !noalias !3
  %4 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load2 = load <vscale x 2 x i32>, ptr %4, align 4, !alias.scope !3
  %5 = add nsw <vscale x 2 x i32> %wide.load2, %wide.load
  %6 = add nuw nsw i64 %index, 64
  %7 = getelementptr inbounds i32, ptr %a, i64 %6
  store <vscale x 2 x i32> %5, ptr %7, align 4, !alias.scope !0, !noalias !3
  %index.next = add nuw i64 %index, %2
  %8 = icmp eq i64 %index.next, 1024
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br i1 true, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %9 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %b, i64 %iv
  %10 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %10, %9
  %11 = add nuw nsw i64 %iv, 64
  %arrayidx5 = getelementptr inbounds i32, ptr %a, i64 %11
  store i32 %add, ptr %arrayidx5, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !8

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

attributes #0 = { "target-features"="+m,+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.isvectorized", i32 1}
!7 = !{!"llvm.loop.unroll.runtime.disable"}
!8 = distinct !{!8, !6}
