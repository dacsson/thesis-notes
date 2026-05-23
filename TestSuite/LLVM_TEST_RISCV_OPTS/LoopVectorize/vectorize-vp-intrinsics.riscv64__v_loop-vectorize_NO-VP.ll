; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/vectorize-vp-intrinsics.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck --check-prefix=NO-VP %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @foo(ptr noalias %a, ptr noalias %b, ptr noalias %c, i64 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %c, i64 %iv
  %1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %1, %0
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %add, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpmt5zi801.ll'
source_filename = "/tmp/tmpmt5zi801.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @foo(ptr noalias %a, ptr noalias %b, ptr noalias %c, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 %N, %3
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 4
  %5 = getelementptr inbounds i32, ptr %c, i64 %index
  %wide.load1 = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = add nsw <vscale x 4 x i32> %wide.load1, %wide.load
  %7 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %6, ptr %7, align 4
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %iv
  %9 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %c, i64 %iv
  %10 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %10, %9
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %add, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !3

for.cond.cleanup:                                 ; preds = %middle.block, %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
