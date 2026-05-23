; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/basic-strided-stores.ll
; Variant: riscv64_+m,+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+m,+v -passes=slp-vectorizer -slp-enable-strided-stores -S
; Original: RUN: opt -mtriple=riscv64 -mattr=+m,+v -passes=slp-vectorizer -S -slp-enable-strided-stores < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @constant_stride_2(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 8
  %gep_s5 = getelementptr i8, ptr %ps, i64 10
  %gep_s6 = getelementptr i8, ptr %ps, i64 12
  %gep_s7 = getelementptr i8, ptr %ps, i64 14

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @constant_stride_7(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 7
  %gep_s2 = getelementptr i8, ptr %ps, i64 14
  %gep_s3 = getelementptr i8, ptr %ps, i64 21
  %gep_s4 = getelementptr i8, ptr %ps, i64 28
  %gep_s5 = getelementptr i8, ptr %ps, i64 35
  %gep_s6 = getelementptr i8, ptr %ps, i64 42
  %gep_s7 = getelementptr i8, ptr %ps, i64 49

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @constant_stride_0(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  store i8 %load0, ptr %ps
  store i8 %load1, ptr %ps
  store i8 %load2, ptr %ps
  store i8 %load3, ptr %ps
  store i8 %load4, ptr %ps
  store i8 %load5, ptr %ps
  store i8 %load6, ptr %ps
  store i8 %load7, ptr %ps

  ret void
}

define void @two_constant_strides(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 9
  %gep_s5 = getelementptr i8, ptr %ps, i64 11
  %gep_s6 = getelementptr i8, ptr %ps, i64 13
  %gep_s7 = getelementptr i8, ptr %ps, i64 15

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @constant_strides_variable_gap(ptr %pl, ptr %ps, i64 %gap) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 7
  %gep_s2 = getelementptr i8, ptr %ps, i64 14
  %gep_s3 = getelementptr i8, ptr %ps, i64 21

  %gap_ps = getelementptr i8, ptr %ps, i64 %gap
  %gep_s4 = getelementptr i8, ptr %gap_ps, i64 28
  %gep_s5 = getelementptr i8, ptr %gap_ps, i64 35
  %gep_s6 = getelementptr i8, ptr %gap_ps, i64 42
  %gep_s7 = getelementptr i8, ptr %gap_ps, i64 49

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @overlapping_strides(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 5
  %gep_s5 = getelementptr i8, ptr %ps, i64 8
  %gep_s6 = getelementptr i8, ptr %ps, i64 11
  %gep_s7 = getelementptr i8, ptr %ps, i64 14

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @constant_stride_unit_stride(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 8
  %gep_s5 = getelementptr i8, ptr %ps, i64 9
  %gep_s6 = getelementptr i8, ptr %ps, i64 10
  %gep_s7 = getelementptr i8, ptr %ps, i64 11

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @unit_stride_constant_stride(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 1
  %gep_s2 = getelementptr i8, ptr %ps, i64 2
  %gep_s3 = getelementptr i8, ptr %ps, i64 3
  %gep_s4 = getelementptr i8, ptr %ps, i64 9
  %gep_s5 = getelementptr i8, ptr %ps, i64 11
  %gep_s6 = getelementptr i8, ptr %ps, i64 13
  %gep_s7 = getelementptr i8, ptr %ps, i64 15

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @overlap(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 1
  %gep_s2 = getelementptr i8, ptr %ps, i64 2
  %gep_s3 = getelementptr i8, ptr %ps, i64 3
  %gep_s4 = getelementptr i8, ptr %ps, i64 5
  %gep_s5 = getelementptr i8, ptr %ps, i64 7
  %gep_s6 = getelementptr i8, ptr %ps, i64 9
  %gep_s7 = getelementptr i8, ptr %ps, i64 11

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s7

  ret void
}

define void @overlap2(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 7
  %gep_s5 = getelementptr i8, ptr %ps, i64 8
  %gep_s6 = getelementptr i8, ptr %ps, i64 9

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s1
  store i8 %load2, ptr %gep_s2
  store i8 %load3, ptr %gep_s3
  store i8 %load4, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6

  ret void
}

define void @vf_ordering_issue(ptr %pl, ptr %ps) {
  %gep_l0  = getelementptr i8, ptr %pl, i64 0
  %gep_l1  = getelementptr i8, ptr %pl, i64 38
  %gep_l2  = getelementptr i8, ptr %pl, i64 92
  %gep_l3  = getelementptr i8, ptr %pl, i64 33
  %gep_l4  = getelementptr i8, ptr %pl, i64 4
  %gep_l5  = getelementptr i8, ptr %pl, i64 5
  %gep_l6  = getelementptr i8, ptr %pl, i64 6
  %gep_l7  = getelementptr i8, ptr %pl, i64 7
  %gep_l8  = getelementptr i8, ptr %pl, i64 8
  %gep_l9  = getelementptr i8, ptr %pl, i64 9
  %gep_l10 = getelementptr i8, ptr %pl, i64 10
  %gep_l11 = getelementptr i8, ptr %pl, i64 11
  %gep_l12 = getelementptr i8, ptr %pl, i64 13
  %gep_l13 = getelementptr i8, ptr %pl, i64 83
  %gep_l14 = getelementptr i8, ptr %pl, i64 32
  %gep_l15 = getelementptr i8, ptr %pl, i64 15
  %gep_l16 = getelementptr i8, ptr %pl, i64 16
  %gep_l17 = getelementptr i8, ptr %pl, i64 17
  %gep_l18 = getelementptr i8, ptr %pl, i64 18
  %gep_l19 = getelementptr i8, ptr %pl, i64 19
  %gep_l20 = getelementptr i8, ptr %pl, i64 20
  %gep_l21 = getelementptr i8, ptr %pl, i64 21
  %gep_l22 = getelementptr i8, ptr %pl, i64 22
  %gep_l23 = getelementptr i8, ptr %pl, i64 23

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7
  %load8  = load i8, ptr %gep_l8
  %load9  = load i8, ptr %gep_l9
  %load10 = load i8, ptr %gep_l10
  %load11 = load i8, ptr %gep_l11
  %load12 = load i8, ptr %gep_l12
  %load13 = load i8, ptr %gep_l13
  %load14 = load i8, ptr %gep_l14
  %load15 = load i8, ptr %gep_l15
  %load16 = load i8, ptr %gep_l16
  %load17 = load i8, ptr %gep_l17
  %load18 = load i8, ptr %gep_l18
  %load19 = load i8, ptr %gep_l19
  %load20 = load i8, ptr %gep_l20
  %load21 = load i8, ptr %gep_l21
  %load22 = load i8, ptr %gep_l22
  %load23 = load i8, ptr %gep_l23

  %add4 = add i8 %load4, 1
  %add5 = add i8 %load5, 1
  %add6 = add i8 %load6, 1
  %add7 = add i8 %load7, 1
  %add8 = add i8 %load8, 1
  %add9 = add i8 %load9, 1
  %add10 = add i8 %load10, 1
  %add11 = add i8 %load11, 1

  %gep_s0  = getelementptr i8, ptr %ps, i64 0
  %gep_s1  = getelementptr i8, ptr %ps, i64 2
  %gep_s2  = getelementptr i8, ptr %ps, i64 4
  %gep_s3  = getelementptr i8, ptr %ps, i64 6
  %gep_s4  = getelementptr i8, ptr %ps, i64 8
  %gep_s5  = getelementptr i8, ptr %ps, i64 9
  %gep_s6  = getelementptr i8, ptr %ps, i64 10
  %gep_s7  = getelementptr i8, ptr %ps, i64 11
  %gep_s8  = getelementptr i8, ptr %ps, i64 12
  %gep_s9  = getelementptr i8, ptr %ps, i64 13
  %gep_s10 = getelementptr i8, ptr %ps, i64 14
  %gep_s11 = getelementptr i8, ptr %ps, i64 15
  %gep_s12 = getelementptr i8, ptr %ps, i64 16
  %gep_s13 = getelementptr i8, ptr %ps, i64 18
  %gep_s14 = getelementptr i8, ptr %ps, i64 20
  %gep_s15 = getelementptr i8, ptr %ps, i64 22
  %gep_s16 = getelementptr i8, ptr %ps, i64 24
  %gep_s17 = getelementptr i8, ptr %ps, i64 26
  %gep_s18 = getelementptr i8, ptr %ps, i64 28
  %gep_s19 = getelementptr i8, ptr %ps, i64 30
  %gep_s20 = getelementptr i8, ptr %ps, i64 32
  %gep_s21 = getelementptr i8, ptr %ps, i64 34
  %gep_s22 = getelementptr i8, ptr %ps, i64 36
  %gep_s23 = getelementptr i8, ptr %ps, i64 38

  store i8 %load0 , ptr %gep_s0
  store i8 %load1 , ptr %gep_s1
  store i8 %load2 , ptr %gep_s2
  store i8 %load3 , ptr %gep_s3
  store i8 %add4 , ptr %gep_s4
  store i8 %add5 , ptr %gep_s5
  store i8 %add6 , ptr %gep_s6
  store i8 %add7 , ptr %gep_s7
  store i8 %add8 , ptr %gep_s8
  store i8 %add9 , ptr %gep_s9
  store i8 %add10 , ptr %gep_s10
  store i8 %add11 , ptr %gep_s11
  store i8 %load12 , ptr %gep_s12
  store i8 %load13 , ptr %gep_s13
  store i8 %load14 , ptr %gep_s14
  store i8 %load15 , ptr %gep_s15
  store i8 %load16 , ptr %gep_s16
  store i8 %load17 , ptr %gep_s17
  store i8 %load18 , ptr %gep_s18
  store i8 %load19 , ptr %gep_s19
  store i8 %load20 , ptr %gep_s20
  store i8 %load21 , ptr %gep_s21
  store i8 %load22 , ptr %gep_s22
  store i8 %load23 , ptr %gep_s23

  ret void
}

define void @constant_stride_reorder_data(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 8
  %gep_s5 = getelementptr i8, ptr %ps, i64 10
  %gep_s6 = getelementptr i8, ptr %ps, i64 12
  %gep_s7 = getelementptr i8, ptr %ps, i64 14

  store i8 %load0, ptr %gep_s0
  store i8 %load2, ptr %gep_s1
  store i8 %load1, ptr %gep_s2
  store i8 %load7, ptr %gep_s3
  store i8 %load3, ptr %gep_s4
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load4, ptr %gep_s7

  ret void
}

define void @constant_stride_reorder_geps(ptr %pl, ptr %ps) {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7

  %load0  = load i8, ptr %gep_l0
  %load1  = load i8, ptr %gep_l1
  %load2  = load i8, ptr %gep_l2
  %load3  = load i8, ptr %gep_l3
  %load4  = load i8, ptr %gep_l4
  %load5  = load i8, ptr %gep_l5
  %load6  = load i8, ptr %gep_l6
  %load7  = load i8, ptr %gep_l7

  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 8
  %gep_s5 = getelementptr i8, ptr %ps, i64 10
  %gep_s6 = getelementptr i8, ptr %ps, i64 12
  %gep_s7 = getelementptr i8, ptr %ps, i64 14

  store i8 %load0, ptr %gep_s0
  store i8 %load1, ptr %gep_s2
  store i8 %load2, ptr %gep_s1
  store i8 %load3, ptr %gep_s7
  store i8 %load4, ptr %gep_s3
  store i8 %load5, ptr %gep_s5
  store i8 %load6, ptr %gep_s6
  store i8 %load7, ptr %gep_s4

  ret void
}

define void @reversed_addr_data_reorder(ptr %pl, ptr %ps) {
  %l0 = getelementptr i8, ptr %pl, i64 0
  %l1 = getelementptr i8, ptr %pl, i64 1
  %l2 = getelementptr i8, ptr %pl, i64 2
  %l3 = getelementptr i8, ptr %pl, i64 3
  %l4 = getelementptr i8, ptr %pl, i64 4
  %l5 = getelementptr i8, ptr %pl, i64 5
  %l6 = getelementptr i8, ptr %pl, i64 6
  %l7 = getelementptr i8, ptr %pl, i64 7
  %v0 = load i8, ptr %l0, align 1
  %v1 = load i8, ptr %l1, align 1
  %v2 = load i8, ptr %l2, align 1
  %v3 = load i8, ptr %l3, align 1
  %v4 = load i8, ptr %l4, align 1
  %v5 = load i8, ptr %l5, align 1
  %v6 = load i8, ptr %l6, align 1
  %v7 = load i8, ptr %l7, align 1
  %s0 = getelementptr i8, ptr %ps, i64 14
  %s1 = getelementptr i8, ptr %ps, i64 12
  %s2 = getelementptr i8, ptr %ps, i64 10
  %s3 = getelementptr i8, ptr %ps, i64 8
  %s4 = getelementptr i8, ptr %ps, i64 6
  %s5 = getelementptr i8, ptr %ps, i64 4
  %s6 = getelementptr i8, ptr %ps, i64 2
  %s7 = getelementptr i8, ptr %ps, i64 0
  store i8 %v0, ptr %s0, align 1
  store i8 %v3, ptr %s1, align 1
  store i8 %v1, ptr %s2, align 1
  store i8 %v6, ptr %s3, align 1
  store i8 %v2, ptr %s4, align 1
  store i8 %v7, ptr %s5, align 1
  store i8 %v5, ptr %s6, align 1
  store i8 %v4, ptr %s7, align 1
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpvjesxtdq.ll'
source_filename = "/tmp/tmpvjesxtdq.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @constant_stride_2(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %1 = load <8 x i8>, ptr %gep_l0, align 1
  call void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8> %1, ptr align 1 %gep_s0, i64 2, <8 x i1> splat (i1 true), i32 8)
  ret void
}

define void @constant_stride_7(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %1 = load <8 x i8>, ptr %gep_l0, align 1
  call void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8> %1, ptr align 1 %gep_s0, i64 7, <8 x i1> splat (i1 true), i32 8)
  ret void
}

define void @constant_stride_0(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 1
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l5 = getelementptr i8, ptr %pl, i64 5
  %gep_l6 = getelementptr i8, ptr %pl, i64 6
  %gep_l7 = getelementptr i8, ptr %pl, i64 7
  %load0 = load i8, ptr %gep_l0, align 1
  %load1 = load i8, ptr %gep_l1, align 1
  %load2 = load i8, ptr %gep_l2, align 1
  %load3 = load i8, ptr %gep_l3, align 1
  %load4 = load i8, ptr %gep_l4, align 1
  %load5 = load i8, ptr %gep_l5, align 1
  %load6 = load i8, ptr %gep_l6, align 1
  %load7 = load i8, ptr %gep_l7, align 1
  store i8 %load0, ptr %ps, align 1
  store i8 %load1, ptr %ps, align 1
  store i8 %load2, ptr %ps, align 1
  store i8 %load3, ptr %ps, align 1
  store i8 %load4, ptr %ps, align 1
  store i8 %load5, ptr %ps, align 1
  store i8 %load6, ptr %ps, align 1
  store i8 %load7, ptr %ps, align 1
  ret void
}

define void @two_constant_strides(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s4 = getelementptr i8, ptr %ps, i64 9
  %1 = load <4 x i8>, ptr %gep_l0, align 1
  %2 = load <4 x i8>, ptr %gep_l4, align 1
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %1, ptr align 1 %gep_s0, i64 2, <4 x i1> splat (i1 true), i32 4)
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %2, ptr align 1 %gep_s4, i64 2, <4 x i1> splat (i1 true), i32 4)
  ret void
}

define void @constant_strides_variable_gap(ptr %pl, ptr %ps, i64 %gap) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gap_ps = getelementptr i8, ptr %ps, i64 %gap
  %gep_s4 = getelementptr i8, ptr %gap_ps, i64 28
  %1 = load <4 x i8>, ptr %gep_l4, align 1
  %2 = load <4 x i8>, ptr %gep_l0, align 1
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %2, ptr align 1 %gep_s0, i64 7, <4 x i1> splat (i1 true), i32 4)
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %1, ptr align 1 %gep_s4, i64 7, <4 x i1> splat (i1 true), i32 4)
  ret void
}

define void @overlapping_strides(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s4 = getelementptr i8, ptr %ps, i64 5
  %1 = load <4 x i8>, ptr %gep_l0, align 1
  %2 = load <4 x i8>, ptr %gep_l4, align 1
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %1, ptr align 1 %gep_s0, i64 2, <4 x i1> splat (i1 true), i32 4)
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %2, ptr align 1 %gep_s4, i64 3, <4 x i1> splat (i1 true), i32 4)
  ret void
}

define void @constant_stride_unit_stride(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s4 = getelementptr i8, ptr %ps, i64 8
  %1 = load <4 x i8>, ptr %gep_l4, align 1
  %2 = load <4 x i8>, ptr %gep_l0, align 1
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %2, ptr align 1 %gep_s0, i64 2, <4 x i1> splat (i1 true), i32 4)
  store <4 x i8> %1, ptr %gep_s4, align 1
  ret void
}

define void @unit_stride_constant_stride(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s4 = getelementptr i8, ptr %ps, i64 9
  %1 = load <4 x i8>, ptr %gep_l0, align 1
  %2 = load <4 x i8>, ptr %gep_l4, align 1
  store <4 x i8> %1, ptr %gep_s0, align 1
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %2, ptr align 1 %gep_s4, i64 2, <4 x i1> splat (i1 true), i32 4)
  ret void
}

define void @overlap(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s4 = getelementptr i8, ptr %ps, i64 5
  %1 = load <4 x i8>, ptr %gep_l0, align 1
  %2 = load <4 x i8>, ptr %gep_l4, align 1
  store <4 x i8> %1, ptr %gep_s0, align 1
  call void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8> %2, ptr align 1 %gep_s4, i64 2, <4 x i1> splat (i1 true), i32 4)
  ret void
}

define void @overlap2(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l2 = getelementptr i8, ptr %pl, i64 2
  %gep_l3 = getelementptr i8, ptr %pl, i64 3
  %load2 = load i8, ptr %gep_l2, align 1
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %1 = load <4 x i8>, ptr %gep_l3, align 1
  %2 = load <2 x i8>, ptr %gep_l0, align 1
  call void @llvm.experimental.vp.strided.store.v2i8.p0.i64(<2 x i8> %2, ptr align 1 %gep_s0, i64 2, <2 x i1> splat (i1 true), i32 2)
  store i8 %load2, ptr %gep_s2, align 1
  store <4 x i8> %1, ptr %gep_s3, align 1
  ret void
}

define void @vf_ordering_issue(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_l1 = getelementptr i8, ptr %pl, i64 38
  %gep_l2 = getelementptr i8, ptr %pl, i64 92
  %gep_l3 = getelementptr i8, ptr %pl, i64 33
  %gep_l4 = getelementptr i8, ptr %pl, i64 4
  %gep_l12 = getelementptr i8, ptr %pl, i64 13
  %gep_l13 = getelementptr i8, ptr %pl, i64 83
  %gep_l14 = getelementptr i8, ptr %pl, i64 32
  %gep_l15 = getelementptr i8, ptr %pl, i64 15
  %gep_l23 = getelementptr i8, ptr %pl, i64 23
  %load0 = load i8, ptr %gep_l0, align 1
  %load1 = load i8, ptr %gep_l1, align 1
  %load2 = load i8, ptr %gep_l2, align 1
  %load3 = load i8, ptr %gep_l3, align 1
  %load12 = load i8, ptr %gep_l12, align 1
  %load13 = load i8, ptr %gep_l13, align 1
  %load14 = load i8, ptr %gep_l14, align 1
  %load23 = load i8, ptr %gep_l23, align 1
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %gep_s1 = getelementptr i8, ptr %ps, i64 2
  %gep_s2 = getelementptr i8, ptr %ps, i64 4
  %gep_s3 = getelementptr i8, ptr %ps, i64 6
  %gep_s4 = getelementptr i8, ptr %ps, i64 8
  %gep_s12 = getelementptr i8, ptr %ps, i64 16
  %gep_s13 = getelementptr i8, ptr %ps, i64 18
  %gep_s14 = getelementptr i8, ptr %ps, i64 20
  %gep_s15 = getelementptr i8, ptr %ps, i64 22
  %gep_s23 = getelementptr i8, ptr %ps, i64 38
  %1 = load <8 x i8>, ptr %gep_l4, align 1
  %2 = add <8 x i8> %1, splat (i8 1)
  %3 = load <8 x i8>, ptr %gep_l15, align 1
  store i8 %load0, ptr %gep_s0, align 1
  store i8 %load1, ptr %gep_s1, align 1
  store i8 %load2, ptr %gep_s2, align 1
  store i8 %load3, ptr %gep_s3, align 1
  store <8 x i8> %2, ptr %gep_s4, align 1
  store i8 %load12, ptr %gep_s12, align 1
  store i8 %load13, ptr %gep_s13, align 1
  store i8 %load14, ptr %gep_s14, align 1
  call void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8> %3, ptr align 1 %gep_s15, i64 2, <8 x i1> splat (i1 true), i32 8)
  store i8 %load23, ptr %gep_s23, align 1
  ret void
}

define void @constant_stride_reorder_data(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %1 = load <8 x i8>, ptr %gep_l0, align 1
  %2 = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> <i32 0, i32 2, i32 1, i32 7, i32 3, i32 5, i32 6, i32 4>
  call void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8> %2, ptr align 1 %gep_s0, i64 2, <8 x i1> splat (i1 true), i32 8)
  ret void
}

define void @constant_stride_reorder_geps(ptr %pl, ptr %ps) #0 {
  %gep_l0 = getelementptr i8, ptr %pl, i64 0
  %gep_s0 = getelementptr i8, ptr %ps, i64 0
  %1 = load <8 x i8>, ptr %gep_l0, align 1
  %2 = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> <i32 0, i32 2, i32 1, i32 4, i32 7, i32 5, i32 6, i32 3>
  call void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8> %2, ptr align 1 %gep_s0, i64 2, <8 x i1> splat (i1 true), i32 8)
  ret void
}

define void @reversed_addr_data_reorder(ptr %pl, ptr %ps) #0 {
  %l0 = getelementptr i8, ptr %pl, i64 0
  %s7 = getelementptr i8, ptr %ps, i64 0
  %1 = load <8 x i8>, ptr %l0, align 1
  %2 = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> <i32 4, i32 5, i32 7, i32 2, i32 6, i32 1, i32 3, i32 0>
  call void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8> %2, ptr align 1 %s7, i64 2, <8 x i1> splat (i1 true), i32 8)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.vp.strided.store.v8i8.p0.i64(<8 x i8>, ptr captures(none), i64, <8 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.vp.strided.store.v4i8.p0.i64(<4 x i8>, ptr captures(none), i64, <4 x i1>, i32) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.vp.strided.store.v2i8.p0.i64(<2 x i8>, ptr captures(none), i64, <2 x i1>, i32) #1

attributes #0 = { "target-features"="+m,+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
