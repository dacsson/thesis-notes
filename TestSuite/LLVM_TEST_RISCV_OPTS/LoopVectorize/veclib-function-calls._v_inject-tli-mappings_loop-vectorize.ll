; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/veclib-function-calls.ll
; Variant: +v_inject-tli-mappings,loop-vectorize
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mattr=+v -vector-library=sleefgnuabi -passes=inject-tli-mappings,loop-vectorize -S
; Original: RUN: opt -mattr=+v -vector-library=sleefgnuabi -passes=inject-tli-mappings,loop-vectorize -S < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


target triple = "riscv64-unknown-linux-gnu"

; We are checking whether loops containing function calls can be vectorized,
; when the compiler provides TLI mappings to their vector variants.

declare double @acos(double)
declare float @acosf(float)

;.
;.
define void @acos_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @acos(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @acos_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @acosf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @acosh(double)
declare float @acoshf(float)

define void @acosh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @acosh(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @acosh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @acoshf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @asin(double)
declare float @asinf(float)

define void @asin_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @asin(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @asin_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @asinf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @asinh(double)
declare float @asinhf(float)

define void @asinh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @asinh(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @asinh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @asinhf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @atan(double)
declare float @atanf(float)

define void @atan_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @atan(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @atan_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @atanf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @atan2(double, double)
declare float @atan2f(float, float)

define void @atan2_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @atan2(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @atan2_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @atan2f(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @atanh(double)
declare float @atanhf(float)

define void @atanh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @atanh(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @atanh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @atanhf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @cbrt(double)
declare float @cbrtf(float)

define void @cbrt_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cbrt(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @cbrt_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @cbrtf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @copysign(double, double)
declare float @copysignf(float, float)

define void @copysign_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @copysign(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @copysign_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @copysignf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @cos(double)
declare float @cosf(float)

define void @cos_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cos(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @cos_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @cosf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @cosh(double)
declare float @coshf(float)

define void @cosh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cosh(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @cosh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @coshf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @cospi(double)
declare float @cospif(float)

define void @cospi_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cospi(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @cospi_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @cospif(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @erf(double)
declare float @erff(float)

define void @erf_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @erf(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @erf_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @erff(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @erfc(double)
declare float @erfcf(float)

define void @erfc_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @erfc(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @erfc_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @erfcf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @exp(double)
declare float @expf(float)

define void @exp_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @exp(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @exp_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @expf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @exp10(double)
declare float @exp10f(float)

define void @exp10_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @exp10(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @exp10_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @exp10f(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @exp2(double)
declare float @exp2f(float)

define void @exp2_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @exp2(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @exp2_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @exp2f(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @expm1(double)
declare float @expm1f(float)

define void @expm1_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @expm1(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @expm1_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @expm1f(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @fdim(double, double)
declare float @fdimf(float, float)

define void @fdim_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fdim(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @fdim_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fdimf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @fma(double, double, double)
declare float @fmaf(float, float, float)

define void @fma_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fma(double %in, double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @fma_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fmaf(float %in, float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @fmax(double, double)
declare float @fmaxf(float, float)

define void @fmax_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fmax(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @fmax_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fmaxf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @fmin(double, double)
declare float @fminf(float, float)

define void @fmin_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fmin(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @fmin_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fminf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @fmod(double, double)
declare float @fmodf(float, float)

define void @fmod_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fmod(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @fmod_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fmodf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @hypot(double, double)
declare float @hypotf(float, float)

define void @hypot_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @hypot(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @hypot_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @hypotf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare i32 @ilogb(double)
declare i32 @ilogbf(float)

define void @ilogb_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call i32 @ilogb(double %in)
  %out.gep = getelementptr inbounds i32, ptr %out.ptr, i64 %iv
  store i32 %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @ilogb_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call i32 @ilogbf(float %in)
  %out.gep = getelementptr inbounds i32, ptr %out.ptr, i64 %iv
  store i32 %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @ldexp(double, i32)
declare float @ldexpf(float, i32)

define void @ldexp_f64(ptr noalias %in1.ptr, ptr noalias %in2.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in1.gep = getelementptr inbounds double, ptr %in1.ptr, i64 %iv
  %in1 = load double, ptr %in1.gep, align 8
  %in2.gep = getelementptr inbounds i32, ptr %in2.ptr, i64 %iv
  %in2 = load i32, ptr %in2.gep, align 8
  %call = tail call double @ldexp(double %in1, i32 %in2)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @ldexp_f32(ptr noalias %in1.ptr, ptr noalias %in2.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in1.gep = getelementptr inbounds float, ptr %in1.ptr, i64 %iv
  %in1 = load float, ptr %in1.gep, align 8
  %in2.gep = getelementptr inbounds i32, ptr %in2.ptr, i64 %iv
  %in2 = load i32, ptr %in2.gep, align 8
  %call = tail call float @ldexpf(float %in1, i32 %in2)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @lgamma(double)
declare float @lgammaf(float)

define void @lgamma_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @lgamma(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @lgamma_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @lgammaf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @log(double)
declare float @logf(float)

define void @log_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @log_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @logf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @log10(double)
declare float @log10f(float)

define void @log10_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log10(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @log10_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @log10f(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @log1p(double)
declare float @log1pf(float)

define void @log1p_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log1p(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @log1p_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @log1pf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @log2(double)
declare float @log2f(float)

define void @log2_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log2(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @log2_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @log2f(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @modf(double, ptr)
declare float @modff(float, ptr)

define void @modf_f64(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr double, ptr %a, i64 %indvars.iv
  %num = load double, ptr %gepa, align 8
  %gepb = getelementptr double, ptr %b, i64 %indvars.iv
  %data = call double @modf(double %num, ptr %gepb)
  %gepc = getelementptr inbounds double, ptr %c, i64 %indvars.iv
  store double %data, ptr %gepc, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @modf_f32(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr float, ptr %a, i64 %indvars.iv
  %num = load float, ptr %gepa, align 8
  %gepb = getelementptr float, ptr %b, i64 %indvars.iv
  %data = call float @modff(float %num, ptr %gepb)
  %gepc = getelementptr inbounds float, ptr %c, i64 %indvars.iv
  store float %data, ptr %gepc, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

declare double @nextafter(double, double)
declare float @nextafterf(float, float)

define void @nextafter_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @nextafter(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @nextafter_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @nextafterf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @pow(double, double)
declare float @powf(float, float)

define void @pow_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @pow(double %in, double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @pow_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @powf(float %in, float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @sin(double)
declare float @sinf(float)

define void @sin_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sin(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @sin_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sinf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare void @sincos(double, ptr, ptr)
declare void @sincosf(float, ptr, ptr)

define void @sincos_f64(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr double, ptr %a, i64 %indvars.iv
  %num = load double, ptr %gepa, align 8
  %gepb = getelementptr double, ptr %b, i64 %indvars.iv
  %gepc = getelementptr double, ptr %c, i64 %indvars.iv
  call void @sincos(double %num, ptr %gepb, ptr %gepc)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @sincos_f32(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr float, ptr %a, i64 %indvars.iv
  %num = load float, ptr %gepa, align 8
  %gepb = getelementptr float, ptr %b, i64 %indvars.iv
  %gepc = getelementptr float, ptr %c, i64 %indvars.iv
  call void @sincosf(float %num, ptr %gepb, ptr %gepc)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

declare void @sincospi(double, ptr, ptr)
declare void @sincospif(float, ptr, ptr)

define void @sincospi_f64(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr double, ptr %a, i64 %indvars.iv
  %num = load double, ptr %gepa, align 8
  %gepb = getelementptr double, ptr %b, i64 %indvars.iv
  %gepc = getelementptr double, ptr %c, i64 %indvars.iv
  call void @sincospi(double %num, ptr %gepb, ptr %gepc)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @sincospi_f32(ptr noalias %a, ptr noalias %b, ptr noalias %c) {
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr float, ptr %a, i64 %indvars.iv
  %num = load float, ptr %gepa, align 8
  %gepb = getelementptr float, ptr %b, i64 %indvars.iv
  %gepc = getelementptr float, ptr %c, i64 %indvars.iv
  call void @sincospif(float %num, ptr %gepb, ptr %gepc)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

declare double @sinh(double)
declare float @sinhf(float)

define void @sinh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sinh(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @sinh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sinhf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @sinpi(double)
declare float @sinpif(float)

define void @sinpi_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sinpi(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @sinpi_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sinpif(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @sqrt(double)
declare float @sqrtf(float)

define void @sqrt_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sqrt(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @sqrt_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sqrtf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @tan(double)
declare float @tanf(float)

define void @tan_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @tan(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @tan_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @tanf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @tanh(double)
declare float @tanhf(float)

define void @tanh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @tanh(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @tanh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @tanhf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

declare double @tgamma(double)
declare float @tgammaf(float)

define void @tgamma_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @tgamma(double %in)
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}

define void @tgamma_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) {
  entry:
  br label %for.body

  for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @tgammaf(float %in)
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body

  for.end:
  ret void
}
;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmphyj62w7v.ll'
source_filename = "/tmp/tmphyj62w7v.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

@llvm.compiler.used = appending global [86 x ptr] [ptr @Sleef_acosdx_u10rvvm2, ptr @Sleef_acosfx_u10rvvm2, ptr @Sleef_acoshdx_u10rvvm2, ptr @Sleef_acoshfx_u10rvvm2, ptr @Sleef_asindx_u10rvvm2, ptr @Sleef_asinfx_u10rvvm2, ptr @Sleef_asinhdx_u10rvvm2, ptr @Sleef_asinhfx_u10rvvm2, ptr @Sleef_atandx_u10rvvm2, ptr @Sleef_atanfx_u10rvvm2, ptr @Sleef_atan2dx_u10rvvm2, ptr @Sleef_atan2fx_u10rvvm2, ptr @Sleef_atanhdx_u10rvvm2, ptr @Sleef_atanhfx_u10rvvm2, ptr @Sleef_cbrtdx_u10rvvm2, ptr @Sleef_cbrtfx_u10rvvm2, ptr @Sleef_copysigndx_rvvm2, ptr @Sleef_copysignfx_rvvm2, ptr @Sleef_cosdx_u10rvvm2, ptr @Sleef_cosfx_u10rvvm2, ptr @Sleef_coshdx_u10rvvm2, ptr @Sleef_coshfx_u10rvvm2, ptr @Sleef_cospidx_u05rvvm2, ptr @Sleef_cospifx_u05rvvm2, ptr @Sleef_erfdx_u10rvvm2, ptr @Sleef_erffx_u10rvvm2, ptr @Sleef_erfcdx_u15rvvm2, ptr @Sleef_erfcfx_u15rvvm2, ptr @Sleef_expdx_u10rvvm2, ptr @Sleef_expfx_u10rvvm2, ptr @Sleef_exp10dx_u10rvvm2, ptr @Sleef_exp10fx_u10rvvm2, ptr @Sleef_exp2dx_u10rvvm2, ptr @Sleef_exp2fx_u10rvvm2, ptr @Sleef_expm1dx_u10rvvm2, ptr @Sleef_expm1fx_u10rvvm2, ptr @Sleef_fdimdx_rvvm2, ptr @Sleef_fdimfx_rvvm2, ptr @Sleef_fmadx_rvvm2, ptr @Sleef_fmafx_rvvm2, ptr @Sleef_fmaxdx_rvvm2, ptr @Sleef_fmaxfx_rvvm2, ptr @Sleef_fmindx_u10rvvm2, ptr @Sleef_fminfx_u10rvvm2, ptr @Sleef_fmoddx_rvvm2, ptr @Sleef_fmodfx_rvvm2, ptr @Sleef_hypotdx_u05rvvm2, ptr @Sleef_hypotfx_u05rvvm2, ptr @Sleef_ilogbdx_rvvm2, ptr @Sleef_ilogbfx_rvvm2, ptr @Sleef_ldexpdx_rvvm2, ptr @Sleef_ldexpfx_rvvm2, ptr @Sleef_lgammadx_u10rvvm2, ptr @Sleef_lgammafx_u10rvvm2, ptr @Sleef_logdx_u10rvvm2, ptr @Sleef_logfx_u10rvvm2, ptr @Sleef_log10dx_u10rvvm2, ptr @Sleef_log10fx_u10rvvm2, ptr @Sleef_log1pdx_u10rvvm2, ptr @Sleef_log1pfx_u10rvvm2, ptr @Sleef_log2dx_u10rvvm2, ptr @Sleef_log2fx_u10rvvm2, ptr @Sleef_modfdx_rvvm2, ptr @Sleef_modffx_rvvm2, ptr @Sleef_nextafterdx_rvvm2, ptr @Sleef_nextafterfx_rvvm2, ptr @Sleef_powdx_u10rvvm2, ptr @Sleef_powfx_u10rvvm2, ptr @Sleef_sindx_u10rvvm2, ptr @Sleef_sinfx_u10rvvm2, ptr @Sleef_sincosdx_u10rvvm2, ptr @Sleef_sincosfx_u10rvvm2, ptr @Sleef_sincospidx_u10rvvm2, ptr @Sleef_sincospifx_u10rvvm2, ptr @Sleef_sinhdx_u10rvvm2, ptr @Sleef_sinhfx_u10rvvm2, ptr @Sleef_sinpidx_u05rvvm2, ptr @Sleef_sinpifx_u05rvvm2, ptr @Sleef_sqrtdx_u05rvvm2, ptr @Sleef_sqrtfx_u05rvvm2, ptr @Sleef_tandx_u10rvvm2, ptr @Sleef_tanfx_u10rvvm2, ptr @Sleef_tanhdx_u10rvvm2, ptr @Sleef_tanhfx_u10rvvm2, ptr @Sleef_tgammadx_u10rvvm2, ptr @Sleef_tgammafx_u10rvvm2], section "llvm.metadata"

declare double @acos(double) #0

declare float @acosf(float) #0

define void @acos_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_acosdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @acos(double %in) #2
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @acos_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_acosfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @acosf(float %in) #3
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !5

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @acosh(double) #0

declare float @acoshf(float) #0

define void @acosh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_acoshdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @acosh(double %in) #4
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !7

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @acosh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_acoshfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @acoshf(float %in) #5
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !9

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @asin(double) #0

declare float @asinf(float) #0

define void @asin_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_asindx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @asin(double %in) #6
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !11

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @asin_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_asinfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !12

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @asinf(float %in) #7
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !13

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @asinh(double) #0

declare float @asinhf(float) #0

define void @asinh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_asinhdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @asinh(double %in) #8
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !15

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @asinh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_asinhfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @asinhf(float %in) #9
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !17

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @atan(double) #0

declare float @atanf(float) #0

define void @atan_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_atandx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @atan(double %in) #10
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !19

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @atan_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_atanfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @atanf(float %in) #11
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !21

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @atan2(double, double) #0

declare float @atan2f(float, float) #0

define void @atan2_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_atan2dx_u10rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @atan2(double %in, double %in) #12
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !23

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @atan2_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_atan2fx_u10rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !24

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @atan2f(float %in, float %in) #13
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !25

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @atanh(double) #0

declare float @atanhf(float) #0

define void @atanh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_atanhdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !26

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @atanh(double %in) #14
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !27

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @atanh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_atanhfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @atanhf(float %in) #15
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !29

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @cbrt(double) #0

declare float @cbrtf(float) #0

define void @cbrt_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_cbrtdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !30

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cbrt(double %in) #16
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !31

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @cbrt_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_cbrtfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !32

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @cbrtf(float %in) #17
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !33

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @copysign(double, double) #0

declare float @copysignf(float, float) #0

define void @copysign_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_copysigndx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !34

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @copysign(double %in, double %in) #18
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !35

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @copysign_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_copysignfx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !36

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @copysignf(float %in, float %in) #19
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !37

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @cos(double) #0

declare float @cosf(float) #0

define void @cos_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_cosdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !38

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cos(double %in) #20
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !39

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @cos_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_cosfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !40

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @cosf(float %in) #21
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !41

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @cosh(double) #0

declare float @coshf(float) #0

define void @cosh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_coshdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !42

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cosh(double %in) #22
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !43

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @cosh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_coshfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !44

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @coshf(float %in) #23
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !45

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @cospi(double) #0

declare float @cospif(float) #0

define void @cospi_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_cospidx_u05rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !46

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @cospi(double %in) #24
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !47

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @cospi_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_cospifx_u05rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !48

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @cospif(float %in) #25
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !49

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @erf(double) #0

declare float @erff(float) #0

define void @erf_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_erfdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !50

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @erf(double %in) #26
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !51

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @erf_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_erffx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !52

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @erff(float %in) #27
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !53

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @erfc(double) #0

declare float @erfcf(float) #0

define void @erfc_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_erfcdx_u15rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !54

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @erfc(double %in) #28
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !55

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @erfc_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_erfcfx_u15rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !56

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @erfcf(float %in) #29
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !57

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @exp(double) #0

declare float @expf(float) #0

define void @exp_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_expdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !58

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @exp(double %in) #30
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !59

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @exp_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_expfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !60

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @expf(float %in) #31
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !61

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @exp10(double) #0

declare float @exp10f(float) #0

define void @exp10_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_exp10dx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !62

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @exp10(double %in) #32
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !63

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @exp10_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_exp10fx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !64

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @exp10f(float %in) #33
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !65

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @exp2(double) #0

declare float @exp2f(float) #0

define void @exp2_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_exp2dx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !66

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @exp2(double %in) #34
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !67

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @exp2_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_exp2fx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !68

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @exp2f(float %in) #35
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !69

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @expm1(double) #0

declare float @expm1f(float) #0

define void @expm1_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_expm1dx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !70

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @expm1(double %in) #36
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !71

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @expm1_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_expm1fx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !72

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @expm1f(float %in) #37
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !73

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @fdim(double, double) #0

declare float @fdimf(float, float) #0

define void @fdim_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_fdimdx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !74

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fdim(double %in, double %in) #38
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !75

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @fdim_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_fdimfx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !76

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fdimf(float %in, float %in) #39
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !77

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @fma(double, double, double) #0

declare float @fmaf(float, float, float) #0

define void @fma_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_fmadx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !78

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fma(double %in, double %in, double %in) #40
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !79

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @fma_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_fmafx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !80

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fmaf(float %in, float %in, float %in) #41
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !81

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @fmax(double, double) #0

declare float @fmaxf(float, float) #0

define void @fmax_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_fmaxdx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !82

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fmax(double %in, double %in) #42
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !83

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @fmax_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_fmaxfx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !84

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fmaxf(float %in, float %in) #43
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !85

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @fmin(double, double) #0

declare float @fminf(float, float) #0

define void @fmin_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_fmindx_u10rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !86

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fmin(double %in, double %in) #44
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !87

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @fmin_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_fminfx_u10rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !88

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fminf(float %in, float %in) #45
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !89

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @fmod(double, double) #0

declare float @fmodf(float, float) #0

define void @fmod_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_fmoddx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !90

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @fmod(double %in, double %in) #46
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !91

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @fmod_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_fmodfx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !92

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @fmodf(float %in, float %in) #47
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !93

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @hypot(double, double) #0

declare float @hypotf(float, float) #0

define void @hypot_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_hypotdx_u05rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !94

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @hypot(double %in, double %in) #48
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !95

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @hypot_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_hypotfx_u05rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !96

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @hypotf(float %in, float %in) #49
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !97

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare i32 @ilogb(double) #0

declare i32 @ilogbf(float) #0

define void @ilogb_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x i32> @Sleef_ilogbdx_rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds i32, ptr %out.ptr, i64 %index
  store <vscale x 2 x i32> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !98

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call i32 @ilogb(double %in) #50
  %out.gep = getelementptr inbounds i32, ptr %out.ptr, i64 %iv
  store i32 %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !99

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @ilogb_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x i32> @Sleef_ilogbfx_rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds i32, ptr %out.ptr, i64 %index
  store <vscale x 4 x i32> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !100

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call i32 @ilogbf(float %in) #51
  %out.gep = getelementptr inbounds i32, ptr %out.ptr, i64 %iv
  store i32 %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !101

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @ldexp(double, i32) #0

declare float @ldexpf(float, i32) #0

define void @ldexp_f64(ptr noalias %in1.ptr, ptr noalias %in2.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in1.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = getelementptr inbounds i32, ptr %in2.ptr, i64 %index
  %wide.load1 = load <vscale x 2 x i32>, ptr %4, align 8
  %5 = call <vscale x 2 x double> @Sleef_ldexpdx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x i32> %wide.load1)
  %6 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %5, ptr %6, align 8
  %index.next = add nuw i64 %index, %2
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !102

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in1.gep = getelementptr inbounds double, ptr %in1.ptr, i64 %iv
  %in1 = load double, ptr %in1.gep, align 8
  %in2.gep = getelementptr inbounds i32, ptr %in2.ptr, i64 %iv
  %in2 = load i32, ptr %in2.gep, align 8
  %call = tail call double @ldexp(double %in1, i32 %in2) #52
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !103

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @ldexp_f32(ptr noalias %in1.ptr, ptr noalias %in2.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in1.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = getelementptr inbounds i32, ptr %in2.ptr, i64 %index
  %wide.load1 = load <vscale x 4 x i32>, ptr %4, align 8
  %5 = call <vscale x 4 x float> @Sleef_ldexpfx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x i32> %wide.load1)
  %6 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %5, ptr %6, align 4
  %index.next = add nuw i64 %index, %2
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !104

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in1.gep = getelementptr inbounds float, ptr %in1.ptr, i64 %iv
  %in1 = load float, ptr %in1.gep, align 8
  %in2.gep = getelementptr inbounds i32, ptr %in2.ptr, i64 %iv
  %in2 = load i32, ptr %in2.gep, align 8
  %call = tail call float @ldexpf(float %in1, i32 %in2) #53
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !105

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @lgamma(double) #0

declare float @lgammaf(float) #0

define void @lgamma_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_lgammadx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !106

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @lgamma(double %in) #54
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !107

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @lgamma_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_lgammafx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !108

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @lgammaf(float %in) #55
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !109

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @log(double) #0

declare float @logf(float) #0

define void @log_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_logdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !110

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log(double %in) #56
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !111

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @log_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_logfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !112

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @logf(float %in) #57
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !113

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @log10(double) #0

declare float @log10f(float) #0

define void @log10_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_log10dx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !114

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log10(double %in) #58
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !115

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @log10_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_log10fx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !116

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @log10f(float %in) #59
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !117

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @log1p(double) #0

declare float @log1pf(float) #0

define void @log1p_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_log1pdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !118

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log1p(double %in) #60
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !119

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @log1p_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_log1pfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !120

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @log1pf(float %in) #61
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !121

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @log2(double) #0

declare float @log2f(float) #0

define void @log2_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_log2dx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !122

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @log2(double %in) #62
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !123

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @log2_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_log2fx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !124

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @log2f(float %in) #63
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !125

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @modf(double, ptr) #0

declare float @modff(float, ptr) #0

define void @modf_f64(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr double, ptr %a, i64 %indvars.iv
  %num = load double, ptr %gepa, align 8
  %gepb = getelementptr double, ptr %b, i64 %indvars.iv
  %data = call double @modf(double %num, ptr %gepb) #64
  %gepc = getelementptr inbounds double, ptr %c, i64 %indvars.iv
  store double %data, ptr %gepc, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void
}

define void @modf_f32(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr float, ptr %a, i64 %indvars.iv
  %num = load float, ptr %gepa, align 8
  %gepb = getelementptr float, ptr %b, i64 %indvars.iv
  %data = call float @modff(float %num, ptr %gepb) #65
  %gepc = getelementptr inbounds float, ptr %c, i64 %indvars.iv
  store float %data, ptr %gepc, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void
}

declare double @nextafter(double, double) #0

declare float @nextafterf(float, float) #0

define void @nextafter_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_nextafterdx_rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !126

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @nextafter(double %in, double %in) #66
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !127

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @nextafter_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_nextafterfx_rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !128

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @nextafterf(float %in, float %in) #67
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !129

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @pow(double, double) #0

declare float @powf(float, float) #0

define void @pow_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_powdx_u10rvvm2(<vscale x 2 x double> %wide.load, <vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !130

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @pow(double %in, double %in) #68
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !131

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @pow_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_powfx_u10rvvm2(<vscale x 4 x float> %wide.load, <vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !132

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @powf(float %in, float %in) #69
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !133

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @sin(double) #0

declare float @sinf(float) #0

define void @sin_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_sindx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !134

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sin(double %in) #70
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !135

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @sin_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_sinfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !136

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sinf(float %in) #71
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !137

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare void @sincos(double, ptr, ptr) #0

declare void @sincosf(float, ptr, ptr) #0

define void @sincos_f64(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr double, ptr %a, i64 %indvars.iv
  %num = load double, ptr %gepa, align 8
  %gepb = getelementptr double, ptr %b, i64 %indvars.iv
  %gepc = getelementptr double, ptr %c, i64 %indvars.iv
  call void @sincos(double %num, ptr %gepb, ptr %gepc) #72
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void
}

define void @sincos_f32(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr float, ptr %a, i64 %indvars.iv
  %num = load float, ptr %gepa, align 8
  %gepb = getelementptr float, ptr %b, i64 %indvars.iv
  %gepc = getelementptr float, ptr %c, i64 %indvars.iv
  call void @sincosf(float %num, ptr %gepb, ptr %gepc) #73
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void
}

declare void @sincospi(double, ptr, ptr) #0

declare void @sincospif(float, ptr, ptr) #0

define void @sincospi_f64(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr double, ptr %a, i64 %indvars.iv
  %num = load double, ptr %gepa, align 8
  %gepb = getelementptr double, ptr %b, i64 %indvars.iv
  %gepc = getelementptr double, ptr %c, i64 %indvars.iv
  call void @sincospi(double %num, ptr %gepb, ptr %gepc) #74
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void
}

define void @sincospi_f32(ptr noalias %a, ptr noalias %b, ptr noalias %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepa = getelementptr float, ptr %a, i64 %indvars.iv
  %num = load float, ptr %gepa, align 8
  %gepb = getelementptr float, ptr %b, i64 %indvars.iv
  %gepc = getelementptr float, ptr %c, i64 %indvars.iv
  call void @sincospif(float %num, ptr %gepb, ptr %gepc) #75
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void
}

declare double @sinh(double) #0

declare float @sinhf(float) #0

define void @sinh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_sinhdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !138

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sinh(double %in) #76
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !139

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @sinh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_sinhfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !140

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sinhf(float %in) #77
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !141

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @sinpi(double) #0

declare float @sinpif(float) #0

define void @sinpi_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_sinpidx_u05rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !142

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sinpi(double %in) #78
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !143

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @sinpi_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_sinpifx_u05rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !144

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sinpif(float %in) #79
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !145

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @sqrt(double) #0

declare float @sqrtf(float) #0

define void @sqrt_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_sqrtdx_u05rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !146

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @sqrt(double %in) #80
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !147

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @sqrt_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_sqrtfx_u05rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !148

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @sqrtf(float %in) #81
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !149

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @tan(double) #0

declare float @tanf(float) #0

define void @tan_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_tandx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !150

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @tan(double %in) #82
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !151

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @tan_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_tanfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !152

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @tanf(float %in) #83
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !153

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @tanh(double) #0

declare float @tanhf(float) #0

define void @tanh_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_tanhdx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !154

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @tanh(double %in) #84
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !155

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @tanh_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_tanhfx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !156

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @tanhf(float %in) #85
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !157

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare double @tgamma(double) #0

declare float @tgammaf(float) #0

define void @tgamma_f64(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds double, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %3, align 8
  %4 = call <vscale x 2 x double> @Sleef_tgammadx_u10rvvm2(<vscale x 2 x double> %wide.load)
  %5 = getelementptr inbounds double, ptr %out.ptr, i64 %index
  store <vscale x 2 x double> %4, ptr %5, align 8
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !158

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds double, ptr %in.ptr, i64 %iv
  %in = load double, ptr %in.gep, align 8
  %call = tail call double @tgamma(double %in) #86
  %out.gep = getelementptr inbounds double, ptr %out.ptr, i64 %iv
  store double %call, ptr %out.gep, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !159

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

define void @tgamma_f32(ptr noalias %in.ptr, ptr noalias %out.ptr) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1000, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %n.mod.vf = urem i64 1000, %2
  %n.vec = sub i64 1000, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = getelementptr inbounds float, ptr %in.ptr, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %3, align 8
  %4 = call <vscale x 4 x float> @Sleef_tgammafx_u10rvvm2(<vscale x 4 x float> %wide.load)
  %5 = getelementptr inbounds float, ptr %out.ptr, i64 %index
  store <vscale x 4 x float> %4, ptr %5, align 4
  %index.next = add nuw i64 %index, %2
  %6 = icmp eq i64 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !160

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1000, %n.vec
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %for.body

for.body:                                         ; preds = %scalar.ph, %for.body
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %for.body ]
  %in.gep = getelementptr inbounds float, ptr %in.ptr, i64 %iv
  %in = load float, ptr %in.gep, align 8
  %call = tail call float @tgammaf(float %in) #87
  %out.gep = getelementptr inbounds float, ptr %out.ptr, i64 %iv
  store float %call, ptr %out.gep, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 1000
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !161

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

declare <vscale x 2 x double> @Sleef_acosdx_u10rvvm2(<vscale x 2 x double>) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

declare <vscale x 4 x float> @Sleef_acosfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_acoshdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_acoshfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_asindx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_asinfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_asinhdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_asinhfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_atandx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_atanfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_atan2dx_u10rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_atan2fx_u10rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_atanhdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_atanhfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_cbrtdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_cbrtfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_copysigndx_rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_copysignfx_rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_cosdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_cosfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_coshdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_coshfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_cospidx_u05rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_cospifx_u05rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_erfdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_erffx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_erfcdx_u15rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_erfcfx_u15rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_expdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_expfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_exp10dx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_exp10fx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_exp2dx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_exp2fx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_expm1dx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_expm1fx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_fdimdx_rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_fdimfx_rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_fmadx_rvvm2(<vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_fmafx_rvvm2(<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_fmaxdx_rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_fmaxfx_rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_fmindx_u10rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_fminfx_u10rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_fmoddx_rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_fmodfx_rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_hypotdx_u05rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_hypotfx_u05rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x i32> @Sleef_ilogbdx_rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x i32> @Sleef_ilogbfx_rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_ldexpdx_rvvm2(<vscale x 2 x double>, <vscale x 2 x i32>) #0

declare <vscale x 4 x float> @Sleef_ldexpfx_rvvm2(<vscale x 4 x float>, <vscale x 4 x i32>) #0

declare <vscale x 2 x double> @Sleef_lgammadx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_lgammafx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_logdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_logfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_log10dx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_log10fx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_log1pdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_log1pfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_log2dx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_log2fx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_modfdx_rvvm2(<vscale x 2 x double>, ptr) #0

declare <vscale x 4 x float> @Sleef_modffx_rvvm2(<vscale x 4 x float>, ptr) #0

declare <vscale x 2 x double> @Sleef_nextafterdx_rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_nextafterfx_rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_powdx_u10rvvm2(<vscale x 2 x double>, <vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_powfx_u10rvvm2(<vscale x 4 x float>, <vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_sindx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_sinfx_u10rvvm2(<vscale x 4 x float>) #0

declare void @Sleef_sincosdx_u10rvvm2(<vscale x 2 x double>, ptr, ptr) #0

declare void @Sleef_sincosfx_u10rvvm2(<vscale x 4 x float>, ptr, ptr) #0

declare void @Sleef_sincospidx_u10rvvm2(<vscale x 2 x double>, ptr, ptr) #0

declare void @Sleef_sincospifx_u10rvvm2(<vscale x 4 x float>, ptr, ptr) #0

declare <vscale x 2 x double> @Sleef_sinhdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_sinhfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_sinpidx_u05rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_sinpifx_u05rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_sqrtdx_u05rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_sqrtfx_u05rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_tandx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_tanfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_tanhdx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_tanhfx_u10rvvm2(<vscale x 4 x float>) #0

declare <vscale x 2 x double> @Sleef_tgammadx_u10rvvm2(<vscale x 2 x double>) #0

declare <vscale x 4 x float> @Sleef_tgammafx_u10rvvm2(<vscale x 4 x float>) #0

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "vector-function-abi-variant"="_ZGVrNxv_acos(Sleef_acosdx_u10rvvm2)" }
attributes #3 = { "vector-function-abi-variant"="_ZGVrNxv_acosf(Sleef_acosfx_u10rvvm2)" }
attributes #4 = { "vector-function-abi-variant"="_ZGVrNxv_acosh(Sleef_acoshdx_u10rvvm2)" }
attributes #5 = { "vector-function-abi-variant"="_ZGVrNxv_acoshf(Sleef_acoshfx_u10rvvm2)" }
attributes #6 = { "vector-function-abi-variant"="_ZGVrNxv_asin(Sleef_asindx_u10rvvm2)" }
attributes #7 = { "vector-function-abi-variant"="_ZGVrNxv_asinf(Sleef_asinfx_u10rvvm2)" }
attributes #8 = { "vector-function-abi-variant"="_ZGVrNxv_asinh(Sleef_asinhdx_u10rvvm2)" }
attributes #9 = { "vector-function-abi-variant"="_ZGVrNxv_asinhf(Sleef_asinhfx_u10rvvm2)" }
attributes #10 = { "vector-function-abi-variant"="_ZGVrNxv_atan(Sleef_atandx_u10rvvm2)" }
attributes #11 = { "vector-function-abi-variant"="_ZGVrNxv_atanf(Sleef_atanfx_u10rvvm2)" }
attributes #12 = { "vector-function-abi-variant"="_ZGVrNxvv_atan2(Sleef_atan2dx_u10rvvm2)" }
attributes #13 = { "vector-function-abi-variant"="_ZGVrNxvv_atan2f(Sleef_atan2fx_u10rvvm2)" }
attributes #14 = { "vector-function-abi-variant"="_ZGVrNxv_atanh(Sleef_atanhdx_u10rvvm2)" }
attributes #15 = { "vector-function-abi-variant"="_ZGVrNxv_atanhf(Sleef_atanhfx_u10rvvm2)" }
attributes #16 = { "vector-function-abi-variant"="_ZGVrNxv_cbrt(Sleef_cbrtdx_u10rvvm2)" }
attributes #17 = { "vector-function-abi-variant"="_ZGVrNxv_cbrtf(Sleef_cbrtfx_u10rvvm2)" }
attributes #18 = { "vector-function-abi-variant"="_ZGVrNxvv_copysign(Sleef_copysigndx_rvvm2)" }
attributes #19 = { "vector-function-abi-variant"="_ZGVrNxvv_copysignf(Sleef_copysignfx_rvvm2)" }
attributes #20 = { "vector-function-abi-variant"="_ZGVrNxv_cos(Sleef_cosdx_u10rvvm2)" }
attributes #21 = { "vector-function-abi-variant"="_ZGVrNxv_cosf(Sleef_cosfx_u10rvvm2)" }
attributes #22 = { "vector-function-abi-variant"="_ZGVrNxv_cosh(Sleef_coshdx_u10rvvm2)" }
attributes #23 = { "vector-function-abi-variant"="_ZGVrNxv_coshf(Sleef_coshfx_u10rvvm2)" }
attributes #24 = { "vector-function-abi-variant"="_ZGVrNxv_cospi(Sleef_cospidx_u05rvvm2)" }
attributes #25 = { "vector-function-abi-variant"="_ZGVrNxv_cospif(Sleef_cospifx_u05rvvm2)" }
attributes #26 = { "vector-function-abi-variant"="_ZGVrNxv_erf(Sleef_erfdx_u10rvvm2)" }
attributes #27 = { "vector-function-abi-variant"="_ZGVrNxv_erff(Sleef_erffx_u10rvvm2)" }
attributes #28 = { "vector-function-abi-variant"="_ZGVrNxv_erfc(Sleef_erfcdx_u15rvvm2)" }
attributes #29 = { "vector-function-abi-variant"="_ZGVrNxv_erfcf(Sleef_erfcfx_u15rvvm2)" }
attributes #30 = { "vector-function-abi-variant"="_ZGVrNxv_exp(Sleef_expdx_u10rvvm2)" }
attributes #31 = { "vector-function-abi-variant"="_ZGVrNxv_expf(Sleef_expfx_u10rvvm2)" }
attributes #32 = { "vector-function-abi-variant"="_ZGVrNxv_exp10(Sleef_exp10dx_u10rvvm2)" }
attributes #33 = { "vector-function-abi-variant"="_ZGVrNxv_exp10f(Sleef_exp10fx_u10rvvm2)" }
attributes #34 = { "vector-function-abi-variant"="_ZGVrNxv_exp2(Sleef_exp2dx_u10rvvm2)" }
attributes #35 = { "vector-function-abi-variant"="_ZGVrNxv_exp2f(Sleef_exp2fx_u10rvvm2)" }
attributes #36 = { "vector-function-abi-variant"="_ZGVrNxv_expm1(Sleef_expm1dx_u10rvvm2)" }
attributes #37 = { "vector-function-abi-variant"="_ZGVrNxv_expm1f(Sleef_expm1fx_u10rvvm2)" }
attributes #38 = { "vector-function-abi-variant"="_ZGVrNxvv_fdim(Sleef_fdimdx_rvvm2)" }
attributes #39 = { "vector-function-abi-variant"="_ZGVrNxvv_fdimf(Sleef_fdimfx_rvvm2)" }
attributes #40 = { "vector-function-abi-variant"="_ZGVrNxvvv_fma(Sleef_fmadx_rvvm2)" }
attributes #41 = { "vector-function-abi-variant"="_ZGVrNxvvv_fmaf(Sleef_fmafx_rvvm2)" }
attributes #42 = { "vector-function-abi-variant"="_ZGVrNxvv_fmax(Sleef_fmaxdx_rvvm2)" }
attributes #43 = { "vector-function-abi-variant"="_ZGVrNxvv_fmaxf(Sleef_fmaxfx_rvvm2)" }
attributes #44 = { "vector-function-abi-variant"="_ZGVrNxvv_fmin(Sleef_fmindx_u10rvvm2)" }
attributes #45 = { "vector-function-abi-variant"="_ZGVrNxvv_fminf(Sleef_fminfx_u10rvvm2)" }
attributes #46 = { "vector-function-abi-variant"="_ZGVrNxvv_fmod(Sleef_fmoddx_rvvm2)" }
attributes #47 = { "vector-function-abi-variant"="_ZGVrNxvv_fmodf(Sleef_fmodfx_rvvm2)" }
attributes #48 = { "vector-function-abi-variant"="_ZGVrNxvv_hypot(Sleef_hypotdx_u05rvvm2)" }
attributes #49 = { "vector-function-abi-variant"="_ZGVrNxvv_hypotf(Sleef_hypotfx_u05rvvm2)" }
attributes #50 = { "vector-function-abi-variant"="_ZGVrNxv_ilogb(Sleef_ilogbdx_rvvm2)" }
attributes #51 = { "vector-function-abi-variant"="_ZGVrNxv_ilogbf(Sleef_ilogbfx_rvvm2)" }
attributes #52 = { "vector-function-abi-variant"="_ZGVrNxvv_ldexp(Sleef_ldexpdx_rvvm2)" }
attributes #53 = { "vector-function-abi-variant"="_ZGVrNxvv_ldexpf(Sleef_ldexpfx_rvvm2)" }
attributes #54 = { "vector-function-abi-variant"="_ZGVrNxv_lgamma(Sleef_lgammadx_u10rvvm2)" }
attributes #55 = { "vector-function-abi-variant"="_ZGVrNxv_lgammaf(Sleef_lgammafx_u10rvvm2)" }
attributes #56 = { "vector-function-abi-variant"="_ZGVsNxv_log(Sleef_logdx_u10rvvm2)" }
attributes #57 = { "vector-function-abi-variant"="_ZGVrNxv_logf(Sleef_logfx_u10rvvm2)" }
attributes #58 = { "vector-function-abi-variant"="_ZGVrNxv_log10(Sleef_log10dx_u10rvvm2)" }
attributes #59 = { "vector-function-abi-variant"="_ZGVrNxv_log10f(Sleef_log10fx_u10rvvm2)" }
attributes #60 = { "vector-function-abi-variant"="_ZGVrNxv_log1p(Sleef_log1pdx_u10rvvm2)" }
attributes #61 = { "vector-function-abi-variant"="_ZGVrNxv_log1pf(Sleef_log1pfx_u10rvvm2)" }
attributes #62 = { "vector-function-abi-variant"="_ZGVrNxv_log2(Sleef_log2dx_u10rvvm2)" }
attributes #63 = { "vector-function-abi-variant"="_ZGVrNxv_log2f(Sleef_log2fx_u10rvvm2)" }
attributes #64 = { "vector-function-abi-variant"="_ZGVrNxvl8_modf(Sleef_modfdx_rvvm2)" }
attributes #65 = { "vector-function-abi-variant"="_ZGVrNxvl4_modff(Sleef_modffx_rvvm2)" }
attributes #66 = { "vector-function-abi-variant"="_ZGVrNxvv_nextafter(Sleef_nextafterdx_rvvm2)" }
attributes #67 = { "vector-function-abi-variant"="_ZGVrNxvv_nextafterf(Sleef_nextafterfx_rvvm2)" }
attributes #68 = { "vector-function-abi-variant"="_ZGVrNxvv_pow(Sleef_powdx_u10rvvm2)" }
attributes #69 = { "vector-function-abi-variant"="_ZGVrNxvv_powf(Sleef_powfx_u10rvvm2)" }
attributes #70 = { "vector-function-abi-variant"="_ZGVrNxv_sin(Sleef_sindx_u10rvvm2)" }
attributes #71 = { "vector-function-abi-variant"="_ZGVrNxv_sinf(Sleef_sinfx_u10rvvm2)" }
attributes #72 = { "vector-function-abi-variant"="_ZGVrNxvl8l8_sincos(Sleef_sincosdx_u10rvvm2)" }
attributes #73 = { "vector-function-abi-variant"="_ZGVrNxvl4l4_sincosf(Sleef_sincosfx_u10rvvm2)" }
attributes #74 = { "vector-function-abi-variant"="_ZGVrNxvl8l8_sincospi(Sleef_sincospidx_u10rvvm2)" }
attributes #75 = { "vector-function-abi-variant"="_ZGVrNxvl4l4_sincospif(Sleef_sincospifx_u10rvvm2)" }
attributes #76 = { "vector-function-abi-variant"="_ZGVrNxv_sinh(Sleef_sinhdx_u10rvvm2)" }
attributes #77 = { "vector-function-abi-variant"="_ZGVrNxv_sinhf(Sleef_sinhfx_u10rvvm2)" }
attributes #78 = { "vector-function-abi-variant"="_ZGVrNxv_sinpi(Sleef_sinpidx_u05rvvm2)" }
attributes #79 = { "vector-function-abi-variant"="_ZGVrNxv_sinpif(Sleef_sinpifx_u05rvvm2)" }
attributes #80 = { "vector-function-abi-variant"="_ZGVrNxv_sqrt(Sleef_sqrtdx_u05rvvm2)" }
attributes #81 = { "vector-function-abi-variant"="_ZGVrNxv_sqrtf(Sleef_sqrtfx_u05rvvm2)" }
attributes #82 = { "vector-function-abi-variant"="_ZGVrNxv_tan(Sleef_tandx_u10rvvm2)" }
attributes #83 = { "vector-function-abi-variant"="_ZGVrNxv_tanf(Sleef_tanfx_u10rvvm2)" }
attributes #84 = { "vector-function-abi-variant"="_ZGVrNxv_tanh(Sleef_tanhdx_u10rvvm2)" }
attributes #85 = { "vector-function-abi-variant"="_ZGVrNxv_tanhf(Sleef_tanhfx_u10rvvm2)" }
attributes #86 = { "vector-function-abi-variant"="_ZGVrNxv_tgamma(Sleef_tgammadx_u10rvvm2)" }
attributes #87 = { "vector-function-abi-variant"="_ZGVrNxv_tgammaf(Sleef_tgammafx_u10rvvm2)" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !2, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !2, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !2, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !2, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !2, !1}
!18 = distinct !{!18, !1, !2}
!19 = distinct !{!19, !2, !1}
!20 = distinct !{!20, !1, !2}
!21 = distinct !{!21, !2, !1}
!22 = distinct !{!22, !1, !2}
!23 = distinct !{!23, !2, !1}
!24 = distinct !{!24, !1, !2}
!25 = distinct !{!25, !2, !1}
!26 = distinct !{!26, !1, !2}
!27 = distinct !{!27, !2, !1}
!28 = distinct !{!28, !1, !2}
!29 = distinct !{!29, !2, !1}
!30 = distinct !{!30, !1, !2}
!31 = distinct !{!31, !2, !1}
!32 = distinct !{!32, !1, !2}
!33 = distinct !{!33, !2, !1}
!34 = distinct !{!34, !1, !2}
!35 = distinct !{!35, !2, !1}
!36 = distinct !{!36, !1, !2}
!37 = distinct !{!37, !2, !1}
!38 = distinct !{!38, !1, !2}
!39 = distinct !{!39, !2, !1}
!40 = distinct !{!40, !1, !2}
!41 = distinct !{!41, !2, !1}
!42 = distinct !{!42, !1, !2}
!43 = distinct !{!43, !2, !1}
!44 = distinct !{!44, !1, !2}
!45 = distinct !{!45, !2, !1}
!46 = distinct !{!46, !1, !2}
!47 = distinct !{!47, !2, !1}
!48 = distinct !{!48, !1, !2}
!49 = distinct !{!49, !2, !1}
!50 = distinct !{!50, !1, !2}
!51 = distinct !{!51, !2, !1}
!52 = distinct !{!52, !1, !2}
!53 = distinct !{!53, !2, !1}
!54 = distinct !{!54, !1, !2}
!55 = distinct !{!55, !2, !1}
!56 = distinct !{!56, !1, !2}
!57 = distinct !{!57, !2, !1}
!58 = distinct !{!58, !1, !2}
!59 = distinct !{!59, !2, !1}
!60 = distinct !{!60, !1, !2}
!61 = distinct !{!61, !2, !1}
!62 = distinct !{!62, !1, !2}
!63 = distinct !{!63, !2, !1}
!64 = distinct !{!64, !1, !2}
!65 = distinct !{!65, !2, !1}
!66 = distinct !{!66, !1, !2}
!67 = distinct !{!67, !2, !1}
!68 = distinct !{!68, !1, !2}
!69 = distinct !{!69, !2, !1}
!70 = distinct !{!70, !1, !2}
!71 = distinct !{!71, !2, !1}
!72 = distinct !{!72, !1, !2}
!73 = distinct !{!73, !2, !1}
!74 = distinct !{!74, !1, !2}
!75 = distinct !{!75, !2, !1}
!76 = distinct !{!76, !1, !2}
!77 = distinct !{!77, !2, !1}
!78 = distinct !{!78, !1, !2}
!79 = distinct !{!79, !2, !1}
!80 = distinct !{!80, !1, !2}
!81 = distinct !{!81, !2, !1}
!82 = distinct !{!82, !1, !2}
!83 = distinct !{!83, !2, !1}
!84 = distinct !{!84, !1, !2}
!85 = distinct !{!85, !2, !1}
!86 = distinct !{!86, !1, !2}
!87 = distinct !{!87, !2, !1}
!88 = distinct !{!88, !1, !2}
!89 = distinct !{!89, !2, !1}
!90 = distinct !{!90, !1, !2}
!91 = distinct !{!91, !2, !1}
!92 = distinct !{!92, !1, !2}
!93 = distinct !{!93, !2, !1}
!94 = distinct !{!94, !1, !2}
!95 = distinct !{!95, !2, !1}
!96 = distinct !{!96, !1, !2}
!97 = distinct !{!97, !2, !1}
!98 = distinct !{!98, !1, !2}
!99 = distinct !{!99, !2, !1}
!100 = distinct !{!100, !1, !2}
!101 = distinct !{!101, !2, !1}
!102 = distinct !{!102, !1, !2}
!103 = distinct !{!103, !2, !1}
!104 = distinct !{!104, !1, !2}
!105 = distinct !{!105, !2, !1}
!106 = distinct !{!106, !1, !2}
!107 = distinct !{!107, !2, !1}
!108 = distinct !{!108, !1, !2}
!109 = distinct !{!109, !2, !1}
!110 = distinct !{!110, !1, !2}
!111 = distinct !{!111, !2, !1}
!112 = distinct !{!112, !1, !2}
!113 = distinct !{!113, !2, !1}
!114 = distinct !{!114, !1, !2}
!115 = distinct !{!115, !2, !1}
!116 = distinct !{!116, !1, !2}
!117 = distinct !{!117, !2, !1}
!118 = distinct !{!118, !1, !2}
!119 = distinct !{!119, !2, !1}
!120 = distinct !{!120, !1, !2}
!121 = distinct !{!121, !2, !1}
!122 = distinct !{!122, !1, !2}
!123 = distinct !{!123, !2, !1}
!124 = distinct !{!124, !1, !2}
!125 = distinct !{!125, !2, !1}
!126 = distinct !{!126, !1, !2}
!127 = distinct !{!127, !2, !1}
!128 = distinct !{!128, !1, !2}
!129 = distinct !{!129, !2, !1}
!130 = distinct !{!130, !1, !2}
!131 = distinct !{!131, !2, !1}
!132 = distinct !{!132, !1, !2}
!133 = distinct !{!133, !2, !1}
!134 = distinct !{!134, !1, !2}
!135 = distinct !{!135, !2, !1}
!136 = distinct !{!136, !1, !2}
!137 = distinct !{!137, !2, !1}
!138 = distinct !{!138, !1, !2}
!139 = distinct !{!139, !2, !1}
!140 = distinct !{!140, !1, !2}
!141 = distinct !{!141, !2, !1}
!142 = distinct !{!142, !1, !2}
!143 = distinct !{!143, !2, !1}
!144 = distinct !{!144, !1, !2}
!145 = distinct !{!145, !2, !1}
!146 = distinct !{!146, !1, !2}
!147 = distinct !{!147, !2, !1}
!148 = distinct !{!148, !1, !2}
!149 = distinct !{!149, !2, !1}
!150 = distinct !{!150, !1, !2}
!151 = distinct !{!151, !2, !1}
!152 = distinct !{!152, !1, !2}
!153 = distinct !{!153, !2, !1}
!154 = distinct !{!154, !1, !2}
!155 = distinct !{!155, !2, !1}
!156 = distinct !{!156, !1, !2}
!157 = distinct !{!157, !2, !1}
!158 = distinct !{!158, !1, !2}
!159 = distinct !{!159, !2, !1}
!160 = distinct !{!160, !1, !2}
!161 = distinct !{!161, !2, !1}
