; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/math-function.ll
; Variant: riscv64_+v,+f_slp-vectorizer_DEFAULT
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64 -mattr=+v,+f -S
; Original: RUN: opt < %s -passes=slp-vectorizer -S -mtriple=riscv64 -mattr=+v,+f  | FileCheck %s --check-prefix=DEFAULT

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


declare float @fabsf(float) readonly nounwind willreturn

define <4 x float> @fabs_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @fabsf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @fabsf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @fabsf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @fabsf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.fabs.f32(float)

define <4 x float> @int_fabs_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.fabs.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.fabs.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.fabs.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.fabs.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @sqrtf(float) readonly nounwind willreturn

define <4 x float> @sqrt_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @sqrtf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @sqrtf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @sqrtf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @sqrtf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.sqrt.f32(float)

define <4 x float> @int_sqrt_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.sqrt.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.sqrt.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.sqrt.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.sqrt.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @expf(float) readonly nounwind willreturn

; We can not vectorized exp since RISCV has no such instruction.
define <4 x float> @exp_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @expf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @expf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @expf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @expf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.exp.f32(float)

; We can not vectorized exp since RISCV has no such instruction.
define <4 x float> @int_exp_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.exp.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.exp.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.exp.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.exp.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @logf(float) readonly nounwind willreturn

; We can not vectorized log since RISCV has no such instruction.
define <4 x float> @log_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @logf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @logf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @logf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @logf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.log.f32(float)

; We can not vectorized log since RISCV has no such instruction.
define <4 x float> @int_log_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.log.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.log.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.log.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.log.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @sinf(float) readonly nounwind willreturn

; We can not vectorized sin since RISCV has no such instruction.
define <4 x float> @sin_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @sinf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @sinf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @sinf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @sinf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.sin.f32(float)

; We can not vectorized sin since RISCV has no such instruction.
define <4 x float> @int_sin_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.sin.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.sin.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.sin.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.sin.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @asinf(float) readonly nounwind willreturn

; We can not vectorized asin since RISCV has no such instruction.
define <4 x float> @asin_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @asinf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @asinf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @asinf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @asinf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.asin.f32(float)

; We can not vectorized asin since RISCV has no such instruction.
define <4 x float> @int_asin_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.asin.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.asin.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.asin.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.asin.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @cosf(float) readonly nounwind willreturn

; We can not vectorized cos cosce RISCV has no such instruction.
define <4 x float> @cos_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @cosf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @cosf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @cosf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @cosf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.cos.f32(float)

; We can not vectorized cos cosce RISCV has no such instruction.
define <4 x float> @int_cos_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.cos.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.cos.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.cos.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.cos.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @acosf(float) readonly nounwind willreturn

; We can not vectorized acos cosce RISCV has no such instruction.
define <4 x float> @acos_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @acosf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @acosf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @acosf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @acosf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.acos.f32(float)

; We can not vectorized acos cosce RISCV has no such instruction.
define <4 x float> @int_acos_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.acos.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.acos.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.acos.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.acos.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @tanf(float) readonly nounwind willreturn

; We can not vectorized tan tance RISCV has no such instruction.
define <4 x float> @tan_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @tanf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @tanf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @tanf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @tanf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.tan.f32(float)

; We can not vectorized tan tance RISCV has no such instruction.
define <4 x float> @int_tan_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.tan.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.tan.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.tan.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.tan.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @atanf(float) readonly nounwind willreturn

; We can not vectorized atan tance RISCV has no such instruction.
define <4 x float> @atan_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @atanf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @atanf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @atanf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @atanf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.atan.f32(float)

; We can not vectorized atan tance RISCV has no such instruction.
define <4 x float> @int_atan_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.atan.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.atan.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.atan.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.atan.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @sinhf(float) readonly nounwind willreturn

; We can not vectorized sinh since RISCV has no such instruction.
define <4 x float> @sinh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @sinhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @sinhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @sinhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @sinhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.sinh.f32(float)

; We can not vectorized sinh since RISCV has no such instruction.
define <4 x float> @int_sinh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.sinh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.sinh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.sinh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.sinh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @asinhf(float) readonly nounwind willreturn

; We can not vectorized asinh since RISCV has no such instruction.
define <4 x float> @asinh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @asinhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @asinhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @asinhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @asinhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.asinh.f32(float)

; We can not vectorized asinh since RISCV has no such instruction.
define <4 x float> @int_asinh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.asinh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.asinh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.asinh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.asinh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @coshf(float) readonly nounwind willreturn

; We can not vectorized cosh since RISCV has no such instruction.
define <4 x float> @cosh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @coshf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @coshf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @coshf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @coshf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.cosh.f32(float)

; We can not vectorized cosh since RISCV has no such instruction.
define <4 x float> @int_cosh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.cosh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.cosh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.cosh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.cosh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @acoshf(float) readonly nounwind willreturn

; We can not vectorized acosh since RISCV has no such instruction.
define <4 x float> @acosh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @acoshf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @acoshf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @acoshf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @acoshf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.acosh.f32(float)

; We can not vectorized acosh since RISCV has no such instruction.
define <4 x float> @int_acosh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.acosh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.acosh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.acosh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.acosh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @tanhf(float) readonly nounwind willreturn

; We can not vectorized tanh since RISCV has no such instruction.
define <4 x float> @tanh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @tanhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @tanhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @tanhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @tanhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.tanh.f32(float)

; We can not vectorized tanh since RISCV has no such instruction.
define <4 x float> @int_tanh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.tanh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.tanh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.tanh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.tanh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @atanhf(float) readonly nounwind willreturn

; We can not vectorized atanh since RISCV has no such instruction.
define <4 x float> @atanh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @atanhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @atanhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @atanhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @atanhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

declare float @llvm.atanh.f32(float)

; We can not vectorized atanh since RISCV has no such instruction.
define <4 x float> @int_atanh_4x(ptr %a) {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.atanh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.atanh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.atanh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.atanh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

define void @f(i1 %c, ptr %p, ptr %q, ptr %r) {
  %x0 = load i64, ptr %p
  %p1 =  getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1
  br i1 %c, label %foo, label %bar
foo:
  %y0 = load float, ptr %r
  %y1 = call float @fabsf(float %y0)
  br label %baz
bar:
  %z0 = load float, ptr %r
  %z1 = call float @fabsf(float %z0)
  br label %baz
baz:
  store i64 %x0, ptr %q
  %q1 =  getelementptr i64, ptr %q, i64 1
  store i64 %x1, ptr %q1

  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpob6cxj83.ll'
source_filename = "/tmp/tmpob6cxj83.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nounwind willreturn memory(read)
declare float @fabsf(float) #0

define <4 x float> @fabs_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %0)
  ret <4 x float> %1
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fabs.f32(float) #2

define <4 x float> @int_fabs_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %0)
  ret <4 x float> %1
}

; Function Attrs: nounwind willreturn memory(read)
declare float @sqrtf(float) #0

define <4 x float> @sqrt_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call fast <4 x float> @llvm.sqrt.v4f32(<4 x float> %0)
  ret <4 x float> %1
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #2

define <4 x float> @int_sqrt_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = call fast <4 x float> @llvm.sqrt.v4f32(<4 x float> %0)
  ret <4 x float> %1
}

; Function Attrs: nounwind willreturn memory(read)
declare float @expf(float) #0

define <4 x float> @exp_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @expf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @expf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @expf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @expf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #2

define <4 x float> @int_exp_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.exp.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.exp.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.exp.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.exp.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @logf(float) #0

define <4 x float> @log_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @logf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @logf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @logf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @logf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.log.f32(float) #2

define <4 x float> @int_log_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.log.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.log.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.log.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.log.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @sinf(float) #0

define <4 x float> @sin_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @sinf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @sinf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @sinf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @sinf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sin.f32(float) #2

define <4 x float> @int_sin_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.sin.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.sin.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.sin.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.sin.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @asinf(float) #0

define <4 x float> @asin_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @asinf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @asinf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @asinf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @asinf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.asin.f32(float) #3

define <4 x float> @int_asin_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.asin.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.asin.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.asin.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.asin.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @cosf(float) #0

define <4 x float> @cos_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @cosf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @cosf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @cosf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @cosf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.cos.f32(float) #2

define <4 x float> @int_cos_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.cos.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.cos.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.cos.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.cos.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @acosf(float) #0

define <4 x float> @acos_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @acosf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @acosf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @acosf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @acosf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.acos.f32(float) #3

define <4 x float> @int_acos_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.acos.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.acos.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.acos.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.acos.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @tanf(float) #0

define <4 x float> @tan_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @tanf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @tanf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @tanf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @tanf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.tan.f32(float) #3

define <4 x float> @int_tan_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.tan.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.tan.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.tan.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.tan.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @atanf(float) #0

define <4 x float> @atan_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @atanf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @atanf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @atanf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @atanf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.atan.f32(float) #3

define <4 x float> @int_atan_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.atan.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.atan.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.atan.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.atan.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @sinhf(float) #0

define <4 x float> @sinh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @sinhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @sinhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @sinhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @sinhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sinh.f32(float) #3

define <4 x float> @int_sinh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.sinh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.sinh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.sinh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.sinh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @asinhf(float) #0

define <4 x float> @asinh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @asinhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @asinhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @asinhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @asinhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Unknown intrinsic
declare float @llvm.asinh.f32(float) #1

define <4 x float> @int_asinh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.asinh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.asinh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.asinh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.asinh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @coshf(float) #0

define <4 x float> @cosh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @coshf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @coshf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @coshf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @coshf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.cosh.f32(float) #3

define <4 x float> @int_cosh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.cosh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.cosh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.cosh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.cosh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @acoshf(float) #0

define <4 x float> @acosh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @acoshf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @acoshf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @acoshf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @acoshf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Unknown intrinsic
declare float @llvm.acosh.f32(float) #1

define <4 x float> @int_acosh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.acosh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.acosh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.acosh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.acosh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @tanhf(float) #0

define <4 x float> @tanh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @tanhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @tanhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @tanhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @tanhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.tanh.f32(float) #3

define <4 x float> @int_tanh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.tanh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.tanh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.tanh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.tanh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Function Attrs: nounwind willreturn memory(read)
declare float @atanhf(float) #0

define <4 x float> @atanh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @atanhf(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @atanhf(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @atanhf(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @atanhf(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

; Unknown intrinsic
declare float @llvm.atanh.f32(float) #1

define <4 x float> @int_atanh_4x(ptr %a) #1 {
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %vecext = extractelement <4 x float> %0, i32 0
  %1 = tail call fast float @llvm.atanh.f32(float %vecext)
  %vecins = insertelement <4 x float> poison, float %1, i32 0
  %vecext.1 = extractelement <4 x float> %0, i32 1
  %2 = tail call fast float @llvm.atanh.f32(float %vecext.1)
  %vecins.1 = insertelement <4 x float> %vecins, float %2, i32 1
  %vecext.2 = extractelement <4 x float> %0, i32 2
  %3 = tail call fast float @llvm.atanh.f32(float %vecext.2)
  %vecins.2 = insertelement <4 x float> %vecins.1, float %3, i32 2
  %vecext.3 = extractelement <4 x float> %0, i32 3
  %4 = tail call fast float @llvm.atanh.f32(float %vecext.3)
  %vecins.3 = insertelement <4 x float> %vecins.2, float %4, i32 3
  ret <4 x float> %vecins.3
}

define void @f(i1 %c, ptr %p, ptr %q, ptr %r) #1 {
  %x0 = load i64, ptr %p, align 8
  %p1 = getelementptr i64, ptr %p, i64 1
  %x1 = load i64, ptr %p1, align 8
  br i1 %c, label %foo, label %bar

foo:                                              ; preds = %0
  %y0 = load float, ptr %r, align 4
  %y1 = call float @fabsf(float %y0)
  br label %baz

bar:                                              ; preds = %0
  %z0 = load float, ptr %r, align 4
  %z1 = call float @fabsf(float %z0)
  br label %baz

baz:                                              ; preds = %bar, %foo
  store i64 %x0, ptr %q, align 8
  %q1 = getelementptr i64, ptr %q, i64 1
  store i64 %x1, ptr %q1, align 8
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #4

attributes #0 = { nounwind willreturn memory(read) "target-features"="+v,+f" }
attributes #1 = { "target-features"="+v,+f" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+f" }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
