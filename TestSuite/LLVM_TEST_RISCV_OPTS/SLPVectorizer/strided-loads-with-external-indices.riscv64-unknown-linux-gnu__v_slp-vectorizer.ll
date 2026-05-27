; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/strided-loads-with-external-indices.ll
; Variant: riscv64-unknown-linux-gnu_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -slp-threshold=-50 -mtriple=riscv64-unknown-linux-gnu -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -slp-threshold=-50 -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s| FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


%class.A = type { i32, i32 }

define void @test() {
entry:
  br label %body

body:
  %add.i.i62.us = shl i64 0, 0
  %mul.i.i63.us = or i64 %add.i.i62.us, 0
  %add.ptr.i.i.i64.us = getelementptr %class.A, ptr null, i64 %mul.i.i63.us
  %sub4.i.i65.us = or i64 0, 1
  %add.ptr.i63.i.i66.us = getelementptr %class.A, ptr null, i64 %sub4.i.i65.us
  %0 = load i32, ptr %add.ptr.i.i.i64.us, align 4
  %1 = load i32, ptr %add.ptr.i63.i.i66.us, align 4
  %cmp.i.i.i.i67.us = icmp slt i32 %0, %1
  %spec.select.i.i68.us = select i1 false, i64 %sub4.i.i65.us, i64 0
  br label %body
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpakkl46yo.ll'
source_filename = "/tmp/tmpakkl46yo.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%class.A = type { i32, i32 }

define void @test() #0 {
entry:
  %sub4.i.i65.us = or i64 0, 1
  br label %body

body:                                             ; preds = %body, %entry
  %0 = call <2 x i32> @llvm.masked.gather.v2i32.v2p0(<2 x ptr> align 4 getelementptr (%class.A, <2 x ptr> splat (ptr null), <2 x i64> <i64 0, i64 1>), <2 x i1> splat (i1 true), <2 x i32> poison)
  %1 = extractelement <2 x i32> %0, i32 0
  %2 = extractelement <2 x i32> %0, i32 1
  %cmp.i.i.i.i67.us = icmp slt i32 %1, %2
  %spec.select.i.i68.us = select i1 false, i64 %sub4.i.i65.us, i64 0
  br label %body
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <2 x i32> @llvm.masked.gather.v2i32.v2p0(<2 x ptr>, <2 x i1>, <2 x i32>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
