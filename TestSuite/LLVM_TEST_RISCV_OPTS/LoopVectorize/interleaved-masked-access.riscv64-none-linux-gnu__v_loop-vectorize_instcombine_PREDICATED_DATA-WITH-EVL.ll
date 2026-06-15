; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/interleaved-masked-access.ll
; Variant: riscv64-none-linux-gnu_+v_loop-vectorize,instcombine_PREDICATED_DATA-WITH-EVL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-none-linux-gnu -passes=loop-vectorize,instcombine -mattr=+v -tail-folding-policy=prefer-fold-tail -S
; Original: RUN: opt -mtriple=riscv64-none-linux-gnu -S -passes=loop-vectorize,instcombine -mattr=+v -tail-folding-policy=prefer-fold-tail %s 2>&1 | FileCheck %s -check-prefix=PREDICATED_DATA-WITH-EVL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

define void @masked_strided_factor2(ptr noalias nocapture readonly %p, ptr noalias nocapture %q, i8 zeroext %guard) {
entry:
  %conv = zext i8 %guard to i32
  br label %for.body

for.body:
  %ix.024 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp1 = icmp ugt i32 %ix.024, %conv
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %mul = shl nuw nsw i32 %ix.024, 1
  %arrayidx = getelementptr inbounds i8, ptr %p, i32 %mul
  %0 = load i8, ptr %arrayidx, align 1
  %add = or disjoint i32 %mul, 1
  %arrayidx4 = getelementptr inbounds i8, ptr %p, i32 %add
  %1 = load i8, ptr %arrayidx4, align 1
  %cmp.i = icmp slt i8 %0, %1
  %spec.select.i = select i1 %cmp.i, i8 %1, i8 %0
  %arrayidx6 = getelementptr inbounds i8, ptr %q, i32 %mul
  store i8 %spec.select.i, ptr %arrayidx6, align 1
  %sub = sub i8 0, %spec.select.i
  %arrayidx11 = getelementptr inbounds i8, ptr %q, i32 %add
  store i8 %sub, ptr %arrayidx11, align 1
  br label %for.inc

for.inc:
  %inc = add nuw nsw i32 %ix.024, 1
  %exitcond = icmp eq i32 %inc, 1024
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret void
}


define void @masked_strided_factor4(ptr noalias nocapture readonly %p, ptr noalias nocapture %q, i8 zeroext %guard) {
entry:
  %conv = zext i8 %guard to i32
  br label %for.body

for.body:
  %ix.024 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp1 = icmp ugt i32 %ix.024, %conv
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %idx0 = shl nuw nsw i32 %ix.024, 2
  %idx1 = add i32 %idx0, 1
  %idx2 = add i32 %idx0, 2
  %idx3 = add i32 %idx0, 3

  %array1idx0 = getelementptr inbounds i8, ptr %p, i32 %idx0
  %0 = load i8, ptr %array1idx0, align 1
  %array1idx1 = getelementptr inbounds i8, ptr %p, i32 %idx1
  %1 = load i8, ptr %array1idx1, align 1
  %array1idx2 = getelementptr inbounds i8, ptr %p, i32 %idx2
  %2 = load i8, ptr %array1idx2, align 1
  %array1idx3 = getelementptr inbounds i8, ptr %p, i32 %idx3
  %3 = load i8, ptr %array1idx3, align 1

  %cmp.i1 = icmp slt i8 %0, %1
  %spec.select.i1 = select i1 %cmp.i1, i8 %1, i8 %0
  %sub1 = sub i8 0, %spec.select.i1
  %cmp.i2 = icmp slt i8 %2, %3
  %spec.select.i2 = select i1 %cmp.i2, i8 %3, i8 %2
  %sub2 = sub i8 0, %spec.select.i2

  %array3idx0 = getelementptr inbounds i8, ptr %q, i32 %idx0
  store i8 %spec.select.i1, ptr %array3idx0, align 1
  %array3idx1 = getelementptr inbounds i8, ptr %q, i32 %idx1
  store i8 %sub1, ptr %array3idx1, align 1
  %array3idx2 = getelementptr inbounds i8, ptr %q, i32 %idx2
  store i8 %spec.select.i2, ptr %array3idx2, align 1
  %array3idx3 = getelementptr inbounds i8, ptr %q, i32 %idx3
  store i8 %sub2, ptr %array3idx3, align 1

  br label %for.inc

for.inc:
  %inc = add nuw nsw i32 %ix.024, 1
  %exitcond = icmp eq i32 %inc, 1024
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpu5nzycu5.ll'
source_filename = "/tmp/tmpu5nzycu5.ll"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-none-linux-gnu"

define void @masked_strided_factor2(ptr noalias readonly captures(none) %p, ptr noalias captures(none) %q, i8 zeroext %guard) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %conv = zext i8 %guard to i32
  %broadcast.splatinsert = insertelement <vscale x 16 x i32> poison, i32 %conv, i64 0
  %broadcast.splat = shufflevector <vscale x 16 x i32> %broadcast.splatinsert, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %0 = call <vscale x 16 x i32> @llvm.stepvector.nxv16i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 16 x i32> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 16, i1 true)
  %broadcast.splatinsert1 = insertelement <vscale x 16 x i32> poison, i32 %1, i64 0
  %broadcast.splat2 = shufflevector <vscale x 16 x i32> %broadcast.splatinsert1, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %2 = icmp ugt <vscale x 16 x i32> %vec.ind, %broadcast.splat
  %3 = shl i32 %index, 1
  %4 = sext i32 %3 to i64
  %5 = getelementptr i8, ptr %p, i64 %4
  %interleave.evl = shl nuw nsw i32 %1, 1
  %interleaved.mask = call <vscale x 32 x i1> @llvm.vector.interleave2.nxv32i1(<vscale x 16 x i1> %2, <vscale x 16 x i1> %2)
  %wide.vp.load = call <vscale x 32 x i8> @llvm.vp.load.nxv32i8.p0(ptr align 1 %5, <vscale x 32 x i1> %interleaved.mask, i32 %interleave.evl)
  %strided.vec = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave2.nxv32i8(<vscale x 32 x i8> %wide.vp.load)
  %6 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 0
  %7 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 1
  %8 = call <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8> %6, <vscale x 16 x i8> %7)
  %9 = sext i32 %3 to i64
  %10 = getelementptr i8, ptr %q, i64 %9
  %11 = sub <vscale x 16 x i8> zeroinitializer, %8
  %interleave.evl3 = shl nuw nsw i32 %1, 1
  %interleaved.mask4 = call <vscale x 32 x i1> @llvm.vector.interleave2.nxv32i1(<vscale x 16 x i1> %2, <vscale x 16 x i1> %2)
  %interleaved.vec = call <vscale x 32 x i8> @llvm.vector.interleave2.nxv32i8(<vscale x 16 x i8> %8, <vscale x 16 x i8> %11)
  call void @llvm.vp.store.nxv32i8.p0(<vscale x 32 x i8> %interleaved.vec, ptr align 1 %10, <vscale x 32 x i1> %interleaved.mask4, i32 %interleave.evl3)
  %current.iteration.next = add nuw i32 %1, %index
  %avl.next = sub nuw i32 %avl, %1
  %vec.ind.next = add nuw nsw <vscale x 16 x i32> %vec.ind, %broadcast.splat2
  %12 = icmp eq i32 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @masked_strided_factor4(ptr noalias readonly captures(none) %p, ptr noalias captures(none) %q, i8 zeroext %guard) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %conv = zext i8 %guard to i32
  %broadcast.splatinsert = insertelement <vscale x 16 x i32> poison, i32 %conv, i64 0
  %broadcast.splat = shufflevector <vscale x 16 x i32> %broadcast.splatinsert, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %0 = call <vscale x 16 x i32> @llvm.stepvector.nxv16i32()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 16 x i32> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i32 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i32(i32 %avl, i32 16, i1 true)
  %broadcast.splatinsert1 = insertelement <vscale x 16 x i32> poison, i32 %1, i64 0
  %broadcast.splat2 = shufflevector <vscale x 16 x i32> %broadcast.splatinsert1, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %2 = icmp ugt <vscale x 16 x i32> %vec.ind, %broadcast.splat
  %3 = shl i32 %index, 2
  %4 = sext i32 %3 to i64
  %5 = getelementptr i8, ptr %p, i64 %4
  %interleave.evl = shl nuw nsw i32 %1, 2
  %interleaved.mask = call <vscale x 64 x i1> @llvm.vector.interleave4.nxv64i1(<vscale x 16 x i1> %2, <vscale x 16 x i1> %2, <vscale x 16 x i1> %2, <vscale x 16 x i1> %2)
  %wide.vp.load = call <vscale x 64 x i8> @llvm.vp.load.nxv64i8.p0(ptr align 1 %5, <vscale x 64 x i1> %interleaved.mask, i32 %interleave.evl)
  %strided.vec = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave4.nxv64i8(<vscale x 64 x i8> %wide.vp.load)
  %6 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 0
  %7 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 1
  %8 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 2
  %9 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 3
  %10 = call <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8> %6, <vscale x 16 x i8> %7)
  %11 = sub <vscale x 16 x i8> zeroinitializer, %10
  %12 = call <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8> %8, <vscale x 16 x i8> %9)
  %13 = sub <vscale x 16 x i8> zeroinitializer, %12
  %14 = sext i32 %3 to i64
  %15 = getelementptr i8, ptr %q, i64 %14
  %interleave.evl3 = shl nuw nsw i32 %1, 2
  %interleaved.mask4 = call <vscale x 64 x i1> @llvm.vector.interleave4.nxv64i1(<vscale x 16 x i1> %2, <vscale x 16 x i1> %2, <vscale x 16 x i1> %2, <vscale x 16 x i1> %2)
  %interleaved.vec = call <vscale x 64 x i8> @llvm.vector.interleave4.nxv64i8(<vscale x 16 x i8> %10, <vscale x 16 x i8> %11, <vscale x 16 x i8> %12, <vscale x 16 x i8> %13)
  call void @llvm.vp.store.nxv64i8.p0(<vscale x 64 x i8> %interleaved.vec, ptr align 1 %15, <vscale x 64 x i1> %interleaved.mask4, i32 %interleave.evl3)
  %current.iteration.next = add nuw i32 %1, %index
  %avl.next = sub nuw i32 %avl, %1
  %vec.ind.next = add nuw nsw <vscale x 16 x i32> %vec.ind, %broadcast.splat2
  %16 = icmp eq i32 %avl.next, 0
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 16 x i32> @llvm.stepvector.nxv16i32() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i32(i32, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 32 x i1> @llvm.vector.interleave2.nxv32i1(<vscale x 16 x i1>, <vscale x 16 x i1>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 32 x i8> @llvm.vp.load.nxv32i8.p0(ptr captures(none), <vscale x 32 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave2.nxv32i8(<vscale x 32 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 32 x i8> @llvm.vector.interleave2.nxv32i8(<vscale x 16 x i8>, <vscale x 16 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv32i8.p0(<vscale x 32 x i8>, ptr captures(none), <vscale x 32 x i1>, i32) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 64 x i1> @llvm.vector.interleave4.nxv64i1(<vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 64 x i8> @llvm.vp.load.nxv64i8.p0(ptr captures(none), <vscale x 64 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave4.nxv64i8(<vscale x 64 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 64 x i8> @llvm.vector.interleave4.nxv64i8(<vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv64i8.p0(<vscale x 64 x i8>, ptr captures(none), <vscale x 64 x i1>, i32) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #5 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
