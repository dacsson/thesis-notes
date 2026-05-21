; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/vec3-base.ll
; Variant: riscv64_+m,+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2 -mtriple=riscv64 -mattr=+m,+v -S
; Original: RUN: opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2 -mtriple=riscv64 -mattr=+m,+v -S %s | FileCheck --check-prefixes=CHECK,NON-POW2 %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @v3_load_i32_mul_by_constant_store(ptr %src, ptr %dst) {
entry:
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %l.src.0 = load i32, ptr %gep.src.0, align 4
  %mul.0 = mul nsw i32 %l.src.0, 10

  %gep.src.1 = getelementptr inbounds i32, ptr %src, i32 1
  %l.src.1 = load i32, ptr %gep.src.1, align 4
  %mul.1 = mul nsw i32 %l.src.1, 10

  %gep.src.2 = getelementptr inbounds i32, ptr %src, i32 2
  %l.src.2 = load i32, ptr %gep.src.2, align 4
  %mul.2 = mul nsw i32 %l.src.2, 10

  store i32 %mul.0, ptr %dst

  %dst.1 = getelementptr i32, ptr %dst, i32 1
  store i32 %mul.1, ptr %dst.1

  %dst.2 = getelementptr i32, ptr %dst, i32 2
  store i32 %mul.2, ptr %dst.2

  ret void
}

; Should no be vectorized with a undef/poison element as padding, as
; division by undef/poison may cause UB.  Must use VL predication or
; masking instead, where RISCV wins.
define void @v3_load_i32_udiv_by_constant_store(ptr %src, ptr %dst) {
entry:
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %l.src.0 = load i32, ptr %gep.src.0, align 4
  %mul.0 = udiv i32 10, %l.src.0

  %gep.src.1 = getelementptr inbounds i32, ptr %src, i32 1
  %l.src.1 = load i32, ptr %gep.src.1, align 4
  %mul.1 = udiv i32 10, %l.src.1

  %gep.src.2 = getelementptr inbounds i32, ptr %src, i32 2
  %l.src.2 = load i32, ptr %gep.src.2, align 4
  %mul.2 = udiv i32 10, %l.src.2

  store i32 %mul.0, ptr %dst

  %dst.1 = getelementptr i32, ptr %dst, i32 1
  store i32 %mul.1, ptr %dst.1

  %dst.2 = getelementptr i32, ptr %dst, i32 2
  store i32 %mul.2, ptr %dst.2

  ret void
}



define void @v3_load_i32_mul_store(ptr %src.1, ptr %src.2, ptr %dst) {
entry:
  %gep.src.1.0 = getelementptr inbounds i32, ptr %src.1, i32 0
  %l.src.1.0 = load i32, ptr %gep.src.1.0, align 4
  %gep.src.2.0 = getelementptr inbounds i32, ptr %src.2, i32 0
  %l.src.2.0 = load i32, ptr %gep.src.2.0, align 4
  %mul.0 = mul nsw i32 %l.src.1.0, %l.src.2.0

  %gep.src.1.1 = getelementptr inbounds i32, ptr %src.1, i32 1
  %l.src.1.1 = load i32, ptr %gep.src.1.1, align 4
  %gep.src.2.1 = getelementptr inbounds i32, ptr %src.2, i32 1
  %l.src.2.1 = load i32, ptr %gep.src.2.1, align 4
  %mul.1 = mul nsw i32 %l.src.1.1, %l.src.2.1

  %gep.src.1.2 = getelementptr inbounds i32, ptr %src.1, i32 2
  %l.src.1.2 = load i32, ptr %gep.src.1.2, align 4
  %gep.src.2.2 = getelementptr inbounds i32, ptr %src.2, i32 2
  %l.src.2.2 = load i32, ptr %gep.src.2.2, align 4
  %mul.2 = mul nsw i32 %l.src.1.2, %l.src.2.2

  store i32 %mul.0, ptr %dst

  %dst.1 = getelementptr i32, ptr %dst, i32 1
  store i32 %mul.1, ptr %dst.1

  %dst.2 = getelementptr i32, ptr %dst, i32 2
  store i32 %mul.2, ptr %dst.2

  ret void
}

define void @v3_load_i32_mul_add_const_store(ptr %src.1, ptr %src.2, ptr %dst) {
entry:
  %gep.src.1.0 = getelementptr inbounds i32, ptr %src.1, i32 0
  %l.src.1.0 = load i32, ptr %gep.src.1.0, align 4
  %gep.src.2.0 = getelementptr inbounds i32, ptr %src.2, i32 0
  %l.src.2.0 = load i32, ptr %gep.src.2.0, align 4
  %mul.0 = mul nsw i32 %l.src.1.0, %l.src.2.0
  %add.0 = add i32 %mul.0, 9

  %gep.src.1.1 = getelementptr inbounds i32, ptr %src.1, i32 1
  %l.src.1.1 = load i32, ptr %gep.src.1.1, align 4
  %gep.src.2.1 = getelementptr inbounds i32, ptr %src.2, i32 1
  %l.src.2.1 = load i32, ptr %gep.src.2.1, align 4
  %mul.1 = mul nsw i32 %l.src.1.1, %l.src.2.1
  %add.1 = add i32 %mul.1, 9

  %gep.src.1.2 = getelementptr inbounds i32, ptr %src.1, i32 2
  %l.src.1.2 = load i32, ptr %gep.src.1.2, align 4
  %gep.src.2.2 = getelementptr inbounds i32, ptr %src.2, i32 2
  %l.src.2.2 = load i32, ptr %gep.src.2.2, align 4
  %mul.2 = mul nsw i32 %l.src.1.2, %l.src.2.2
  %add.2 = add i32 %mul.2, 9

  store i32 %add.0, ptr %dst

  %dst.1 = getelementptr i32, ptr %dst, i32 1
  store i32 %add.1, ptr %dst.1

  %dst.2 = getelementptr i32, ptr %dst, i32 2
  store i32 %add.2, ptr %dst.2

  ret void
}

define void @v3_load_f32_fadd_fadd_by_constant_store(ptr %src, ptr %dst) {
entry:
  %gep.src.0 = getelementptr inbounds float, ptr %src, i32 0
  %l.src.0 = load float , ptr %gep.src.0, align 4
  %fadd.0 = fadd float %l.src.0, 10.0

  %gep.src.1 = getelementptr inbounds float , ptr %src, i32 1
  %l.src.1 = load float, ptr %gep.src.1, align 4
  %fadd.1 = fadd float %l.src.1, 10.0

  %gep.src.2 = getelementptr inbounds float, ptr %src, i32 2
  %l.src.2 = load float, ptr %gep.src.2, align 4
  %fadd.2 = fadd float %l.src.2, 10.0

  store float %fadd.0, ptr %dst

  %dst.1 = getelementptr float, ptr %dst, i32 1
  store float %fadd.1, ptr %dst.1

  %dst.2 = getelementptr float, ptr %dst, i32 2
  store float %fadd.2, ptr %dst.2

  ret void
}

define void @phi_store3(ptr %dst) {
entry:
  br label %exit

invoke.cont8.loopexit:                            ; No predecessors!
  br label %exit

exit:
  %p.0 = phi i32 [ 1, %entry ], [ 0, %invoke.cont8.loopexit ]
  %p.1 = phi i32 [ 2, %entry ], [ 0, %invoke.cont8.loopexit ]
  %p.2 = phi i32 [ 3, %entry ], [ 0, %invoke.cont8.loopexit ]

  %dst.1 = getelementptr i32, ptr %dst, i32 1
  %dst.2 = getelementptr i32, ptr %dst, i32 2

  store i32 %p.0, ptr %dst, align 4
  store i32 %p.1, ptr %dst.1, align 4
  store i32 %p.2, ptr %dst.2, align 4
  ret void
}

define void @store_try_reorder(ptr %dst) {
entry:
  %add = add i32 0, 0
  store i32 %add, ptr %dst, align 4
  %add207 = sub i32 0, 0
  %arrayidx.i1887 = getelementptr i32, ptr %dst, i64 1
  store i32 %add207, ptr %arrayidx.i1887, align 4
  %add216 = sub i32 0, 0
  %arrayidx.i1891 = getelementptr i32, ptr %dst, i64 2
  store i32 %add216, ptr %arrayidx.i1891, align 4
  ret void
}

define void @vec3_fpext_cost(ptr %Colour, float %0) {
entry:
  %arrayidx72 = getelementptr float, ptr %Colour, i64 1
  %arrayidx80 = getelementptr float, ptr %Colour, i64 2
  %conv62 = fpext float %0 to double
  %1 = call double @llvm.fmuladd.f64(double %conv62, double 0.000000e+00, double 0.000000e+00)
  %conv66 = fptrunc double %1 to float
  store float %conv66, ptr %Colour, align 4
  %conv70 = fpext float %0 to double
  %2 = call double @llvm.fmuladd.f64(double %conv70, double 0.000000e+00, double 0.000000e+00)
  %conv74 = fptrunc double %2 to float
  store float %conv74, ptr %arrayidx72, align 4
  %conv78 = fpext float %0 to double
  %3 = call double @llvm.fmuladd.f64(double %conv78, double 0.000000e+00, double 0.000000e+00)
  %conv82 = fptrunc double %3 to float
  store float %conv82, ptr %arrayidx80, align 4
  ret void
}

define void @fpext_scatter(ptr %dst, double %conv) {
entry:
  %conv25 = fptrunc double %conv to float
  %Lengths = getelementptr float, ptr %dst, i64 0
  store float %conv25, ptr %Lengths, align 4
  %arrayidx32 = getelementptr float, ptr %dst, i64 1
  store float %conv25, ptr %arrayidx32, align 4
  %arrayidx37 = getelementptr float, ptr %dst, i64 2
  store float %conv25, ptr %arrayidx37, align 4
  ret void
}

define i32 @reduce_add(ptr %src) {
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %l.src.0 = load i32, ptr %gep.src.0, align 4
  %gep.src.1 = getelementptr inbounds i32, ptr %src, i32 1
  %l.src.1 = load i32, ptr %gep.src.1, align 4
  %gep.src.2 = getelementptr inbounds i32, ptr %src, i32 2
  %l.src.2 = load i32, ptr %gep.src.2, align 4

  %add.0 = add i32 %l.src.0, %l.src.1
  %add.1 = add i32 %add.0, %l.src.2
  ret i32 %add.1
}

define float @reduce_fadd(ptr %src) {
  %gep.src.0 = getelementptr inbounds float, ptr %src, i32 0
  %l.src.0 = load float, ptr %gep.src.0, align 4
  %gep.src.1 = getelementptr inbounds float, ptr %src, i32 1
  %l.src.1 = load float, ptr %gep.src.1, align 4
  %gep.src.2 = getelementptr inbounds float, ptr %src, i32 2
  %l.src.2 = load float, ptr %gep.src.2, align 4

  %add.0 = fadd fast float %l.src.0, %l.src.1
  %add.1 = fadd fast float %add.0, %l.src.2
  ret float %add.1
}

define i32 @reduce_add_after_mul(ptr %src) {
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %l.src.0 = load i32, ptr %gep.src.0, align 4
  %gep.src.1 = getelementptr inbounds i32, ptr %src, i32 1
  %l.src.1 = load i32, ptr %gep.src.1, align 4
  %gep.src.2 = getelementptr inbounds i32, ptr %src, i32 2
  %l.src.2 = load i32, ptr %gep.src.2, align 4

  %mul.0 = mul nsw i32 %l.src.0, 10
  %mul.1 = mul nsw i32 %l.src.1, 10
  %mul.2 = mul nsw i32 %l.src.2, 10

  %add.0 = add i32 %mul.0, %mul.1
  %add.1 = add i32 %add.0, %mul.2
  ret i32 %add.1
}

define i32 @dot_product_i32(ptr %a, ptr %b) {
  %gep.a.0 = getelementptr inbounds i32, ptr %a, i32 0
  %l.a.0 = load i32, ptr %gep.a.0, align 4
  %gep.a.1 = getelementptr inbounds i32, ptr %a, i32 1
  %l.a.1 = load i32, ptr %gep.a.1, align 4
  %gep.a.2 = getelementptr inbounds i32, ptr %a, i32 2
  %l.a.2 = load i32, ptr %gep.a.2, align 4

  %gep.b.0 = getelementptr inbounds i32, ptr %b, i32 0
  %l.b.0 = load i32, ptr %gep.b.0, align 4
  %gep.b.1 = getelementptr inbounds i32, ptr %b, i32 1
  %l.b.1 = load i32, ptr %gep.b.1, align 4
  %gep.b.2 = getelementptr inbounds i32, ptr %b, i32 2
  %l.b.2 = load i32, ptr %gep.b.2, align 4

  %mul.0 = mul nsw i32 %l.a.0, %l.b.0
  %mul.1 = mul nsw i32 %l.a.1, %l.b.1
  %mul.2 = mul nsw i32 %l.a.2, %l.b.2

  %add.0 = add i32 %mul.0, %mul.1
  %add.1 = add i32 %add.0, %mul.2
  ret i32 %add.1
}

; Same as above, except the reduction order has been perturbed.  This
; is checking for our ability to reorder.
define i32 @dot_product_i32_reorder(ptr %a, ptr %b) {
  %gep.a.0 = getelementptr inbounds i32, ptr %a, i32 0
  %l.a.0 = load i32, ptr %gep.a.0, align 4
  %gep.a.1 = getelementptr inbounds i32, ptr %a, i32 1
  %l.a.1 = load i32, ptr %gep.a.1, align 4
  %gep.a.2 = getelementptr inbounds i32, ptr %a, i32 2
  %l.a.2 = load i32, ptr %gep.a.2, align 4

  %gep.b.0 = getelementptr inbounds i32, ptr %b, i32 0
  %l.b.0 = load i32, ptr %gep.b.0, align 4
  %gep.b.1 = getelementptr inbounds i32, ptr %b, i32 1
  %l.b.1 = load i32, ptr %gep.b.1, align 4
  %gep.b.2 = getelementptr inbounds i32, ptr %b, i32 2
  %l.b.2 = load i32, ptr %gep.b.2, align 4

  %mul.0 = mul nsw i32 %l.a.0, %l.b.0
  %mul.1 = mul nsw i32 %l.a.1, %l.b.1
  %mul.2 = mul nsw i32 %l.a.2, %l.b.2

  %add.0 = add i32 %mul.1, %mul.0
  %add.1 = add i32 %add.0, %mul.2
  ret i32 %add.1
}

define float @dot_product_fp32(ptr %a, ptr %b) {
  %gep.a.0 = getelementptr inbounds float, ptr %a, i32 0
  %l.a.0 = load float, ptr %gep.a.0, align 4
  %gep.a.1 = getelementptr inbounds float, ptr %a, i32 1
  %l.a.1 = load float, ptr %gep.a.1, align 4
  %gep.a.2 = getelementptr inbounds float, ptr %a, i32 2
  %l.a.2 = load float, ptr %gep.a.2, align 4

  %gep.b.0 = getelementptr inbounds float, ptr %b, i32 0
  %l.b.0 = load float, ptr %gep.b.0, align 4
  %gep.b.1 = getelementptr inbounds float, ptr %b, i32 1
  %l.b.1 = load float, ptr %gep.b.1, align 4
  %gep.b.2 = getelementptr inbounds float, ptr %b, i32 2
  %l.b.2 = load float, ptr %gep.b.2, align 4

  %mul.0 = fmul fast float %l.a.0, %l.b.0
  %mul.1 = fmul fast float %l.a.1, %l.b.1
  %mul.2 = fmul fast float %l.a.2, %l.b.2

  %add.0 = fadd fast float %mul.0, %mul.1
  %add.1 = fadd fast float %add.0, %mul.2
  ret float %add.1
}

; Same as above, except the reduction order has been perturbed.  This
; is checking for our ability to reorder.
define float @dot_product_fp32_reorder(ptr %a, ptr %b) {
  %gep.a.0 = getelementptr inbounds float, ptr %a, i32 0
  %l.a.0 = load float, ptr %gep.a.0, align 4
  %gep.a.1 = getelementptr inbounds float, ptr %a, i32 1
  %l.a.1 = load float, ptr %gep.a.1, align 4
  %gep.a.2 = getelementptr inbounds float, ptr %a, i32 2
  %l.a.2 = load float, ptr %gep.a.2, align 4

  %gep.b.0 = getelementptr inbounds float, ptr %b, i32 0
  %l.b.0 = load float, ptr %gep.b.0, align 4
  %gep.b.1 = getelementptr inbounds float, ptr %b, i32 1
  %l.b.1 = load float, ptr %gep.b.1, align 4
  %gep.b.2 = getelementptr inbounds float, ptr %b, i32 2
  %l.b.2 = load float, ptr %gep.b.2, align 4

  %mul.0 = fmul fast float %l.a.0, %l.b.0
  %mul.1 = fmul fast float %l.a.1, %l.b.1
  %mul.2 = fmul fast float %l.a.2, %l.b.2

  %add.0 = fadd fast float %mul.1, %mul.0
  %add.1 = fadd fast float %add.0, %mul.2
  ret float %add.1
}


define double @dot_product_fp64(ptr %a, ptr %b) {
  %gep.a.0 = getelementptr inbounds double, ptr %a, i32 0
  %l.a.0 = load double, ptr %gep.a.0, align 4
  %gep.a.1 = getelementptr inbounds double, ptr %a, i32 1
  %l.a.1 = load double, ptr %gep.a.1, align 4
  %gep.a.2 = getelementptr inbounds double, ptr %a, i32 2
  %l.a.2 = load double, ptr %gep.a.2, align 4

  %gep.b.0 = getelementptr inbounds double, ptr %b, i32 0
  %l.b.0 = load double, ptr %gep.b.0, align 4
  %gep.b.1 = getelementptr inbounds double, ptr %b, i32 1
  %l.b.1 = load double, ptr %gep.b.1, align 4
  %gep.b.2 = getelementptr inbounds double, ptr %b, i32 2
  %l.b.2 = load double, ptr %gep.b.2, align 4

  %mul.0 = fmul fast double %l.a.0, %l.b.0
  %mul.1 = fmul fast double %l.a.1, %l.b.1
  %mul.2 = fmul fast double %l.a.2, %l.b.2

  %add.0 = fadd fast double %mul.0, %mul.1
  %add.1 = fadd fast double %add.0, %mul.2
  ret double %add.1
}

;; Covers a case where SLP would previous crash due to a
;; missing bailout in TryToFindDuplicates for the case
;; where a VL=3 list was vectorized directly (without
;; a root instruction such as a store or reduce).
define double @no_root_reshuffle(ptr  %ptr) {
entry:
  %0 = load double, ptr %ptr, align 8
  %mul = fmul fast double %0, %0
  %arrayidx2 = getelementptr inbounds i8, ptr %ptr, i64 8
  %1 = load double, ptr %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds i8, ptr %ptr, i64 16
  %2 = load double, ptr %arrayidx3, align 8
  %3 = fmul fast double %2, %2
  %mul6 = fmul fast double %3, %1
  %add = fadd fast double %mul6, %mul
  ret double %add
}

define float @reduce_fadd_after_fmul_of_buildvec(float %a, float %b, float %c) {
  %mul.0 = fmul fast float %a, 10.0
  %mul.1 = fmul fast float %b, 10.0
  %mul.2 = fmul fast float %c, 10.0

  %add.0 = fadd fast float %mul.0, %mul.1
  %add.1 = fadd fast float %add.0, %mul.2
  ret float %add.1
}


declare float @llvm.fmuladd.f32(float, float, float)

declare double @llvm.fmuladd.f64(double, double, double)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpwjf8k6w1.ll'
source_filename = "/tmp/tmpwjf8k6w1.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @v3_load_i32_mul_by_constant_store(ptr %src, ptr %dst) #0 {
entry:
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %0 = load <3 x i32>, ptr %gep.src.0, align 4
  %1 = mul nsw <3 x i32> %0, splat (i32 10)
  store <3 x i32> %1, ptr %dst, align 4
  ret void
}

define void @v3_load_i32_udiv_by_constant_store(ptr %src, ptr %dst) #0 {
entry:
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %0 = load <3 x i32>, ptr %gep.src.0, align 4
  %1 = udiv <3 x i32> splat (i32 10), %0
  store <3 x i32> %1, ptr %dst, align 4
  ret void
}

define void @v3_load_i32_mul_store(ptr %src.1, ptr %src.2, ptr %dst) #0 {
entry:
  %gep.src.1.0 = getelementptr inbounds i32, ptr %src.1, i32 0
  %gep.src.2.0 = getelementptr inbounds i32, ptr %src.2, i32 0
  %0 = load <3 x i32>, ptr %gep.src.1.0, align 4
  %1 = load <3 x i32>, ptr %gep.src.2.0, align 4
  %2 = mul nsw <3 x i32> %0, %1
  store <3 x i32> %2, ptr %dst, align 4
  ret void
}

define void @v3_load_i32_mul_add_const_store(ptr %src.1, ptr %src.2, ptr %dst) #0 {
entry:
  %gep.src.1.0 = getelementptr inbounds i32, ptr %src.1, i32 0
  %gep.src.2.0 = getelementptr inbounds i32, ptr %src.2, i32 0
  %0 = load <3 x i32>, ptr %gep.src.1.0, align 4
  %1 = load <3 x i32>, ptr %gep.src.2.0, align 4
  %2 = mul nsw <3 x i32> %0, %1
  %3 = add <3 x i32> %2, splat (i32 9)
  store <3 x i32> %3, ptr %dst, align 4
  ret void
}

define void @v3_load_f32_fadd_fadd_by_constant_store(ptr %src, ptr %dst) #0 {
entry:
  %gep.src.0 = getelementptr inbounds float, ptr %src, i32 0
  %0 = load <3 x float>, ptr %gep.src.0, align 4
  %1 = fadd <3 x float> %0, splat (float 1.000000e+01)
  store <3 x float> %1, ptr %dst, align 4
  ret void
}

define void @phi_store3(ptr %dst) #0 {
entry:
  br label %exit

invoke.cont8.loopexit:                            ; No predecessors!
  br label %exit

exit:                                             ; preds = %invoke.cont8.loopexit, %entry
  %0 = phi <3 x i32> [ <i32 1, i32 2, i32 3>, %entry ], [ poison, %invoke.cont8.loopexit ]
  store <3 x i32> %0, ptr %dst, align 4
  ret void
}

define void @store_try_reorder(ptr %dst) #0 {
entry:
  store <3 x i32> zeroinitializer, ptr %dst, align 4
  ret void
}

define void @vec3_fpext_cost(ptr %Colour, float %0) #0 {
entry:
  %1 = insertelement <3 x float> poison, float %0, i32 0
  %2 = shufflevector <3 x float> %1, <3 x float> poison, <3 x i32> zeroinitializer
  %3 = fpext <3 x float> %2 to <3 x double>
  %4 = call <3 x double> @llvm.fmuladd.v3f64(<3 x double> %3, <3 x double> zeroinitializer, <3 x double> zeroinitializer)
  %5 = fptrunc <3 x double> %4 to <3 x float>
  store <3 x float> %5, ptr %Colour, align 4
  ret void
}

define void @fpext_scatter(ptr %dst, double %conv) #0 {
entry:
  %conv25 = fptrunc double %conv to float
  %Lengths = getelementptr float, ptr %dst, i64 0
  store float %conv25, ptr %Lengths, align 4
  %arrayidx32 = getelementptr float, ptr %dst, i64 1
  store float %conv25, ptr %arrayidx32, align 4
  %arrayidx37 = getelementptr float, ptr %dst, i64 2
  store float %conv25, ptr %arrayidx37, align 4
  ret void
}

define i32 @reduce_add(ptr %src) #0 {
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %l.src.0 = load i32, ptr %gep.src.0, align 4
  %gep.src.1 = getelementptr inbounds i32, ptr %src, i32 1
  %l.src.1 = load i32, ptr %gep.src.1, align 4
  %gep.src.2 = getelementptr inbounds i32, ptr %src, i32 2
  %l.src.2 = load i32, ptr %gep.src.2, align 4
  %add.0 = add i32 %l.src.0, %l.src.1
  %add.1 = add i32 %add.0, %l.src.2
  ret i32 %add.1
}

define float @reduce_fadd(ptr %src) #0 {
  %gep.src.0 = getelementptr inbounds float, ptr %src, i32 0
  %1 = load <3 x float>, ptr %gep.src.0, align 4
  %2 = call fast float @llvm.vector.reduce.fadd.v3f32(float 0.000000e+00, <3 x float> %1)
  ret float %2
}

define i32 @reduce_add_after_mul(ptr %src) #0 {
  %gep.src.0 = getelementptr inbounds i32, ptr %src, i32 0
  %1 = load <3 x i32>, ptr %gep.src.0, align 4
  %2 = mul nsw <3 x i32> %1, splat (i32 10)
  %3 = call i32 @llvm.vector.reduce.add.v3i32(<3 x i32> %2)
  ret i32 %3
}

define i32 @dot_product_i32(ptr %a, ptr %b) #0 {
  %gep.a.0 = getelementptr inbounds i32, ptr %a, i32 0
  %gep.b.0 = getelementptr inbounds i32, ptr %b, i32 0
  %1 = load <3 x i32>, ptr %gep.a.0, align 4
  %2 = load <3 x i32>, ptr %gep.b.0, align 4
  %3 = mul nsw <3 x i32> %1, %2
  %4 = call i32 @llvm.vector.reduce.add.v3i32(<3 x i32> %3)
  ret i32 %4
}

define i32 @dot_product_i32_reorder(ptr %a, ptr %b) #0 {
  %gep.a.0 = getelementptr inbounds i32, ptr %a, i32 0
  %gep.b.0 = getelementptr inbounds i32, ptr %b, i32 0
  %1 = load <3 x i32>, ptr %gep.a.0, align 4
  %2 = load <3 x i32>, ptr %gep.b.0, align 4
  %3 = mul nsw <3 x i32> %1, %2
  %4 = call i32 @llvm.vector.reduce.add.v3i32(<3 x i32> %3)
  ret i32 %4
}

define float @dot_product_fp32(ptr %a, ptr %b) #0 {
  %gep.a.0 = getelementptr inbounds float, ptr %a, i32 0
  %gep.b.0 = getelementptr inbounds float, ptr %b, i32 0
  %1 = load <3 x float>, ptr %gep.a.0, align 4
  %2 = load <3 x float>, ptr %gep.b.0, align 4
  %3 = fmul fast <3 x float> %1, %2
  %4 = call fast float @llvm.vector.reduce.fadd.v3f32(float 0.000000e+00, <3 x float> %3)
  ret float %4
}

define float @dot_product_fp32_reorder(ptr %a, ptr %b) #0 {
  %gep.a.0 = getelementptr inbounds float, ptr %a, i32 0
  %gep.b.0 = getelementptr inbounds float, ptr %b, i32 0
  %1 = load <3 x float>, ptr %gep.a.0, align 4
  %2 = load <3 x float>, ptr %gep.b.0, align 4
  %3 = fmul fast <3 x float> %1, %2
  %4 = call fast float @llvm.vector.reduce.fadd.v3f32(float 0.000000e+00, <3 x float> %3)
  ret float %4
}

define double @dot_product_fp64(ptr %a, ptr %b) #0 {
  %gep.a.0 = getelementptr inbounds double, ptr %a, i32 0
  %l.a.0 = load double, ptr %gep.a.0, align 4
  %gep.a.1 = getelementptr inbounds double, ptr %a, i32 1
  %l.a.1 = load double, ptr %gep.a.1, align 4
  %gep.a.2 = getelementptr inbounds double, ptr %a, i32 2
  %l.a.2 = load double, ptr %gep.a.2, align 4
  %gep.b.0 = getelementptr inbounds double, ptr %b, i32 0
  %l.b.0 = load double, ptr %gep.b.0, align 4
  %gep.b.1 = getelementptr inbounds double, ptr %b, i32 1
  %l.b.1 = load double, ptr %gep.b.1, align 4
  %gep.b.2 = getelementptr inbounds double, ptr %b, i32 2
  %l.b.2 = load double, ptr %gep.b.2, align 4
  %mul.0 = fmul fast double %l.a.0, %l.b.0
  %mul.1 = fmul fast double %l.a.1, %l.b.1
  %mul.2 = fmul fast double %l.a.2, %l.b.2
  %add.0 = fadd fast double %mul.0, %mul.1
  %add.1 = fadd fast double %add.0, %mul.2
  ret double %add.1
}

define double @no_root_reshuffle(ptr %ptr) #0 {
entry:
  %0 = load double, ptr %ptr, align 8
  %mul = fmul fast double %0, %0
  %arrayidx2 = getelementptr inbounds i8, ptr %ptr, i64 8
  %1 = load double, ptr %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds i8, ptr %ptr, i64 16
  %2 = load double, ptr %arrayidx3, align 8
  %3 = fmul fast double %2, %2
  %mul6 = fmul fast double %3, %1
  %add = fadd fast double %mul6, %mul
  ret double %add
}

define float @reduce_fadd_after_fmul_of_buildvec(float %a, float %b, float %c) #0 {
  %mul.0 = fmul fast float %a, 1.000000e+01
  %mul.1 = fmul fast float %b, 1.000000e+01
  %mul.2 = fmul fast float %c, 1.000000e+01
  %add.0 = fadd fast float %mul.0, %mul.1
  %add.1 = fadd fast float %add.0, %mul.2
  ret float %add.1
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <3 x double> @llvm.fmuladd.v3f64(<3 x double>, <3 x double>, <3 x double>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.v3f32(float, <3 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v3i32(<3 x i32>) #2

attributes #0 = { "target-features"="+m,+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+m,+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
