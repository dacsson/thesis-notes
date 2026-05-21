; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SimplifyCFG/RISCV/switch-of-powers-of-two.ll
; Variant: riscv64_simplifycfg<switch-to-lookup>
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes='simplifycfg<switch-to-lookup>' -simplifycfg-require-and-preserve-domtree=1 -mtriple=riscv64 -S
; Original: RUN: opt -passes='simplifycfg<switch-to-lookup>' -simplifycfg-require-and-preserve-domtree=1 -S -mtriple=riscv64 < %s  | FileCheck %s --check-prefixes=CHECK,RV64I

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Check that the range of switch of powers of two is reduced and switch itself is lowered to lookup-table.
define i32 @switch_of_powers(i32 %x) {
entry:
  switch i32 %x, label %default_case [
  i32 1,  label %bb1
  i32 8,  label %bb2
  i32 16, label %bb3
  i32 32, label %bb4
  i32 64, label %bb5
  ]


default_case: unreachable
bb1: br label %return
bb2: br label %return
bb3: br label %return
bb4: br label %return
bb5: br label %return

return:
  %p = phi i32 [ 3, %bb1 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 42, %bb5 ]
  ret i32 %p
}

; Check that switch's of powers of two range with the default case reachable is reduced
; w/ Zbb enabled, by jumping non-power-of-two inputs to the default block.
define i32 @switch_of_powers_reachable_default(i32 %x) {
entry:
  switch i32 %x, label %default_case [
  i32 1,  label %bb1
  i32 8,  label %bb2
  i32 16, label %bb3
  i32 32, label %bb4
  i32 64, label %bb5
  ]


default_case: br label %return
bb1: br label %return
bb2: br label %return
bb3: br label %return
bb4: br label %return
bb5: br label %return

return:
  %p = phi i32 [ 3, %bb1 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 42, %bb5 ], [-1, %default_case]
  ret i32 %p
}

; Check that switch with zero case is not considered as switch of powers of two
define i32 @switch_of_non_powers(i32 %x) {
entry:
  switch i32 %x, label %default_case [
  i32 0,  label %bb1
  i32 1,  label %bb2
  i32 16, label %bb3
  i32 32, label %bb4
  i32 64, label %bb5
  ]


default_case: unreachable
bb1: br label %return
bb2: br label %return
bb3: br label %return
bb4: br label %return
bb5: br label %return

return:
  %p = phi i32 [ 3, %bb1 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 42, %bb5 ]
  ret i32 %p
}

define i32 @unable_to_create_dense_switch(i32 %x) {
entry:
  switch i32 %x, label %default_case [
  i32 1,  label %bb2
  i32 2, label %bb3
  i32 4, label %bb4
  i32 4096, label %bb5
  ]


default_case: unreachable
bb1: br label %return
bb2: br label %return
bb3: br label %return
bb4: br label %return
bb5: br label %return

return:
  %p = phi i32 [ 3, %bb1 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 42, %bb5 ]
  ret i32 %p
}

declare i32 @bar(i32)
define i32 @unable_to_generate_lookup_table(i32 %x, i32 %y) {
entry:
  switch i32 %y, label %default_case [
  i32 1,  label %bb2
  i32 2, label %bb3
  i32 8, label %bb4
  i32 64, label %bb5
  ]


default_case: unreachable
bb1:
  %xor1 = xor i32 %x, 42
  %call1 = call i32 @bar(i32 %xor1)
  %add1 = add i32 %call1, %x
  br label %return
bb2:
  %xor2 = xor i32 %x, 48
  %call2 = call i32 @bar(i32 %xor2)
  %add2 = sub i32 %call2, %x
  br label %return
bb3:
  %xor3 = xor i32 %x, 96
  %call3 = call i32 @bar(i32 %xor3)
  %add3 = add i32 %call3, %x
  br label %return
bb4:
  %call4 = call i32 @bar(i32 %x)
  %add4 = add i32 %call4, %x
  br label %return
bb5:
  %xor5 = xor i32 %x, 9
  %call5 = call i32 @bar(i32 %xor5)
  %add5 = add i32 %call5, %x
  br label %return

return:
  %p = phi i32 [ %add1, %bb1 ], [ %add2, %bb2 ], [ %add3, %bb3 ], [ %add4, %bb4 ], [ %add5, %bb5 ]

  ret i32 %p
}

define i128 @switch_with_long_condition(i128 %x) {
entry:
  switch i128 %x, label %default_case [
  i128 1,  label %bb2
  i128 2, label %bb3
  i128 4, label %bb4
  i128 32, label %bb5
  ]


default_case: unreachable
bb1: br label %return
bb2: br label %return
bb3: br label %return
bb4: br label %return
bb5: br label %return

return:
  %p = phi i128 [ 3, %bb1 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 42, %bb5 ]
  ret i128 %p
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpheal1eti.ll'
source_filename = "/tmp/tmpheal1eti.ll"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "riscv64"

define i32 @switch_of_powers(i32 %x) {
entry:
  switch i32 %x, label %default_case [
    i32 1, label %return
    i32 8, label %bb2
    i32 16, label %bb3
    i32 32, label %bb4
    i32 64, label %bb5
  ]

default_case:                                     ; preds = %entry
  unreachable

bb2:                                              ; preds = %entry
  br label %return

bb3:                                              ; preds = %entry
  br label %return

bb4:                                              ; preds = %entry
  br label %return

bb5:                                              ; preds = %entry
  br label %return

return:                                           ; preds = %entry, %bb5, %bb4, %bb3, %bb2
  %p = phi i32 [ 42, %bb5 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 3, %entry ]
  ret i32 %p
}

define i32 @switch_of_powers_reachable_default(i32 %x) {
entry:
  switch i32 %x, label %return [
    i32 1, label %bb1
    i32 8, label %bb2
    i32 16, label %bb3
    i32 32, label %bb4
    i32 64, label %bb5
  ]

bb1:                                              ; preds = %entry
  br label %return

bb2:                                              ; preds = %entry
  br label %return

bb3:                                              ; preds = %entry
  br label %return

bb4:                                              ; preds = %entry
  br label %return

bb5:                                              ; preds = %entry
  br label %return

return:                                           ; preds = %entry, %bb5, %bb4, %bb3, %bb2, %bb1
  %p = phi i32 [ 3, %bb1 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 42, %bb5 ], [ -1, %entry ]
  ret i32 %p
}

define i32 @switch_of_non_powers(i32 %x) {
entry:
  switch i32 %x, label %default_case [
    i32 0, label %return
    i32 1, label %bb2
    i32 16, label %bb3
    i32 32, label %bb4
    i32 64, label %bb5
  ]

default_case:                                     ; preds = %entry
  unreachable

bb2:                                              ; preds = %entry
  br label %return

bb3:                                              ; preds = %entry
  br label %return

bb4:                                              ; preds = %entry
  br label %return

bb5:                                              ; preds = %entry
  br label %return

return:                                           ; preds = %entry, %bb5, %bb4, %bb3, %bb2
  %p = phi i32 [ 42, %bb5 ], [ 2, %bb2 ], [ 1, %bb3 ], [ 0, %bb4 ], [ 3, %entry ]
  ret i32 %p
}

define i32 @unable_to_create_dense_switch(i32 %x) {
entry:
  switch i32 %x, label %default_case [
    i32 1, label %return
    i32 2, label %bb3
    i32 4, label %bb4
    i32 4096, label %bb5
  ]

default_case:                                     ; preds = %entry
  unreachable

bb3:                                              ; preds = %entry
  br label %return

bb4:                                              ; preds = %entry
  br label %return

bb5:                                              ; preds = %entry
  br label %return

return:                                           ; preds = %entry, %bb5, %bb4, %bb3
  %p = phi i32 [ 42, %bb5 ], [ 0, %bb4 ], [ 1, %bb3 ], [ 2, %entry ]
  ret i32 %p
}

declare i32 @bar(i32)

define i32 @unable_to_generate_lookup_table(i32 %x, i32 %y) {
entry:
  switch i32 %y, label %default_case [
    i32 1, label %bb2
    i32 2, label %bb3
    i32 8, label %bb4
    i32 64, label %bb5
  ]

default_case:                                     ; preds = %entry
  unreachable

bb2:                                              ; preds = %entry
  %xor2 = xor i32 %x, 48
  %call2 = call i32 @bar(i32 %xor2)
  %add2 = sub i32 %call2, %x
  br label %return

bb3:                                              ; preds = %entry
  %xor3 = xor i32 %x, 96
  %call3 = call i32 @bar(i32 %xor3)
  %add3 = add i32 %call3, %x
  br label %return

bb4:                                              ; preds = %entry
  %call4 = call i32 @bar(i32 %x)
  %add4 = add i32 %call4, %x
  br label %return

bb5:                                              ; preds = %entry
  %xor5 = xor i32 %x, 9
  %call5 = call i32 @bar(i32 %xor5)
  %add5 = add i32 %call5, %x
  br label %return

return:                                           ; preds = %bb5, %bb4, %bb3, %bb2
  %p = phi i32 [ %add5, %bb5 ], [ %add2, %bb2 ], [ %add3, %bb3 ], [ %add4, %bb4 ]
  ret i32 %p
}

define i128 @switch_with_long_condition(i128 %x) {
entry:
  switch i128 %x, label %default_case [
    i128 1, label %return
    i128 2, label %bb3
    i128 4, label %bb4
    i128 32, label %bb5
  ]

default_case:                                     ; preds = %entry
  unreachable

bb3:                                              ; preds = %entry
  br label %return

bb4:                                              ; preds = %entry
  br label %return

bb5:                                              ; preds = %entry
  br label %return

return:                                           ; preds = %entry, %bb5, %bb4, %bb3
  %p = phi i128 [ 42, %bb5 ], [ 0, %bb4 ], [ 1, %bb3 ], [ 2, %entry ]
  ret i128 %p
}
