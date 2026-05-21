; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/interleaved-masked-access.ll
; Variant: riscv64-none-linux-gnu_+v_loop-vectorize,instcombine_SCALAR_EPILOGUE
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-none-linux-gnu -passes=loop-vectorize,instcombine -mattr=+v -tail-folding-policy=dont-fold-tail -S
; Original: RUN: opt -mtriple=riscv64-none-linux-gnu -S -passes=loop-vectorize,instcombine -mattr=+v -tail-folding-policy=dont-fold-tail %s 2>&1 | FileCheck %s -check-prefix=SCALAR_EPILOGUE

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

; ModuleID = '/tmp/tmp9k2o9b8s.ll'
source_filename = "/tmp/tmp9k2o9b8s.ll"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-none-linux-gnu"

define void @masked_strided_factor2(ptr noalias readonly captures(none) %p, ptr noalias captures(none) %q, i8 zeroext %guard) #0 {
entry:
  %conv = zext i8 %guard to i32
  %0 = call i32 @llvm.vscale.i32()
  %min.iters.check = icmp ugt i32 %0, 64
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %1 = call i32 @llvm.vscale.i32()
  %2 = shl nuw i32 %1, 4
  %n.mod.vf = urem i32 1024, %2
  %n.vec = sub nuw nsw i32 1024, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 16 x i32> poison, i32 %conv, i64 0
  %broadcast.splat = shufflevector <vscale x 16 x i32> %broadcast.splatinsert, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %3 = call <vscale x 16 x i32> @llvm.stepvector.nxv16i32()
  %broadcast.splatinsert1 = insertelement <vscale x 16 x i32> poison, i32 %2, i64 0
  %broadcast.splat2 = shufflevector <vscale x 16 x i32> %broadcast.splatinsert1, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 16 x i32> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %4 = icmp ugt <vscale x 16 x i32> %vec.ind, %broadcast.splat
  %5 = shl i32 %index, 1
  %6 = sext i32 %5 to i64
  %7 = getelementptr i8, ptr %p, i64 %6
  %interleaved.mask = call <vscale x 32 x i1> @llvm.vector.interleave2.nxv32i1(<vscale x 16 x i1> %4, <vscale x 16 x i1> %4)
  %wide.masked.vec = call <vscale x 32 x i8> @llvm.masked.load.nxv32i8.p0(ptr align 1 %7, <vscale x 32 x i1> %interleaved.mask, <vscale x 32 x i8> poison)
  %strided.vec = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave2.nxv32i8(<vscale x 32 x i8> %wide.masked.vec)
  %8 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 0
  %9 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 1
  %10 = call <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8> %8, <vscale x 16 x i8> %9)
  %11 = sext i32 %5 to i64
  %12 = getelementptr i8, ptr %q, i64 %11
  %13 = sub <vscale x 16 x i8> zeroinitializer, %10
  %interleaved.vec = call <vscale x 32 x i8> @llvm.vector.interleave2.nxv32i8(<vscale x 16 x i8> %10, <vscale x 16 x i8> %13)
  %interleaved.mask3 = call <vscale x 32 x i1> @llvm.vector.interleave2.nxv32i1(<vscale x 16 x i1> %4, <vscale x 16 x i1> %4)
  call void @llvm.masked.store.nxv32i8.p0(<vscale x 32 x i8> %interleaved.vec, ptr align 1 %12, <vscale x 32 x i1> %interleaved.mask3)
  %index.next = add nuw i32 %index, %2
  %vec.ind.next = add nuw nsw <vscale x 16 x i32> %vec.ind, %broadcast.splat2
  %14 = icmp eq i32 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.mod.vf, 0
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i32 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %ix.024 = phi i32 [ %bc.resume.val, %scalar.ph ], [ %inc, %for.inc ]
  %cmp1 = icmp samesign ugt i32 %ix.024, %conv
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %mul = shl nuw nsw i32 %ix.024, 1
  %15 = zext nneg i32 %mul to i64
  %arrayidx = getelementptr inbounds nuw i8, ptr %p, i64 %15
  %16 = load i8, ptr %arrayidx, align 1
  %add = or disjoint i32 %mul, 1
  %17 = zext nneg i32 %add to i64
  %arrayidx4 = getelementptr inbounds nuw i8, ptr %p, i64 %17
  %18 = load i8, ptr %arrayidx4, align 1
  %spec.select.i = call i8 @llvm.smax.i8(i8 %16, i8 %18)
  %19 = zext nneg i32 %mul to i64
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %q, i64 %19
  store i8 %spec.select.i, ptr %arrayidx6, align 1
  %sub = sub i8 0, %spec.select.i
  %20 = zext nneg i32 %add to i64
  %arrayidx11 = getelementptr inbounds nuw i8, ptr %q, i64 %20
  store i8 %sub, ptr %arrayidx11, align 1
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %inc = add nuw nsw i32 %ix.024, 1
  %exitcond = icmp eq i32 %inc, 1024
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.inc
  ret void
}

define void @masked_strided_factor4(ptr noalias readonly captures(none) %p, ptr noalias captures(none) %q, i8 zeroext %guard) #0 {
entry:
  %conv = zext i8 %guard to i32
  %0 = call i32 @llvm.vscale.i32()
  %min.iters.check = icmp ugt i32 %0, 64
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %1 = call i32 @llvm.vscale.i32()
  %2 = shl nuw i32 %1, 4
  %n.mod.vf = urem i32 1024, %2
  %n.vec = sub nuw nsw i32 1024, %n.mod.vf
  %broadcast.splatinsert = insertelement <vscale x 16 x i32> poison, i32 %conv, i64 0
  %broadcast.splat = shufflevector <vscale x 16 x i32> %broadcast.splatinsert, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %3 = call <vscale x 16 x i32> @llvm.stepvector.nxv16i32()
  %broadcast.splatinsert1 = insertelement <vscale x 16 x i32> poison, i32 %2, i64 0
  %broadcast.splat2 = shufflevector <vscale x 16 x i32> %broadcast.splatinsert1, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 16 x i32> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %4 = icmp ugt <vscale x 16 x i32> %vec.ind, %broadcast.splat
  %5 = shl i32 %index, 2
  %6 = sext i32 %5 to i64
  %7 = getelementptr i8, ptr %p, i64 %6
  %interleaved.mask = call <vscale x 64 x i1> @llvm.vector.interleave4.nxv64i1(<vscale x 16 x i1> %4, <vscale x 16 x i1> %4, <vscale x 16 x i1> %4, <vscale x 16 x i1> %4)
  %wide.masked.vec = call <vscale x 64 x i8> @llvm.masked.load.nxv64i8.p0(ptr align 1 %7, <vscale x 64 x i1> %interleaved.mask, <vscale x 64 x i8> poison)
  %strided.vec = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave4.nxv64i8(<vscale x 64 x i8> %wide.masked.vec)
  %8 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 0
  %9 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 1
  %10 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 2
  %11 = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %strided.vec, 3
  %12 = call <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8> %8, <vscale x 16 x i8> %9)
  %13 = sub <vscale x 16 x i8> zeroinitializer, %12
  %14 = call <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8> %10, <vscale x 16 x i8> %11)
  %15 = sub <vscale x 16 x i8> zeroinitializer, %14
  %16 = sext i32 %5 to i64
  %17 = getelementptr i8, ptr %q, i64 %16
  %interleaved.vec = call <vscale x 64 x i8> @llvm.vector.interleave4.nxv64i8(<vscale x 16 x i8> %12, <vscale x 16 x i8> %13, <vscale x 16 x i8> %14, <vscale x 16 x i8> %15)
  %interleaved.mask3 = call <vscale x 64 x i1> @llvm.vector.interleave4.nxv64i1(<vscale x 16 x i1> %4, <vscale x 16 x i1> %4, <vscale x 16 x i1> %4, <vscale x 16 x i1> %4)
  call void @llvm.masked.store.nxv64i8.p0(<vscale x 64 x i8> %interleaved.vec, ptr align 1 %17, <vscale x 64 x i1> %interleaved.mask3)
  %index.next = add nuw i32 %index, %2
  %vec.ind.next = add nuw nsw <vscale x 16 x i32> %vec.ind, %broadcast.splat2
  %18 = icmp eq i32 %index.next, %n.vec
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.mod.vf, 0
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i32 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %ix.024 = phi i32 [ %bc.resume.val, %scalar.ph ], [ %inc, %for.inc ]
  %cmp1 = icmp samesign ugt i32 %ix.024, %conv
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %idx0 = shl nuw nsw i32 %ix.024, 2
  %idx1 = or disjoint i32 %idx0, 1
  %idx2 = or disjoint i32 %idx0, 2
  %idx3 = or disjoint i32 %idx0, 3
  %19 = zext nneg i32 %idx0 to i64
  %array1idx0 = getelementptr inbounds nuw i8, ptr %p, i64 %19
  %20 = load i8, ptr %array1idx0, align 1
  %21 = zext nneg i32 %idx1 to i64
  %array1idx1 = getelementptr inbounds nuw i8, ptr %p, i64 %21
  %22 = load i8, ptr %array1idx1, align 1
  %23 = zext nneg i32 %idx2 to i64
  %array1idx2 = getelementptr inbounds nuw i8, ptr %p, i64 %23
  %24 = load i8, ptr %array1idx2, align 1
  %25 = zext nneg i32 %idx3 to i64
  %array1idx3 = getelementptr inbounds nuw i8, ptr %p, i64 %25
  %26 = load i8, ptr %array1idx3, align 1
  %spec.select.i1 = call i8 @llvm.smax.i8(i8 %20, i8 %22)
  %sub1 = sub i8 0, %spec.select.i1
  %spec.select.i2 = call i8 @llvm.smax.i8(i8 %24, i8 %26)
  %sub2 = sub i8 0, %spec.select.i2
  %27 = zext nneg i32 %idx0 to i64
  %array3idx0 = getelementptr inbounds nuw i8, ptr %q, i64 %27
  store i8 %spec.select.i1, ptr %array3idx0, align 1
  %28 = zext nneg i32 %idx1 to i64
  %array3idx1 = getelementptr inbounds nuw i8, ptr %q, i64 %28
  store i8 %sub1, ptr %array3idx1, align 1
  %29 = zext nneg i32 %idx2 to i64
  %array3idx2 = getelementptr inbounds nuw i8, ptr %q, i64 %29
  store i8 %spec.select.i2, ptr %array3idx2, align 1
  %30 = zext nneg i32 %idx3 to i64
  %array3idx3 = getelementptr inbounds nuw i8, ptr %q, i64 %30
  store i8 %sub2, ptr %array3idx3, align 1
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %inc = add nuw nsw i32 %ix.024, 1
  %exitcond = icmp eq i32 %inc, 1024
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !5

for.end:                                          ; preds = %middle.block, %for.inc
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vscale.i32() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 16 x i32> @llvm.stepvector.nxv16i32() #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 32 x i1> @llvm.vector.interleave2.nxv32i1(<vscale x 16 x i1>, <vscale x 16 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 32 x i8> @llvm.masked.load.nxv32i8.p0(ptr captures(none), <vscale x 32 x i1>, <vscale x 32 x i8>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave2.nxv32i8(<vscale x 32 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 32 x i8> @llvm.vector.interleave2.nxv32i8(<vscale x 16 x i8>, <vscale x 16 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.nxv32i8.p0(<vscale x 32 x i8>, ptr captures(none), <vscale x 32 x i1>) #5

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 16 x i8> @llvm.smax.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i8 @llvm.smax.i8(i8, i8) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 64 x i1> @llvm.vector.interleave4.nxv64i1(<vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 64 x i8> @llvm.masked.load.nxv64i8.p0(ptr captures(none), <vscale x 64 x i1>, <vscale x 64 x i8>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.vector.deinterleave4.nxv64i8(<vscale x 64 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 64 x i8> @llvm.vector.interleave4.nxv64i8(<vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.nxv64i8.p0(<vscale x 64 x i8>, ptr captures(none), <vscale x 64 x i1>) #5

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
