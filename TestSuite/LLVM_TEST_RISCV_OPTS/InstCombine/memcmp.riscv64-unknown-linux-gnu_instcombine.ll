; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InstCombine/RISCV/memcmp.ll
; Variant: riscv64-unknown-linux-gnu_instcombine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=instcombine -mtriple=riscv64-unknown-linux-gnu -S
; Original: RUN: opt %s -passes=instcombine -mtriple=riscv64-unknown-linux-gnu -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


declare signext i32 @memcmp(ptr, ptr, i64)

; Make sure we use signext attribute for the bcmp result.
define signext i32 @test_bcmp(ptr %mem1, ptr %mem2, i64 %size) {
  %call = call signext i32 @memcmp(ptr %mem1, ptr %mem2, i64 %size)
  %cmp = icmp eq i32 %call, 0
  %zext = zext i1 %cmp to i32
  ret i32 %zext
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpb6t51fpl.ll'
source_filename = "/tmp/tmpb6t51fpl.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

declare signext i32 @memcmp(ptr, ptr, i64)

define signext i32 @test_bcmp(ptr %mem1, ptr %mem2, i64 %size) {
  %bcmp = call i32 @bcmp(ptr %mem1, ptr %mem2, i64 %size)
  %cmp = icmp eq i32 %bcmp, 0
  %zext = zext i1 %cmp to i32
  ret i32 %zext
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: read)
declare signext i32 @bcmp(ptr captures(none), ptr captures(none), i64) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: read) }
