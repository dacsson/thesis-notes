; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/bf16.ll
; Variant: riscv64_+v_loop-vectorize_NO-ZVFBFMIN_2
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v -tail-folding-policy=prefer-fold-tail -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v -S -tail-folding-policy=prefer-fold-tail | FileCheck %s -check-prefix=NO-ZVFBFMIN

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @fadd(ptr noalias %a, ptr noalias %b, i64 %n) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%i.next, %loop]
  %a.gep = getelementptr bfloat, ptr %a, i64 %i
  %b.gep = getelementptr bfloat, ptr %b, i64 %i
  %x = load bfloat, ptr %a.gep
  %y = load bfloat, ptr %b.gep
  %z = fadd bfloat %x, %y
  store bfloat %z, ptr %a.gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @vfwmaccbf16.vv(ptr noalias %a, ptr noalias %b, ptr noalias %c, i64 %n) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%i.next, %loop]
  %a.gep = getelementptr bfloat, ptr %a, i64 %i
  %b.gep = getelementptr bfloat, ptr %b, i64 %i
  %c.gep = getelementptr float, ptr %c, i64 %i
  %x = load bfloat, ptr %a.gep
  %y = load bfloat, ptr %b.gep
  %z = load float, ptr %c.gep
  %x.ext = fpext bfloat %x to float
  %y.ext = fpext bfloat %y to float
  %fmuladd = call float @llvm.fmuladd.f32(float %x.ext, float %y.ext, float %z)
  store float %fmuladd, ptr %c.gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp0st8pzkf.ll'
source_filename = "/tmp/tmp0st8pzkf.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @fadd(ptr noalias %a, ptr noalias %b, i64 %n) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %a.gep = getelementptr bfloat, ptr %a, i64 %i
  %b.gep = getelementptr bfloat, ptr %b, i64 %i
  %x = load bfloat, ptr %a.gep, align 2
  %y = load bfloat, ptr %b.gep, align 2
  %z = fadd bfloat %x, %y
  store bfloat %z, ptr %a.gep, align 2
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @vfwmaccbf16.vv(ptr noalias %a, ptr noalias %b, ptr noalias %c, i64 %n) #0 {
entry:
  %min.iters.check = icmp ult i64 %n, 4
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %n, 4
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr bfloat, ptr %a, i64 %index
  %1 = getelementptr bfloat, ptr %b, i64 %index
  %2 = getelementptr float, ptr %c, i64 %index
  %wide.load = load <4 x bfloat>, ptr %0, align 2
  %wide.load1 = load <4 x bfloat>, ptr %1, align 2
  %wide.load2 = load <4 x float>, ptr %2, align 4
  %3 = fpext <4 x bfloat> %wide.load to <4 x float>
  %4 = fpext <4 x bfloat> %wide.load1 to <4 x float>
  %5 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %4, <4 x float> %wide.load2)
  store <4 x float> %5, ptr %2, align 4
  %index.next = add nuw i64 %index, 4
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %i.next, %loop ]
  %a.gep = getelementptr bfloat, ptr %a, i64 %i
  %b.gep = getelementptr bfloat, ptr %b, i64 %i
  %c.gep = getelementptr float, ptr %c, i64 %i
  %x = load bfloat, ptr %a.gep, align 2
  %y = load bfloat, ptr %b.gep, align 2
  %z = load float, ptr %c.gep, align 4
  %x.ext = fpext bfloat %x to float
  %y.ext = fpext bfloat %y to float
  %fmuladd = call float @llvm.fmuladd.f32(float %x.ext, float %y.ext, float %z)
  store float %fmuladd, ptr %c.gep, align 4
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %n
  br i1 %done, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
