; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/Inline/RISCV/inline-target-features.ll
; Variant: riscv64-unknown-linux-gnu_inline
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-unknown-linux-gnu -passes=inline -S
; Original: RUN: opt < %s -mtriple=riscv64-unknown-linux-gnu -S -passes=inline | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

; Check that we only inline when we have compatible target attributes.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @foo() #0 {
entry:
  %call = call i32 (...) @baz()
  ret i32 %call
}
declare i32 @baz(...) #0

define i32 @bar() #1 {
entry:
  %call = call i32 @foo()
  ret i32 %call
}

define i32 @qux() #0 {
entry:
  %call = call i32 @bar()
  ret i32 %call
}

attributes #0 = { "target-cpu"="generic-rv64" "target-features"="+f,+d" }
attributes #1 = { "target-cpu"="generic-rv64" "target-features"="+f,+d,+m,+v" }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp7jgse18o.ll'
source_filename = "/tmp/tmp7jgse18o.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @foo() #0 {
entry:
  %call = call i32 (...) @baz()
  ret i32 %call
}

declare i32 @baz(...) #0

define i32 @bar() #1 {
entry:
  %call.i = call i32 (...) @baz()
  ret i32 %call.i
}

define i32 @qux() #0 {
entry:
  %call = call i32 @bar()
  ret i32 %call
}

attributes #0 = { "target-cpu"="generic-rv64" "target-features"="+f,+d" }
attributes #1 = { "target-cpu"="generic-rv64" "target-features"="+f,+d,+m,+v" }
