; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-masked-loadstore.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @masked_loadstore(ptr noalias %a, ptr noalias %b, i64 %n) {
entry:
  br label %for.body

for.body:
  %i.011 = phi i64 [ %inc, %for.inc ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %i.011
  %0 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp ne i32 %0, 0
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %arrayidx3 = getelementptr inbounds i32, ptr %a, i64 %i.011
  %1 = load i32, ptr %arrayidx3, align 4
  %add = add i32 %0, %1
  store i32 %add, ptr %arrayidx3, align 4
  br label %for.inc

for.inc:
  %inc = add nuw nsw i64 %i.011, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp6gphbos4.ll'
source_filename = "/tmp/tmp6gphbos4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @masked_loadstore(ptr noalias %a, ptr noalias %b, i64 %n) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 8)
  %min.iters.check = icmp ult i64 %n, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 2
  %n.mod.vf = urem i64 %n, %3
  %n.vec = sub i64 %n, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 4
  %5 = icmp ne <vscale x 4 x i32> %wide.load, zeroinitializer
  %6 = getelementptr i32, ptr %a, i64 %index
  %wide.masked.load = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr align 4 %6, <vscale x 4 x i1> %5, <vscale x 4 x i32> poison)
  %7 = add <vscale x 4 x i32> %wide.load, %wide.masked.load
  call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> %7, ptr align 4 %6, <vscale x 4 x i1> %5)
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.inc
  %i.011 = phi i64 [ %inc, %for.inc ], [ %bc.resume.val, %scalar.ph ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %i.011
  %9 = load i32, ptr %arrayidx, align 4
  %cmp1 = icmp ne i32 %9, 0
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %arrayidx3 = getelementptr inbounds i32, ptr %a, i64 %i.011
  %10 = load i32, ptr %arrayidx3, align 4
  %add = add i32 %9, %10
  store i32 %add, ptr %arrayidx3, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %inc = add nuw nsw i64 %i.011, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !3

exit:                                             ; preds = %middle.block, %for.inc
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, <vscale x 4 x i32>) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>) #4

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
