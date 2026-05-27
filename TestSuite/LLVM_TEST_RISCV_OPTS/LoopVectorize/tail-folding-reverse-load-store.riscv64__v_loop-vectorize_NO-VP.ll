; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-reverse-load-store.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=NO-VP

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

; ModuleID = '/tmp/tmphlvxwbcl.ll'
source_filename = "/tmp/tmphlvxwbcl.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @reverse_load_store(i64 %startval, ptr noalias %ptr, ptr noalias %ptr2) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %4 = sub i64 %startval, %n.vec
  %5 = trunc i64 %n.vec to i32
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = sub i64 %startval, %index
  %7 = add i64 %6, -1
  %8 = getelementptr inbounds i32, ptr %ptr, i64 %7
  %9 = sub nuw nsw i64 %3, 1
  %10 = sub i64 0, %9
  %11 = getelementptr inbounds i32, ptr %8, i64 %10
  %wide.load = load <vscale x 4 x i32>, ptr %11, align 4
  %reverse = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %wide.load)
  %12 = getelementptr inbounds i32, ptr %ptr2, i64 %7
  %13 = getelementptr inbounds i32, ptr %12, i64 %10
  %reverse1 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %reverse)
  store <vscale x 4 x i32> %reverse1, ptr %13, align 4
  %index.next = add nuw i64 %index, %3
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %loopend, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %4, %middle.block ], [ %startval, %entry ]
  %bc.resume.val2 = phi i32 [ %5, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %add.phi = phi i64 [ %bc.resume.val, %scalar.ph ], [ %add, %for.body ]
  %i = phi i32 [ %bc.resume.val2, %scalar.ph ], [ %inc, %for.body ]
  %add = add i64 %add.phi, -1
  %gepl = getelementptr inbounds i32, ptr %ptr, i64 %add
  %tmp = load i32, ptr %gepl, align 4
  %geps = getelementptr inbounds i32, ptr %ptr2, i64 %add
  store i32 %tmp, ptr %geps, align 4
  %inc = add i32 %i, 1
  %exitcond = icmp ne i32 %inc, 1024
  br i1 %exitcond, label %for.body, label %loopend, !llvm.loop !3

loopend:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @reverse_load_store_masked(i64 %startval, ptr noalias %ptr, ptr noalias %ptr1, ptr noalias %ptr2) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %4 = sub i64 %startval, %n.vec
  %5 = trunc i64 %n.vec to i32
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = sub i64 %startval, %index
  %7 = trunc i64 %index to i32
  %8 = add i64 %6, -1
  %9 = getelementptr inbounds i32, ptr %ptr, i32 %7
  %wide.load = load <vscale x 4 x i32>, ptr %9, align 4
  %10 = icmp slt <vscale x 4 x i32> %wide.load, splat (i32 100)
  %11 = getelementptr i32, ptr %ptr1, i64 %8
  %12 = sub nuw nsw i64 %3, 1
  %13 = sub i64 0, %12
  %14 = getelementptr i32, ptr %11, i64 %13
  %reverse = call <vscale x 4 x i1> @llvm.vector.reverse.nxv4i1(<vscale x 4 x i1> %10)
  %wide.masked.load = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr align 4 %14, <vscale x 4 x i1> %reverse, <vscale x 4 x i32> poison)
  %reverse1 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %wide.masked.load)
  %15 = getelementptr i32, ptr %ptr2, i64 %8
  %16 = getelementptr i32, ptr %15, i64 %13
  %reverse2 = call <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32> %reverse1)
  call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> %reverse2, ptr align 4 %16, <vscale x 4 x i1> %reverse)
  %index.next = add nuw i64 %index, %3
  %17 = icmp eq i64 %index.next, %n.vec
  br i1 %17, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %loopend, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %4, %middle.block ], [ %startval, %entry ]
  %bc.resume.val3 = phi i32 [ %5, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %add.phi = phi i64 [ %bc.resume.val, %scalar.ph ], [ %add, %for.inc ]
  %i = phi i32 [ %bc.resume.val3, %scalar.ph ], [ %inc, %for.inc ]
  %add = add i64 %add.phi, -1
  %gepl = getelementptr inbounds i32, ptr %ptr, i32 %i
  %tmp = load i32, ptr %gepl, align 4
  %cmp1 = icmp slt i32 %tmp, 100
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %gepl1 = getelementptr inbounds i32, ptr %ptr1, i64 %add
  %v = load i32, ptr %gepl1, align 4
  %geps = getelementptr inbounds i32, ptr %ptr2, i64 %add
  store i32 %v, ptr %geps, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %inc = add i32 %i, 1
  %exitcond = icmp ne i32 %inc, 1024
  br i1 %exitcond, label %for.body, label %loopend, !llvm.loop !5

loopend:                                          ; preds = %middle.block, %for.inc
  ret void
}

define void @multiple_reverse_vector_pointer(ptr noalias %a, ptr noalias %b, ptr noalias %c, ptr noalias %d) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = sub i64 1024, %index
  %1 = getelementptr i8, ptr %a, i64 %0
  %2 = getelementptr i8, ptr %1, i64 -15
  %wide.load = load <16 x i8>, ptr %2, align 1
  %reverse = shufflevector <16 x i8> %wide.load, <16 x i8> poison, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %3 = getelementptr i8, ptr %b, <16 x i8> %reverse
  %wide.masked.gather = call <16 x i8> @llvm.masked.gather.v16i8.v16p0(<16 x ptr> align 1 %3, <16 x i1> splat (i1 true), <16 x i8> poison)
  %4 = getelementptr i8, ptr %c, i64 %0
  %5 = getelementptr i8, ptr %4, i64 -15
  %reverse1 = shufflevector <16 x i8> %wide.masked.gather, <16 x i8> poison, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  store <16 x i8> %reverse1, ptr %5, align 1
  %6 = getelementptr i8, ptr %d, i64 %0
  %7 = getelementptr i8, ptr %6, i64 -15
  store <16 x i8> %reverse1, ptr %7, align 1
  %index.next = add nuw i64 %index, 16
  %8 = icmp eq i64 %index.next, 1024
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %middle.block
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ 0, %scalar.ph ], [ %iv.next, %loop ]
  %gep.a = getelementptr i8, ptr %a, i64 %iv
  %x = load i8, ptr %gep.a, align 1
  %gep.b = getelementptr i8, ptr %b, i8 %x
  %y = load i8, ptr %gep.b, align 1
  %gep.c = getelementptr i8, ptr %c, i64 %iv
  store i8 %y, ptr %gep.c, align 1
  %gep.d = getelementptr i8, ptr %d, i64 %iv
  store i8 %y, ptr %gep.d, align 1
  %iv.next = add i64 %iv, -1
  %cmp.not = icmp eq i64 %iv, 0
  br i1 %cmp.not, label %exit, label %loop, !llvm.loop !7

exit:                                             ; preds = %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vector.reverse.nxv4i32(<vscale x 4 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i1> @llvm.vector.reverse.nxv4i1(<vscale x 4 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, <vscale x 4 x i32>) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i8> @llvm.masked.gather.v16i8.v16p0(<16 x ptr>, <16 x i1>, <16 x i8>) #5

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
