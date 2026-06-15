; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InstCombine/RISCV/libcall-arg-exts.ll
; Variant: riscv64_instcombine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=instcombine -mtriple=riscv64 -S
; Original: RUN: opt < %s -passes=instcombine -S -mtriple=riscv64 | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================

; Check that i32 arguments to generated libcalls have the proper extension
; attributes.


declare double @exp2(double)
declare float @exp2f(float)
declare fp128 @exp2l(fp128)

define double @fun1(i32 %x) {
  %conv = sitofp i32 %x to double
  %ret = call double @exp2(double %conv)
  ret double %ret
}

define float @fun2(i32 %x) {
  %conv = sitofp i32 %x to float
  %ret = call float @exp2f(float %conv)
  ret float %ret
}

define fp128 @fun3(i8 zeroext %x) {
  %conv = uitofp i8 %x to fp128
  %ret = call fp128 @exp2l(fp128 %conv)
  ret fp128 %ret
}

@a = common global [60 x i8] zeroinitializer, align 1
@b = common global [60 x i8] zeroinitializer, align 1
declare ptr @__memccpy_chk(ptr, ptr, i32, i64, i64)
define ptr @fun4() {
  %ret = call ptr @__memccpy_chk(ptr @a, ptr @b, i32 0, i64 60, i64 -1)
  ret ptr %ret
}

%FILE = type { }
@A = constant [2 x i8] c"A\00"
declare i32 @fputs(ptr, ptr)
define void @fun5(ptr %fp) {
  call i32 @fputs(ptr @A, ptr %fp)
  ret void
}

@empty = constant [1 x i8] zeroinitializer
declare i32 @puts(ptr)
define void @fun6() {
  call i32 @puts(ptr @empty)
  ret void
}

@.str1 = private constant [2 x i8] c"a\00"
declare ptr @strstr(ptr, ptr)
define ptr @fun7(ptr %str) {
  %ret = call ptr @strstr(ptr %str, ptr @.str1)
  ret ptr %ret
}


@hello = constant [14 x i8] c"hello world\5Cn\00"
@chp = global ptr zeroinitializer
declare ptr @strchr(ptr, i32)
define void @fun8(i32 %chr) {
  %dst = call ptr @strchr(ptr @hello, i32 %chr)
  store ptr %dst, ptr @chp
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp3124i0ik.ll'
source_filename = "/tmp/tmp3124i0ik.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

@a = common global [60 x i8] zeroinitializer, align 1
@b = common global [60 x i8] zeroinitializer, align 1
@A = constant [2 x i8] c"A\00"
@empty = constant [1 x i8] zeroinitializer
@.str1 = private constant [2 x i8] c"a\00"
@hello = constant [14 x i8] c"hello world\\n\00"
@chp = global ptr null

declare double @exp2(double)

declare float @exp2f(float)

declare fp128 @exp2l(fp128)

define double @fun1(i32 %x) {
  %ldexp = call double @ldexp(double 1.000000e+00, i32 %x)
  ret double %ldexp
}

define float @fun2(i32 %x) {
  %ldexpf = call float @ldexpf(float 1.000000e+00, i32 %x)
  ret float %ldexpf
}

define fp128 @fun3(i8 zeroext %x) {
  %1 = zext i8 %x to i32
  %ldexpl = call fp128 @ldexpl(fp128 1.000000e+00, i32 %1)
  ret fp128 %ldexpl
}

declare ptr @__memccpy_chk(ptr, ptr, i32, i64, i64)

define ptr @fun4() {
  %memccpy = call ptr @memccpy(ptr nonnull @a, ptr nonnull @b, i32 0, i64 60)
  ret ptr %memccpy
}

declare i32 @fputs(ptr, ptr)

define void @fun5(ptr %fp) {
  %fputc = call i32 @fputc(i32 65, ptr %fp)
  ret void
}

declare i32 @puts(ptr)

define void @fun6() {
  %putchar = call i32 @putchar(i32 10)
  ret void
}

declare ptr @strstr(ptr, ptr)

define ptr @fun7(ptr %str) {
  %strchr = call ptr @strchr(ptr noundef nonnull dereferenceable(1) %str, i32 97)
  ret ptr %strchr
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: read)
declare ptr @strchr(ptr, i32 signext) #0

define void @fun8(i32 %chr) {
  %memchr = call ptr @memchr(ptr noundef nonnull dereferenceable(1) @hello, i32 %chr, i64 14)
  store ptr %memchr, ptr @chp, align 8
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(errnomem: write)
declare double @ldexp(double, i32 signext) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(errnomem: write)
declare float @ldexpf(float, i32 signext) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(errnomem: write)
declare fp128 @ldexpl(fp128, i32 signext) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare ptr @memccpy(ptr noalias writeonly, ptr noalias readonly captures(none), i32 signext, i64) #2

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef signext, ptr noundef captures(none)) #3

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef signext) #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: read)
declare ptr @memchr(ptr, i32 signext, i64) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: read) }
attributes #1 = { nocallback nofree nounwind willreturn memory(errnomem: write) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nofree nounwind }
