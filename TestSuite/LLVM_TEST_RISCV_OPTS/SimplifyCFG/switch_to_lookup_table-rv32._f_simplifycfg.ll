; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SimplifyCFG/RISCV/switch_to_lookup_table-rv32.ll
; Variant: +f_simplifycfg
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=simplifycfg -switch-to-lookup=true -keep-loops=false -mattr=+f -S
; Original: RUN: opt < %s -passes=simplifycfg -switch-to-lookup=true -keep-loops=false -S -mattr=+f | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-elf"

; A simple int-to-int selection switch.
; It is dense enough to be replaced by table lookup.
; The result is directly by a ret from an otherwise empty bb,
; so we return early, directly from the lookup bb.

;.
;.
define i32 @f(i32 %c) {
entry:
  switch i32 %c, label %sw.default [
  i32 42, label %return
  i32 43, label %sw.bb1
  i32 44, label %sw.bb2
  i32 45, label %sw.bb3
  i32 46, label %sw.bb4
  i32 47, label %sw.bb5
  i32 48, label %sw.bb6
  ]

sw.bb1: br label %return
sw.bb2: br label %return
sw.bb3: br label %return
sw.bb4: br label %return
sw.bb5: br label %return
sw.bb6: br label %return
sw.default: br label %return
return:
  %retval.0 = phi i32 [ 15, %sw.default ], [ 1, %sw.bb6 ], [ 62, %sw.bb5 ], [ 27, %sw.bb4 ], [ -1, %sw.bb3 ], [ 0, %sw.bb2 ], [ 123, %sw.bb1 ], [ 55, %entry ]
  ret i32 %retval.0

}

; Same thing, but with i8's

define i8 @char(i32 %c) {
entry:
  switch i32 %c, label %sw.default [
  i32 42, label %return
  i32 43, label %sw.bb1
  i32 44, label %sw.bb2
  i32 45, label %sw.bb3
  i32 46, label %sw.bb4
  i32 47, label %sw.bb5
  i32 48, label %sw.bb6
  i32 49, label %sw.bb7
  i32 50, label %sw.bb8
  ]

sw.bb1: br label %return
sw.bb2: br label %return
sw.bb3: br label %return
sw.bb4: br label %return
sw.bb5: br label %return
sw.bb6: br label %return
sw.bb7: br label %return
sw.bb8: br label %return
sw.default: br label %return
return:
  %retval.0 = phi i8 [ 15, %sw.default ], [ 84, %sw.bb8 ], [ 33, %sw.bb7 ], [ 1, %sw.bb6 ], [ 62, %sw.bb5 ], [ 27, %sw.bb4 ], [ -1, %sw.bb3 ], [ 0, %sw.bb2 ], [ 123, %sw.bb1 ], [ 55, %entry ]
  ret i8 %retval.0

}

; A switch used to initialize two variables, an i8 and a float.

declare void @dummy(i8 signext, float)
define void @h(i32 %x) {
entry:
  switch i32 %x, label %sw.default [
  i32 0, label %sw.epilog
  i32 1, label %sw.bb1
  i32 2, label %sw.bb2
  i32 3, label %sw.bb3
  ]

sw.bb1: br label %sw.epilog
sw.bb2: br label %sw.epilog
sw.bb3: br label %sw.epilog
sw.default: br label %sw.epilog

sw.epilog:
  %a.0 = phi i8 [ 7, %sw.default ], [ 5, %sw.bb3 ], [ 88, %sw.bb2 ], [ 9, %sw.bb1 ], [ 42, %entry ]
  %b.0 = phi float [ 0x4023FAE140000000, %sw.default ], [ 0x4001AE1480000000, %sw.bb3 ], [ 0x4012449BA0000000, %sw.bb2 ], [ 0x3FF3BE76C0000000, %sw.bb1 ], [ 0x40091EB860000000, %entry ]
  call void @dummy(i8 signext %a.0, float %b.0)
  ret void

}


; Switch used to return a string.

@.str = private unnamed_addr constant [4 x i8] c"foo\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"bar\00", align 1
@.str2 = private unnamed_addr constant [4 x i8] c"baz\00", align 1
@.str3 = private unnamed_addr constant [4 x i8] c"qux\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"error\00", align 1

define ptr @foostring(i32 %x)  {
entry:
  switch i32 %x, label %sw.default [
  i32 0, label %return
  i32 1, label %sw.bb1
  i32 2, label %sw.bb2
  i32 3, label %sw.bb3
  ]

sw.bb1: br label %return
sw.bb2: br label %return
sw.bb3: br label %return
sw.default: br label %return

return:
  %retval.0 = phi ptr [ @.str4, %sw.default ],
  [ @.str3, %sw.bb3 ],
  [ @.str2, %sw.bb2 ],
  [ @.str1, %sw.bb1 ],
  [ @.str, %entry ]
  ret ptr %retval.0

}
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpi17v2enc.ll'
source_filename = "/tmp/tmpi17v2enc.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-elf"

@.str = private unnamed_addr constant [4 x i8] c"foo\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"bar\00", align 1
@.str2 = private unnamed_addr constant [4 x i8] c"baz\00", align 1
@.str3 = private unnamed_addr constant [4 x i8] c"qux\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"error\00", align 1
@switch.table.f = private unnamed_addr constant [7 x i32] [i32 55, i32 123, i32 0, i32 -1, i32 27, i32 62, i32 1], align 4
@switch.table.char = private unnamed_addr constant [9 x i8] c"7{\00\FF\1B>\01!T", align 1
@switch.table.h = private unnamed_addr constant [4 x float] [float 3.140000e+00, float 1.234000e+00, float 4.567000e+00, float 2.210000e+00], align 4
@switch.table.foostring = private unnamed_addr constant [4 x ptr] [ptr @.str, ptr @.str1, ptr @.str2, ptr @.str3], align 4

define i32 @f(i32 %c) #0 {
entry:
  %switch.tableidx = sub i32 %c, 42
  %0 = icmp ult i32 %switch.tableidx, 7
  br i1 %0, label %switch.lookup, label %return

switch.lookup:                                    ; preds = %entry
  %switch.gep = getelementptr inbounds [7 x i32], ptr @switch.table.f, i32 0, i32 %switch.tableidx
  %switch.load = load i32, ptr %switch.gep, align 4
  br label %return

return:                                           ; preds = %entry, %switch.lookup
  %retval.0 = phi i32 [ %switch.load, %switch.lookup ], [ 15, %entry ]
  ret i32 %retval.0
}

define i8 @char(i32 %c) #0 {
entry:
  %switch.tableidx = sub i32 %c, 42
  %0 = icmp ult i32 %switch.tableidx, 9
  br i1 %0, label %switch.lookup, label %return

switch.lookup:                                    ; preds = %entry
  %switch.gep = getelementptr inbounds [9 x i8], ptr @switch.table.char, i32 0, i32 %switch.tableidx
  %switch.load = load i8, ptr %switch.gep, align 1
  br label %return

return:                                           ; preds = %entry, %switch.lookup
  %retval.0 = phi i8 [ %switch.load, %switch.lookup ], [ 15, %entry ]
  ret i8 %retval.0
}

declare void @dummy(i8 signext, float) #0

define void @h(i32 %x) #0 {
entry:
  %0 = icmp ult i32 %x, 4
  br i1 %0, label %switch.lookup, label %sw.epilog

switch.lookup:                                    ; preds = %entry
  %switch.shiftamt = mul nuw nsw i32 %x, 8
  %switch.downshift = lshr i32 89655594, %switch.shiftamt
  %switch.masked = trunc i32 %switch.downshift to i8
  %switch.gep = getelementptr inbounds [4 x float], ptr @switch.table.h, i32 0, i32 %x
  %switch.load = load float, ptr %switch.gep, align 4
  br label %sw.epilog

sw.epilog:                                        ; preds = %entry, %switch.lookup
  %a.0 = phi i8 [ %switch.masked, %switch.lookup ], [ 7, %entry ]
  %b.0 = phi float [ %switch.load, %switch.lookup ], [ f0x411FD70A, %entry ]
  call void @dummy(i8 signext %a.0, float %b.0)
  ret void
}

define ptr @foostring(i32 %x) #0 {
entry:
  %0 = icmp ult i32 %x, 4
  br i1 %0, label %switch.lookup, label %return

switch.lookup:                                    ; preds = %entry
  %switch.gep = getelementptr inbounds [4 x ptr], ptr @switch.table.foostring, i32 0, i32 %x
  %switch.load = load ptr, ptr %switch.gep, align 4
  br label %return

return:                                           ; preds = %entry, %switch.lookup
  %retval.0 = phi ptr [ %switch.load, %switch.lookup ], [ @.str4, %entry ]
  ret ptr %retval.0
}

attributes #0 = { "target-features"="+f" }
