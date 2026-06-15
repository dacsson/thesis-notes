; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/fminimumnum.ll
; Variant: riscv64_"+v,+zvfhmin"_slp-vectorizer_ZVFHMIN
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer --mtriple=riscv64 -mattr="+v,+zvfhmin" -S
; Original: RUN: opt --passes=slp-vectorizer --mtriple=riscv64 -mattr="+v,+zvfhmin" -S < %s | FileCheck %s --check-prefix=ZVFHMIN

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


@input1_f32 = global [9 x float] zeroinitializer, align 16
@input2_f32 = global [9 x float] zeroinitializer, align 16
@output_f32 = global [9 x float] zeroinitializer, align 16
@input1_f64 = global [9 x double] zeroinitializer, align 16
@input2_f64 = global [9 x double] zeroinitializer, align 16
@output_f64 = global [9 x double] zeroinitializer, align 16
@input1_f16 = global [9 x half] zeroinitializer, align 16
@input2_f16 = global [9 x half] zeroinitializer, align 16
@output_f16 = global [9 x half] zeroinitializer, align 16

define void @fmin32()  {
entry:
  %input0_0 = load float, ptr @input1_f32, align 16
  %input0_1 = load float, ptr @input2_f32, align 16
  %output0 = tail call float @llvm.minimumnum.f32(float %input0_0, float %input0_1)
  store float %output0, ptr @output_f32, align 16
  %input1_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 4), align 4
  %input1_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 4), align 4
  %output1 = tail call float @llvm.minimumnum.f32(float %input1_1, float %input1_2)
  store float %output1, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 4), align 4
  %input2_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 8), align 8
  %input2_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 8), align 8
  %output2 = tail call float @llvm.minimumnum.f32(float %input2_1, float %input2_2)
  store float %output2, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 8), align 8
  %input3_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 12), align 4
  %input3_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 12), align 4
  %output3 = tail call float @llvm.minimumnum.f32(float %input3_1, float %input3_2)
  store float %output3, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 12), align 4
  %input4_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 16), align 16
  %input4_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 16), align 16
  %output4 = tail call float @llvm.minimumnum.f32(float %input4_1, float %input4_2)
  store float %output4, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 16), align 16
  %input5_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 20), align 4
  %input5_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 20), align 4
  %output5 = tail call float @llvm.minimumnum.f32(float %input5_1, float %input5_2)
  store float %output5, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 20), align 4
  %input6_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 24), align 8
  %input6_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 24), align 8
  %output6 = tail call float @llvm.minimumnum.f32(float %input6_1, float %input6_2)
  store float %output6, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 24), align 8
  %input7_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 28), align 4
  %input7_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 28), align 4
  %output7 = tail call float @llvm.minimumnum.f32(float %input7_1, float %input7_2)
  store float %output7, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 28), align 4
  %input8_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 32), align 16
  %input8_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 32), align 16
  %output8 = tail call float @llvm.minimumnum.f32(float %input8_1, float %input8_2)
  store float %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 32), align 16
  ret void
}

declare float @llvm.minimumnum.f32(float, float)

define void @fmax32()  {
entry:
  %input0_0 = load float, ptr @input1_f32, align 16
  %input0_1 = load float, ptr @input2_f32, align 16
  %output0 = tail call float @llvm.maximumnum.f32(float %input0_0, float %input0_1)
  store float %output0, ptr @output_f32, align 16
  %input1_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 4), align 4
  %input1_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 4), align 4
  %output1 = tail call float @llvm.maximumnum.f32(float %input1_1, float %input1_2)
  store float %output1, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 4), align 4
  %input2_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 8), align 8
  %input2_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 8), align 8
  %output2 = tail call float @llvm.maximumnum.f32(float %input2_1, float %input2_2)
  store float %output2, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 8), align 8
  %input3_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 12), align 4
  %input3_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 12), align 4
  %output3 = tail call float @llvm.maximumnum.f32(float %input3_1, float %input3_2)
  store float %output3, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 12), align 4
  %input4_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 16), align 16
  %input4_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 16), align 16
  %output4 = tail call float @llvm.maximumnum.f32(float %input4_1, float %input4_2)
  store float %output4, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 16), align 16
  %input5_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 20), align 4
  %input5_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 20), align 4
  %output5 = tail call float @llvm.maximumnum.f32(float %input5_1, float %input5_2)
  store float %output5, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 20), align 4
  %input6_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 24), align 8
  %input6_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 24), align 8
  %output6 = tail call float @llvm.maximumnum.f32(float %input6_1, float %input6_2)
  store float %output6, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 24), align 8
  %input7_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 28), align 4
  %input7_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 28), align 4
  %output7 = tail call float @llvm.maximumnum.f32(float %input7_1, float %input7_2)
  store float %output7, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 28), align 4
  %input8_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 32), align 16
  %input8_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 32), align 16
  %output8 = tail call float @llvm.maximumnum.f32(float %input8_1, float %input8_2)
  store float %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 32), align 16
  ret void
}

declare float @llvm.maximumnum.f32(float, float)

define void @fmin64()  {
entry:
  %input0_0 = load double, ptr @input1_f64, align 16
  %input0_1 = load double, ptr @input2_f64, align 16
  %output0 = tail call double @llvm.minimumnum.f64(double %input0_0, double %input0_1)
  store double %output0, ptr @output_f64, align 16
  %input1_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 8), align 8
  %input1_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 8), align 8
  %output1 = tail call double @llvm.minimumnum.f64(double %input1_1, double %input1_2)
  store double %output1, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 8), align 8
  %input2_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 16), align 16
  %input2_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 16), align 16
  %output2 = tail call double @llvm.minimumnum.f64(double %input2_1, double %input2_2)
  store double %output2, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 16), align 16
  %input3_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 24), align 8
  %input3_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 24), align 8
  %output3 = tail call double @llvm.minimumnum.f64(double %input3_1, double %input3_2)
  store double %output3, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 24), align 8
  %input4_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 32), align 16
  %input4_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 32), align 16
  %output4 = tail call double @llvm.minimumnum.f64(double %input4_1, double %input4_2)
  store double %output4, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 32), align 16
  %input5_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 40), align 8
  %input5_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 40), align 8
  %output5 = tail call double @llvm.minimumnum.f64(double %input5_1, double %input5_2)
  store double %output5, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 40), align 8
  %input6_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 48), align 16
  %input6_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 48), align 16
  %output6 = tail call double @llvm.minimumnum.f64(double %input6_1, double %input6_2)
  store double %output6, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 48), align 16
  %input7_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 56), align 8
  %input7_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 56), align 8
  %output7 = tail call double @llvm.minimumnum.f64(double %input7_1, double %input7_2)
  store double %output7, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 56), align 8
  %input8_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 64), align 16
  %input8_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 64), align 16
  %output8 = tail call double @llvm.minimumnum.f64(double %input8_1, double %input8_2)
  store double %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 64), align 16
  ret void
}

declare double @llvm.minimumnum.f64(double, double)

define void @fmax64()  {
entry:
  %input0_0 = load double, ptr @input1_f64, align 16
  %input0_1 = load double, ptr @input2_f64, align 16
  %output0 = tail call double @llvm.maximumnum.f64(double %input0_0, double %input0_1)
  store double %output0, ptr @output_f64, align 16
  %input1_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 8), align 8
  %input1_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 8), align 8
  %output1 = tail call double @llvm.maximumnum.f64(double %input1_1, double %input1_2)
  store double %output1, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 8), align 8
  %input2_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 16), align 16
  %input2_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 16), align 16
  %output2 = tail call double @llvm.maximumnum.f64(double %input2_1, double %input2_2)
  store double %output2, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 16), align 16
  %input3_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 24), align 8
  %input3_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 24), align 8
  %output3 = tail call double @llvm.maximumnum.f64(double %input3_1, double %input3_2)
  store double %output3, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 24), align 8
  %input4_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 32), align 16
  %input4_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 32), align 16
  %output4 = tail call double @llvm.maximumnum.f64(double %input4_1, double %input4_2)
  store double %output4, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 32), align 16
  %input5_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 40), align 8
  %input5_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 40), align 8
  %output5 = tail call double @llvm.maximumnum.f64(double %input5_1, double %input5_2)
  store double %output5, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 40), align 8
  %input6_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 48), align 16
  %input6_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 48), align 16
  %output6 = tail call double @llvm.maximumnum.f64(double %input6_1, double %input6_2)
  store double %output6, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 48), align 16
  %input7_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 56), align 8
  %input7_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 56), align 8
  %output7 = tail call double @llvm.maximumnum.f64(double %input7_1, double %input7_2)
  store double %output7, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 56), align 8
  %input8_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 64), align 16
  %input8_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 64), align 16
  %output8 = tail call double @llvm.maximumnum.f64(double %input8_1, double %input8_2)
  store double %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 64), align 16
  ret void
}

declare double @llvm.maximumnum.f64(double, double)

define void @fmin16()  {
entry:
  %input0_0 = load half, ptr @input1_f16, align 16
  %input0_1 = load half, ptr @input2_f16, align 16
  %output0 = tail call half @llvm.minimumnum.f16(half %input0_0, half %input0_1)
  store half %output0, ptr @output_f16, align 16
  %input1_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 2), align 2
  %input1_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 2), align 2
  %output1 = tail call half @llvm.minimumnum.f16(half %input1_1, half %input1_2)
  store half %output1, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 2), align 2
  %input2_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 4), align 4
  %input2_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 4), align 4
  %output2 = tail call half @llvm.minimumnum.f16(half %input2_1, half %input2_2)
  store half %output2, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 4), align 4
  %input3_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 6), align 2
  %input3_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 6), align 2
  %output3 = tail call half @llvm.minimumnum.f16(half %input3_1, half %input3_2)
  store half %output3, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 6), align 2
  %input4_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 8), align 8
  %input4_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 8), align 8
  %output4 = tail call half @llvm.minimumnum.f16(half %input4_1, half %input4_2)
  store half %output4, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 8), align 8
  %input5_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 10), align 2
  %input5_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 10), align 2
  %output5 = tail call half @llvm.minimumnum.f16(half %input5_1, half %input5_2)
  store half %output5, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 10), align 2
  %input6_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 12), align 4
  %input6_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 12), align 4
  %output6 = tail call half @llvm.minimumnum.f16(half %input6_1, half %input6_2)
  store half %output6, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 12), align 4
  %input7_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 14), align 2
  %input7_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 14), align 2
  %output7 = tail call half @llvm.minimumnum.f16(half %input7_1, half %input7_2)
  store half %output7, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 14), align 2
  %input8_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 16), align 16
  %input8_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 16), align 16
  %output8 = tail call half @llvm.minimumnum.f16(half %input8_1, half %input8_2)
  store half %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 16), align 16
  ret void
}

declare half @llvm.minimumnum.f16(half, half)

define void @fmax16()  {
entry:
  %input0_0 = load half, ptr @input1_f16, align 16
  %input0_1 = load half, ptr @input2_f16, align 16
  %output0 = tail call half @llvm.maximumnum.f16(half %input0_0, half %input0_1)
  store half %output0, ptr @output_f16, align 16
  %input1_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 2), align 2
  %input1_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 2), align 2
  %output1 = tail call half @llvm.maximumnum.f16(half %input1_1, half %input1_2)
  store half %output1, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 2), align 2
  %input2_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 4), align 4
  %input2_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 4), align 4
  %output2 = tail call half @llvm.maximumnum.f16(half %input2_1, half %input2_2)
  store half %output2, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 4), align 4
  %input3_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 6), align 2
  %input3_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 6), align 2
  %output3 = tail call half @llvm.maximumnum.f16(half %input3_1, half %input3_2)
  store half %output3, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 6), align 2
  %input4_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 8), align 8
  %input4_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 8), align 8
  %output4 = tail call half @llvm.maximumnum.f16(half %input4_1, half %input4_2)
  store half %output4, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 8), align 8
  %input5_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 10), align 2
  %input5_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 10), align 2
  %output5 = tail call half @llvm.maximumnum.f16(half %input5_1, half %input5_2)
  store half %output5, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 10), align 2
  %input6_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 12), align 4
  %input6_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 12), align 4
  %output6 = tail call half @llvm.maximumnum.f16(half %input6_1, half %input6_2)
  store half %output6, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 12), align 4
  %input7_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 14), align 2
  %input7_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 14), align 2
  %output7 = tail call half @llvm.maximumnum.f16(half %input7_1, half %input7_2)
  store half %output7, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 14), align 2
  %input8_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 16), align 16
  %input8_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 16), align 16
  %output8 = tail call half @llvm.maximumnum.f16(half %input8_1, half %input8_2)
  store half %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 16), align 16
  ret void
}

declare half @llvm.maximumnum.f16(half, half)

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp28a1oowc.ll'
source_filename = "/tmp/tmp28a1oowc.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

@input1_f32 = global [9 x float] zeroinitializer, align 16
@input2_f32 = global [9 x float] zeroinitializer, align 16
@output_f32 = global [9 x float] zeroinitializer, align 16
@input1_f64 = global [9 x double] zeroinitializer, align 16
@input2_f64 = global [9 x double] zeroinitializer, align 16
@output_f64 = global [9 x double] zeroinitializer, align 16
@input1_f16 = global [9 x half] zeroinitializer, align 16
@input2_f16 = global [9 x half] zeroinitializer, align 16
@output_f16 = global [9 x half] zeroinitializer, align 16

define void @fmin32() #0 {
entry:
  %0 = load <8 x float>, ptr @input1_f32, align 16
  %1 = load <8 x float>, ptr @input2_f32, align 16
  %2 = call <8 x float> @llvm.minimumnum.v8f32(<8 x float> %0, <8 x float> %1)
  store <8 x float> %2, ptr @output_f32, align 16
  %input8_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 32), align 16
  %input8_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 32), align 16
  %output8 = tail call float @llvm.minimumnum.f32(float %input8_1, float %input8_2)
  store float %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 32), align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minimumnum.f32(float, float) #1

define void @fmax32() #0 {
entry:
  %0 = load <8 x float>, ptr @input1_f32, align 16
  %1 = load <8 x float>, ptr @input2_f32, align 16
  %2 = call <8 x float> @llvm.maximumnum.v8f32(<8 x float> %0, <8 x float> %1)
  store <8 x float> %2, ptr @output_f32, align 16
  %input8_1 = load float, ptr getelementptr inbounds nuw (i8, ptr @input1_f32, i64 32), align 16
  %input8_2 = load float, ptr getelementptr inbounds nuw (i8, ptr @input2_f32, i64 32), align 16
  %output8 = tail call float @llvm.maximumnum.f32(float %input8_1, float %input8_2)
  store float %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f32, i64 32), align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maximumnum.f32(float, float) #1

define void @fmin64() #0 {
entry:
  %0 = load <4 x double>, ptr @input1_f64, align 16
  %1 = load <4 x double>, ptr @input2_f64, align 16
  %2 = call <4 x double> @llvm.minimumnum.v4f64(<4 x double> %0, <4 x double> %1)
  store <4 x double> %2, ptr @output_f64, align 16
  %3 = load <4 x double>, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 32), align 16
  %4 = load <4 x double>, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 32), align 16
  %5 = call <4 x double> @llvm.minimumnum.v4f64(<4 x double> %3, <4 x double> %4)
  store <4 x double> %5, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 32), align 16
  %input8_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 64), align 16
  %input8_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 64), align 16
  %output8 = tail call double @llvm.minimumnum.f64(double %input8_1, double %input8_2)
  store double %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 64), align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.minimumnum.f64(double, double) #1

define void @fmax64() #0 {
entry:
  %0 = load <4 x double>, ptr @input1_f64, align 16
  %1 = load <4 x double>, ptr @input2_f64, align 16
  %2 = call <4 x double> @llvm.maximumnum.v4f64(<4 x double> %0, <4 x double> %1)
  store <4 x double> %2, ptr @output_f64, align 16
  %3 = load <4 x double>, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 32), align 16
  %4 = load <4 x double>, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 32), align 16
  %5 = call <4 x double> @llvm.maximumnum.v4f64(<4 x double> %3, <4 x double> %4)
  store <4 x double> %5, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 32), align 16
  %input8_1 = load double, ptr getelementptr inbounds nuw (i8, ptr @input1_f64, i64 64), align 16
  %input8_2 = load double, ptr getelementptr inbounds nuw (i8, ptr @input2_f64, i64 64), align 16
  %output8 = tail call double @llvm.maximumnum.f64(double %input8_1, double %input8_2)
  store double %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f64, i64 64), align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.maximumnum.f64(double, double) #1

define void @fmin16() #0 {
entry:
  %0 = load <8 x half>, ptr @input1_f16, align 16
  %1 = load <8 x half>, ptr @input2_f16, align 16
  %2 = call <8 x half> @llvm.minimumnum.v8f16(<8 x half> %0, <8 x half> %1)
  store <8 x half> %2, ptr @output_f16, align 16
  %input8_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 16), align 16
  %input8_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 16), align 16
  %output8 = tail call half @llvm.minimumnum.f16(half %input8_1, half %input8_2)
  store half %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 16), align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.minimumnum.f16(half, half) #1

define void @fmax16() #0 {
entry:
  %0 = load <8 x half>, ptr @input1_f16, align 16
  %1 = load <8 x half>, ptr @input2_f16, align 16
  %2 = call <8 x half> @llvm.maximumnum.v8f16(<8 x half> %0, <8 x half> %1)
  store <8 x half> %2, ptr @output_f16, align 16
  %input8_1 = load half, ptr getelementptr inbounds nuw (i8, ptr @input1_f16, i64 16), align 16
  %input8_2 = load half, ptr getelementptr inbounds nuw (i8, ptr @input2_f16, i64 16), align 16
  %output8 = tail call half @llvm.maximumnum.f16(half %input8_1, half %input8_2)
  store half %output8, ptr getelementptr inbounds nuw (i8, ptr @output_f16, i64 16), align 16
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.maximumnum.f16(half, half) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.minimumnum.v8f32(<8 x float>, <8 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.maximumnum.v8f32(<8 x float>, <8 x float>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x double> @llvm.minimumnum.v4f64(<4 x double>, <4 x double>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x double> @llvm.maximumnum.v4f64(<4 x double>, <4 x double>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x half> @llvm.minimumnum.v8f16(<8 x half>, <8 x half>) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x half> @llvm.maximumnum.v8f16(<8 x half>, <8 x half>) #2

attributes #0 = { "target-features"="+v,+zvfhmin" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v,+zvfhmin" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
