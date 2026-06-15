; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/dbg-tail-folding-by-evl.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @reverse_store(ptr %a, i64 %n) !dbg !3 {
entry:
  br label %loop

loop:
  %iv = phi i64 [ %n, %entry ], [ %iv.next, %loop ]
  %iv.next = add nsw i64 %iv, -1, !dbg !6
  %arrayidx = getelementptr inbounds nuw i64, ptr %a, i64 %iv.next, !dbg !7
  store i64 %iv.next, ptr %arrayidx, align 8, !dbg !8
  %cmp = icmp samesign ugt i64 %iv, 1, !dbg !9
  br i1 %cmp, label %loop, label %exit, !dbg !10, !llvm.loop !11

exit:
  ret void
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "dbg-tail-folding-by-evl.cpp", directory: "/test/file/path")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "reverse_store", scope: !1, file: !1, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !5)
!4 = !DISubroutineType(types: !5)
!5 = !{}
!6 = !DILocation(line: 2, scope: !3)
!7 = !DILocation(line: 3, column: 7, scope: !3)
!8 = !DILocation(line: 3, column: 12, scope: !3)
!9 = !DILocation(line: 2, column: 27, scope: !3)
!10 = !DILocation(line: 2, column: 5, scope: !3)
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.vectorize.enable", i1 true}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmphv02m3q4.ll'
source_filename = "/tmp/tmphv02m3q4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @reverse_store(ptr %a, i64 %n) #0 !dbg !3 {
entry:
  %0 = add i64 %n, 1
  %umin = call i64 @llvm.umin.i64(i64 %n, i64 1)
  %1 = sub i64 %0, %umin
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %n, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %3 = sub nsw <vscale x 2 x i64> %broadcast.splat, %2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 2 x i64> [ %3, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ %1, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %5 = zext i32 %4 to i64
  %6 = sub nsw i64 0, %5
  %broadcast.splatinsert1 = insertelement <vscale x 2 x i64> poison, i64 %6, i64 0
  %broadcast.splat2 = shufflevector <vscale x 2 x i64> %broadcast.splatinsert1, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %7 = add nsw <vscale x 2 x i64> %vec.ind, splat (i64 -1), !dbg !6
  %8 = extractelement <vscale x 2 x i64> %7, i64 0
  %9 = getelementptr inbounds nuw i64, ptr %a, i64 %8, !dbg !7
  %10 = sub nuw nsw i64 %5, 1
  %11 = sub i64 0, %10
  %12 = getelementptr i64, ptr %9, i64 %11, !dbg !8
  %13 = call <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64> %7, <vscale x 2 x i1> splat (i1 true), i32 %4), !dbg !8
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %13, ptr align 8 %12, <vscale x 2 x i1> splat (i1 true), i32 %4), !dbg !8
  %avl.next = sub nuw i64 %avl, %5
  %vec.ind.next = add nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat2
  %14 = icmp eq i64 %avl.next, 0
  br i1 %14, label %middle.block, label %vector.body, !dbg !9, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  br label %exit, !dbg !9

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "dbg-tail-folding-by-evl.cpp", directory: "/test/file/path")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "reverse_store", scope: !1, file: !1, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !5)
!4 = !DISubroutineType(types: !5)
!5 = !{}
!6 = !DILocation(line: 2, scope: !3)
!7 = !DILocation(line: 3, column: 7, scope: !3)
!8 = !DILocation(line: 3, column: 12, scope: !3)
!9 = !DILocation(line: 2, column: 5, scope: !3)
!10 = distinct !{!10, !11, !12}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
