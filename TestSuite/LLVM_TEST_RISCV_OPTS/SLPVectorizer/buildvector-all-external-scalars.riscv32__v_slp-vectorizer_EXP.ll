; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/buildvector-all-external-scalars.ll
; Variant: riscv32_+v_slp-vectorizer_EXP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -slp-threshold=-55 -mattr=+v -mtriple riscv32 -S
; Original: RUN: opt -passes=slp-vectorizer -S -slp-threshold=-55 -mattr=+v -mtriple riscv32 < %s | FileCheck %s --check-prefix=EXP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %__last.addr.011.i.i, ptr %call3) {
newFuncRoot:
  br label %while.body.i.i

while.body.i.i:
  %__last.addr.014.i.i = phi ptr [ %__last.addr.011.i.i, %newFuncRoot ], [ %__last.addr.0.i.i.31, %while.body.i.i ]
  %__first.addr.013.i.i = phi ptr [ %call3, %newFuncRoot ], [ %incdec.ptr2.i.i.31, %while.body.i.i ]
  %0 = load float, ptr %__first.addr.013.i.i, align 4
  %1 = load float, ptr %__last.addr.014.i.i, align 4
  store float %1, ptr %__first.addr.013.i.i, align 4
  store float %0, ptr %__last.addr.014.i.i, align 4
  %incdec.ptr2.i.i = getelementptr inbounds nuw i8, ptr %__first.addr.013.i.i, i32 4
  %__last.addr.0.i.i = getelementptr inbounds i8, ptr %__last.addr.014.i.i, i32 -4
  %2 = load float, ptr %incdec.ptr2.i.i, align 4
  %3 = load float, ptr %__last.addr.0.i.i, align 4
  store float %3, ptr %incdec.ptr2.i.i, align 4
  store float %2, ptr %__last.addr.0.i.i, align 4
  %incdec.ptr2.i.i.1 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i, i32 4
  %__last.addr.0.i.i.1 = getelementptr inbounds i8, ptr %__last.addr.0.i.i, i32 -4
  %4 = load float, ptr %incdec.ptr2.i.i.1, align 4
  %5 = load float, ptr %__last.addr.0.i.i.1, align 4
  store float %5, ptr %incdec.ptr2.i.i.1, align 4
  store float %4, ptr %__last.addr.0.i.i.1, align 4
  %incdec.ptr2.i.i.2 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.1, i32 4
  %__last.addr.0.i.i.2 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.1, i32 -4
  %6 = load float, ptr %incdec.ptr2.i.i.2, align 4
  %7 = load float, ptr %__last.addr.0.i.i.2, align 4
  store float %7, ptr %incdec.ptr2.i.i.2, align 4
  store float %6, ptr %__last.addr.0.i.i.2, align 4
  %incdec.ptr2.i.i.3 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.2, i32 4
  %__last.addr.0.i.i.3 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.2, i32 -4
  %8 = load float, ptr %incdec.ptr2.i.i.3, align 4
  %9 = load float, ptr %__last.addr.0.i.i.3, align 4
  store float %9, ptr %incdec.ptr2.i.i.3, align 4
  store float %8, ptr %__last.addr.0.i.i.3, align 4
  %incdec.ptr2.i.i.4 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.3, i32 4
  %__last.addr.0.i.i.4 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.3, i32 -4
  %10 = load float, ptr %incdec.ptr2.i.i.4, align 4
  %11 = load float, ptr %__last.addr.0.i.i.4, align 4
  store float %11, ptr %incdec.ptr2.i.i.4, align 4
  store float %10, ptr %__last.addr.0.i.i.4, align 4
  %incdec.ptr2.i.i.5 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.4, i32 4
  %__last.addr.0.i.i.5 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.4, i32 -4
  %12 = load float, ptr %incdec.ptr2.i.i.5, align 4
  %13 = load float, ptr %__last.addr.0.i.i.5, align 4
  store float %13, ptr %incdec.ptr2.i.i.5, align 4
  store float %12, ptr %__last.addr.0.i.i.5, align 4
  %incdec.ptr2.i.i.6 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.5, i32 4
  %__last.addr.0.i.i.6 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.5, i32 -4
  %14 = load float, ptr %incdec.ptr2.i.i.6, align 4
  %15 = load float, ptr %__last.addr.0.i.i.6, align 4
  store float %15, ptr %incdec.ptr2.i.i.6, align 4
  store float %14, ptr %__last.addr.0.i.i.6, align 4
  %incdec.ptr2.i.i.7 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.6, i32 4
  %__last.addr.0.i.i.7 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.6, i32 -4
  %16 = load float, ptr %incdec.ptr2.i.i.7, align 4
  %17 = load float, ptr %__last.addr.0.i.i.7, align 4
  store float %17, ptr %incdec.ptr2.i.i.7, align 4
  store float %16, ptr %__last.addr.0.i.i.7, align 4
  %incdec.ptr2.i.i.8 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.7, i32 4
  %__last.addr.0.i.i.8 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.7, i32 -4
  %18 = load float, ptr %incdec.ptr2.i.i.8, align 4
  %19 = load float, ptr %__last.addr.0.i.i.8, align 4
  store float %19, ptr %incdec.ptr2.i.i.8, align 4
  store float %18, ptr %__last.addr.0.i.i.8, align 4
  %incdec.ptr2.i.i.9 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.8, i32 4
  %__last.addr.0.i.i.9 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.8, i32 -4
  %20 = load float, ptr %incdec.ptr2.i.i.9, align 4
  %21 = load float, ptr %__last.addr.0.i.i.9, align 4
  store float %21, ptr %incdec.ptr2.i.i.9, align 4
  store float %20, ptr %__last.addr.0.i.i.9, align 4
  %incdec.ptr2.i.i.10 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.9, i32 4
  %__last.addr.0.i.i.10 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.9, i32 -4
  %22 = load float, ptr %incdec.ptr2.i.i.10, align 4
  %23 = load float, ptr %__last.addr.0.i.i.10, align 4
  store float %23, ptr %incdec.ptr2.i.i.10, align 4
  store float %22, ptr %__last.addr.0.i.i.10, align 4
  %incdec.ptr2.i.i.11 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.10, i32 4
  %__last.addr.0.i.i.11 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.10, i32 -4
  %24 = load float, ptr %incdec.ptr2.i.i.11, align 4
  %25 = load float, ptr %__last.addr.0.i.i.11, align 4
  store float %25, ptr %incdec.ptr2.i.i.11, align 4
  store float %24, ptr %__last.addr.0.i.i.11, align 4
  %incdec.ptr2.i.i.12 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.11, i32 4
  %__last.addr.0.i.i.12 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.11, i32 -4
  %26 = load float, ptr %incdec.ptr2.i.i.12, align 4
  %27 = load float, ptr %__last.addr.0.i.i.12, align 4
  store float %27, ptr %incdec.ptr2.i.i.12, align 4
  store float %26, ptr %__last.addr.0.i.i.12, align 4
  %incdec.ptr2.i.i.13 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.12, i32 4
  %__last.addr.0.i.i.13 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.12, i32 -4
  %28 = load float, ptr %incdec.ptr2.i.i.13, align 4
  %29 = load float, ptr %__last.addr.0.i.i.13, align 4
  store float %29, ptr %incdec.ptr2.i.i.13, align 4
  store float %28, ptr %__last.addr.0.i.i.13, align 4
  %incdec.ptr2.i.i.14 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.13, i32 4
  %__last.addr.0.i.i.14 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.13, i32 -4
  %30 = load float, ptr %incdec.ptr2.i.i.14, align 4
  %31 = load float, ptr %__last.addr.0.i.i.14, align 4
  store float %31, ptr %incdec.ptr2.i.i.14, align 4
  store float %30, ptr %__last.addr.0.i.i.14, align 4
  %incdec.ptr2.i.i.15 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.14, i32 4
  %__last.addr.0.i.i.15 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.14, i32 -4
  %32 = load float, ptr %incdec.ptr2.i.i.15, align 4
  %33 = load float, ptr %__last.addr.0.i.i.15, align 4
  store float %33, ptr %incdec.ptr2.i.i.15, align 4
  store float %32, ptr %__last.addr.0.i.i.15, align 4
  %incdec.ptr2.i.i.16 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.15, i32 4
  %__last.addr.0.i.i.16 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.15, i32 -4
  %34 = load float, ptr %incdec.ptr2.i.i.16, align 4
  %35 = load float, ptr %__last.addr.0.i.i.16, align 4
  store float %35, ptr %incdec.ptr2.i.i.16, align 4
  store float %34, ptr %__last.addr.0.i.i.16, align 4
  %incdec.ptr2.i.i.17 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.16, i32 4
  %__last.addr.0.i.i.17 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.16, i32 -4
  %36 = load float, ptr %incdec.ptr2.i.i.17, align 4
  %37 = load float, ptr %__last.addr.0.i.i.17, align 4
  store float %37, ptr %incdec.ptr2.i.i.17, align 4
  store float %36, ptr %__last.addr.0.i.i.17, align 4
  %incdec.ptr2.i.i.18 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.17, i32 4
  %__last.addr.0.i.i.18 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.17, i32 -4
  %38 = load float, ptr %incdec.ptr2.i.i.18, align 4
  %39 = load float, ptr %__last.addr.0.i.i.18, align 4
  store float %39, ptr %incdec.ptr2.i.i.18, align 4
  store float %38, ptr %__last.addr.0.i.i.18, align 4
  %incdec.ptr2.i.i.19 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.18, i32 4
  %__last.addr.0.i.i.19 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.18, i32 -4
  %40 = load float, ptr %incdec.ptr2.i.i.19, align 4
  %41 = load float, ptr %__last.addr.0.i.i.19, align 4
  store float %41, ptr %incdec.ptr2.i.i.19, align 4
  store float %40, ptr %__last.addr.0.i.i.19, align 4
  %incdec.ptr2.i.i.20 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.19, i32 4
  %__last.addr.0.i.i.20 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.19, i32 -4
  %42 = load float, ptr %incdec.ptr2.i.i.20, align 4
  %43 = load float, ptr %__last.addr.0.i.i.20, align 4
  store float %43, ptr %incdec.ptr2.i.i.20, align 4
  store float %42, ptr %__last.addr.0.i.i.20, align 4
  %incdec.ptr2.i.i.21 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.20, i32 4
  %__last.addr.0.i.i.21 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.20, i32 -4
  %44 = load float, ptr %incdec.ptr2.i.i.21, align 4
  %45 = load float, ptr %__last.addr.0.i.i.21, align 4
  store float %45, ptr %incdec.ptr2.i.i.21, align 4
  store float %44, ptr %__last.addr.0.i.i.21, align 4
  %incdec.ptr2.i.i.22 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.21, i32 4
  %__last.addr.0.i.i.22 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.21, i32 -4
  %46 = load float, ptr %incdec.ptr2.i.i.22, align 4
  %47 = load float, ptr %__last.addr.0.i.i.22, align 4
  store float %47, ptr %incdec.ptr2.i.i.22, align 4
  store float %46, ptr %__last.addr.0.i.i.22, align 4
  %incdec.ptr2.i.i.23 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.22, i32 4
  %__last.addr.0.i.i.23 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.22, i32 -4
  %48 = load float, ptr %incdec.ptr2.i.i.23, align 4
  %49 = load float, ptr %__last.addr.0.i.i.23, align 4
  store float %49, ptr %incdec.ptr2.i.i.23, align 4
  store float %48, ptr %__last.addr.0.i.i.23, align 4
  %incdec.ptr2.i.i.24 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.23, i32 4
  %__last.addr.0.i.i.24 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.23, i32 -4
  %50 = load float, ptr %incdec.ptr2.i.i.24, align 4
  %51 = load float, ptr %__last.addr.0.i.i.24, align 4
  store float %51, ptr %incdec.ptr2.i.i.24, align 4
  store float %50, ptr %__last.addr.0.i.i.24, align 4
  %incdec.ptr2.i.i.25 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.24, i32 4
  %__last.addr.0.i.i.25 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.24, i32 -4
  %52 = load float, ptr %incdec.ptr2.i.i.25, align 4
  %53 = load float, ptr %__last.addr.0.i.i.25, align 4
  store float %53, ptr %incdec.ptr2.i.i.25, align 4
  store float %52, ptr %__last.addr.0.i.i.25, align 4
  %incdec.ptr2.i.i.26 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.25, i32 4
  %__last.addr.0.i.i.26 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.25, i32 -4
  %54 = load float, ptr %incdec.ptr2.i.i.26, align 4
  %55 = load float, ptr %__last.addr.0.i.i.26, align 4
  store float %55, ptr %incdec.ptr2.i.i.26, align 4
  store float %54, ptr %__last.addr.0.i.i.26, align 4
  %incdec.ptr2.i.i.27 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.26, i32 4
  %__last.addr.0.i.i.27 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.26, i32 -4
  %56 = load float, ptr %incdec.ptr2.i.i.27, align 4
  %57 = load float, ptr %__last.addr.0.i.i.27, align 4
  store float %57, ptr %incdec.ptr2.i.i.27, align 4
  store float %56, ptr %__last.addr.0.i.i.27, align 4
  %incdec.ptr2.i.i.28 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.27, i32 4
  %__last.addr.0.i.i.28 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.27, i32 -4
  %58 = load float, ptr %incdec.ptr2.i.i.28, align 4
  %59 = load float, ptr %__last.addr.0.i.i.28, align 4
  store float %59, ptr %incdec.ptr2.i.i.28, align 4
  store float %58, ptr %__last.addr.0.i.i.28, align 4
  %incdec.ptr2.i.i.29 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.28, i32 4
  %__last.addr.0.i.i.29 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.28, i32 -4
  %60 = load float, ptr %incdec.ptr2.i.i.29, align 4
  %61 = load float, ptr %__last.addr.0.i.i.29, align 4
  store float %61, ptr %incdec.ptr2.i.i.29, align 4
  store float %60, ptr %__last.addr.0.i.i.29, align 4
  %incdec.ptr2.i.i.30 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.29, i32 4
  %__last.addr.0.i.i.30 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.29, i32 -4
  %62 = load float, ptr %incdec.ptr2.i.i.30, align 4
  %63 = load float, ptr %__last.addr.0.i.i.30, align 4
  store float %63, ptr %incdec.ptr2.i.i.30, align 4
  store float %62, ptr %__last.addr.0.i.i.30, align 4
  %incdec.ptr2.i.i.31 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.30, i32 4
  %__last.addr.0.i.i.31 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.30, i32 -4
  %cmp1.i.i.31 = icmp ult ptr %incdec.ptr2.i.i.31, %__last.addr.0.i.i.31
  br i1 %cmp1.i.i.31, label %while.body.i.i, label %invoke.cont21.exitStub

invoke.cont21.exitStub:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpyv0u8i14.ll'
source_filename = "/tmp/tmpyv0u8i14.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define void @test(ptr %__last.addr.011.i.i, ptr %call3) #0 {
newFuncRoot:
  %0 = insertelement <2 x ptr> poison, ptr %__last.addr.011.i.i, i32 0
  %1 = insertelement <2 x ptr> %0, ptr %call3, i32 1
  br label %while.body.i.i

while.body.i.i:                                   ; preds = %while.body.i.i, %newFuncRoot
  %2 = phi <2 x ptr> [ %1, %newFuncRoot ], [ %94, %while.body.i.i ]
  %3 = extractelement <2 x ptr> %2, i32 1
  %4 = load float, ptr %3, align 4
  %5 = extractelement <2 x ptr> %2, i32 0
  %6 = load float, ptr %5, align 4
  store float %6, ptr %3, align 4
  store float %4, ptr %5, align 4
  %incdec.ptr2.i.i = getelementptr inbounds nuw i8, ptr %3, i32 4
  %__last.addr.0.i.i = getelementptr inbounds i8, ptr %5, i32 -4
  %7 = load float, ptr %incdec.ptr2.i.i, align 4
  %8 = load float, ptr %__last.addr.0.i.i, align 4
  store float %8, ptr %incdec.ptr2.i.i, align 4
  store float %7, ptr %__last.addr.0.i.i, align 4
  %incdec.ptr2.i.i.1 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i, i32 4
  %__last.addr.0.i.i.1 = getelementptr inbounds i8, ptr %__last.addr.0.i.i, i32 -4
  %9 = load float, ptr %incdec.ptr2.i.i.1, align 4
  %10 = load float, ptr %__last.addr.0.i.i.1, align 4
  store float %10, ptr %incdec.ptr2.i.i.1, align 4
  store float %9, ptr %__last.addr.0.i.i.1, align 4
  %incdec.ptr2.i.i.2 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.1, i32 4
  %__last.addr.0.i.i.2 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.1, i32 -4
  %11 = load float, ptr %incdec.ptr2.i.i.2, align 4
  %12 = load float, ptr %__last.addr.0.i.i.2, align 4
  store float %12, ptr %incdec.ptr2.i.i.2, align 4
  store float %11, ptr %__last.addr.0.i.i.2, align 4
  %incdec.ptr2.i.i.3 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.2, i32 4
  %__last.addr.0.i.i.3 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.2, i32 -4
  %13 = load float, ptr %incdec.ptr2.i.i.3, align 4
  %14 = load float, ptr %__last.addr.0.i.i.3, align 4
  store float %14, ptr %incdec.ptr2.i.i.3, align 4
  store float %13, ptr %__last.addr.0.i.i.3, align 4
  %incdec.ptr2.i.i.4 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.3, i32 4
  %__last.addr.0.i.i.4 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.3, i32 -4
  %15 = load float, ptr %incdec.ptr2.i.i.4, align 4
  %16 = load float, ptr %__last.addr.0.i.i.4, align 4
  store float %16, ptr %incdec.ptr2.i.i.4, align 4
  store float %15, ptr %__last.addr.0.i.i.4, align 4
  %incdec.ptr2.i.i.5 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.4, i32 4
  %__last.addr.0.i.i.5 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.4, i32 -4
  %17 = load float, ptr %incdec.ptr2.i.i.5, align 4
  %18 = load float, ptr %__last.addr.0.i.i.5, align 4
  store float %18, ptr %incdec.ptr2.i.i.5, align 4
  store float %17, ptr %__last.addr.0.i.i.5, align 4
  %incdec.ptr2.i.i.6 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.5, i32 4
  %__last.addr.0.i.i.6 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.5, i32 -4
  %19 = load float, ptr %incdec.ptr2.i.i.6, align 4
  %20 = load float, ptr %__last.addr.0.i.i.6, align 4
  store float %20, ptr %incdec.ptr2.i.i.6, align 4
  store float %19, ptr %__last.addr.0.i.i.6, align 4
  %incdec.ptr2.i.i.7 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.6, i32 4
  %__last.addr.0.i.i.7 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.6, i32 -4
  %21 = load float, ptr %incdec.ptr2.i.i.7, align 4
  %22 = load float, ptr %__last.addr.0.i.i.7, align 4
  store float %22, ptr %incdec.ptr2.i.i.7, align 4
  store float %21, ptr %__last.addr.0.i.i.7, align 4
  %incdec.ptr2.i.i.8 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.7, i32 4
  %__last.addr.0.i.i.8 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.7, i32 -4
  %23 = load float, ptr %incdec.ptr2.i.i.8, align 4
  %24 = load float, ptr %__last.addr.0.i.i.8, align 4
  store float %24, ptr %incdec.ptr2.i.i.8, align 4
  store float %23, ptr %__last.addr.0.i.i.8, align 4
  %incdec.ptr2.i.i.9 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.8, i32 4
  %__last.addr.0.i.i.9 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.8, i32 -4
  %25 = load float, ptr %incdec.ptr2.i.i.9, align 4
  %26 = load float, ptr %__last.addr.0.i.i.9, align 4
  store float %26, ptr %incdec.ptr2.i.i.9, align 4
  store float %25, ptr %__last.addr.0.i.i.9, align 4
  %incdec.ptr2.i.i.10 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.9, i32 4
  %__last.addr.0.i.i.10 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.9, i32 -4
  %27 = load float, ptr %incdec.ptr2.i.i.10, align 4
  %28 = load float, ptr %__last.addr.0.i.i.10, align 4
  store float %28, ptr %incdec.ptr2.i.i.10, align 4
  store float %27, ptr %__last.addr.0.i.i.10, align 4
  %incdec.ptr2.i.i.11 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.10, i32 4
  %__last.addr.0.i.i.11 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.10, i32 -4
  %29 = load float, ptr %incdec.ptr2.i.i.11, align 4
  %30 = load float, ptr %__last.addr.0.i.i.11, align 4
  store float %30, ptr %incdec.ptr2.i.i.11, align 4
  store float %29, ptr %__last.addr.0.i.i.11, align 4
  %incdec.ptr2.i.i.12 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.11, i32 4
  %__last.addr.0.i.i.12 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.11, i32 -4
  %31 = load float, ptr %incdec.ptr2.i.i.12, align 4
  %32 = load float, ptr %__last.addr.0.i.i.12, align 4
  store float %32, ptr %incdec.ptr2.i.i.12, align 4
  store float %31, ptr %__last.addr.0.i.i.12, align 4
  %incdec.ptr2.i.i.13 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.12, i32 4
  %__last.addr.0.i.i.13 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.12, i32 -4
  %33 = load float, ptr %incdec.ptr2.i.i.13, align 4
  %34 = load float, ptr %__last.addr.0.i.i.13, align 4
  store float %34, ptr %incdec.ptr2.i.i.13, align 4
  store float %33, ptr %__last.addr.0.i.i.13, align 4
  %incdec.ptr2.i.i.14 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.13, i32 4
  %__last.addr.0.i.i.14 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.13, i32 -4
  %35 = load float, ptr %incdec.ptr2.i.i.14, align 4
  %36 = load float, ptr %__last.addr.0.i.i.14, align 4
  store float %36, ptr %incdec.ptr2.i.i.14, align 4
  store float %35, ptr %__last.addr.0.i.i.14, align 4
  %incdec.ptr2.i.i.15 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.14, i32 4
  %__last.addr.0.i.i.15 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.14, i32 -4
  %37 = load float, ptr %incdec.ptr2.i.i.15, align 4
  %38 = load float, ptr %__last.addr.0.i.i.15, align 4
  store float %38, ptr %incdec.ptr2.i.i.15, align 4
  store float %37, ptr %__last.addr.0.i.i.15, align 4
  %incdec.ptr2.i.i.16 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.15, i32 4
  %__last.addr.0.i.i.16 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.15, i32 -4
  %39 = load float, ptr %incdec.ptr2.i.i.16, align 4
  %40 = load float, ptr %__last.addr.0.i.i.16, align 4
  store float %40, ptr %incdec.ptr2.i.i.16, align 4
  store float %39, ptr %__last.addr.0.i.i.16, align 4
  %incdec.ptr2.i.i.17 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.16, i32 4
  %__last.addr.0.i.i.17 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.16, i32 -4
  %41 = load float, ptr %incdec.ptr2.i.i.17, align 4
  %42 = load float, ptr %__last.addr.0.i.i.17, align 4
  store float %42, ptr %incdec.ptr2.i.i.17, align 4
  store float %41, ptr %__last.addr.0.i.i.17, align 4
  %incdec.ptr2.i.i.18 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.17, i32 4
  %__last.addr.0.i.i.18 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.17, i32 -4
  %43 = load float, ptr %incdec.ptr2.i.i.18, align 4
  %44 = load float, ptr %__last.addr.0.i.i.18, align 4
  store float %44, ptr %incdec.ptr2.i.i.18, align 4
  store float %43, ptr %__last.addr.0.i.i.18, align 4
  %incdec.ptr2.i.i.19 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.18, i32 4
  %__last.addr.0.i.i.19 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.18, i32 -4
  %45 = load float, ptr %incdec.ptr2.i.i.19, align 4
  %46 = load float, ptr %__last.addr.0.i.i.19, align 4
  store float %46, ptr %incdec.ptr2.i.i.19, align 4
  store float %45, ptr %__last.addr.0.i.i.19, align 4
  %__last.addr.0.i.i.20 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.19, i32 -4
  %47 = insertelement <2 x ptr> poison, ptr %incdec.ptr2.i.i.19, i32 0
  %48 = insertelement <2 x ptr> %47, ptr %__last.addr.0.i.i.19, i32 1
  %49 = getelementptr i8, <2 x ptr> %48, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.20 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.19, i32 4
  %50 = load float, ptr %incdec.ptr2.i.i.20, align 4
  %51 = load float, ptr %__last.addr.0.i.i.20, align 4
  store float %51, ptr %incdec.ptr2.i.i.20, align 4
  store float %50, ptr %__last.addr.0.i.i.20, align 4
  %52 = insertelement <2 x ptr> poison, ptr %__last.addr.0.i.i.20, i32 0
  %53 = insertelement <2 x ptr> %52, ptr %incdec.ptr2.i.i.20, i32 1
  %54 = getelementptr i8, <2 x ptr> %53, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.21 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.20, i32 -4
  %55 = getelementptr i8, <2 x ptr> %49, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.21 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.20, i32 4
  %56 = load float, ptr %incdec.ptr2.i.i.21, align 4
  %57 = load float, ptr %__last.addr.0.i.i.21, align 4
  store float %57, ptr %incdec.ptr2.i.i.21, align 4
  store float %56, ptr %__last.addr.0.i.i.21, align 4
  %58 = getelementptr i8, <2 x ptr> %54, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.22 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.21, i32 -4
  %59 = getelementptr i8, <2 x ptr> %55, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.22 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.21, i32 4
  %60 = load float, ptr %incdec.ptr2.i.i.22, align 4
  %61 = load float, ptr %__last.addr.0.i.i.22, align 4
  store float %61, ptr %incdec.ptr2.i.i.22, align 4
  store float %60, ptr %__last.addr.0.i.i.22, align 4
  %62 = getelementptr i8, <2 x ptr> %58, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.23 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.22, i32 -4
  %63 = getelementptr i8, <2 x ptr> %59, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.23 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.22, i32 4
  %64 = load float, ptr %incdec.ptr2.i.i.23, align 4
  %65 = load float, ptr %__last.addr.0.i.i.23, align 4
  store float %65, ptr %incdec.ptr2.i.i.23, align 4
  store float %64, ptr %__last.addr.0.i.i.23, align 4
  %66 = getelementptr i8, <2 x ptr> %62, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.24 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.23, i32 -4
  %67 = getelementptr i8, <2 x ptr> %63, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.24 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.23, i32 4
  %68 = load float, ptr %incdec.ptr2.i.i.24, align 4
  %69 = load float, ptr %__last.addr.0.i.i.24, align 4
  store float %69, ptr %incdec.ptr2.i.i.24, align 4
  store float %68, ptr %__last.addr.0.i.i.24, align 4
  %70 = getelementptr i8, <2 x ptr> %66, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.25 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.24, i32 -4
  %71 = getelementptr i8, <2 x ptr> %67, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.25 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.24, i32 4
  %72 = load float, ptr %incdec.ptr2.i.i.25, align 4
  %73 = load float, ptr %__last.addr.0.i.i.25, align 4
  store float %73, ptr %incdec.ptr2.i.i.25, align 4
  store float %72, ptr %__last.addr.0.i.i.25, align 4
  %74 = getelementptr i8, <2 x ptr> %70, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.26 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.25, i32 -4
  %75 = getelementptr i8, <2 x ptr> %71, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.26 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.25, i32 4
  %76 = load float, ptr %incdec.ptr2.i.i.26, align 4
  %77 = load float, ptr %__last.addr.0.i.i.26, align 4
  store float %77, ptr %incdec.ptr2.i.i.26, align 4
  store float %76, ptr %__last.addr.0.i.i.26, align 4
  %78 = getelementptr i8, <2 x ptr> %74, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.27 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.26, i32 -4
  %79 = getelementptr i8, <2 x ptr> %75, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.27 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.26, i32 4
  %80 = load float, ptr %incdec.ptr2.i.i.27, align 4
  %81 = load float, ptr %__last.addr.0.i.i.27, align 4
  store float %81, ptr %incdec.ptr2.i.i.27, align 4
  store float %80, ptr %__last.addr.0.i.i.27, align 4
  %82 = getelementptr i8, <2 x ptr> %78, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.28 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.27, i32 -4
  %83 = getelementptr i8, <2 x ptr> %79, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.28 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.27, i32 4
  %84 = load float, ptr %incdec.ptr2.i.i.28, align 4
  %85 = load float, ptr %__last.addr.0.i.i.28, align 4
  store float %85, ptr %incdec.ptr2.i.i.28, align 4
  store float %84, ptr %__last.addr.0.i.i.28, align 4
  %86 = getelementptr i8, <2 x ptr> %82, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.29 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.28, i32 -4
  %87 = getelementptr i8, <2 x ptr> %83, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.29 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.28, i32 4
  %88 = load float, ptr %incdec.ptr2.i.i.29, align 4
  %89 = load float, ptr %__last.addr.0.i.i.29, align 4
  store float %89, ptr %incdec.ptr2.i.i.29, align 4
  store float %88, ptr %__last.addr.0.i.i.29, align 4
  %90 = getelementptr i8, <2 x ptr> %86, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.30 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.29, i32 -4
  %91 = getelementptr i8, <2 x ptr> %87, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.30 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.29, i32 4
  %92 = load float, ptr %incdec.ptr2.i.i.30, align 4
  %93 = load float, ptr %__last.addr.0.i.i.30, align 4
  store float %93, ptr %incdec.ptr2.i.i.30, align 4
  store float %92, ptr %__last.addr.0.i.i.30, align 4
  %94 = getelementptr i8, <2 x ptr> %90, <2 x i32> <i32 -4, i32 4>
  %__last.addr.0.i.i.31 = getelementptr inbounds i8, ptr %__last.addr.0.i.i.30, i32 -4
  %95 = getelementptr i8, <2 x ptr> %91, <2 x i32> <i32 4, i32 -4>
  %incdec.ptr2.i.i.31 = getelementptr inbounds nuw i8, ptr %incdec.ptr2.i.i.30, i32 4
  %cmp1.i.i.31 = icmp ult ptr %incdec.ptr2.i.i.31, %__last.addr.0.i.i.31
  br i1 %cmp1.i.i.31, label %while.body.i.i, label %invoke.cont21.exitStub

invoke.cont21.exitStub:                           ; preds = %while.body.i.i
  ret void
}

attributes #0 = { "target-features"="+v" }
