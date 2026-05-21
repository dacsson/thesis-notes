; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/masked_gather_scatter.ll
; Variant: riscv64_+v,+zvl256b,+d_loop-vectorize_RV64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v,+zvl256b,+d -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv64 -mattr=+v,+zvl256b,+d -S | FileCheck %s -check-prefixes=RV64

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; The source code:
;void foo4(ptr A, ptr B, int *trigger) {
;  for (int i=0; i<10000; i += 16) {
;    if (trigger[i] < 100) {
;          A[i] = B[i*2] + trigger[i]; << non-consecutive access
;    }
;  }
;}

define void @foo4(ptr nocapture %A, ptr nocapture readonly %B, ptr nocapture readonly %trigger) #0 {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %trigger, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp slt i32 %0, 100
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %1 = shl nuw nsw i64 %indvars.iv, 1
  %arrayidx3 = getelementptr inbounds double, ptr %B, i64 %1
  %2 = load double, ptr %arrayidx3, align 8
  %conv = sitofp i32 %0 to double
  %add = fadd double %2, %conv
  %arrayidx7 = getelementptr inbounds double, ptr %A, i64 %indvars.iv
  store double %add, ptr %arrayidx7, align 8
  br label %for.inc

for.inc:
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 16
  %cmp = icmp ult i64 %indvars.iv.next, 10000
  br i1 %cmp, label %for.body, label %for.end

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpfv3o4bwk.ll'
source_filename = "/tmp/tmpfv3o4bwk.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @foo4(ptr captures(none) %A, ptr readonly captures(none) %B, ptr readonly captures(none) %trigger) #0 {
entry:
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr i8, ptr %A, i64 79880
  %scevgep1 = getelementptr i8, ptr %trigger, i64 39940
  %scevgep2 = getelementptr i8, ptr %B, i64 159752
  %bound0 = icmp ult ptr %A, %scevgep1
  %bound1 = icmp ult ptr %trigger, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  %bound03 = icmp ult ptr %A, %scevgep2
  %bound14 = icmp ult ptr %B, %scevgep
  %found.conflict5 = and i1 %bound03, %bound14
  %conflict.rdx = or i1 %found.conflict, %found.conflict5
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %0 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %1 = mul nuw nsw <vscale x 2 x i64> %0, splat (i64 16)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 625, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %3 = zext i32 %2 to i64
  %4 = shl nuw nsw i64 %3, 4
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %5 = getelementptr inbounds i32, ptr %trigger, <vscale x 2 x i64> %vec.ind
  %wide.masked.gather = call <vscale x 2 x i32> @llvm.vp.gather.nxv2i32.nxv2p0(<vscale x 2 x ptr> align 4 %5, <vscale x 2 x i1> splat (i1 true), i32 %2), !alias.scope !0
  %6 = icmp slt <vscale x 2 x i32> %wide.masked.gather, splat (i32 100)
  %7 = shl nuw nsw <vscale x 2 x i64> %vec.ind, splat (i64 1)
  %8 = getelementptr inbounds double, ptr %B, <vscale x 2 x i64> %7
  %wide.masked.gather6 = call <vscale x 2 x double> @llvm.vp.gather.nxv2f64.nxv2p0(<vscale x 2 x ptr> align 8 %8, <vscale x 2 x i1> %6, i32 %2), !alias.scope !3
  %9 = sitofp <vscale x 2 x i32> %wide.masked.gather to <vscale x 2 x double>
  %10 = fadd <vscale x 2 x double> %wide.masked.gather6, %9
  %11 = getelementptr inbounds double, ptr %A, <vscale x 2 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv2f64.nxv2p0(<vscale x 2 x double> %10, <vscale x 2 x ptr> align 8 %11, <vscale x 2 x i1> %6, i32 %2), !alias.scope !5, !noalias !7
  %avl.next = sub nuw i64 %avl, %3
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %12 = icmp eq i64 %avl.next, 0
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  br label %for.end

scalar.ph:                                        ; preds = %vector.memcheck
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %indvars.iv = phi i64 [ 0, %scalar.ph ], [ %indvars.iv.next, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %trigger, i64 %indvars.iv
  %13 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp slt i32 %13, 100
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %14 = shl nuw nsw i64 %indvars.iv, 1
  %arrayidx3 = getelementptr inbounds double, ptr %B, i64 %14
  %15 = load double, ptr %arrayidx3, align 8
  %conv = sitofp i32 %13 to double
  %add = fadd double %15, %conv
  %arrayidx7 = getelementptr inbounds double, ptr %A, i64 %indvars.iv
  store double %add, ptr %arrayidx7, align 8
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 16
  %cmp = icmp ult i64 %indvars.iv.next, 10000
  br i1 %cmp, label %for.body, label %for.end, !llvm.loop !11

for.end:                                          ; preds = %middle.block, %for.inc
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i32> @llvm.vp.gather.nxv2i32.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x double> @llvm.vp.gather.nxv2f64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2f64.nxv2p0(<vscale x 2 x double>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #4

attributes #0 = { "target-features"="+v,+zvl256b,+d" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = !{!6}
!6 = distinct !{!6, !2}
!7 = !{!1, !4}
!8 = distinct !{!8, !9, !10}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = !{!"llvm.loop.unroll.runtime.disable"}
!11 = distinct !{!11, !9}
