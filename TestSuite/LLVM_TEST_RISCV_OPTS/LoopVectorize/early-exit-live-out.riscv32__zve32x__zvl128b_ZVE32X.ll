; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/early-exit-live-out.ll
; Variant: riscv32_+zve32x,+zvl128b_ZVE32X
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv32 -mattr=+zve32x,+zvl128b -S
; Original: RUN: opt < %s -S -p loop-vectorize -mtriple riscv32 -mattr=+zve32x,+zvl128b | FileCheck %s --check-prefix=ZVE32X

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Make sure that we generate a VPInstruction::FirstActiveLane that matches the
; targets index type, i.e. i64 on RV64 and i32 on RV32.  Otherwise on rv32 with
; zve32x we return an invalid cost for cttz.elts with scalable VFs.

define i32 @early_exit_live_out(ptr align 4 dereferenceable(4096) %p) {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [0, %entry], [%iv.next, %latch]
  %gep = getelementptr i32, ptr %p, i64 %iv
  %ld = load i32, ptr %gep
  %c = icmp eq i32 %ld, 0
  br i1 %c, label %latch, label %exit

latch:
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 1024
  br i1 %ec, label %exit, label %loop.header

exit:
  %ret = phi i32 [ %ld, %loop.header ], [ 0, %latch ]
  ret i32 %ret
}

define i64 @strided_search(ptr align 8 dereferenceable(14784) %p) {
entry:
  br label %loop.header

loop.header:
  %idx = phi i64 [ 0, %entry ], [ %idx.next, %latch ]
  %ptr = getelementptr inbounds nuw i8, ptr %p, i64 %idx
  %fieldp = getelementptr inbounds nuw i8, ptr %ptr, i64 88
  %v = load i64, ptr %fieldp, align 8
  %hit = icmp eq i64 %v, 0
  br i1 %hit, label %exit, label %latch

latch:
  %idx.next = add nuw nsw i64 %idx, 112
  %done = icmp eq i64 %idx.next, 14784
  br i1 %done, label %exit, label %loop.header

exit:
  %ret = phi i64 [ %idx, %loop.header ], [ -1, %latch ]
  ret i64 %ret
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp3qtsj4mg.ll'
source_filename = "/tmp/tmp3qtsj4mg.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define i32 @early_exit_live_out(ptr align 4 dereferenceable(4096) %p) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1024, %2
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body.interim, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body.interim ]
  %3 = getelementptr i32, ptr %p, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %3, align 4
  %4 = icmp ne <vscale x 4 x i32> %wide.load, zeroinitializer
  %index.next = add nuw i64 %index, %2
  %5 = freeze <vscale x 4 x i1> %4
  %6 = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %5)
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %vector.early.exit, label %vector.body.interim

vector.body.interim:                              ; preds = %vector.body
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body.interim
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

vector.early.exit:                                ; preds = %vector.body
  %first.active.lane = call i32 @llvm.experimental.cttz.elts.i32.nxv4i1(<vscale x 4 x i1> %4, i1 false)
  %8 = extractelement <vscale x 4 x i32> %wide.load, i32 %first.active.lane
  br label %exit

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop.header

loop.header:                                      ; preds = %scalar.ph, %latch
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %latch ]
  %gep = getelementptr i32, ptr %p, i64 %iv
  %ld = load i32, ptr %gep, align 4
  %c = icmp eq i32 %ld, 0
  br i1 %c, label %latch, label %exit

latch:                                            ; preds = %loop.header
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 1024
  br i1 %ec, label %exit, label %loop.header, !llvm.loop !3

exit:                                             ; preds = %vector.early.exit, %middle.block, %latch, %loop.header
  %ret = phi i32 [ %ld, %loop.header ], [ 0, %latch ], [ 0, %middle.block ], [ %8, %vector.early.exit ]
  ret i32 %ret
}

define i64 @strided_search(ptr align 8 dereferenceable(14784) %p) #0 {
entry:
  br label %loop.header

loop.header:                                      ; preds = %latch, %entry
  %idx = phi i64 [ 0, %entry ], [ %idx.next, %latch ]
  %ptr = getelementptr inbounds nuw i8, ptr %p, i64 %idx
  %fieldp = getelementptr inbounds nuw i8, ptr %ptr, i64 88
  %v = load i64, ptr %fieldp, align 8
  %hit = icmp eq i64 %v, 0
  br i1 %hit, label %exit, label %latch

latch:                                            ; preds = %loop.header
  %idx.next = add nuw nsw i64 %idx, 112
  %done = icmp eq i64 %idx.next, 14784
  br i1 %done, label %exit, label %loop.header

exit:                                             ; preds = %latch, %loop.header
  %ret = phi i64 [ %idx, %loop.header ], [ -1, %latch ]
  ret i64 %ret
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.cttz.elts.i32.nxv4i1(<vscale x 4 x i1>, i1 immarg) #1

attributes #0 = { "target-features"="+zve32x,+zvl128b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
