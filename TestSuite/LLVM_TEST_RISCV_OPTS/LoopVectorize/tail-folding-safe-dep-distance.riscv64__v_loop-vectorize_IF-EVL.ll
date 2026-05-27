; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-safe-dep-distance.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=IF-EVL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



; Dependence distance between read and write is greater than the trip
; count of the loop.  Thus, values written are never read for any
; valid vectorization of the loop.
define void @test(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 8
  %offset = add i64 %iv, 200
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 8
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; Dependence distance is less than trip count, thus we must prove that
; chosen VF guaranteed to be less than dependence distance.
define void @test_may_clobber1(ptr %p) {
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

define void @test_may_clobber2(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 9
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 32
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

define void @test_may_clobber3(ptr %p) {
entry:
  br label %loop

loop:
  %iv = phi i64 [0, %entry], [%iv.next, %loop]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 10
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
  %cmp = icmp ne i64 %iv, 3001
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

define void @non-power-2-storeloadforward(ptr %A) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 16, %entry ], [ %iv.next, %for.body ]
  %0 = add nsw i64 %iv, -3
  %arrayidx = getelementptr inbounds i32, ptr %A, i64 %0
  %1 = load i32, ptr %arrayidx, align 4
  %2 = add nsw i64 %iv, 4
  %arrayidx2 = getelementptr inbounds i32, ptr %A, i64 %2
  %3 = load i32, ptr %arrayidx2, align 4
  %add3 = add nsw i32 %3, %1
  %arrayidx5 = getelementptr inbounds i32, ptr %A, i64 %iv
  store i32 %add3, ptr %arrayidx5, align 4
  %iv.next = add i64 %iv, 1
  %lftr.wideiv = trunc i64 %iv.next to i32
  %exitcond = icmp ne i32 %lftr.wideiv, 128
  br i1 %exitcond, label %for.body, label %for.end

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmple1gkdlr.ll'
source_filename = "/tmp/tmple1gkdlr.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

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
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add i64 %index, 200
  %3 = getelementptr i64, ptr %p, i64 %2
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %vp.op.load, ptr align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %0)
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

define void @test_may_clobber1(ptr %p) #0 {
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

define void @test_may_clobber2(ptr %p) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %a1 = getelementptr i64, ptr %p, i64 %iv
  %v = load i64, ptr %a1, align 32
  %offset = add i64 %iv, 9
  %a2 = getelementptr i64, ptr %p, i64 %offset
  store i64 %v, ptr %a2, align 32
  %iv.next = add i64 %iv, 1
  %cmp = icmp ne i64 %iv, 199
  br i1 %cmp, label %loop, label %exit

exit:                                             ; preds = %loop
  ret void
}

define void @test_may_clobber3(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr i64, ptr %p, i64 %index
  %wide.load = load <2 x i64>, ptr %0, align 32
  %1 = add i64 %index, 10
  %2 = getelementptr i64, ptr %p, i64 %1
  store <2 x i64> %wide.load, ptr %2, align 32
  %index.next = add nuw i64 %index, 2
  %3 = icmp eq i64 %index.next, 200
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !4

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
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !5

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
  %avl = phi i64 [ 3002, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = icmp ult i64 %avl, 1024
  %safe_avl = select i1 %0, i64 %avl, i64 1024
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %safe_avl, i32 1, i1 true)
  %2 = getelementptr i64, ptr %p, i64 %index
  %vp.op.load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0(ptr align 32 %2, <vscale x 1 x i1> splat (i1 true), i32 %1)
  %3 = add i64 %index, 1024
  %4 = getelementptr i64, ptr %p, i64 %3
  call void @llvm.vp.store.nxv1i64.p0(<vscale x 1 x i64> %vp.op.load, ptr align 32 %4, <vscale x 1 x i1> splat (i1 true), i32 %1)
  %5 = zext i32 %1 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @non-power-2-storeloadforward(ptr %A) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 16, %entry ], [ %iv.next, %for.body ]
  %0 = add nsw i64 %iv, -3
  %arrayidx = getelementptr inbounds i32, ptr %A, i64 %0
  %1 = load i32, ptr %arrayidx, align 4
  %2 = add nsw i64 %iv, 4
  %arrayidx2 = getelementptr inbounds i32, ptr %A, i64 %2
  %3 = load i32, ptr %arrayidx2, align 4
  %add3 = add nsw i32 %3, %1
  %arrayidx5 = getelementptr inbounds i32, ptr %A, i64 %iv
  store i32 %add3, ptr %arrayidx5, align 4
  %iv.next = add i64 %iv, 1
  %lftr.wideiv = trunc i64 %iv.next to i32
  %exitcond = icmp ne i32 %lftr.wideiv, 128
  br i1 %exitcond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0(ptr captures(none), <vscale x 1 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv1i64.p0(<vscale x 1 x i64>, ptr captures(none), <vscale x 1 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
