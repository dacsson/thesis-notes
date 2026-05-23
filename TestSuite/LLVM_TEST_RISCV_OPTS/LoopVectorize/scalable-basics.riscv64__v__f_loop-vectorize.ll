; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/scalable-basics.ll
; Variant: riscv64_+v,+f_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple riscv64 -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple riscv64 -mattr=+v,+f -S 2>%t | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; A collection of fairly basic functional tests when both fixed and scalable vectorization is
; allowed.  The primary goal of this is check for crashes during cost modeling, but it also
; exercises the default heuristics in a useful way.

define void @vector_add(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  %elem = load i64, ptr %arrayidx
  %add = add i64 %elem, %v
  store i64 %add, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; Same as above, but with op type of i32.  We currently have a bug around
; etype=ELEN profitability in the vectorizer, and having a smaller element
; width test allows us to highlight different aspects of codegen.
define void @vector_add_i32(ptr noalias nocapture %a, i32 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %elem = load i32, ptr %arrayidx
  %add = add i32 %elem, %v
  store i32 %add, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}


; a[b[i]] += v, mostly to exercise scatter/gather costing
; TODO: Currently fails to vectorize due to a memory conflict
define void @indexed_add(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %baddr = getelementptr inbounds i64, ptr %b, i64 %iv
  %aidx = load i64, ptr %baddr
  %aaddr = getelementptr inbounds i64, ptr %a, i64 %aidx
  %elem = load i64, ptr %aaddr
  %add = add i64 %elem, %v
  store i64 %add, ptr %aaddr
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; a[b[i]] = v, exercise scatter support
define void @indexed_store(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %baddr = getelementptr inbounds i64, ptr %b, i64 %iv
  %aidx = load i64, ptr %baddr
  %aaddr = getelementptr inbounds i64, ptr %a, i64 %aidx
  store i64 %v, ptr %aaddr
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define i64 @indexed_load(ptr noalias nocapture %a, ptr noalias nocapture %b, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum = phi i64 [0, %entry], [%sum.next, %for.body]
  %baddr = getelementptr inbounds i64, ptr %b, i64 %iv
  %aidx = load i64, ptr %baddr
  %aaddr = getelementptr inbounds i64, ptr %a, i64 %aidx
  %elem = load i64, ptr %aaddr
  %iv.next = add nuw nsw i64 %iv, 1
  %sum.next = add i64 %sum, %elem
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret i64 %sum.next
}

define void @splat_int(ptr noalias nocapture %a, i64 %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

define void @splat_ptr(ptr noalias nocapture %a, ptr %v, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %iv
  store ptr %v, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpvnkbhl4v.ll'
source_filename = "/tmp/tmpvnkbhl4v.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vector_add(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 2 x i64> %vp.op.load, %broadcast.splat
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %2, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @vector_add_i32(ptr noalias captures(none) %a, i32 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 4 x i32> poison, i32 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i32> %broadcast.splatinsert, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr inbounds i32, ptr %a, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 4 x i32> %vp.op.load, %broadcast.splat
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %2, ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @indexed_add(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %baddr = getelementptr inbounds i64, ptr %b, i64 %iv
  %aidx = load i64, ptr %baddr, align 8
  %aaddr = getelementptr inbounds i64, ptr %a, i64 %aidx
  %elem = load i64, ptr %aaddr, align 8
  %add = add i64 %elem, %v
  store i64 %add, ptr %aaddr, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

define void @indexed_store(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %b, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr inbounds i64, ptr %a, <vscale x 2 x i64> %vp.op.load
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %broadcast.splat, <vscale x 2 x ptr> align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define i64 @indexed_load(ptr noalias captures(none) %a, ptr noalias captures(none) %b, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.phi = phi <vscale x 2 x i64> [ zeroinitializer, %vector.ph ], [ %4, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %b, i64 %index
  %vp.op.load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = getelementptr inbounds i64, ptr %a, <vscale x 2 x i64> %vp.op.load
  %wide.masked.gather = call <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %2, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %3 = add <vscale x 2 x i64> %vec.phi, %wide.masked.gather
  %4 = call <vscale x 2 x i64> @llvm.vp.merge.nxv2i64(<vscale x 2 x i1> splat (i1 true), <vscale x 2 x i64> %3, <vscale x 2 x i64> %vec.phi, i32 %0)
  %5 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %5, %index
  %avl.next = sub nuw i64 %avl, %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %7 = call i64 @llvm.vector.reduce.add.nxv2i64(<vscale x 2 x i64> %4)
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret i64 %7
}

define void @splat_int(ptr noalias captures(none) %a, i64 %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %broadcast.splat, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

define void @splat_ptr(ptr noalias captures(none) %a, ptr %v, i64 %n) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %v, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %1 = getelementptr inbounds i64, ptr %a, i64 %index
  call void @llvm.vp.store.nxv2p0.p0(<vscale x 2 x ptr> %broadcast.splat, ptr align 8 %1, <vscale x 2 x i1> splat (i1 true), i32 %0)
  %2 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %3 = icmp eq i64 %avl.next, 0
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr captures(none), <vscale x 2 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.vp.merge.nxv2i64(<vscale x 2 x i1>, <vscale x 2 x i64>, <vscale x 2 x i64>, i32) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.nxv2i64(<vscale x 2 x i64>) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2p0.p0(<vscale x 2 x ptr>, ptr captures(none), <vscale x 2 x i1>, i32) #3

attributes #0 = { "target-features"="+v,+f" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nofree nosync nounwind willreturn }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #6 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !1, !2}
