; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopUnroll/RISCV/runtime-unroll-max-trip-count.ll
; Variant: +no-default-unroll_loop-unroll
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-unroll -mattr=+no-default-unroll -S
; Original: RUN: opt < %s -S -passes=loop-unroll -mattr=+no-default-unroll | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Regression test: when a loop has a small MaxTripCount and falls through to
; runtime unrolling, the unroll count should be based on DefaultUnrollRuntimeCount
; (not MaxTripCount). Previously, a quirk would set UP.Count = MaxTripCount (5)
; before the power-of-two reduction, yielding count 2 (5 >> 1). Now the count
; starts at DefaultUnrollRuntimeCount (8) and reduces to 4 (8 >> 1).
; This test uses RISC-V because we need a target that sets UP.Force = true
; (via RISCVTTIImpl::getUnrollingPreferences) to trigger the bug.

target triple = "riscv64-unknown-linux-gnu"

define void @test(i32 %start, ptr %p) {
entry:
  %end = add i32 %start, 5
  br label %loop

loop:
  %iv = phi i32 [ %start, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %p, i32 %iv
  %v = load volatile i32, ptr %gep
  %b0 = call i32 @llvm.bswap.i32(i32 %v)
  %b1 = call i32 @llvm.bswap.i32(i32 %b0)
  %b2 = call i32 @llvm.bswap.i32(i32 %b1)
  %b3 = call i32 @llvm.bswap.i32(i32 %b2)
  %b4 = call i32 @llvm.bswap.i32(i32 %b3)
  %b5 = call i32 @llvm.bswap.i32(i32 %b4)
  %b6 = call i32 @llvm.bswap.i32(i32 %b5)
  %b7 = call i32 @llvm.bswap.i32(i32 %b6)
  %b8 = call i32 @llvm.bswap.i32(i32 %b7)
  %b9 = call i32 @llvm.bswap.i32(i32 %b8)
  %b10 = call i32 @llvm.bswap.i32(i32 %b9)
  %b11 = call i32 @llvm.bswap.i32(i32 %b10)
  %b12 = call i32 @llvm.bswap.i32(i32 %b11)
  %b13 = call i32 @llvm.bswap.i32(i32 %b12)
  %b14 = call i32 @llvm.bswap.i32(i32 %b13)
  %b15 = call i32 @llvm.bswap.i32(i32 %b14)
  %b16 = call i32 @llvm.bswap.i32(i32 %b15)
  %b17 = call i32 @llvm.bswap.i32(i32 %b16)
  %b18 = call i32 @llvm.bswap.i32(i32 %b17)
  %b19 = call i32 @llvm.bswap.i32(i32 %b18)
  %b20 = call i32 @llvm.bswap.i32(i32 %b19)
  %b21 = call i32 @llvm.bswap.i32(i32 %b20)
  %b22 = call i32 @llvm.bswap.i32(i32 %b21)
  %b23 = call i32 @llvm.bswap.i32(i32 %b22)
  %b24 = call i32 @llvm.bswap.i32(i32 %b23)
  %b25 = call i32 @llvm.bswap.i32(i32 %b24)
  store volatile i32 %b25, ptr %gep
  %iv.next = add nuw i32 %iv, 1
  %cmp = icmp ult i32 %iv.next, %end
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpycn92k4i.ll'
source_filename = "/tmp/tmpycn92k4i.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(i32 %start, ptr %p) #0 {
entry:
  %end = add i32 %start, 5
  br label %loop

loop:                                             ; preds = %loop.3, %entry
  %iv = phi i32 [ %start, %entry ], [ %iv.next.3, %loop.3 ]
  %gep = getelementptr inbounds i32, ptr %p, i32 %iv
  %v = load volatile i32, ptr %gep, align 4
  store volatile i32 %v, ptr %gep, align 4
  %iv.next = add nuw i32 %iv, 1
  %cmp = icmp ult i32 %iv.next, %end
  br i1 %cmp, label %loop.1, label %exit

loop.1:                                           ; preds = %loop
  %gep.1 = getelementptr inbounds i32, ptr %p, i32 %iv.next
  %v.1 = load volatile i32, ptr %gep.1, align 4
  store volatile i32 %v.1, ptr %gep.1, align 4
  %iv.next.1 = add nuw i32 %iv, 2
  %cmp.1 = icmp ult i32 %iv.next.1, %end
  br i1 %cmp.1, label %loop.2, label %exit

loop.2:                                           ; preds = %loop.1
  %gep.2 = getelementptr inbounds i32, ptr %p, i32 %iv.next.1
  %v.2 = load volatile i32, ptr %gep.2, align 4
  store volatile i32 %v.2, ptr %gep.2, align 4
  %iv.next.2 = add nuw i32 %iv, 3
  %cmp.2 = icmp ult i32 %iv.next.2, %end
  br i1 %cmp.2, label %loop.3, label %exit

loop.3:                                           ; preds = %loop.2
  %gep.3 = getelementptr inbounds i32, ptr %p, i32 %iv.next.2
  %v.3 = load volatile i32, ptr %gep.3, align 4
  store volatile i32 %v.3, ptr %gep.3, align 4
  %iv.next.3 = add nuw i32 %iv, 4
  %cmp.3 = icmp ult i32 %iv.next.3, %end
  br i1 %cmp.3, label %loop, label %exit

exit:                                             ; preds = %loop.3, %loop.2, %loop.1, %loop
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.bswap.i32(i32) #1

attributes #0 = { "target-features"="+no-default-unroll" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+no-default-unroll" }
