; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/pointer-induction.ll
; Variant: CHECK
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -S
; Original: RUN: opt -p loop-vectorize -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target triple = "riscv64-unknown-linux-gnu"

define void @ptr_induction(ptr %p, ptr noalias %q, ptr noalias %p.end) #0 {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %ptr.ind = phi ptr [ %p, %entry ], [ %ptr.ind.next, %loop ]
  %ptri64 = ptrtoint ptr %ptr.ind to i64
  store i64 %ptri64, ptr %q
  store i64 %iv, ptr %p
  %iv.next = add i64 %iv, 1
  %ptr.ind.next = getelementptr i8, ptr %ptr.ind, i64 1
  %ec = icmp eq ptr %ptr.ind, %p.end
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define i1 @scalarize_ptr_induction(ptr %start, ptr %end, ptr noalias %dst, i1 %c) #1 {
entry:
  br label %loop

loop:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop ]
  %gep = getelementptr i8, ptr %ptr.iv, i64 4
  %l = load i32, ptr %gep, align 4
  %ext = zext i32 %l to i64
  %unused = load i32, ptr %ptr.iv, align 4
  %mul1 = mul i64 %ext, -7070675565921424023
  %mul2 = add i64 %mul1, -4
  store i64 %mul2, ptr %dst, align 1
  %ptr.iv.next = getelementptr nusw i8, ptr %ptr.iv, i64 12
  %cmp = icmp eq ptr %ptr.iv.next, %end
  br i1 %cmp, label %exit, label %loop

exit:
  ret i1 %cmp
}

attributes #0 = { "target-features"="+v" }
attributes #1 = { "target-cpu"="sifive-p670" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpe11si53l.ll'
source_filename = "/tmp/tmpe11si53l.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @ptr_induction(ptr %p, ptr noalias %q, ptr noalias %p.end) #0 {
entry:
  %p2 = ptrtoint ptr %p to i64
  %p.end1 = ptrtoint ptr %p.end to i64
  %0 = add i64 %p.end1, 1
  %1 = sub i64 %0, %p2
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %q, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <vscale x 2 x ptr> poison, ptr %p, i64 0
  %broadcast.splat4 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert3, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %2 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i64> [ %2, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %pointer.phi = phi ptr [ %p, %vector.ph ], [ %ptr.ind7, %vector.body ]
  %avl = phi i64 [ %1, %vector.ph ], [ %avl.next, %vector.body ]
  %vector.gep = getelementptr i8, ptr %pointer.phi, <vscale x 2 x i64> %2
  %3 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %4 = zext i32 %3 to i64
  %broadcast.splatinsert5 = insertelement <vscale x 2 x i64> poison, i64 %4, i64 0
  %broadcast.splat6 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert5, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %5 = ptrtoint <vscale x 2 x ptr> %vector.gep to <vscale x 2 x i64>
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %5, <vscale x 2 x ptr> align 8 %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %3)
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %vec.ind, <vscale x 2 x ptr> align 8 %broadcast.splat4, <vscale x 2 x i1> splat (i1 true), i32 %3)
  %avl.next = sub nuw i64 %avl, %4
  %vec.ind.next = add <vscale x 2 x i64> %vec.ind, %broadcast.splat6
  %ptr.ind7 = getelementptr i8, ptr %pointer.phi, i64 %4
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define i1 @scalarize_ptr_induction(ptr %start, ptr %end, ptr noalias %dst, i1 %c) #1 {
entry:
  %start5 = ptrtoint ptr %start to i64
  %end4 = ptrtoint ptr %end to i64
  %start2 = ptrtoint ptr %start to i64
  %end1 = ptrtoint ptr %end to i64
  %0 = add i64 %end4, -12
  %1 = sub i64 %0, %start5
  %2 = udiv i64 %1, 12
  %3 = add nuw nsw i64 %2, 1
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %dst, i64 8
  %4 = add i64 %end1, -12
  %5 = sub i64 %4, %start2
  %6 = udiv i64 %5, 12
  %7 = mul nuw i64 %6, 12
  %8 = add i64 %7, 8
  %scevgep3 = getelementptr i8, ptr %start, i64 %8
  %bound0 = icmp ult ptr %dst, %scevgep3
  %bound1 = icmp ult ptr %start, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %broadcast.splatinsert = insertelement <vscale x 2 x ptr> poison, ptr %dst, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  %broadcast.splatinsert6 = insertelement <vscale x 2 x ptr> poison, ptr %end, i64 0
  %broadcast.splat7 = shufflevector <vscale x 2 x ptr> %broadcast.splatinsert6, <vscale x 2 x ptr> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %pointer.phi = phi ptr [ %start, %vector.ph ], [ %ptr.ind, %vector.body ]
  %avl = phi i64 [ %3, %vector.ph ], [ %avl.next, %vector.body ]
  %9 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %10 = mul <vscale x 2 x i64> %9, splat (i64 12)
  %vector.gep = getelementptr i8, ptr %pointer.phi, <vscale x 2 x i64> %10
  %11 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %12 = getelementptr i8, <vscale x 2 x ptr> %vector.gep, i64 4
  %wide.masked.gather = call <vscale x 2 x i32> @llvm.vp.gather.nxv2i32.nxv2p0(<vscale x 2 x ptr> align 4 %12, <vscale x 2 x i1> splat (i1 true), i32 %11), !alias.scope !3
  %13 = zext <vscale x 2 x i32> %wide.masked.gather to <vscale x 2 x i64>
  %14 = mul <vscale x 2 x i64> %13, splat (i64 -7070675565921424023)
  %15 = add <vscale x 2 x i64> %14, splat (i64 -4)
  call void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64> %15, <vscale x 2 x ptr> align 1 %broadcast.splat, <vscale x 2 x i1> splat (i1 true), i32 %11), !alias.scope !6, !noalias !3
  %16 = zext i32 %11 to i64
  %avl.next = sub nuw i64 %avl, %16
  %17 = mul i64 12, %16
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 %17
  %18 = icmp eq i64 %avl.next, 0
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %19 = getelementptr nusw i8, <vscale x 2 x ptr> %vector.gep, i64 12
  %20 = icmp eq <vscale x 2 x ptr> %19, %broadcast.splat7
  %21 = sub i64 %16, 1
  %22 = extractelement <vscale x 2 x i1> %20, i64 %21
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %ptr.iv = phi ptr [ %start, %scalar.ph ], [ %ptr.iv.next, %loop ]
  %gep = getelementptr i8, ptr %ptr.iv, i64 4
  %l = load i32, ptr %gep, align 4
  %ext = zext i32 %l to i64
  %unused = load i32, ptr %ptr.iv, align 4
  %mul1 = mul i64 %ext, -7070675565921424023
  %mul2 = add i64 %mul1, -4
  store i64 %mul2, ptr %dst, align 1
  %ptr.iv.next = getelementptr nusw i8, ptr %ptr.iv, i64 12
  %cmp = icmp eq ptr %ptr.iv.next, %end
  br i1 %cmp, label %exit, label %loop, !llvm.loop !9

exit:                                             ; preds = %middle.block, %loop
  %cmp.lcssa = phi i1 [ %cmp, %loop ], [ %22, %middle.block ]
  ret i1 %cmp.lcssa
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2i64.nxv2p0(<vscale x 2 x i64>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i32> @llvm.vp.gather.nxv2i32.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

attributes #0 = { "target-features"="+v" }
attributes #1 = { "target-cpu"="sifive-p670" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = !{!4}
!4 = distinct !{!4, !5}
!5 = distinct !{!5, !"LVerDomain"}
!6 = !{!7}
!7 = distinct !{!7, !5}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1}
