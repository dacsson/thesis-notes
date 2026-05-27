; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/spillcost.ll
; Variant: riscv64_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S < %s -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


declare void @g()

; Shouldn't be vectorized
define void @f0(i1 %c, ptr %p, ptr %q) {
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br i1 %c, label %foo, label %bar
foo:
  call void @g()
  call void @g()
  call void @g()
  br label %baz
bar:
  call void @g()
  call void @g()
  call void @g()
  br label %baz
baz:
  store i64 %x0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %x1, ptr %q1

  ret void
}

; Should be vectorized - just one spill of TMP0
define void @f1(i1 %c, ptr %p, ptr %q, ptr %r) {
entry:
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br i1 %c, label %foo, label %bar
foo:
  %y0 = add i64 %x0, 1
  %y1 = add i64 %x1, 1
  br label %baz
bar:
  call void @g()
  call void @g()
  call void @g()
  br label %baz
baz:
  %phi0 = phi i64 [%y0, %foo], [%x0, %bar]
  %phi1 = phi i64 [%y1, %foo], [%x1, %bar]
  store i64 %phi0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1

  ret void
}

; Shouldn't be vectorized
define void @f11(i1 %c, ptr %p, ptr %q, ptr %r) {
entry:
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br i1 %c, label %foo, label %bar
foo:
  br label %baz
bar:
  call void @g()
  call void @g()
  call void @g()
  br label %baz
baz:
  %phi0 = phi i64 [0, %foo], [%x0, %bar]
  %phi1 = phi i64 [1, %foo], [%x1, %bar]
  store i64 %phi0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1

  ret void
}

; Should be vectorized
define void @f2(i1 %c, ptr %p, ptr %q, ptr %r) {
entry:
  call void @g()
  call void @g()
  call void @g()
  br i1 %c, label %foo, label %bar
foo:
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br label %bar
bar:
  %phi0 = phi i64 [0, %entry], [%x0, %foo]
  %phi1 = phi i64 [0, %entry], [%x1, %foo]
  store i64 %phi0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1

  ret void
}


; Shouldn't be vectorized
define void @f3(i64 %n, double %f0, double %f1, ptr %q) {
entry:
  br label %loop
loop:
  %iv = phi i64 [0, %entry], [%iv.next, %latch]
  %phi0 = phi double [%f0, %entry], [%x0, %latch]
  %phi1 = phi double [%f1, %entry], [%x1, %latch]
  call void @g()
  call void @g()
  call void @g()
  br label %latch
latch:
  %x0 = fadd double %phi0, 1.0
  %x1 = fadd double %phi1, 1.0

  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, %n
  br i1 %done, label %exit, label %loop
exit:
  %q.gep0 =  getelementptr i64, ptr %q, i64 %iv
  store double %x0, ptr %q.gep0
  %q.gep1 =  getelementptr i64, ptr %q.gep0, i64 1
  store double %x1, ptr %q.gep1
  ret void
}

; Should be vectorized
define void @f4(ptr %p, ptr %q, i1 %c0, i1 %c1) {
entry:
  br label %foo
foo:
  call void @g()
  call void @g()
  call void @g()
  br label %bar
bar:
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br i1 %c0, label %baz, label %qux
baz:
  %y0 = add i64 %x0, 1
  %y1 = add i64 %x1, 1
  br label %qux
qux:
  %z0 = phi i64 [%x0, %bar], [%y0, %baz]
  %z1 = phi i64 [%x1, %bar], [%y1, %baz]
  store i64 %z0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %z1, ptr %q1
  br i1 %c1, label %foo, label %bar
}


; Should be vectorized
define void @f5(i1 %c0, ptr %p, ptr %q) {
entry:
  br label %foo
foo:
  call void @g()
  call void @g()
  call void @g()
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br i1 %c0, label %bar, label %foobar
bar:
  br label %baz
baz:
  %y0 = add i64 %x0, 1
  %y1 = add i64 %x1, 1
  br label %barfoo
foobar:
  %z0 = add i64 %x0, 2
  %z1 = add i64 %x1, 2
  br label %barfoo
barfoo:
  %phi0 = phi i64 [%z0, %foobar], [%y0, %baz]
  %phi1 = phi i64 [%z1, %foobar], [%y1, %baz]
  store i64 %phi0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1
  br label %foo
}

; Shouldn't be vectorized
define void @f6(i1 %c, ptr %p, ptr %q, ptr %r) {
entry:
  br i1 %c, label %foo, label %bar
foo:
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br label %bar
bar:
  %phi0 = phi i64 [0, %entry], [%x0, %foo]
  %phi1 = phi i64 [0, %entry], [%x1, %foo]
  call void @g()
  call void @g()
  call void @g()
  br label %baz
baz:
  store i64 %phi0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpqy0fzne4.ll'
source_filename = "/tmp/tmpqy0fzne4.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

declare void @g() #0

define void @f0(i1 %c, ptr %p, ptr %q) #0 {
  %x0 = load i64, ptr %p, align 8
  %p1 = getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1, align 8
  br i1 %c, label %foo, label %bar

foo:                                              ; preds = %0
  call void @g()
  call void @g()
  call void @g()
  br label %baz

bar:                                              ; preds = %0
  call void @g()
  call void @g()
  call void @g()
  br label %baz

baz:                                              ; preds = %bar, %foo
  store i64 %x0, ptr %q, align 8
  %q1 = getelementptr i64, ptr %q, i64 1
  store i64 %x1, ptr %q1, align 8
  ret void
}

define void @f1(i1 %c, ptr %p, ptr %q, ptr %r) #0 {
entry:
  %0 = load <2 x i64>, ptr %p, align 8
  br i1 %c, label %foo, label %bar

foo:                                              ; preds = %entry
  %1 = add <2 x i64> %0, splat (i64 1)
  br label %baz

bar:                                              ; preds = %entry
  call void @g()
  call void @g()
  call void @g()
  br label %baz

baz:                                              ; preds = %bar, %foo
  %2 = phi <2 x i64> [ %1, %foo ], [ %0, %bar ]
  store <2 x i64> %2, ptr %q, align 8
  ret void
}

define void @f11(i1 %c, ptr %p, ptr %q, ptr %r) #0 {
entry:
  %x0 = load i64, ptr %p, align 8
  %p1 = getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1, align 8
  br i1 %c, label %foo, label %bar

foo:                                              ; preds = %entry
  br label %baz

bar:                                              ; preds = %entry
  call void @g()
  call void @g()
  call void @g()
  br label %baz

baz:                                              ; preds = %bar, %foo
  %phi0 = phi i64 [ 0, %foo ], [ %x0, %bar ]
  %phi1 = phi i64 [ 1, %foo ], [ %x1, %bar ]
  store i64 %phi0, ptr %q, align 8
  %q1 = getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1, align 8
  ret void
}

define void @f2(i1 %c, ptr %p, ptr %q, ptr %r) #0 {
entry:
  call void @g()
  call void @g()
  call void @g()
  br i1 %c, label %foo, label %bar

foo:                                              ; preds = %entry
  %0 = load <2 x i64>, ptr %p, align 8
  br label %bar

bar:                                              ; preds = %foo, %entry
  %1 = phi <2 x i64> [ zeroinitializer, %entry ], [ %0, %foo ]
  store <2 x i64> %1, ptr %q, align 8
  ret void
}

define void @f3(i64 %n, double %f0, double %f1, ptr %q) #0 {
entry:
  br label %loop

loop:                                             ; preds = %latch, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %phi0 = phi double [ %f0, %entry ], [ %x0, %latch ]
  %phi1 = phi double [ %f1, %entry ], [ %x1, %latch ]
  call void @g()
  call void @g()
  call void @g()
  br label %latch

latch:                                            ; preds = %loop
  %x0 = fadd double %phi0, 1.000000e+00
  %x1 = fadd double %phi1, 1.000000e+00
  %iv.next = add i64 %iv, 1
  %done = icmp eq i64 %iv.next, %n
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %latch
  %q.gep0 = getelementptr i64, ptr %q, i64 %iv
  store double %x0, ptr %q.gep0, align 8
  %q.gep1 = getelementptr i64, ptr %q.gep0, i64 1
  store double %x1, ptr %q.gep1, align 8
  ret void
}

define void @f4(ptr %p, ptr %q, i1 %c0, i1 %c1) #0 {
entry:
  br label %foo

foo:                                              ; preds = %qux, %entry
  call void @g()
  call void @g()
  call void @g()
  br label %bar

bar:                                              ; preds = %qux, %foo
  %0 = load <2 x i64>, ptr %p, align 8
  br i1 %c0, label %baz, label %qux

baz:                                              ; preds = %bar
  %1 = add <2 x i64> %0, splat (i64 1)
  br label %qux

qux:                                              ; preds = %baz, %bar
  %2 = phi <2 x i64> [ %0, %bar ], [ %1, %baz ]
  store <2 x i64> %2, ptr %q, align 8
  br i1 %c1, label %foo, label %bar
}

define void @f5(i1 %c0, ptr %p, ptr %q) #0 {
entry:
  br label %foo

foo:                                              ; preds = %barfoo, %entry
  call void @g()
  call void @g()
  call void @g()
  %0 = load <2 x i64>, ptr %p, align 8
  br i1 %c0, label %bar, label %foobar

bar:                                              ; preds = %foo
  br label %baz

baz:                                              ; preds = %bar
  %1 = add <2 x i64> %0, splat (i64 1)
  br label %barfoo

foobar:                                           ; preds = %foo
  %2 = add <2 x i64> %0, splat (i64 2)
  br label %barfoo

barfoo:                                           ; preds = %foobar, %baz
  %3 = phi <2 x i64> [ %2, %foobar ], [ %1, %baz ]
  store <2 x i64> %3, ptr %q, align 8
  br label %foo
}

define void @f6(i1 %c, ptr %p, ptr %q, ptr %r) #0 {
entry:
  br i1 %c, label %foo, label %bar

foo:                                              ; preds = %entry
  %x0 = load i64, ptr %p, align 8
  %p1 = getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1, align 8
  br label %bar

bar:                                              ; preds = %foo, %entry
  %phi0 = phi i64 [ 0, %entry ], [ %x0, %foo ]
  %phi1 = phi i64 [ 0, %entry ], [ %x1, %foo ]
  call void @g()
  call void @g()
  call void @g()
  br label %baz

baz:                                              ; preds = %bar
  store i64 %phi0, ptr %q, align 8
  %q1 = getelementptr i64, ptr %q, i64 1
  store i64 %phi1, ptr %q1, align 8
  ret void
}

attributes #0 = { "target-features"="+v" }
