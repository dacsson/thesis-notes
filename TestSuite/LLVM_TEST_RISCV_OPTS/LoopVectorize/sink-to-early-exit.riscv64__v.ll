; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/sink-to-early-exit.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S < %s -p loop-vectorize -mtriple=riscv64 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; TODO: Recipe used only in the early exit block can be sunk there.

declare void @init_mem(ptr, i64)

define i64 @sink_to_early_exit(i64 %offset) {
entry:
  %p1 = alloca [1024 x i8], align 4
  %p2 = alloca [1024 x i8], align 4
  call void @init_mem(ptr %p1, i64 1024)
  call void @init_mem(ptr %p2, i64 1024)
  br label %loop

loop:
  %index = phi i64 [ %index.next, %loop.inc ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i8, ptr %p1, i64 %index
  %ld1 = load i8, ptr %arrayidx, align 1
  %arrayidx1 = getelementptr inbounds i8, ptr %p2, i64 %index
  %ld2 = load i8, ptr %arrayidx1, align 1
  %result = add i64 %index, %offset
  %cmp = icmp eq i8 %ld1, %ld2
  br i1 %cmp, label %loop.inc, label %loop.early.exit

loop.inc:
  %index.next = add i64 %index, 1
  %exitcond = icmp ne i64 %index.next, 1024
  br i1 %exitcond, label %loop, label %loop.end

loop.early.exit:
  ret i64 %result

loop.end:
  ret i64 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpzrv4qj9f.ll'
source_filename = "/tmp/tmpzrv4qj9f.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

declare void @init_mem(ptr, i64) #0

define i64 @sink_to_early_exit(i64 %offset) #0 {
entry:
  %p1 = alloca [1024 x i8], align 4
  %p2 = alloca [1024 x i8], align 4
  call void @init_mem(ptr %p1, i64 1024)
  call void @init_mem(ptr %p2, i64 1024)
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 4
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 4
  %n.mod.vf = urem i64 1024, %2
  %n.vec = sub i64 1024, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 16 x i64> poison, i64 %offset, i64 0
  %broadcast.splat = shufflevector <vscale x 16 x i64> %broadcast.splatinsert, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  %3 = call <vscale x 16 x i64> @llvm.stepvector.nxv16i64()
  %broadcast.splatinsert2 = insertelement <vscale x 16 x i64> poison, i64 %2, i64 0
  %broadcast.splat3 = shufflevector <vscale x 16 x i64> %broadcast.splatinsert2, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body.interim, %vector.ph
  %index4 = phi i64 [ 0, %vector.ph ], [ %index.next6, %vector.body.interim ]
  %vec.ind = phi <vscale x 16 x i64> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body.interim ]
  %4 = getelementptr inbounds i8, ptr %p1, i64 %index4
  %wide.load = load <vscale x 16 x i8>, ptr %4, align 1
  %5 = getelementptr inbounds i8, ptr %p2, i64 %index4
  %wide.load5 = load <vscale x 16 x i8>, ptr %5, align 1
  %6 = icmp ne <vscale x 16 x i8> %wide.load, %wide.load5
  %index.next6 = add nuw i64 %index4, %2
  %7 = freeze <vscale x 16 x i1> %6
  %8 = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %7)
  %9 = icmp eq i64 %index.next6, %n.vec
  %vec.ind.next = add <vscale x 16 x i64> %vec.ind, %broadcast.splat3
  br i1 %8, label %vector.early.exit, label %vector.body.interim

vector.body.interim:                              ; preds = %vector.body
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body.interim
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %loop.end, label %scalar.ph

vector.early.exit:                                ; preds = %vector.body
  %10 = add <vscale x 16 x i64> %vec.ind, %broadcast.splat
  %first.active.lane = call i64 @llvm.experimental.cttz.elts.i64.nxv16i1(<vscale x 16 x i1> %6, i1 false)
  %11 = extractelement <vscale x 16 x i64> %10, i64 %first.active.lane
  br label %loop.early.exit

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop.inc
  %index = phi i64 [ %index.next, %loop.inc ], [ %bc.resume.val, %scalar.ph ]
  %arrayidx = getelementptr inbounds i8, ptr %p1, i64 %index
  %ld1 = load i8, ptr %arrayidx, align 1
  %arrayidx1 = getelementptr inbounds i8, ptr %p2, i64 %index
  %ld2 = load i8, ptr %arrayidx1, align 1
  %result = add i64 %index, %offset
  %cmp = icmp eq i8 %ld1, %ld2
  br i1 %cmp, label %loop.inc, label %loop.early.exit

loop.inc:                                         ; preds = %loop
  %index.next = add i64 %index, 1
  %exitcond = icmp ne i64 %index.next, 1024
  br i1 %exitcond, label %loop, label %loop.end, !llvm.loop !3

loop.early.exit:                                  ; preds = %vector.early.exit, %loop
  %result.lcssa = phi i64 [ %result, %loop ], [ %11, %vector.early.exit ]
  ret i64 %result.lcssa

loop.end:                                         ; preds = %middle.block, %loop.inc
  ret i64 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 16 x i64> @llvm.stepvector.nxv16i64() #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.experimental.cttz.elts.i64.nxv16i1(<vscale x 16 x i1>, i1 immarg) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
