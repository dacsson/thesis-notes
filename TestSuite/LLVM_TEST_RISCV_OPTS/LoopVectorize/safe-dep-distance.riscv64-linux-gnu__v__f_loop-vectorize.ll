; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/safe-dep-distance.ll
; Variant: riscv64-linux-gnu_+v,+f_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+v,+f -S 2>%t | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

; Dependence distance between read and write is greater than the trip
; count of the loop.  Thus, values written are never read for any
; valid vectorization of the loop.
define void @test(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 200
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 32
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; Dependence distance is less than trip count, thus we must prove that
; chosen VF guaranteed to be less than dependence distance.
define void @test_may_clobber(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 100
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 32
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; Trviailly no overlap due to maximum possible value of VLEN and LMUL
define void @trivial_due_max_vscale(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 8192
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 32
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; Dependence distance could be violated via LMUL>=2 or interleaving
define void @no_high_lmul_or_interleave(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 1024
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 32
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

@a = external global [10 x [12 x i16]]

; Test case for https://github.com/llvm/llvm-project/issues/134696.
define void @safe_load_store_distance_not_pow_of_2(i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr [10 x [12 x i16]], ptr @a, i64 0, i64 0, i64 %iv
  %1 = load i16, ptr %gep, align 2
  %gep.off = getelementptr [10 x [12 x i16]], ptr @a, i64 0, i64 8, i64 %iv
  store i16 0, ptr %gep.off, align 2
  %iv.next = add nsw i64 %iv, 3
  %cmp = icmp ult i64 %iv, %N
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp3m5mpre1.ll'
source_filename = "/tmp/tmp3m5mpre1.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

@a = external global [10 x [12 x i16]]

define void @test(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 200, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 32 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add i64 %index, 200
  %3 = getelementptr i64, ptr %p, i64 %2
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %vp.op.load, ptr align 32 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @test_may_clobber(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr i64, ptr %p, i64 %index
  %wide.load = load <4 x i64>, ptr %0, align 32
  %1 = add i64 %index, 100
  %2 = getelementptr i64, ptr %p, i64 %1
  store <4 x i64> %wide.load, ptr %2, align 32
  %index.next = add nuw i64 %index, 4
  %3 = icmp eq i64 %index.next, 200
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @trivial_due_max_vscale(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 200, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 32 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add i64 %index, 8192
  %3 = getelementptr i64, ptr %p, i64 %2
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %vp.op.load, ptr align 32 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @no_high_lmul_or_interleave(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 200, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 32 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add i64 %index, 1024
  %3 = getelementptr i64, ptr %p, i64 %2
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %vp.op.load, ptr align 32 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %4 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @safe_load_store_distance_not_pow_of_2(i64 %N) #0 {
entry:
  %umin = call i64 @llvm.umin.i64(i64 %N, i64 1)
  %0 = sub i64 %N, %umin
  %1 = udiv i64 %0, 3
  %2 = add i64 %umin, %1
  %3 = add i64 %2, 1
  %min.iters.check = icmp ule i64 %3, 8
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.mod.vf = urem i64 %3, 8
  %4 = icmp eq i64 %n.mod.vf, 0
  %5 = select i1 %4, i64 8, i64 %n.mod.vf
  %n.vec = sub i64 %3, %5
  %6 = mul i64 %n.vec, 3
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <8 x i64> [ <i64 0, i64 3, i64 6, i64 9, i64 12, i64 15, i64 18, i64 21>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %7 = getelementptr [10 x [12 x i16]], ptr @a, i64 0, i64 8, <8 x i64> %vec.ind
  call void @llvm.masked.scatter.v8i16.v8p0(<8 x i16> zeroinitializer, <8 x ptr> align 2 %7, <8 x i1> splat (i1 true))
  %index.next = add nuw i64 %index, 8
  %vec.ind.next = add nsw <8 x i64> %vec.ind, splat (i64 24)
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %6, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr [10 x [12 x i16]], ptr @a, i64 0, i64 0, i64 %iv
  %9 = load i16, ptr %gep, align 2
  %gep.off = getelementptr [10 x [12 x i16]], ptr @a, i64 0, i64 8, i64 %iv
  store i16 0, ptr %gep.off, align 2
  %iv.next = add nsw i64 %iv, 3
  %cmp = icmp ult i64 %iv, %N
  br i1 %cmp, label %loop, label %exit, !llvm.loop !7

exit:                                             ; preds = %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.masked.scatter.v8i16.v8p0(<8 x i16>, <8 x ptr>, <8 x i1>) #5

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
