; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/bf16.ll
; Variant: riscv64_+v,+zvfbfmin_loop-vectorize_ZVFBFMIN
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v,+zvfbfmin -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v,+zvfbfmin -S | FileCheck %s -check-prefix=ZVFBFMIN

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

; ModuleID = '/tmp/tmp995jlw0d.ll'
source_filename = "/tmp/tmp995jlw0d.ll"
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
  %1 = getelementptr bfloat, ptr %a, i64 %index
  %2 = getelementptr bfloat, ptr %b, i64 %index
  %vp.op.load = call <vscale x 8 x bfloat> @llvm.vp.load.nxv8bf16.p0(ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %vp.op.load1 = call <vscale x 8 x bfloat> @llvm.vp.load.nxv8bf16.p0(ptr align 2 %2, <vscale x 8 x i1> splat (i1 true), i32 %0)
  %3 = fadd <vscale x 8 x bfloat> %vp.op.load, %vp.op.load1
  call void @llvm.vp.store.nxv8bf16.p0(<vscale x 8 x bfloat> %3, ptr align 2 %1, <vscale x 8 x i1> splat (i1 true), i32 %0)
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

define void @vfwmaccbf16.vv(ptr noalias %a, ptr noalias %b, ptr noalias %c, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %n, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr bfloat, ptr %a, i64 %index
  %2 = getelementptr bfloat, ptr %b, i64 %index
  %3 = getelementptr float, ptr %c, i64 %index
  %vp.op.load = call <vscale x 4 x bfloat> @llvm.vp.load.nxv4bf16.p0(ptr align 2 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %vp.op.load1 = call <vscale x 4 x bfloat> @llvm.vp.load.nxv4bf16.p0(ptr align 2 %2, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %vp.op.load2 = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %4 = fpext <vscale x 4 x bfloat> %vp.op.load to <vscale x 4 x float>
  %5 = fpext <vscale x 4 x bfloat> %vp.op.load1 to <vscale x 4 x float>
  %6 = call <vscale x 4 x float> @llvm.fmuladd.nxv4f32(<vscale x 4 x float> %4, <vscale x 4 x float> %5, <vscale x 4 x float> %vp.op.load2)
  call void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float> %6, ptr align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 8 x bfloat> @llvm.vp.load.nxv8bf16.p0(ptr captures(none), <vscale x 8 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv8bf16.p0(<vscale x 8 x bfloat>, ptr captures(none), <vscale x 8 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x bfloat> @llvm.vp.load.nxv4bf16.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x float> @llvm.fmuladd.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4f32.p0(<vscale x 4 x float>, ptr captures(none), <vscale x 4 x i1>, i32) #4

attributes #0 = { "target-features"="+v,+zvfbfmin" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+zvfbfmin" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #5 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
