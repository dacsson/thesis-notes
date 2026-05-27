; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-iv32.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck --check-prefix=NO-VP %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @iv32(ptr noalias %a, ptr noalias %b, i32 %N) {
entry:
  br label %for.body

for.body:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i32 %iv
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i32 %iv
  store i32 %0, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpvmstimre.ll'
source_filename = "/tmp/tmpvmstimre.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @iv32(ptr noalias %a, ptr noalias %b, i32 %N) #0 {
entry:
  %0 = call i32 @llvm.vscale.i32()
  %1 = shl nuw i32 %0, 2
  %umax = call i32 @llvm.umax.i32(i32 %1, i32 8)
  %min.iters.check = icmp ult i32 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i32 @llvm.vscale.i32()
  %3 = shl nuw i32 %2, 2
  %n.mod.vf = urem i32 %N, %3
  %n.vec = sub i32 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr inbounds i32, ptr %b, i32 %index
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 4
  %5 = getelementptr inbounds i32, ptr %a, i32 %index
  store <vscale x 4 x i32> %wide.load, ptr %5, align 4
  %index.next = add nuw i32 %index, %3
  %6 = icmp eq i32 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %N, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i32 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i32 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i32 %iv
  %7 = load i32, ptr %arrayidx, align 4
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i32 %iv
  store i32 %7, ptr %arrayidx4, align 4
  %iv.next = add nuw nsw i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, %N
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !3

for.cond.cleanup:                                 ; preds = %middle.block, %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
