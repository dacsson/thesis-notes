; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/preserve-dbg-loc.ll
; Variant: riscv64_+v_debugify,loop-vectorize_DEBUGLOC
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=debugify,loop-vectorize -tail-folding-policy=prefer-fold-tail -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-max=128 -S
; Original: RUN: opt -passes=debugify,loop-vectorize  -tail-folding-policy=prefer-fold-tail  -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-max=128 -S < %s 2>&1 | FileCheck --check-prefix=DEBUGLOC %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Testing the debug locations of the generated vector intrinsic is same as
; its scalar counterpart.

define void @vp_select(ptr %a, ptr %b, ptr %c, i64 %N) {
 entry:
   br label %loop

loop:
   %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
   %gep.b = getelementptr inbounds i32, ptr %b, i64 %iv
   %load.b = load i32, ptr %gep.b, align 4
   %gep.c = getelementptr inbounds i32, ptr %c, i64 %iv
   %load.c = load i32, ptr %gep.c, align 4
   %cmp = icmp sgt i32 %load.b, %load.c
   %neg.c = sub i32 0, %load.c
   %sel = select i1 %cmp, i32 %load.c, i32 %neg.c
   %add = add i32 %sel, %load.b
   %gep.a = getelementptr inbounds i32, ptr %a, i64 %iv
   store i32 %add, ptr %gep.a, align 4
   %iv.next = add nuw nsw i64 %iv, 1
   %exitcond = icmp eq i64 %iv.next, %N
   br i1 %exitcond, label %exit, label %loop

 exit:
   ret void
 }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp3edju81v.ll'
source_filename = "/tmp/tmp3edju81v.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vp_select(ptr %a, ptr %b, ptr %c, i64 %N) #0 !dbg !5 {
entry:
  %c3 = ptrtoaddr ptr %c to i64, !dbg !24
  %b2 = ptrtoaddr ptr %b to i64, !dbg !24
  %a1 = ptrtoaddr ptr %a to i64, !dbg !24
  br label %vector.memcheck, !dbg !24

vector.memcheck:                                  ; preds = %entry
  %0 = call i64 @llvm.vscale.i64(), !dbg !24
  %1 = mul nuw i64 %0, 4, !dbg !24
  %2 = mul i64 %1, 4, !dbg !24
  %3 = sub i64 %a1, %b2, !dbg !24
  %diff.check = icmp ult i64 %3, %2, !dbg !24
  %4 = mul i64 %1, 4, !dbg !24
  %5 = sub i64 %a1, %c3, !dbg !24
  %diff.check4 = icmp ult i64 %5, %4, !dbg !24
  %conflict.rdx = or i1 %diff.check, %diff.check4, !dbg !24
  br i1 %conflict.rdx, label %scalar.ph, label %vector.ph, !dbg !25

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body, !dbg !25

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ], !dbg !25
  %avl = phi i64 [ %N, %vector.ph ], [ %avl.next, %vector.body ]
  %6 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %7 = getelementptr inbounds i32, ptr %b, i64 %index, !dbg !26
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %6), !dbg !27
  %8 = getelementptr inbounds i32, ptr %c, i64 %index, !dbg !28
  %vp.op.load5 = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %8, <vscale x 4 x i1> splat (i1 true), i32 %6), !dbg !29
  %9 = icmp sgt <vscale x 4 x i32> %vp.op.load, %vp.op.load5, !dbg !30
  %10 = sub <vscale x 4 x i32> zeroinitializer, %vp.op.load5, !dbg !31
  %11 = select <vscale x 4 x i1> %9, <vscale x 4 x i32> %vp.op.load5, <vscale x 4 x i32> %10, !dbg !32
  %12 = add <vscale x 4 x i32> %11, %vp.op.load, !dbg !33
  %13 = getelementptr inbounds i32, ptr %a, i64 %index, !dbg !34
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %12, ptr align 4 %13, <vscale x 4 x i1> splat (i1 true), i32 %6), !dbg !35
  %14 = zext i32 %6 to i64, !dbg !25
  %current.iteration.next = add i64 %14, %index, !dbg !25
  %avl.next = sub nuw i64 %avl, %14
  %15 = icmp eq i64 %avl.next, 0
  br i1 %15, label %middle.block, label %vector.body, !dbg !36, !llvm.loop !37

middle.block:                                     ; preds = %vector.body
  br label %exit, !dbg !36

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop, !dbg !24

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ 0, %scalar.ph ], [ %iv.next, %loop ], !dbg !25
    #dbg_value(i64 %iv, !9, !DIExpression(), !25)
  %gep.b = getelementptr inbounds i32, ptr %b, i64 %iv, !dbg !26
    #dbg_value(ptr %gep.b, !11, !DIExpression(), !26)
  %load.b = load i32, ptr %gep.b, align 4, !dbg !27
    #dbg_value(i32 %load.b, !12, !DIExpression(), !27)
  %gep.c = getelementptr inbounds i32, ptr %c, i64 %iv, !dbg !28
    #dbg_value(ptr %gep.c, !14, !DIExpression(), !28)
  %load.c = load i32, ptr %gep.c, align 4, !dbg !29
    #dbg_value(i32 %load.c, !15, !DIExpression(), !29)
  %cmp = icmp sgt i32 %load.b, %load.c, !dbg !30
    #dbg_value(i1 %cmp, !16, !DIExpression(), !30)
  %neg.c = sub i32 0, %load.c, !dbg !31
    #dbg_value(i32 %neg.c, !18, !DIExpression(), !31)
  %sel = select i1 %cmp, i32 %load.c, i32 %neg.c, !dbg !32
    #dbg_value(i32 %sel, !19, !DIExpression(), !32)
  %add = add i32 %sel, %load.b, !dbg !33
    #dbg_value(i32 %add, !20, !DIExpression(), !33)
  %gep.a = getelementptr inbounds i32, ptr %a, i64 %iv, !dbg !34
    #dbg_value(ptr %gep.a, !21, !DIExpression(), !34)
  store i32 %add, ptr %gep.a, align 4, !dbg !35
  %iv.next = add nuw nsw i64 %iv, 1, !dbg !40
    #dbg_value(i64 %iv.next, !22, !DIExpression(), !40)
  %exitcond = icmp eq i64 %iv.next, %N, !dbg !41
    #dbg_value(i1 %exitcond, !23, !DIExpression(), !41)
  br i1 %exitcond, label %exit, label %loop, !dbg !36, !llvm.loop !42

exit:                                             ; preds = %middle.block, %loop
  ret void, !dbg !43
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!llvm.dbg.cu = !{!0}
!llvm.debugify = !{!2, !3}
!llvm.module.flags = !{!4}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "debugify", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "/tmp/tmp3edju81v.ll", directory: "/")
!2 = !{i32 16}
!3 = !{i32 12}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = distinct !DISubprogram(name: "vp_select", linkageName: "vp_select", scope: null, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !8)
!6 = !DISubroutineType(types: !7)
!7 = !{}
!8 = !{!9, !11, !12, !14, !15, !16, !18, !19, !20, !21, !22, !23}
!9 = !DILocalVariable(name: "1", scope: !5, file: !1, line: 2, type: !10)
!10 = !DIBasicType(name: "ty64", size: 64, encoding: DW_ATE_unsigned)
!11 = !DILocalVariable(name: "2", scope: !5, file: !1, line: 3, type: !10)
!12 = !DILocalVariable(name: "3", scope: !5, file: !1, line: 4, type: !13)
!13 = !DIBasicType(name: "ty32", size: 32, encoding: DW_ATE_unsigned)
!14 = !DILocalVariable(name: "4", scope: !5, file: !1, line: 5, type: !10)
!15 = !DILocalVariable(name: "5", scope: !5, file: !1, line: 6, type: !13)
!16 = !DILocalVariable(name: "6", scope: !5, file: !1, line: 7, type: !17)
!17 = !DIBasicType(name: "ty8", size: 8, encoding: DW_ATE_unsigned)
!18 = !DILocalVariable(name: "7", scope: !5, file: !1, line: 8, type: !13)
!19 = !DILocalVariable(name: "8", scope: !5, file: !1, line: 9, type: !13)
!20 = !DILocalVariable(name: "9", scope: !5, file: !1, line: 10, type: !13)
!21 = !DILocalVariable(name: "10", scope: !5, file: !1, line: 11, type: !10)
!22 = !DILocalVariable(name: "11", scope: !5, file: !1, line: 13, type: !10)
!23 = !DILocalVariable(name: "12", scope: !5, file: !1, line: 14, type: !17)
!24 = !DILocation(line: 1, column: 1, scope: !5)
!25 = !DILocation(line: 2, column: 1, scope: !5)
!26 = !DILocation(line: 3, column: 1, scope: !5)
!27 = !DILocation(line: 4, column: 1, scope: !5)
!28 = !DILocation(line: 5, column: 1, scope: !5)
!29 = !DILocation(line: 6, column: 1, scope: !5)
!30 = !DILocation(line: 7, column: 1, scope: !5)
!31 = !DILocation(line: 8, column: 1, scope: !5)
!32 = !DILocation(line: 9, column: 1, scope: !5)
!33 = !DILocation(line: 10, column: 1, scope: !5)
!34 = !DILocation(line: 11, column: 1, scope: !5)
!35 = !DILocation(line: 12, column: 1, scope: !5)
!36 = !DILocation(line: 15, column: 1, scope: !5)
!37 = distinct !{!37, !38, !39}
!38 = !{!"llvm.loop.isvectorized", i32 1}
!39 = !{!"llvm.loop.unroll.runtime.disable"}
!40 = !DILocation(line: 13, column: 1, scope: !5)
!41 = !DILocation(line: 14, column: 1, scope: !5)
!42 = distinct !{!42, !38}
!43 = !DILocation(line: 16, column: 1, scope: !5)
