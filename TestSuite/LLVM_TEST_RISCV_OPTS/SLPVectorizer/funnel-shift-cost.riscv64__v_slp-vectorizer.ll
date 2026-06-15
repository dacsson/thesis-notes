; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/funnel-shift-cost.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=slp-vectorizer -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+v -passes=slp-vectorizer -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; The four fshl.i16 calls use a constant shift amount (1), so the scalar cost
; of each is 3 (Or + Shl + LShr only; Sub, modulo, ICmp and Select are not
; needed for constant shift amounts).  Total scalar fshl cost = 4 x 3 = 12.
; SLP considers vectorizing the fshl+store bundle to <4 x i16>:
;   - fshl bundle:  VectorCost=7  ScalarCost=12  net=-5
;   - store bundle: VectorCost=1  ScalarCost=4   net=-3
;   - right-input gather (non-contiguous phi values): +3
;   Tree total cost = -5
; However, the four fshl results are also consumed by scalar add/sub in
; use.results, requiring element extractions from the vector:
;   ExtractElement cost = 1+2+2+2 = 7
; Total cost = -5 + 7 = 2 > 0, so SLP correctly decides not to vectorize.
; Before the fix, Sub/ICmp/Select were always included in the scalar fshl cost
; even for constant shifts, giving ScalarCost=24 for the bundle (net=-17),
; which overwhelmed the extract cost (total=-10) and caused incorrect
; vectorization.

declare i16 @llvm.fshl.i16(i16, i16, i16)

define void @foo(i16 %lx3, ptr %extra_bits, i16 %init_count) {
entry:
  %eb1_ptr = getelementptr inbounds nuw i8, ptr %extra_bits, i64 2
  %eb2_ptr = getelementptr inbounds nuw i8, ptr %extra_bits, i64 4
  %eb3_ptr = getelementptr inbounds nuw i8, ptr %extra_bits, i64 6
  br label %while.body

while.body:
  %eb0 = phi i16 [ 0, %entry ], [ %new_eb0, %use.results ]
  %eb1 = phi i16 [ 0, %entry ], [ %new_eb1, %use.results ]
  %eb2 = phi i16 [ 0, %entry ], [ %new_eb2, %use.results ]
  %eb3 = phi i16 [ 0, %entry ], [ %new_eb3, %use.results ]
  %ctr = phi i16 [ %init_count, %entry ], [ %ctr.dec, %use.results ]

  %new_eb3 = tail call i16 @llvm.fshl.i16(i16 %eb3, i16 %lx3, i16 1)
  store i16 %new_eb3, ptr %eb3_ptr, align 2
  %new_eb2 = tail call i16 @llvm.fshl.i16(i16 %eb2, i16 %eb3, i16 1)
  store i16 %new_eb2, ptr %eb2_ptr, align 2
  %new_eb1 = tail call i16 @llvm.fshl.i16(i16 %eb1, i16 %eb2, i16 1)
  store i16 %new_eb1, ptr %eb1_ptr, align 2
  %new_eb0 = tail call i16 @llvm.fshl.i16(i16 %eb0, i16 %eb1, i16 1)
  store i16 %new_eb0, ptr %extra_bits, align 2
  br label %use.results

use.results:
  %sum01 = add i16 %new_eb0, %new_eb1
  %sum23 = sub i16 %new_eb2, %new_eb3
  %sum   = add i16 %sum01, %sum23
  store i16 %sum, ptr %extra_bits, align 2
  %ctr.dec = add i16 %ctr, -1
  %done    = icmp sgt i16 %ctr.dec, -1
  br i1 %done, label %while.body, label %exit

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp7djicofy.ll'
source_filename = "/tmp/tmp7djicofy.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.fshl.i16(i16, i16, i16) #0

define void @foo(i16 %lx3, ptr %extra_bits, i16 %init_count) #1 {
entry:
  %eb1_ptr = getelementptr inbounds nuw i8, ptr %extra_bits, i64 2
  %eb2_ptr = getelementptr inbounds nuw i8, ptr %extra_bits, i64 4
  %eb3_ptr = getelementptr inbounds nuw i8, ptr %extra_bits, i64 6
  br label %while.body

while.body:                                       ; preds = %use.results, %entry
  %eb0 = phi i16 [ 0, %entry ], [ %new_eb0, %use.results ]
  %eb1 = phi i16 [ 0, %entry ], [ %new_eb1, %use.results ]
  %eb2 = phi i16 [ 0, %entry ], [ %new_eb2, %use.results ]
  %eb3 = phi i16 [ 0, %entry ], [ %new_eb3, %use.results ]
  %ctr = phi i16 [ %init_count, %entry ], [ %ctr.dec, %use.results ]
  %new_eb3 = tail call i16 @llvm.fshl.i16(i16 %eb3, i16 %lx3, i16 1)
  store i16 %new_eb3, ptr %eb3_ptr, align 2
  %new_eb2 = tail call i16 @llvm.fshl.i16(i16 %eb2, i16 %eb3, i16 1)
  store i16 %new_eb2, ptr %eb2_ptr, align 2
  %new_eb1 = tail call i16 @llvm.fshl.i16(i16 %eb1, i16 %eb2, i16 1)
  store i16 %new_eb1, ptr %eb1_ptr, align 2
  %new_eb0 = tail call i16 @llvm.fshl.i16(i16 %eb0, i16 %eb1, i16 1)
  store i16 %new_eb0, ptr %extra_bits, align 2
  br label %use.results

use.results:                                      ; preds = %while.body
  %sum01 = add i16 %new_eb0, %new_eb1
  %sum23 = sub i16 %new_eb2, %new_eb3
  %sum = add i16 %sum01, %sum23
  store i16 %sum, ptr %extra_bits, align 2
  %ctr.dec = add i16 %ctr, -1
  %done = icmp sgt i16 %ctr.dec, -1
  br i1 %done, label %while.body, label %exit

exit:                                             ; preds = %use.results
  ret void
}

attributes #0 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #1 = { "target-features"="+v" }
