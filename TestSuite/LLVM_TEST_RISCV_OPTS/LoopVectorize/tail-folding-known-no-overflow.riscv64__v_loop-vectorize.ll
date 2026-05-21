; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-known-no-overflow.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; TODO: We know the IV will never overflow here so we can skip the overflow
; check

define void @trip_count_max_1024(ptr %p, i64 %tc) vscale_range(2, 1024) {
entry:
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop
loop:
  %i = phi i64 [%i.next, %loop], [0, %entry]
  %gep = getelementptr i64, ptr %p, i64 %i
  %x = load i64, ptr %gep
  %y = add i64 %x, 1
  store i64 %y, ptr %gep
  %i.next = add i64 %i, 1
  %done = icmp uge i64 %i.next, %tc
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; If %tc = 0 the IV will overflow, so we need to emit an overflow check
; FIXME: The check still allows %tc =0

define void @overflow_at_0(ptr %p, i64 %tc) vscale_range(2, 1024) {
entry:
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop
loop:
  %i = phi i64 [%i.next, %loop], [0, %entry]
  %gep = getelementptr i64, ptr %p, i64 %i
  %x = load i64, ptr %gep
  %y = add i64 %x, 1
  store i64 %y, ptr %gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %tc
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; %tc won't = 0 so the IV won't overflow

define void @no_overflow_at_0(ptr %p, i64 %tc) vscale_range(2, 1024) {
entry:
  %tc.add = add nuw i64 %tc, 1
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop
loop:
  %i = phi i64 [%i.next, %loop], [0, %entry]
  %gep = getelementptr i64, ptr %p, i64 %i
  %x = load i64, ptr %gep
  %y = add i64 %x, 1
  store i64 %y, ptr %gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %tc.add
  br i1 %done, label %exit, label %loop
exit:
  ret void
}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp3ekud1ee.ll'
source_filename = "/tmp/tmp3ekud1ee.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: vscale_range(2,1024)
define void @trip_count_max_1024(ptr %p, i64 %tc) #0 {
entry:
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop.preheader

loop.preheader:                                   ; preds = %entry
  %umax = call i64 @llvm.umax.i64(i64 %tc, i64 1)
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %umax, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 2 x i64> %vp.op.load, splat (i64 1)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit.loopexit

exit.loopexit:                                    ; preds = %middle.block
  br label %exit

exit:                                             ; preds = %exit.loopexit, %entry
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @overflow_at_0(ptr %p, i64 %tc) #0 {
entry:
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop.preheader

loop.preheader:                                   ; preds = %entry
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %tc, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 2 x i64> %vp.op.load, splat (i64 1)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit.loopexit

exit.loopexit:                                    ; preds = %middle.block
  br label %exit

exit:                                             ; preds = %exit.loopexit, %entry
  ret void
}

; Function Attrs: vscale_range(2,1024)
define void @no_overflow_at_0(ptr %p, i64 %tc) #0 {
entry:
  %tc.add = add i64 %tc, 1
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop.preheader

loop.preheader:                                   ; preds = %entry
  br label %vector.ph

vector.ph:                                        ; preds = %loop.preheader
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ %tc.add, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 2 x i64> %vp.op.load, splat (i64 1)
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit.loopexit

exit.loopexit:                                    ; preds = %middle.block
  br label %exit

exit:                                             ; preds = %exit.loopexit, %entry
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #4

attributes #0 = { vscale_range(2,1024) "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
