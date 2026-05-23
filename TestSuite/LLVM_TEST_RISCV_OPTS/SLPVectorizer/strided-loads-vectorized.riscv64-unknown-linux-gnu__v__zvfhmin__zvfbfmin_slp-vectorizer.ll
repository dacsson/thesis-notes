; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/strided-loads-vectorized.ll
; Variant: riscv64-unknown-linux-gnu_+v,+zvfhmin,+zvfbfmin_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v,+zvfhmin,+zvfbfmin -S
; Original: RUN: opt -passes=slp-vectorizer -S -mtriple=riscv64-unknown-linux-gnu -mattr=+v,+zvfhmin,+zvfbfmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN-ZVFBFMIN

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @test(ptr %p, ptr noalias %s) {
entry:
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %i = load float, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %i1 = load float, ptr %arrayidx1, align 4
  %add = fsub fast float %i1, %i
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  store float %add, ptr %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 4
  %i2 = load float, ptr %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 26
  %i3 = load float, ptr %arrayidx6, align 4
  %add7 = fsub fast float %i3, %i2
  %arrayidx9 = getelementptr inbounds float, ptr %s, i64 1
  store float %add7, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 8
  %i4 = load float, ptr %arrayidx11, align 4
  %arrayidx13 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 22
  %i5 = load float, ptr %arrayidx13, align 4
  %add14 = fsub fast float %i5, %i4
  %arrayidx16 = getelementptr inbounds float, ptr %s, i64 2
  store float %add14, ptr %arrayidx16, align 4
  %arrayidx18 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 12
  %i6 = load float, ptr %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 18
  %i7 = load float, ptr %arrayidx20, align 4
  %add21 = fsub fast float %i7, %i6
  %arrayidx23 = getelementptr inbounds float, ptr %s, i64 3
  store float %add21, ptr %arrayidx23, align 4
  %arrayidx25 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 16
  %i8 = load float, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 14
  %i9 = load float, ptr %arrayidx27, align 4
  %add28 = fsub fast float %i9, %i8
  %arrayidx30 = getelementptr inbounds float, ptr %s, i64 4
  store float %add28, ptr %arrayidx30, align 4
  %arrayidx32 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 20
  %i10 = load float, ptr %arrayidx32, align 4
  %arrayidx34 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 10
  %i11 = load float, ptr %arrayidx34, align 4
  %add35 = fsub fast float %i11, %i10
  %arrayidx37 = getelementptr inbounds float, ptr %s, i64 5
  store float %add35, ptr %arrayidx37, align 4
  %arrayidx39 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 24
  %i12 = load float, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 6
  %i13 = load float, ptr %arrayidx41, align 4
  %add42 = fsub fast float %i13, %i12
  %arrayidx44 = getelementptr inbounds float, ptr %s, i64 6
  store float %add42, ptr %arrayidx44, align 4
  %arrayidx46 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 28
  %i14 = load float, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 2
  %i15 = load float, ptr %arrayidx48, align 4
  %add49 = fsub fast float %i15, %i14
  %arrayidx51 = getelementptr inbounds float, ptr %s, i64 7
  store float %add49, ptr %arrayidx51, align 4
  ret void
}

define void @test1(ptr %p, ptr noalias %s, i32 %stride) {
entry:
  %str = zext i32 %stride to i64
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %i = load float, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %i1 = load float, ptr %arrayidx1, align 4
  %add = fsub fast float %i1, %i
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  store float %add, ptr %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %str
  %i2 = load float, ptr %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 26
  %i3 = load float, ptr %arrayidx6, align 4
  %add7 = fsub fast float %i3, %i2
  %arrayidx9 = getelementptr inbounds float, ptr %s, i64 1
  store float %add7, ptr %arrayidx9, align 4
  %st1 = mul i64 %str, 2
  %arrayidx11 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st1
  %i4 = load float, ptr %arrayidx11, align 4
  %arrayidx13 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 22
  %i5 = load float, ptr %arrayidx13, align 4
  %add14 = fsub fast float %i5, %i4
  %arrayidx16 = getelementptr inbounds float, ptr %s, i64 2
  store float %add14, ptr %arrayidx16, align 4
  %st2 = mul i64 %str, 3
  %arrayidx18 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st2
  %i6 = load float, ptr %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 18
  %i7 = load float, ptr %arrayidx20, align 4
  %add21 = fsub fast float %i7, %i6
  %arrayidx23 = getelementptr inbounds float, ptr %s, i64 3
  store float %add21, ptr %arrayidx23, align 4
  %st3 = mul i64 %str, 4
  %arrayidx25 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st3
  %i8 = load float, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 14
  %i9 = load float, ptr %arrayidx27, align 4
  %add28 = fsub fast float %i9, %i8
  %arrayidx30 = getelementptr inbounds float, ptr %s, i64 4
  store float %add28, ptr %arrayidx30, align 4
  %st4 = mul i64 %str, 5
  %arrayidx32 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st4
  %i10 = load float, ptr %arrayidx32, align 4
  %arrayidx34 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 10
  %i11 = load float, ptr %arrayidx34, align 4
  %add35 = fsub fast float %i11, %i10
  %arrayidx37 = getelementptr inbounds float, ptr %s, i64 5
  store float %add35, ptr %arrayidx37, align 4
  %st5 = mul i64 %str, 6
  %arrayidx39 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st5
  %i12 = load float, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 6
  %i13 = load float, ptr %arrayidx41, align 4
  %add42 = fsub fast float %i13, %i12
  %arrayidx44 = getelementptr inbounds float, ptr %s, i64 6
  store float %add42, ptr %arrayidx44, align 4
  %st6 = mul i64 %str, 7
  %arrayidx46 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st6
  %i14 = load float, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 2
  %i15 = load float, ptr %arrayidx48, align 4
  %add49 = fsub fast float %i15, %i14
  %arrayidx51 = getelementptr inbounds float, ptr %s, i64 7
  store float %add49, ptr %arrayidx51, align 4
  ret void
}

define void @test2(ptr %p, ptr noalias %s, i32 %stride) {
entry:
  %str = zext i32 %stride to i64
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 2
  %i = load float, ptr %arrayidx, align 4
  %st6 = mul i64 %str, 7
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st6
  %i1 = load float, ptr %arrayidx1, align 4
  %add = fsub fast float %i1, %i
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  store float %add, ptr %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 6
  %i2 = load float, ptr %arrayidx4, align 4
  %st5 = mul i64 %str, 6
  %arrayidx6 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st5
  %i3 = load float, ptr %arrayidx6, align 4
  %add7 = fsub fast float %i3, %i2
  %arrayidx9 = getelementptr inbounds float, ptr %s, i64 1
  store float %add7, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 10
  %i4 = load float, ptr %arrayidx11, align 4
  %st4 = mul i64 %str, 5
  %arrayidx13 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st4
  %i5 = load float, ptr %arrayidx13, align 4
  %add14 = fsub fast float %i5, %i4
  %arrayidx16 = getelementptr inbounds float, ptr %s, i64 2
  store float %add14, ptr %arrayidx16, align 4
  %arrayidx18 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 14
  %i6 = load float, ptr %arrayidx18, align 4
  %st3 = mul i64 %str, 4
  %arrayidx20 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st3
  %i7 = load float, ptr %arrayidx20, align 4
  %add21 = fsub fast float %i7, %i6
  %arrayidx23 = getelementptr inbounds float, ptr %s, i64 3
  store float %add21, ptr %arrayidx23, align 4
  %arrayidx25 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 18
  %st2 = mul i64 %str, 3
  %i8 = load float, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st2
  %i9 = load float, ptr %arrayidx27, align 4
  %add28 = fsub fast float %i9, %i8
  %arrayidx30 = getelementptr inbounds float, ptr %s, i64 4
  store float %add28, ptr %arrayidx30, align 4
  %arrayidx32 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 22
  %i10 = load float, ptr %arrayidx32, align 4
  %st1 = mul i64 %str, 2
  %arrayidx34 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st1
  %i11 = load float, ptr %arrayidx34, align 4
  %add35 = fsub fast float %i11, %i10
  %arrayidx37 = getelementptr inbounds float, ptr %s, i64 5
  store float %add35, ptr %arrayidx37, align 4
  %arrayidx39 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 26
  %i12 = load float, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %str
  %i13 = load float, ptr %arrayidx41, align 4
  %add42 = fsub fast float %i13, %i12
  %arrayidx44 = getelementptr inbounds float, ptr %s, i64 6
  store float %add42, ptr %arrayidx44, align 4
  %arrayidx46 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %i14 = load float, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %i15 = load float, ptr %arrayidx48, align 4
  %add49 = fsub fast float %i15, %i14
  %arrayidx51 = getelementptr inbounds float, ptr %s, i64 7
  store float %add49, ptr %arrayidx51, align 4
  ret void
}

define void @test3(ptr %p, ptr noalias %s) {
entry:
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %i = load float, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %i1 = load float, ptr %arrayidx1, align 4
  %add = fsub fast float %i1, %i
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  store float %add, ptr %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 4
  %i2 = load float, ptr %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 29
  %i3 = load float, ptr %arrayidx6, align 4
  %add7 = fsub fast float %i3, %i2
  %arrayidx9 = getelementptr inbounds float, ptr %s, i64 1
  store float %add7, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 8
  %i4 = load float, ptr %arrayidx11, align 4
  %arrayidx13 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 28
  %i5 = load float, ptr %arrayidx13, align 4
  %add14 = fsub fast float %i5, %i4
  %arrayidx16 = getelementptr inbounds float, ptr %s, i64 2
  store float %add14, ptr %arrayidx16, align 4
  %arrayidx18 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 12
  %i6 = load float, ptr %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 27
  %i7 = load float, ptr %arrayidx20, align 4
  %add21 = fsub fast float %i7, %i6
  %arrayidx23 = getelementptr inbounds float, ptr %s, i64 3
  store float %add21, ptr %arrayidx23, align 4
  %arrayidx25 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 16
  %i8 = load float, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 26
  %i9 = load float, ptr %arrayidx27, align 4
  %add28 = fsub fast float %i9, %i8
  %arrayidx30 = getelementptr inbounds float, ptr %s, i64 4
  store float %add28, ptr %arrayidx30, align 4
  %arrayidx32 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 20
  %i10 = load float, ptr %arrayidx32, align 4
  %arrayidx34 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 25
  %i11 = load float, ptr %arrayidx34, align 4
  %add35 = fsub fast float %i11, %i10
  %arrayidx37 = getelementptr inbounds float, ptr %s, i64 5
  store float %add35, ptr %arrayidx37, align 4
  %arrayidx39 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 24
  %i12 = load float, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 24
  %i13 = load float, ptr %arrayidx41, align 4
  %add42 = fsub fast float %i13, %i12
  %arrayidx44 = getelementptr inbounds float, ptr %s, i64 6
  store float %add42, ptr %arrayidx44, align 4
  %arrayidx46 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 28
  %i14 = load float, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 23
  %i15 = load float, ptr %arrayidx48, align 4
  %add49 = fsub fast float %i15, %i14
  %arrayidx51 = getelementptr inbounds float, ptr %s, i64 7
  store float %add49, ptr %arrayidx51, align 4
  ret void
}


define void @test_bf16(ptr %p, ptr noalias %s) {
entry:
  %arrayidx = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 0
  %i = load bfloat, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 30
  %i1 = load bfloat, ptr %arrayidx1, align 4
  %add = fsub fast bfloat %i1, %i
  %arrayidx2 = getelementptr inbounds bfloat, ptr %s, i64 0
  store bfloat %add, ptr %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 4
  %i2 = load bfloat, ptr %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 26
  %i3 = load bfloat, ptr %arrayidx6, align 4
  %add7 = fsub fast bfloat %i3, %i2
  %arrayidx9 = getelementptr inbounds bfloat, ptr %s, i64 1
  store bfloat %add7, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 8
  %i4 = load bfloat, ptr %arrayidx11, align 4
  %arrayidx13 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 22
  %i5 = load bfloat, ptr %arrayidx13, align 4
  %add14 = fsub fast bfloat %i5, %i4
  %arrayidx16 = getelementptr inbounds bfloat, ptr %s, i64 2
  store bfloat %add14, ptr %arrayidx16, align 4
  %arrayidx18 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 12
  %i6 = load bfloat, ptr %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 18
  %i7 = load bfloat, ptr %arrayidx20, align 4
  %add21 = fsub fast bfloat %i7, %i6
  %arrayidx23 = getelementptr inbounds bfloat, ptr %s, i64 3
  store bfloat %add21, ptr %arrayidx23, align 4
  %arrayidx25 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 16
  %i8 = load bfloat, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 14
  %i9 = load bfloat, ptr %arrayidx27, align 4
  %add28 = fsub fast bfloat %i9, %i8
  %arrayidx30 = getelementptr inbounds bfloat, ptr %s, i64 4
  store bfloat %add28, ptr %arrayidx30, align 4
  %arrayidx32 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 20
  %i10 = load bfloat, ptr %arrayidx32, align 4
  %arrayidx34 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 10
  %i11 = load bfloat, ptr %arrayidx34, align 4
  %add35 = fsub fast bfloat %i11, %i10
  %arrayidx37 = getelementptr inbounds bfloat, ptr %s, i64 5
  store bfloat %add35, ptr %arrayidx37, align 4
  %arrayidx39 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 24
  %i12 = load bfloat, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 6
  %i13 = load bfloat, ptr %arrayidx41, align 4
  %add42 = fsub fast bfloat %i13, %i12
  %arrayidx44 = getelementptr inbounds bfloat, ptr %s, i64 6
  store bfloat %add42, ptr %arrayidx44, align 4
  %arrayidx46 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 28
  %i14 = load bfloat, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 2
  %i15 = load bfloat, ptr %arrayidx48, align 4
  %add49 = fsub fast bfloat %i15, %i14
  %arrayidx51 = getelementptr inbounds bfloat, ptr %s, i64 7
  store bfloat %add49, ptr %arrayidx51, align 4
  ret void
}

define void @test_f16(ptr %p, ptr noalias %s) {
entry:
  %arrayidx = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 0
  %i = load half, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 30
  %i1 = load half, ptr %arrayidx1, align 4
  %add = fsub fast half %i1, %i
  %arrayidx2 = getelementptr inbounds half, ptr %s, i64 0
  store half %add, ptr %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 4
  %i2 = load half, ptr %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 26
  %i3 = load half, ptr %arrayidx6, align 4
  %add7 = fsub fast half %i3, %i2
  %arrayidx9 = getelementptr inbounds half, ptr %s, i64 1
  store half %add7, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 8
  %i4 = load half, ptr %arrayidx11, align 4
  %arrayidx13 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 22
  %i5 = load half, ptr %arrayidx13, align 4
  %add14 = fsub fast half %i5, %i4
  %arrayidx16 = getelementptr inbounds half, ptr %s, i64 2
  store half %add14, ptr %arrayidx16, align 4
  %arrayidx18 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 12
  %i6 = load half, ptr %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 18
  %i7 = load half, ptr %arrayidx20, align 4
  %add21 = fsub fast half %i7, %i6
  %arrayidx23 = getelementptr inbounds half, ptr %s, i64 3
  store half %add21, ptr %arrayidx23, align 4
  %arrayidx25 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 16
  %i8 = load half, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 14
  %i9 = load half, ptr %arrayidx27, align 4
  %add28 = fsub fast half %i9, %i8
  %arrayidx30 = getelementptr inbounds half, ptr %s, i64 4
  store half %add28, ptr %arrayidx30, align 4
  %arrayidx32 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 20
  %i10 = load half, ptr %arrayidx32, align 4
  %arrayidx34 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 10
  %i11 = load half, ptr %arrayidx34, align 4
  %add35 = fsub fast half %i11, %i10
  %arrayidx37 = getelementptr inbounds half, ptr %s, i64 5
  store half %add35, ptr %arrayidx37, align 4
  %arrayidx39 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 24
  %i12 = load half, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 6
  %i13 = load half, ptr %arrayidx41, align 4
  %add42 = fsub fast half %i13, %i12
  %arrayidx44 = getelementptr inbounds half, ptr %s, i64 6
  store half %add42, ptr %arrayidx44, align 4
  %arrayidx46 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 28
  %i14 = load half, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 2
  %i15 = load half, ptr %arrayidx48, align 4
  %add49 = fsub fast half %i15, %i14
  %arrayidx51 = getelementptr inbounds half, ptr %s, i64 7
  store half %add49, ptr %arrayidx51, align 4
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpet1tp9vl.ll'
source_filename = "/tmp/tmpet1tp9vl.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test(ptr %p, ptr noalias %s) #0 {
entry:
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  %0 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx, i64 16, <8 x i1> splat (i1 true), i32 8)
  %1 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx1, i64 -16, <8 x i1> splat (i1 true), i32 8)
  %2 = fsub fast <8 x float> %1, %0
  store <8 x float> %2, ptr %arrayidx2, align 4
  ret void
}

define void @test1(ptr %p, ptr noalias %s, i32 %stride) #0 {
entry:
  %str = zext i32 %stride to i64
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  %0 = mul i64 %str, 4
  %1 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx, i64 %0, <8 x i1> splat (i1 true), i32 8)
  %2 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx1, i64 -16, <8 x i1> splat (i1 true), i32 8)
  %3 = fsub fast <8 x float> %2, %1
  store <8 x float> %3, ptr %arrayidx2, align 4
  ret void
}

define void @test2(ptr %p, ptr noalias %s, i32 %stride) #0 {
entry:
  %str = zext i32 %stride to i64
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 2
  %st6 = mul i64 %str, 7
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 %st6
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  %0 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx, i64 16, <8 x i1> splat (i1 true), i32 8)
  %1 = mul i64 %str, -4
  %2 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx1, i64 %1, <8 x i1> splat (i1 true), i32 8)
  %3 = fsub fast <8 x float> %2, %0
  store <8 x float> %3, ptr %arrayidx2, align 4
  ret void
}

define void @test3(ptr %p, ptr noalias %s) #0 {
entry:
  %arrayidx = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 0
  %arrayidx1 = getelementptr inbounds [48 x float], ptr %p, i64 0, i64 30
  %arrayidx2 = getelementptr inbounds float, ptr %s, i64 0
  %0 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx, i64 16, <8 x i1> splat (i1 true), i32 8)
  %1 = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr align 4 %arrayidx1, i64 -4, <8 x i1> splat (i1 true), i32 8)
  %2 = fsub fast <8 x float> %1, %0
  store <8 x float> %2, ptr %arrayidx2, align 4
  ret void
}

define void @test_bf16(ptr %p, ptr noalias %s) #0 {
entry:
  %arrayidx = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 0
  %arrayidx1 = getelementptr inbounds [48 x bfloat], ptr %p, i64 0, i64 30
  %arrayidx2 = getelementptr inbounds bfloat, ptr %s, i64 0
  %0 = call <8 x bfloat> @llvm.experimental.vp.strided.load.v8bf16.p0.i64(ptr align 4 %arrayidx, i64 8, <8 x i1> splat (i1 true), i32 8)
  %1 = call <8 x bfloat> @llvm.experimental.vp.strided.load.v8bf16.p0.i64(ptr align 4 %arrayidx1, i64 -8, <8 x i1> splat (i1 true), i32 8)
  %2 = fsub fast <8 x bfloat> %1, %0
  store <8 x bfloat> %2, ptr %arrayidx2, align 4
  ret void
}

define void @test_f16(ptr %p, ptr noalias %s) #0 {
entry:
  %arrayidx = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 0
  %arrayidx1 = getelementptr inbounds [48 x half], ptr %p, i64 0, i64 30
  %arrayidx2 = getelementptr inbounds half, ptr %s, i64 0
  %0 = call <8 x half> @llvm.experimental.vp.strided.load.v8f16.p0.i64(ptr align 4 %arrayidx, i64 8, <8 x i1> splat (i1 true), i32 8)
  %1 = call <8 x half> @llvm.experimental.vp.strided.load.v8f16.p0.i64(ptr align 4 %arrayidx1, i64 -8, <8 x i1> splat (i1 true), i32 8)
  %2 = fsub fast <8 x half> %1, %0
  store <8 x half> %2, ptr %arrayidx2, align 4
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i64(ptr captures(none), i64, <8 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <8 x bfloat> @llvm.experimental.vp.strided.load.v8bf16.p0.i64(ptr captures(none), i64, <8 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <8 x half> @llvm.experimental.vp.strided.load.v8f16.p0.i64(ptr captures(none), i64, <8 x i1>, i32) #1

attributes #0 = { "target-features"="+v,+zvfhmin,+zvfbfmin" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
