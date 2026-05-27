; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/strided-loads-with-external-use-ptr.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -slp-threshold=-20 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v -slp-threshold=-20 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


%S = type { i16, i16 }

define i16 @test() {
entry:
  %pPrev.058.i = getelementptr %S, ptr null, i64 -1
  br label %while.body.i

while.body.i:
  %0 = phi i16 [ 0, %while.body.i ], [ 0, %entry ]
  %pPrev.062.i = phi ptr [ %pPrev.0.i, %while.body.i ], [ %pPrev.058.i, %entry ]
  %pEdge.061.i = phi ptr [ %incdec.ptr.i, %while.body.i ], [ null, %entry ]
  %incdec.ptr.i = getelementptr %S, ptr %pEdge.061.i, i64 -1
  %pPrev.0.i = getelementptr %S, ptr %pPrev.062.i, i64 -1
  %1 = load i16, ptr %incdec.ptr.i, align 2
  %2 = load i16, ptr %pPrev.0.i, align 2
  %cmp.i178 = icmp ult i16 %1, %2
  br label %while.body.i
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpknbw7i17.ll'
source_filename = "/tmp/tmpknbw7i17.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%S = type { i16, i16 }

define i16 @test() #0 {
entry:
  %pPrev.058.i = getelementptr %S, ptr null, i64 -1
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %entry
  %0 = phi i16 [ 0, %while.body.i ], [ 0, %entry ]
  %pPrev.062.i = phi ptr [ %pPrev.0.i, %while.body.i ], [ %pPrev.058.i, %entry ]
  %pEdge.061.i = phi ptr [ %incdec.ptr.i, %while.body.i ], [ null, %entry ]
  %incdec.ptr.i = getelementptr %S, ptr %pEdge.061.i, i64 -1
  %pPrev.0.i = getelementptr %S, ptr %pPrev.062.i, i64 -1
  %1 = call <3 x i16> @llvm.masked.load.v3i16.p0(ptr align 2 %pPrev.0.i, <3 x i1> <i1 true, i1 false, i1 true>, <3 x i16> poison)
  %2 = shufflevector <3 x i16> %1, <3 x i16> poison, <2 x i32> <i32 0, i32 2>
  %3 = extractelement <2 x i16> %2, i32 0
  %4 = extractelement <2 x i16> %2, i32 1
  %cmp.i178 = icmp ult i16 %4, %3
  br label %while.body.i
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <3 x i16> @llvm.masked.load.v3i16.p0(ptr captures(none), <3 x i1>, <3 x i16>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
