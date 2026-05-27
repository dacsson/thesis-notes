; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/masked_gather_scatter.ll
; Variant: riscv32_+v,+zvl256b,+d_loop-vectorize_RV32
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv32 -mattr=+v,+zvl256b,+d -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv32 -mattr=+v,+zvl256b,+d -S | FileCheck %s -check-prefixes=RV32

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

; ModuleID = '/tmp/tmpfjr7cblc.ll'
source_filename = "/tmp/tmpfjr7cblc.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define void @foo4(ptr captures(none) %A, ptr readonly captures(none) %B, ptr readonly captures(none) %trigger) #0 {
entry:
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %mul = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 128, i32 624)
  %mul.result = extractvalue { i32, i1 } %mul, 0
  %mul.overflow = extractvalue { i32, i1 } %mul, 1
  %0 = getelementptr i8, ptr %A, i32 %mul.result
  %1 = icmp ult ptr %0, %A
  %2 = or i1 %1, %mul.overflow
  %mul1 = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 256, i32 624)
  %mul.result2 = extractvalue { i32, i1 } %mul1, 0
  %mul.overflow3 = extractvalue { i32, i1 } %mul1, 1
  %3 = getelementptr i8, ptr %B, i32 %mul.result2
  %4 = icmp ult ptr %3, %B
  %5 = or i1 %4, %mul.overflow3
  %6 = or i1 %2, %5
  br i1 %6, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %scevgep = getelementptr i8, ptr %trigger, i32 39940
  %scevgep4 = getelementptr i8, ptr %A, i32 79880
  %scevgep5 = getelementptr i8, ptr %B, i32 159752
  %bound0 = icmp ult ptr %trigger, %scevgep4
  %bound1 = icmp ult ptr %A, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  %bound06 = icmp ult ptr %A, %scevgep5
  %bound17 = icmp ult ptr %B, %scevgep4
  %found.conflict8 = and i1 %bound06, %bound17
  %conflict.rdx = or i1 %found.conflict, %found.conflict8
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %7 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %8 = mul nuw nsw <vscale x 2 x i64> %7, splat (i64 16)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i64> [ %8, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 625, %vector.ph ], [ %avl.next, %vector.body ]
  %9 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %10 = zext i32 %9 to i64
  %11 = shl nuw nsw i64 %10, 4
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %11, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %12 = getelementptr inbounds i32, ptr %trigger, <vscale x 2 x i64> %vec.ind
  %wide.masked.gather = call <vscale x 2 x i32> @llvm.vp.gather.nxv2i32.nxv2p0(<vscale x 2 x ptr> align 4 %12, <vscale x 2 x i1> splat (i1 true), i32 %9), !alias.scope !0, !noalias !3
  %13 = icmp slt <vscale x 2 x i32> %wide.masked.gather, splat (i32 100)
  %14 = shl nuw nsw <vscale x 2 x i64> %vec.ind, splat (i64 1)
  %15 = getelementptr inbounds double, ptr %B, <vscale x 2 x i64> %14
  %wide.masked.gather9 = call <vscale x 2 x double> @llvm.vp.gather.nxv2f64.nxv2p0(<vscale x 2 x ptr> align 8 %15, <vscale x 2 x i1> %13, i32 %9), !alias.scope !5
  %16 = sitofp <vscale x 2 x i32> %wide.masked.gather to <vscale x 2 x double>
  %17 = fadd <vscale x 2 x double> %wide.masked.gather9, %16
  %18 = getelementptr inbounds double, ptr %A, <vscale x 2 x i64> %vec.ind
  call void @llvm.vp.scatter.nxv2f64.nxv2p0(<vscale x 2 x double> %17, <vscale x 2 x ptr> align 8 %18, <vscale x 2 x i1> %13, i32 %9), !alias.scope !3, !noalias !5
  %avl.next = sub nuw i64 %avl, %10
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %19 = icmp eq i64 %avl.next, 0
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %for.end

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %indvars.iv = phi i64 [ 0, %scalar.ph ], [ %indvars.iv.next, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %trigger, i64 %indvars.iv
  %20 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp slt i32 %20, 100
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %21 = shl nuw nsw i64 %indvars.iv, 1
  %arrayidx3 = getelementptr inbounds double, ptr %B, i64 %21
  %22 = load double, ptr %arrayidx3, align 8
  %conv = sitofp i32 %20 to double
  %add = fadd double %22, %conv
  %arrayidx7 = getelementptr inbounds double, ptr %A, i64 %indvars.iv
  store double %add, ptr %arrayidx7, align 8
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 16
  %cmp = icmp ult i64 %indvars.iv.next, 10000
  br i1 %cmp, label %for.body, label %for.end, !llvm.loop !10

for.end:                                          ; preds = %middle.block, %for.inc
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i32> @llvm.vp.gather.nxv2i32.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x double> @llvm.vp.gather.nxv2f64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv2f64.nxv2p0(<vscale x 2 x double>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #5

attributes #0 = { "target-features"="+v,+zvl256b,+d" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #5 = { nocallback nofree nosync nounwind willreturn }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = !{!6}
!6 = distinct !{!6, !2}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.isvectorized", i32 1}
!9 = !{!"llvm.loop.unroll.runtime.disable"}
!10 = distinct !{!10, !8}
