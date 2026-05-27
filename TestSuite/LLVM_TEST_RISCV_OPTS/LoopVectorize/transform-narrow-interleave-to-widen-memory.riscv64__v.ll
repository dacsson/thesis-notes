; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/transform-narrow-interleave-to-widen-memory.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S
; Original: RUN: opt -p loop-vectorize -mtriple riscv64 -mattr=+v -S %s | FileCheck -check-prefix=CHECK %s

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

; ModuleID = '/tmp/tmpjeeqbew5.ll'
source_filename = "/tmp/tmpjeeqbew5.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_store_interleave_group(ptr noalias %data) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = shl nsw i64 %index, 1
  %2 = getelementptr inbounds i64, ptr %data, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 2
  %wide.vp.load = call <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr align 8 %2, <vscale x 4 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64> %wide.vp.load)
  %3 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 0
  %4 = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } %strided.vec, 1
  %interleave.evl1 = mul nuw nsw i32 %0, 2
  %interleaved.vec = call <vscale x 4 x i64> @llvm.vector.interleave2.nxv4i64(<vscale x 2 x i64> %3, <vscale x 2 x i64> %4)
  call void @llvm.vp.store.nxv4i64.p0(<vscale x 4 x i64> %interleaved.vec, ptr align 8 %2, <vscale x 4 x i1> splat (i1 true), i32 %interleave.evl1)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @interleave_group_with_countable_early_exit(i64 %n, ptr %dst) #0 {
entry:
  %0 = add i64 %n, 1
  %1 = call i64 @llvm.vscale.i64()
  %2 = shl nuw i64 %1, 1
  %umax = call i64 @llvm.umax.i64(i64 %2, i64 38)
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
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !3

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
  br i1 %cmp, label %exit2, label %loop.header, !llvm.loop !4

exit2:                                            ; preds = %loop.latch
  ret void
}

define void @load_store_interleave_group_i32(ptr noalias %data) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 100, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = shl nsw i64 %index, 2
  %2 = getelementptr inbounds i32, ptr %data, i64 %1
  %interleave.evl = mul nuw nsw i32 %0, 4
  %wide.vp.load = call <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr align 8 %2, <vscale x 16 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vp.load)
  %3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %4 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %5 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 2
  %6 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 3
  %interleave.evl1 = mul nuw nsw i32 %0, 4
  %interleaved.vec = call <vscale x 16 x i32> @llvm.vector.interleave4.nxv16i32(<vscale x 4 x i32> %3, <vscale x 4 x i32> %4, <vscale x 4 x i32> %5, <vscale x 4 x i32> %6)
  call void @llvm.vp.store.nxv16i32.p0(<vscale x 16 x i32> %interleaved.vec, ptr align 8 %2, <vscale x 16 x i1> splat (i1 true), i32 %interleave.evl1)
  %7 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %7, %index
  %avl.next = sub nuw i64 %avl, %7
  %8 = icmp eq i64 %avl.next, 0
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i64> @llvm.vector.interleave2.nxv4i64(<vscale x 2 x i64>, <vscale x 2 x i64>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i64.p0(<vscale x 4 x i64>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr captures(none), <vscale x 16 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 16 x i32> @llvm.vector.interleave4.nxv16i32(<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv16i32.p0(<vscale x 16 x i32>, ptr captures(none), <vscale x 16 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1}
!5 = distinct !{!5, !1, !2}
