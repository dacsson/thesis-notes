; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/small-phi-tree.ll
; Variant: riscv64_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mcpu=sifive-x280 -passes=slp-vectorizer -slp-threshold=-11 -S
; Original: RUN: opt -mtriple=riscv64 -mcpu=sifive-x280 -passes=slp-vectorizer -S -slp-threshold=-11 < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define float @test(ptr %call78) {
entry:
  br label %for.body194

for.body194:
  %indvars.iv132 = phi i64 [ 0, %entry ], [ 0, %for.body194 ]
  %currentw.031 = phi ptr [ %call78, %entry ], [ %previousw.030, %for.body194 ]
  %previousw.030 = phi ptr [ null, %entry ], [ %currentw.031, %for.body194 ]
  store float 0.000000e+00, ptr %currentw.031, align 4
  tail call void null(ptr %previousw.030, ptr null, ptr null, i32 0, i32 0, ptr null, ptr null, i32 0)
  br i1 false, label %for.end286.loopexit, label %for.body194

for.end286.loopexit:
  %currentw.031.lcssa = phi ptr [ %currentw.031, %for.body194 ]
  %previousw.030.lcssa = phi ptr [ %previousw.030, %for.body194 ]
  ret float 0.000000e+00
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp_5qi9sxv.ll'
source_filename = "/tmp/tmp_5qi9sxv.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define float @test(ptr %call78) #0 {
entry:
  br label %for.body194

for.body194:                                      ; preds = %for.body194, %entry
  %indvars.iv132 = phi i64 [ 0, %entry ], [ 0, %for.body194 ]
  %currentw.031 = phi ptr [ %call78, %entry ], [ %previousw.030, %for.body194 ]
  %previousw.030 = phi ptr [ null, %entry ], [ %currentw.031, %for.body194 ]
  store float 0.000000e+00, ptr %currentw.031, align 4
  tail call void null(ptr %previousw.030, ptr null, ptr null, i32 0, i32 0, ptr null, ptr null, i32 0)
  br i1 false, label %for.end286.loopexit, label %for.body194

for.end286.loopexit:                              ; preds = %for.body194
  %currentw.031.lcssa = phi ptr [ %currentw.031, %for.body194 ]
  %previousw.030.lcssa = phi ptr [ %previousw.030, %for.body194 ]
  ret float 0.000000e+00
}

attributes #0 = { "target-cpu"="sifive-x280" }
