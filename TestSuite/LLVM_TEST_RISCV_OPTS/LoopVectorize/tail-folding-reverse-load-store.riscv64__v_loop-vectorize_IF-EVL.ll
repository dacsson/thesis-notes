; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-reverse-load-store.ll
; Variant: riscv64_+v_loop-vectorize_IF-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=IF-EVL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @reverse_load_store(i64 %startval, ptr noalias %ptr, ptr noalias %ptr2) {
entry:
  br label %for.body

for.body:
  %add.phi = phi i64 [ %startval, %entry ], [ %add, %for.body ]
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %add = add i64 %add.phi, -1
  %gepl = getelementptr inbounds i32, ptr %ptr, i64 %add
  %tmp = load i32, ptr %gepl, align 4
  %geps = getelementptr inbounds i32, ptr %ptr2, i64 %add
  store i32 %tmp, ptr %geps, align 4
  %inc = add i32 %i, 1
  %exitcond = icmp ne i32 %inc, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret void
}

define void @reverse_load_store_masked(i64 %startval, ptr noalias %ptr, ptr noalias %ptr1, ptr noalias %ptr2) {
entry:
  br label %for.body

for.body:
  %add.phi = phi i64 [ %startval, %entry ], [ %add, %for.inc ]
  %i = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %add = add i64 %add.phi, -1
  %gepl = getelementptr inbounds i32, ptr %ptr, i32 %i
  %tmp = load i32, ptr %gepl, align 4
  %cmp1 = icmp slt i32 %tmp, 100
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %gepl1 = getelementptr inbounds i32, ptr %ptr1, i64 %add
  %v = load i32, ptr %gepl1, align 4
  %geps = getelementptr inbounds i32, ptr %ptr2, i64 %add
  store i32 %v, ptr %geps, align 4
  br label %for.inc

for.inc:
  %inc = add i32 %i, 1
  %exitcond = icmp ne i32 %inc, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret void
}

; From a miscompile originally reported at
; https://github.com/llvm/llvm-project/issues/122681

define void @multiple_reverse_vector_pointer(ptr noalias %a, ptr noalias %b, ptr noalias %c, ptr noalias %d) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1024, %entry ], [ %iv.next, %loop ]

  %gep.a = getelementptr i8, ptr %a, i64 %iv
  %x = load i8, ptr %gep.a

  %gep.b = getelementptr i8, ptr %b, i8 %x
  %y = load i8, ptr %gep.b

  %gep.c = getelementptr i8, ptr %c, i64 %iv
  store i8 %y, ptr %gep.c

  %gep.d = getelementptr i8, ptr %d, i64 %iv
  store i8 %y, ptr %gep.d

  %iv.next = add i64 %iv, -1
  %cmp.not = icmp eq i64 %iv, 0
  br i1 %cmp.not, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpzun731h1.ll'
source_filename = "/tmp/tmpzun731h1.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @reverse_load_store(i64 %startval, ptr noalias %ptr, ptr noalias %ptr2) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = sub i64 %startval, %index
  %2 = add i64 %1, -1
  %3 = getelementptr inbounds i32, ptr %ptr, i64 %2
  %4 = zext i32 %0 to i64
  %5 = sub nuw nsw i64 %4, 1
  %6 = sub i64 0, %5
  %7 = getelementptr i32, ptr %3, i64 %6
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %8 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %vp.op.load, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %9 = getelementptr inbounds i32, ptr %ptr2, i64 %2
  %10 = getelementptr i32, ptr %9, i64 %6
  %11 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %8, <vscale x 4 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %11, ptr align 4 %10, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %current.iteration.next = add nuw i64 %4, %index
  %avl.next = sub nuw i64 %avl, %4
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %loopend

loopend:                                          ; preds = %middle.block
  ret void
}

define void @reverse_load_store_masked(i64 %startval, ptr noalias %ptr, ptr noalias %ptr1, ptr noalias %ptr2) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = sub i64 %startval, %index
  %2 = trunc i64 %index to i32
  %3 = add i64 %1, -1
  %4 = getelementptr inbounds i32, ptr %ptr, i32 %2
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %4, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %5 = icmp slt <vscale x 4 x i32> %vp.op.load, splat (i32 100)
  %6 = getelementptr i32, ptr %ptr1, i64 %3
  %7 = call <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1> %5, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %8 = zext i32 %0 to i64
  %9 = sub nuw nsw i64 %8, 1
  %10 = sub i64 0, %9
  %11 = getelementptr i32, ptr %6, i64 %10
  %vp.op.load1 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %11, <vscale x 4 x i1> %7, i32 %0)
  %12 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %vp.op.load1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %13 = getelementptr i32, ptr %ptr2, i64 %3
  %14 = getelementptr i32, ptr %13, i64 %10
  %15 = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> %12, <vscale x 4 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %15, ptr align 4 %14, <vscale x 4 x i1> %7, i32 %0)
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %16 = icmp eq i64 %avl.next, 0
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %loopend

loopend:                                          ; preds = %middle.block
  ret void
}

define void @multiple_reverse_vector_pointer(ptr noalias %a, ptr noalias %b, ptr noalias %c, ptr noalias %d) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1025, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %1 = sub i64 1024, %index
  %2 = getelementptr i8, ptr %a, i64 %1
  %3 = zext i32 %0 to i64
  %4 = sub nuw nsw i64 %3, 1
  %5 = sub i64 0, %4
  %6 = getelementptr i8, ptr %2, i64 %5
  %vp.op.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr align 1 %6, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %7 = call <vscale x 16 x i8> @llvm.experimental.vp.reverse.nxv16i8(<vscale x 16 x i8> %vp.op.load, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %8 = getelementptr i8, ptr %b, <vscale x 16 x i8> %7
  %wide.masked.gather = call <vscale x 16 x i8> @llvm.vp.gather.nxv16i8.nxv16p0(<vscale x 16 x ptr> align 1 %8, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %9 = getelementptr i8, ptr %c, i64 %1
  %10 = getelementptr i8, ptr %9, i64 %5
  %11 = call <vscale x 16 x i8> @llvm.experimental.vp.reverse.nxv16i8(<vscale x 16 x i8> %wide.masked.gather, <vscale x 16 x i1> splat (i1 true), i32 %0)
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %11, ptr align 1 %10, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %12 = getelementptr i8, ptr %d, i64 %1
  %13 = getelementptr i8, ptr %12, i64 %5
  call void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8> %11, ptr align 1 %13, <vscale x 16 x i1> splat (i1 true), i32 %0)
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %14 = icmp eq i64 %avl.next, 0
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr captures(none), <vscale x 16 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 16 x i8> @llvm.experimental.vp.reverse.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 16 x i8> @llvm.vp.gather.nxv16i8.nxv16p0(<vscale x 16 x ptr>, <vscale x 16 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv16i8.p0(<vscale x 16 x i8>, ptr captures(none), <vscale x 16 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
