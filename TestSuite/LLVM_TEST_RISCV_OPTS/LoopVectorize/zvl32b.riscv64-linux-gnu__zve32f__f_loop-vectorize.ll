; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/zvl32b.ll
; Variant: riscv64-linux-gnu_+zve32f,+f_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+zve32f,+f -S
; Original: RUN: opt < %s -passes=loop-vectorize -scalable-vectorization=on -mtriple riscv64-linux-gnu -mattr=+zve32f,+f -S 2>%t | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64"

; We can't vectorize with Zvl32b due to RVVBitsPerBlock being 64. Since our
; vscale value is vlen/RVVBitsPerBlock this makes vscale 0.
define void @vector_add_i16(ptr noalias nocapture %a, i16 %v, i64 %n) {

entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %elem = load i16, ptr %arrayidx
  %add = add i16 %elem, %v
  store i16 %add, ptr %arrayidx
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_8imksm2.ll'
source_filename = "/tmp/tmp_8imksm2.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @vector_add_i16(ptr noalias captures(none) %a, i16 %v, i64 %n) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %iv
  %elem = load i16, ptr %arrayidx, align 2
  %add = add i16 %elem, %v
  store i16 %add, ptr %arrayidx, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

attributes #0 = { "target-features"="+zve32f,+f" }
