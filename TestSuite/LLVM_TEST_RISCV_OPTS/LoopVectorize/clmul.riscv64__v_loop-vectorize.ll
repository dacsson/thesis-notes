; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/clmul.ll
; Variant: riscv64_+v_loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @clmul_loop(ptr %a, ptr %b, ptr %c, i64 %n) {
entry:
  br label %for.body

for.body:
  %i = phi i64 [0, %entry], [%i.next, %for.body]

  %pa = getelementptr i64, ptr %a, i64 %i
  %pb = getelementptr i64, ptr %b, i64 %i
  %pc = getelementptr i64, ptr %c, i64 %i

  %va = load i64, ptr %pa
  %vb = load i64, ptr %pb

  %r = call i64 @llvm.clmul.i64(i64 %va, i64 %vb)

  store i64 %r, ptr %pc

  %i.next = add i64 %i, 1
  %cmp = icmp eq i64 %i.next, %n
  br i1 %cmp, label %for.exit, label %for.body

for.exit:
  ret void

}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp2y3stw7j.ll'
source_filename = "/tmp/tmp2y3stw7j.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @clmul_loop(ptr %a, ptr %b, ptr %c, i64 %n) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %for.body ]
  %pa = getelementptr i64, ptr %a, i64 %i
  %pb = getelementptr i64, ptr %b, i64 %i
  %pc = getelementptr i64, ptr %c, i64 %i
  %va = load i64, ptr %pa, align 8
  %vb = load i64, ptr %pb, align 8
  %r = call i64 @llvm.clmul.i64(i64 %va, i64 %vb)
  store i64 %r, ptr %pc, align 8
  %i.next = add i64 %i, 1
  %cmp = icmp eq i64 %i.next, %n
  br i1 %cmp, label %for.exit, label %for.body

for.exit:                                         ; preds = %for.body
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.clmul.i64(i64, i64) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
