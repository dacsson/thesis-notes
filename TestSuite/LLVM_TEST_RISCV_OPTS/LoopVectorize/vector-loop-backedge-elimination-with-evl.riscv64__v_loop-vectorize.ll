; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/vector-loop-backedge-elimination-with-evl.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple riscv64 -passes=loop-vectorize --tail-folding-policy=must-fold-tail -force-tail-folding-style=data-with-evl -riscv-v-min-trip-count=0 -force-target-instruction-cost=1 -mattr=+v -S
; Original: RUN: opt %s -S -mtriple riscv64 -passes=loop-vectorize --tail-folding-policy=must-fold-tail -force-tail-folding-style=data-with-evl -riscv-v-min-trip-count=0 -force-target-instruction-cost=1 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Check canonical-iv is removed in single-iteration loop
define void @foo(ptr %arg) #0 {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr [3 x i64], ptr %arg, i64 0, i64 %iv
  store i64 0, ptr %gep, align 8
  %iv.next = add i64 %iv, 1
  %cond = icmp eq i64 %iv.next, 3
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

define i32 @test_remove_iv(i32 %start) #0 {
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %red = phi i32 [ %start , %entry ], [ %red.next, %loop ]
  %red.next = xor i32 %red, 3
  %iv.next = add i32 %iv, 1
  %ec = icmp eq i32 %iv, 5
  br i1 %ec, label %exit, label %loop

exit:
  ret i32 %red.next
}

attributes #0 = { vscale_range(2,2) }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp09mp9j54.ll'
source_filename = "/tmp/tmp09mp9j54.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: vscale_range(2,2)
define void @foo(ptr %arg) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> zeroinitializer, ptr align 8 %arg, <vscale x 2 x i1> splat (i1 true), i32 3)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: vscale_range(2,2)
define i32 @test_remove_iv(i32 %start) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = insertelement <vscale x 4 x i32> zeroinitializer, i32 %start, i32 0
  br label %vector.body

vector.body:                                      ; preds = %vector.ph
  %1 = xor <vscale x 4 x i32> %0, splat (i32 3)
  %2 = call <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> %1, <vscale x 4 x i32> %0, i32 6)
  br label %middle.block

middle.block:                                     ; preds = %vector.body
  %3 = call i32 @llvm.vector.reduce.xor.nxv4i32(<vscale x 4 x i32> %2)
  br label %exit

exit:                                             ; preds = %middle.block
  ret i32 %3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vp.merge.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>, i32) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.xor.nxv4i32(<vscale x 4 x i32>) #3

attributes #0 = { vscale_range(2,2) "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
