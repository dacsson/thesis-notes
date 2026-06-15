; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/transform-narrow-interleave-to-widen-memory.ll
; Variant: riscv64_+v_EPILOGUE
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -tail-folding-policy=dont-fold-tail -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S %s -tail-folding-policy=dont-fold-tail | FileCheck -check-prefix=EPILOGUE %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @load_store_interleave_group(ptr noalias %data) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %mul.2 = shl nsw i64 %iv, 1
  %data.0 = getelementptr inbounds i64, ptr %data, i64 %mul.2
  %l.0 = load i64, ptr %data.0, align 8
  store i64 %l.0, ptr %data.0, align 8
  %add.1 = or disjoint i64 %mul.2, 1
  %data.1 = getelementptr inbounds i64, ptr %data, i64 %add.1
  %l.1 = load i64, ptr %data.1, align 8
  store i64 %l.1, ptr %data.1, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 100
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @interleave_group_with_countable_early_exit(i64 %n, ptr %dst) {
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %cond = icmp ugt i64 %iv, %n
  br i1 %cond, label %exit1, label %loop.latch

exit1:
  ret void

loop.latch:
  %gep1 = getelementptr { i64, i64 }, ptr %dst, i64 %iv
  store i64 0, ptr %gep1, align 8
  %gep2 = getelementptr i8, ptr %gep1, i64 8
  store i64 0, ptr %gep2, align 8
  %iv.next = add i64 %iv, 1
  %cmp = icmp eq i64 %n, %iv
  br i1 %cmp, label %exit2, label %loop.header

exit2:
  ret void
}

define void @load_store_interleave_group_i32(ptr noalias %data) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %mul.4 = shl nsw i64 %iv, 2
  %data.0 = getelementptr inbounds i32, ptr %data, i64 %mul.4
  %l.0 = load i32, ptr %data.0, align 8
  store i32 %l.0, ptr %data.0, align 8
  %add.1 = or disjoint i64 %mul.4, 1
  %data.1 = getelementptr inbounds i32, ptr %data, i64 %add.1
  %l.1 = load i32, ptr %data.1, align 8
  store i32 %l.1, ptr %data.1, align 8
  %add.2 = add i64 %mul.4, 2
  %data.2 = getelementptr inbounds i32, ptr %data, i64 %add.2
  %l.2 = load i32, ptr %data.2, align 8
  store i32 %l.2, ptr %data.2, align 8
  %add.3 = add i64 %mul.4, 3
  %data.3 = getelementptr inbounds i32, ptr %data, i64 %add.3
  %l.3 = load i32, ptr %data.3, align 8
  store i32 %l.3, ptr %data.3, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 100
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmprieuuldc.ll'
source_filename = "/tmp/tmprieuuldc.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store_interleave_group(ptr noalias %data) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %n.mod.vf = urem i64 100, %2
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = shl nsw i64 %index, 1
  %4 = getelementptr inbounds i64, ptr %data, i64 %3
  %wide.load = load <vscale x 2 x i64>, ptr %4, align 8
  store <vscale x 2 x i64> %wide.load, ptr %4, align 8
  %index.next = add nuw i64 %index, %2
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %mul.2 = shl nsw i64 %iv, 1
  %data.0 = getelementptr inbounds i64, ptr %data, i64 %mul.2
  %l.0 = load i64, ptr %data.0, align 8
  store i64 %l.0, ptr %data.0, align 8
  %add.1 = or disjoint i64 %mul.2, 1
  %data.1 = getelementptr inbounds i64, ptr %data, i64 %add.1
  %l.1 = load i64, ptr %data.1, align 8
  store i64 %l.1, ptr %data.1, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 100
  br i1 %ec, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @interleave_group_with_countable_early_exit(i64 %n, ptr %dst) #0 {
entry:
  %0 = add i64 %n, 1
  %1 = call i64 @llvm.vscale.i64()
  %2 = shl nuw i64 %1, 1
  %umax = call i64 @llvm.umax.i64(i64 %2, i64 40)
  %min.iters.check = icmp ule i64 %0, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %mul1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 16, i64 %n)
  %mul.result = extractvalue { i64, i1 } %mul1, 0
  %mul.overflow = extractvalue { i64, i1 } %mul1, 1
  %3 = getelementptr i8, ptr %dst, i64 %mul.result
  %4 = icmp ult ptr %3, %dst
  %5 = or i1 %4, %mul.overflow
  %scevgep = getelementptr i8, ptr %dst, i64 8
  %mul2 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 16, i64 %n)
  %mul.result3 = extractvalue { i64, i1 } %mul2, 0
  %mul.overflow4 = extractvalue { i64, i1 } %mul2, 1
  %6 = getelementptr i8, ptr %scevgep, i64 %mul.result3
  %7 = icmp ult ptr %6, %scevgep
  %8 = or i1 %7, %mul.overflow4
  %9 = or i1 %5, %8
  br i1 %9, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  %10 = call i64 @llvm.vscale.i64()
  %n.mod.vf = urem i64 %0, %10
  %11 = icmp eq i64 %n.mod.vf, 0
  %12 = select i1 %11, i64 %10, i64 %n.mod.vf
  %n.vec = sub i64 %0, %12
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %13 = getelementptr { i64, i64 }, ptr %dst, i64 %index
  store <vscale x 2 x i64> zeroinitializer, ptr %13, align 8
  %index.next = add nuw i64 %index, %10
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %vector.scevcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.scevcheck ]
  br label %loop.header

loop.header:                                      ; preds = %scalar.ph, %loop.latch
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop.latch ]
  %cond = icmp ugt i64 %iv, %n
  br i1 %cond, label %exit1, label %loop.latch

exit1:                                            ; preds = %loop.header
  ret void

loop.latch:                                       ; preds = %loop.header
  %gep1 = getelementptr { i64, i64 }, ptr %dst, i64 %iv
  store i64 0, ptr %gep1, align 8
  %gep2 = getelementptr i8, ptr %gep1, i64 8
  store i64 0, ptr %gep2, align 8
  %iv.next = add i64 %iv, 1
  %cmp = icmp eq i64 %n, %iv
  br i1 %cmp, label %exit2, label %loop.header, !llvm.loop !5

exit2:                                            ; preds = %loop.latch
  ret void
}

define void @load_store_interleave_group_i32(ptr noalias %data) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 100, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %n.mod.vf = urem i64 100, %2
  %n.vec = sub i64 100, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = shl nsw i64 %index, 2
  %4 = getelementptr inbounds i32, ptr %data, i64 %3
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 8
  store <vscale x 4 x i32> %wide.load, ptr %4, align 8
  %index.next = add nuw i64 %index, %2
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 100, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %mul.4 = shl nsw i64 %iv, 2
  %data.0 = getelementptr inbounds i32, ptr %data, i64 %mul.4
  %l.0 = load i32, ptr %data.0, align 8
  store i32 %l.0, ptr %data.0, align 8
  %add.1 = or disjoint i64 %mul.4, 1
  %data.1 = getelementptr inbounds i32, ptr %data, i64 %add.1
  %l.1 = load i32, ptr %data.1, align 8
  store i32 %l.1, ptr %data.1, align 8
  %add.2 = add i64 %mul.4, 2
  %data.2 = getelementptr inbounds i32, ptr %data, i64 %add.2
  %l.2 = load i32, ptr %data.2, align 8
  store i32 %l.2, ptr %data.2, align 8
  %add.3 = add i64 %mul.4, 3
  %data.3 = getelementptr inbounds i32, ptr %data, i64 %add.3
  %l.3 = load i32, ptr %data.3, align 8
  store i32 %l.3, ptr %data.3, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 100
  br i1 %ec, label %exit, label %loop, !llvm.loop !7

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
