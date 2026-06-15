; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InterleavedAccess/RISCV/interleaved-accesses.ll
; Variant: riscv64_+v_interleaved-access_RV64
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mattr=+v -passes=interleaved-access -S
; Original: RUN: opt < %s -mtriple=riscv64 -mattr=+v -passes=interleaved-access -S | FileCheck %s --check-prefix=RV64

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @load_factor2(ptr %ptr) {
  %interleaved.vec = load <16 x i32>, ptr %ptr
  %v0 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor2_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 16 x i32>, ptr %ptr
  %v = call { <vscale x 8 x i32>, <vscale x 8 x i32> } @llvm.vector.deinterleave2.nxv16i32(<vscale x 16 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %v, 1
  ret void
}

define void @load_factor3(ptr %ptr) {
  %interleaved.vec = load <12 x i32>, ptr %ptr
  %v0 = shufflevector <12 x i32> %interleaved.vec, <12 x i32> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %v1 = shufflevector <12 x i32> %interleaved.vec, <12 x i32> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %v2 = shufflevector <12 x i32> %interleaved.vec, <12 x i32> poison, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  ret void
}

define void @load_factor3_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 6 x i32>, ptr %ptr
  %v = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave3.nxv6i32(<vscale x 6 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 2
  ret void
}

define void @load_factor4(ptr %ptr) {
  %interleaved.vec = load <16 x i32>, ptr %ptr
  %v0 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %v1 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %v2 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %v3 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  ret void
}

define void @load_factor4_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 16 x i32>, ptr %ptr
  %v = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %v, 1
  %t2 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %v, 2
  %t3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %v, 3
  ret void
}

define void @load_factor5(ptr %ptr) {
  %interleaved.vec = load <20 x i32>, ptr %ptr
  %v0 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 0, i32 5, i32 10, i32 15>
  %v1 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 1, i32 6, i32 11, i32 16>
  %v2 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 2, i32 7, i32 12, i32 17>
  %v3 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 3, i32 8, i32 13, i32 18>
  %v4 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 4, i32 9, i32 14, i32 19>
  ret void
}

define void @load_factor5_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 10 x i32>, ptr %ptr
  %v = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave5.nxv10i32(<vscale x 10 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 4
  ret void
}

define void @load_factor6(ptr %ptr) {
  %interleaved.vec = load <24 x i32>, ptr %ptr
  %v0 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 0, i32 6, i32 12, i32 18>
  %v1 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 1, i32 7, i32 13, i32 19>
  %v2 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 2, i32 8, i32 14, i32 20>
  %v3 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 3, i32 9, i32 15, i32 21>
  %v4 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 4, i32 10, i32 16, i32 22>
  %v5 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 5, i32 11, i32 17, i32 23>
  ret void
}

define void @load_factor6_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 12 x i32>, ptr %ptr
  %v = call {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave6.nxv12i32(<vscale x 12 x i32> %interleaved.vec)
  %t0 = extractvalue {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 0
  %t1 = extractvalue {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 1
  %t2 = extractvalue {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 2
  %t3 = extractvalue {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 3
  %t4 = extractvalue {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 4
  %t5 = extractvalue {  <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 5
  ret void
}

define void @load_factor7(ptr %ptr) {
  %interleaved.vec = load <28 x i32>, ptr %ptr
  %v0 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 0, i32 7, i32 14, i32 21>
  %v1 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 1, i32 8, i32 15, i32 22>
  %v2 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 2, i32 9, i32 16, i32 23>
  %v3 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 3, i32 10, i32 17, i32 24>
  %v4 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 4, i32 11, i32 18, i32 25>
  %v5 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 5, i32 12, i32 19, i32 26>
  %v6 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 6, i32 13, i32 20, i32 27>
  ret void
}

define void @load_factor7_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 14 x i32>, ptr %ptr
  %v = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave7.nxv14i32(<vscale x 14 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 4
  %t5 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 5
  %t6 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 6
  ret void
}

define void @load_factor8(ptr %ptr) {
  %interleaved.vec = load <32 x i32>, ptr %ptr
  %v0 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 0, i32 8, i32 16, i32 24>
  %v1 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 1, i32 9, i32 17, i32 25>
  %v2 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 2, i32 10, i32 18, i32 26>
  %v3 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 3, i32 11, i32 19, i32 27>
  %v4 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 4, i32 12, i32 20, i32 28>
  %v5 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 5, i32 13, i32 21, i32 29>
  %v6 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 6, i32 14, i32 22, i32 30>
  %v7 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 7, i32 15, i32 23, i32 31>
  ret void
}

define void @load_factor8_vscale(ptr %ptr) {
  %interleaved.vec = load <vscale x 16 x i32>, ptr %ptr
  %v = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave8.nxv16i32(<vscale x 16 x i32> %interleaved.vec)
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 4
  %t5 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 5
  %t6 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 6
  %t7 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %v, 7
  ret void
}


define void @store_factor2(ptr %ptr, <8 x i8> %v0, <8 x i8> %v1) {
  %interleaved.vec = shufflevector <8 x i8> %v0, <8 x i8> %v1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  store <16 x i8> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor2_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1) {
  %interleaved.vec = call <vscale x 16 x i8> @llvm.vector.interleave2.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1)
  store <vscale x 16 x i8> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor3(ptr %ptr, <4 x i32> %v0, <4 x i32> %v1, <4 x i32> %v2) {
  %s0 = shufflevector <4 x i32> %v0, <4 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s1 = shufflevector <4 x i32> %v2, <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
  %interleaved.vec = shufflevector <8 x i32> %s0, <8 x i32> %s1, <12 x i32> <i32 0, i32 4, i32 8, i32 1, i32 5, i32 9, i32 2, i32 6, i32 10, i32 3, i32 7, i32 11>
  store <12 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor3_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2) {
  %interleaved.vec = call <vscale x 24 x i8> @llvm.vector.interleave3.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2)
  store <vscale x 24 x i8> %interleaved.vec, ptr %ptr
  ret void
}

define void @store_factor4(ptr %ptr, <4 x i32> %v0, <4 x i32> %v1, <4 x i32> %v2, <4 x i32> %v3) {
  %s0 = shufflevector <4 x i32> %v0, <4 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s1 = shufflevector <4 x i32> %v2, <4 x i32> %v3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %interleaved.vec = shufflevector <8 x i32> %s0, <8 x i32> %s1, <16 x i32> <i32 0, i32 4, i32 8, i32 12, i32 1, i32 5, i32 9, i32 13, i32 2, i32 6, i32 10, i32 14, i32 3, i32 7, i32 11, i32 15>
  store <16 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor4_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3) {
  %interleaved.vec = call <vscale x 32 x i8> @llvm.vector.interleave4.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3)
  store <vscale x 32 x i8> %interleaved.vec, ptr %ptr
  ret void
}

define void @store_factor5_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4) {
  %interleaved.vec = call <vscale x 40 x i8> @llvm.vector.interleave5.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4)
  store <vscale x 40 x i8> %interleaved.vec, ptr %ptr
  ret void
}

define void @store_factor2_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1) {
  %interleaved.vec = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  store <16 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor3_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1, <8 x i32> %v2) {
  %s0 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %s1 = shufflevector <8 x i32> %v2, <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %interleaved.vec = shufflevector <16 x i32> %s0, <16 x i32> %s1, <24 x i32> <i32 0, i32 8, i32 16, i32 1, i32 9, i32 17, i32 2, i32 10, i32 18, i32 3, i32 11, i32 19, i32 4, i32 12, i32 20, i32 5, i32 13, i32 21, i32 6, i32 14, i32 22, i32 7, i32 15, i32 23>
  store <24 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor4_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1, <8 x i32> %v2, <8 x i32> %v3) {
  %s0 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %s1 = shufflevector <8 x i32> %v2, <8 x i32> %v3, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i32> %s0, <16 x i32> %s1, <32 x i32> <i32 0, i32 8, i32 16, i32 24, i32 1, i32 9, i32 17, i32 25, i32 2, i32 10, i32 18, i32 26, i32 3, i32 11, i32 19, i32 27, i32 4, i32 12, i32 20, i32 28, i32 5, i32 13, i32 21, i32 29, i32 6, i32 14, i32 22, i32 30, i32 7, i32 15, i32 23, i32 31>
  store <32 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor6_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5) {
  %interleaved.vec = call <vscale x 48 x i8> @llvm.vector.interleave6.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5)
  store <vscale x 48 x i8> %interleaved.vec, ptr %ptr
  ret void
}

define void @store_factor7_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5, <vscale x 8 x i8> %v6) {
  %interleaved.vec = call <vscale x 56 x i8> @llvm.vector.interleave7.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5, <vscale x 8 x i8> %v6)
  store <vscale x 56 x i8> %interleaved.vec, ptr %ptr
  ret void
}

define void @store_factor8_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5, <vscale x 8 x i8> %v6, <vscale x 8 x i8> %v7) {
  %interleaved.vec = call <vscale x 64 x i8> @llvm.vector.interleave8.nxv8i8(<vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5, <vscale x 8 x i8> %v6, <vscale x 8 x i8> %v7)
  store <vscale x 64 x i8> %interleaved.vec, ptr %ptr
  ret void
}

define void @load_factor2_fp128(ptr %ptr) {
  %interleaved.vec = load <4 x fp128>, ptr %ptr, align 16
  %v0 = shufflevector <4 x fp128> %interleaved.vec, <4 x fp128> poison, <2 x i32> <i32 0, i32 2>
  %v1 = shufflevector <4 x fp128> %interleaved.vec, <4 x fp128> poison, <2 x i32> <i32 1, i32 3>
  ret void
}

define void @load_factor2_f32(ptr %ptr) {
  %interleaved.vec = load <16 x float>, ptr %ptr
  %v0 = shufflevector <16 x float> %interleaved.vec, <16 x float> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x float> %interleaved.vec, <16 x float> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor2_f64(ptr %ptr) {
  %interleaved.vec = load <16 x double>, ptr %ptr
  %v0 = shufflevector <16 x double> %interleaved.vec, <16 x double> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x double> %interleaved.vec, <16 x double> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor2_bf16(ptr %ptr) {
  %interleaved.vec = load <16 x bfloat>, ptr %ptr
  %v0 = shufflevector <16 x bfloat> %interleaved.vec, <16 x bfloat> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x bfloat> %interleaved.vec, <16 x bfloat> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor2_f16(ptr %ptr) {
  %interleaved.vec = load <16 x half>, ptr %ptr
  %v0 = shufflevector <16 x half> %interleaved.vec, <16 x half> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x half> %interleaved.vec, <16 x half> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpjkpluqvc.ll'
source_filename = "/tmp/tmpjkpluqvc.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @load_factor2(ptr %ptr) #0 {
  %1 = call { <8 x i32>, <8 x i32> } @llvm.riscv.seg2.load.mask.v8i32.p0.i64(ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  %2 = extractvalue { <8 x i32>, <8 x i32> } %1, 1
  %3 = extractvalue { <8 x i32>, <8 x i32> } %1, 0
  ret void
}

define void @load_factor2_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 32 x i8>, 2) @llvm.riscv.vlseg2.mask.triscv.vector.tuple_nxv32i8_2t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 32 x i8>, 2) poison, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 8 x i32> @llvm.riscv.tuple.extract.nxv8i32.triscv.vector.tuple_nxv32i8_2t(target("riscv.vector.tuple", <vscale x 32 x i8>, 2) %1, i32 0)
  %3 = insertvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } poison, <vscale x 8 x i32> %2, 0
  %4 = call <vscale x 8 x i32> @llvm.riscv.tuple.extract.nxv8i32.triscv.vector.tuple_nxv32i8_2t(target("riscv.vector.tuple", <vscale x 32 x i8>, 2) %1, i32 1)
  %5 = insertvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %3, <vscale x 8 x i32> %4, 1
  %t0 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %5, 0
  %t1 = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } %5, 1
  ret void
}

define void @load_factor3(ptr %ptr) #0 {
  %1 = call { <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg3.load.mask.v4i32.p0.i64(ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } %1, 2
  %3 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } %1, 1
  %4 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } %1, 0
  ret void
}

define void @load_factor3_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 3) @llvm.riscv.vlseg3.mask.triscv.vector.tuple_nxv8i8_3t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) poison, ptr %ptr, <vscale x 2 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_3t(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) %1, i32 0)
  %3 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> %2, 0
  %4 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_3t(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) %1, i32 1)
  %5 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %3, <vscale x 2 x i32> %4, 1
  %6 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_3t(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) %1, i32 2)
  %7 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %5, <vscale x 2 x i32> %6, 2
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, 2
  ret void
}

define void @load_factor4(ptr %ptr) #0 {
  %1 = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg4.load.mask.v4i32.p0.i64(ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 3
  %3 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 2
  %4 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 1
  %5 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 0
  ret void
}

define void @load_factor4_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.vlseg4.mask.triscv.vector.tuple_nxv16i8_4t.p0.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) poison, ptr %ptr, <vscale x 4 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 4 x i32> @llvm.riscv.tuple.extract.nxv4i32.triscv.vector.tuple_nxv16i8_4t(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %1, i32 0)
  %3 = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } poison, <vscale x 4 x i32> %2, 0
  %4 = call <vscale x 4 x i32> @llvm.riscv.tuple.extract.nxv4i32.triscv.vector.tuple_nxv16i8_4t(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %1, i32 1)
  %5 = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %3, <vscale x 4 x i32> %4, 1
  %6 = call <vscale x 4 x i32> @llvm.riscv.tuple.extract.nxv4i32.triscv.vector.tuple_nxv16i8_4t(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %1, i32 2)
  %7 = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %5, <vscale x 4 x i32> %6, 2
  %8 = call <vscale x 4 x i32> @llvm.riscv.tuple.extract.nxv4i32.triscv.vector.tuple_nxv16i8_4t(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %1, i32 3)
  %9 = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %7, <vscale x 4 x i32> %8, 3
  %t0 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %9, 0
  %t1 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %9, 1
  %t2 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %9, 2
  %t3 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %9, 3
  ret void
}

define void @load_factor5(ptr %ptr) #0 {
  %1 = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg5.load.mask.v4i32.p0.i64(ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 4
  %3 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 3
  %4 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 2
  %5 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 1
  %6 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 0
  ret void
}

define void @load_factor5_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv8i8_5t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) poison, ptr %ptr, <vscale x 2 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_5t(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %1, i32 0)
  %3 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> %2, 0
  %4 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_5t(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %1, i32 1)
  %5 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %3, <vscale x 2 x i32> %4, 1
  %6 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_5t(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %1, i32 2)
  %7 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %5, <vscale x 2 x i32> %6, 2
  %8 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_5t(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %1, i32 3)
  %9 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, <vscale x 2 x i32> %8, 3
  %10 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_5t(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %1, i32 4)
  %11 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %9, <vscale x 2 x i32> %10, 4
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, 4
  ret void
}

define void @load_factor6(ptr %ptr) #0 {
  %1 = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg6.load.mask.v4i32.p0.i64(ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 5
  %3 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 4
  %4 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 3
  %5 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 2
  %6 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 1
  %7 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 0
  ret void
}

define void @load_factor6_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.vlseg6.mask.triscv.vector.tuple_nxv8i8_6t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) poison, ptr %ptr, <vscale x 2 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, i32 0)
  %3 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> %2, 0
  %4 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, i32 1)
  %5 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %3, <vscale x 2 x i32> %4, 1
  %6 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, i32 2)
  %7 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %5, <vscale x 2 x i32> %6, 2
  %8 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, i32 3)
  %9 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, <vscale x 2 x i32> %8, 3
  %10 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, i32 4)
  %11 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %9, <vscale x 2 x i32> %10, 4
  %12 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, i32 5)
  %13 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, <vscale x 2 x i32> %12, 5
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, 4
  %t5 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, 5
  ret void
}

define void @load_factor7(ptr %ptr) #0 {
  %1 = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg7.load.mask.v4i32.p0.i64(ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 6
  %3 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 5
  %4 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 4
  %5 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 3
  %6 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 2
  %7 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 1
  %8 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 0
  ret void
}

define void @load_factor7_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.vlseg7.mask.triscv.vector.tuple_nxv8i8_7t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) poison, ptr %ptr, <vscale x 2 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 0)
  %3 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> %2, 0
  %4 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 1)
  %5 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %3, <vscale x 2 x i32> %4, 1
  %6 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 2)
  %7 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %5, <vscale x 2 x i32> %6, 2
  %8 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 3)
  %9 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, <vscale x 2 x i32> %8, 3
  %10 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 4)
  %11 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %9, <vscale x 2 x i32> %10, 4
  %12 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 5)
  %13 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, <vscale x 2 x i32> %12, 5
  %14 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, i32 6)
  %15 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, <vscale x 2 x i32> %14, 6
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 4
  %t5 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 5
  %t6 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, 6
  ret void
}

define void @load_factor8(ptr %ptr) #0 {
  %1 = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg8.load.mask.v4i32.p0.i64(ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  %2 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 7
  %3 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 6
  %4 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 5
  %5 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 4
  %6 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 3
  %7 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 2
  %8 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 1
  %9 = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } %1, 0
  ret void
}

define void @load_factor8_vscale(ptr %ptr) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.vlseg8.mask.triscv.vector.tuple_nxv8i8_8t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) poison, ptr %ptr, <vscale x 2 x i1> splat (i1 true), i64 -1, i64 3, i64 5)
  %2 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 0)
  %3 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> %2, 0
  %4 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 1)
  %5 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %3, <vscale x 2 x i32> %4, 1
  %6 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 2)
  %7 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %5, <vscale x 2 x i32> %6, 2
  %8 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 3)
  %9 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %7, <vscale x 2 x i32> %8, 3
  %10 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 4)
  %11 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %9, <vscale x 2 x i32> %10, 4
  %12 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 5)
  %13 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %11, <vscale x 2 x i32> %12, 5
  %14 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 6)
  %15 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %13, <vscale x 2 x i32> %14, 6
  %16 = call <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, i32 7)
  %17 = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %15, <vscale x 2 x i32> %16, 7
  %t0 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 0
  %t1 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 1
  %t2 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 2
  %t3 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 3
  %t4 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 4
  %t5 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 5
  %t6 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 6
  %t7 = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } %17, 7
  ret void
}

define void @store_factor2(ptr %ptr, <8 x i8> %v0, <8 x i8> %v1) #0 {
  %1 = shufflevector <8 x i8> %v0, <8 x i8> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <8 x i8> %v0, <8 x i8> %v1, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  call void @llvm.riscv.seg2.store.mask.v8i8.p0.i64(<8 x i8> %1, <8 x i8> %2, ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  ret void
}

define void @store_factor2_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 2) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_2t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 2) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 2) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_2t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 2) %1, <vscale x 8 x i8> %v1, i32 1)
  call void @llvm.riscv.vsseg2.mask.triscv.vector.tuple_nxv8i8_2t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 2) %2, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @store_factor3(ptr %ptr, <4 x i32> %v0, <4 x i32> %v1, <4 x i32> %v2) #0 {
  %s0 = shufflevector <4 x i32> %v0, <4 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s1 = shufflevector <4 x i32> %v2, <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
  %1 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %3 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 8, i32 9, i32 10, i32 11>
  call void @llvm.riscv.seg3.store.mask.v4i32.p0.i64(<4 x i32> %1, <4 x i32> %2, <4 x i32> %3, ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  ret void
}

define void @store_factor3_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 3) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_3t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 3) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_3t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) %1, <vscale x 8 x i8> %v1, i32 1)
  %3 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 3) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_3t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) %2, <vscale x 8 x i8> %v2, i32 2)
  call void @llvm.riscv.vsseg3.mask.triscv.vector.tuple_nxv8i8_3t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 3) %3, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @store_factor4(ptr %ptr, <4 x i32> %v0, <4 x i32> %v1, <4 x i32> %v2, <4 x i32> %v3) #0 {
  %s0 = shufflevector <4 x i32> %v0, <4 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s1 = shufflevector <4 x i32> %v2, <4 x i32> %v3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %1 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %3 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 8, i32 9, i32 10, i32 11>
  %4 = shufflevector <8 x i32> %s0, <8 x i32> %s1, <4 x i32> <i32 12, i32 13, i32 14, i32 15>
  call void @llvm.riscv.seg4.store.mask.v4i32.p0.i64(<4 x i32> %1, <4 x i32> %2, <4 x i32> %3, <4 x i32> %4, ptr %ptr, <4 x i1> splat (i1 true), i64 4)
  ret void
}

define void @store_factor4_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_4t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 4) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_4t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 4) %1, <vscale x 8 x i8> %v1, i32 1)
  %3 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_4t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 4) %2, <vscale x 8 x i8> %v2, i32 2)
  %4 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_4t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 4) %3, <vscale x 8 x i8> %v3, i32 3)
  call void @llvm.riscv.vsseg4.mask.triscv.vector.tuple_nxv8i8_4t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 4) %4, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @store_factor5_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_5t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_5t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %1, <vscale x 8 x i8> %v1, i32 1)
  %3 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_5t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %2, <vscale x 8 x i8> %v2, i32 2)
  %4 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_5t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %3, <vscale x 8 x i8> %v3, i32 3)
  %5 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_5t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %4, <vscale x 8 x i8> %v4, i32 4)
  call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv8i8_5t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) %5, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @store_factor2_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1) #0 {
  %1 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  call void @llvm.riscv.seg2.store.mask.v8i32.p0.i64(<8 x i32> %1, <8 x i32> %2, ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  ret void
}

define void @store_factor3_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1, <8 x i32> %v2) #0 {
  %s0 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %s1 = shufflevector <8 x i32> %v2, <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %1 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  call void @llvm.riscv.seg3.store.mask.v8i32.p0.i64(<8 x i32> %1, <8 x i32> %2, <8 x i32> %3, ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  ret void
}

define void @store_factor4_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1, <8 x i32> %v2, <8 x i32> %v3) #0 {
  %s0 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %s1 = shufflevector <8 x i32> %v2, <8 x i32> %v3, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %1 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %4 = shufflevector <16 x i32> %s0, <16 x i32> %s1, <8 x i32> <i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  call void @llvm.riscv.seg4.store.mask.v8i32.p0.i64(<8 x i32> %1, <8 x i32> %2, <8 x i32> %3, <8 x i32> %4, ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  ret void
}

define void @store_factor6_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %1, <vscale x 8 x i8> %v1, i32 1)
  %3 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %2, <vscale x 8 x i8> %v2, i32 2)
  %4 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %3, <vscale x 8 x i8> %v3, i32 3)
  %5 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %4, <vscale x 8 x i8> %v4, i32 4)
  %6 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %5, <vscale x 8 x i8> %v5, i32 5)
  call void @llvm.riscv.vsseg6.mask.triscv.vector.tuple_nxv8i8_6t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 6) %6, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @store_factor7_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5, <vscale x 8 x i8> %v6) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %1, <vscale x 8 x i8> %v1, i32 1)
  %3 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %2, <vscale x 8 x i8> %v2, i32 2)
  %4 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %3, <vscale x 8 x i8> %v3, i32 3)
  %5 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %4, <vscale x 8 x i8> %v4, i32 4)
  %6 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %5, <vscale x 8 x i8> %v5, i32 5)
  %7 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %6, <vscale x 8 x i8> %v6, i32 6)
  call void @llvm.riscv.vsseg7.mask.triscv.vector.tuple_nxv8i8_7t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) %7, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @store_factor8_vscale(ptr %ptr, <vscale x 8 x i8> %v0, <vscale x 8 x i8> %v1, <vscale x 8 x i8> %v2, <vscale x 8 x i8> %v3, <vscale x 8 x i8> %v4, <vscale x 8 x i8> %v5, <vscale x 8 x i8> %v6, <vscale x 8 x i8> %v7) #0 {
  %1 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) poison, <vscale x 8 x i8> %v0, i32 0)
  %2 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %1, <vscale x 8 x i8> %v1, i32 1)
  %3 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %2, <vscale x 8 x i8> %v2, i32 2)
  %4 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %3, <vscale x 8 x i8> %v3, i32 3)
  %5 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %4, <vscale x 8 x i8> %v4, i32 4)
  %6 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %5, <vscale x 8 x i8> %v5, i32 5)
  %7 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %6, <vscale x 8 x i8> %v6, i32 6)
  %8 = call target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %7, <vscale x 8 x i8> %v7, i32 7)
  call void @llvm.riscv.vsseg8.mask.triscv.vector.tuple_nxv8i8_8t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 8) %8, ptr %ptr, <vscale x 8 x i1> splat (i1 true), i64 -1, i64 3)
  ret void
}

define void @load_factor2_fp128(ptr %ptr) #0 {
  %interleaved.vec = load <4 x fp128>, ptr %ptr, align 16
  %v0 = shufflevector <4 x fp128> %interleaved.vec, <4 x fp128> poison, <2 x i32> <i32 0, i32 2>
  %v1 = shufflevector <4 x fp128> %interleaved.vec, <4 x fp128> poison, <2 x i32> <i32 1, i32 3>
  ret void
}

define void @load_factor2_f32(ptr %ptr) #0 {
  %1 = call { <8 x float>, <8 x float> } @llvm.riscv.seg2.load.mask.v8f32.p0.i64(ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  %2 = extractvalue { <8 x float>, <8 x float> } %1, 1
  %3 = extractvalue { <8 x float>, <8 x float> } %1, 0
  ret void
}

define void @load_factor2_f64(ptr %ptr) #0 {
  %1 = call { <8 x double>, <8 x double> } @llvm.riscv.seg2.load.mask.v8f64.p0.i64(ptr %ptr, <8 x i1> splat (i1 true), i64 8)
  %2 = extractvalue { <8 x double>, <8 x double> } %1, 1
  %3 = extractvalue { <8 x double>, <8 x double> } %1, 0
  ret void
}

define void @load_factor2_bf16(ptr %ptr) #0 {
  %interleaved.vec = load <16 x bfloat>, ptr %ptr, align 32
  %v0 = shufflevector <16 x bfloat> %interleaved.vec, <16 x bfloat> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x bfloat> %interleaved.vec, <16 x bfloat> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor2_f16(ptr %ptr) #0 {
  %interleaved.vec = load <16 x half>, ptr %ptr, align 32
  %v0 = shufflevector <16 x half> %interleaved.vec, <16 x half> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x half> %interleaved.vec, <16 x half> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 8 x i32>, <vscale x 8 x i32> } @llvm.vector.deinterleave2.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave3.nxv6i32(<vscale x 6 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave5.nxv10i32(<vscale x 10 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave6.nxv12i32(<vscale x 12 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave7.nxv14i32(<vscale x 14 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @llvm.vector.deinterleave8.nxv16i32(<vscale x 16 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 16 x i8> @llvm.vector.interleave2.nxv16i8(<vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 24 x i8> @llvm.vector.interleave3.nxv24i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 32 x i8> @llvm.vector.interleave4.nxv32i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 40 x i8> @llvm.vector.interleave5.nxv40i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 48 x i8> @llvm.vector.interleave6.nxv48i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 56 x i8> @llvm.vector.interleave7.nxv56i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 64 x i8> @llvm.vector.interleave8.nxv64i8(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <8 x i32>, <8 x i32> } @llvm.riscv.seg2.load.mask.v8i32.p0.i64(ptr captures(none), <8 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 32 x i8>, 2) @llvm.riscv.vlseg2.mask.triscv.vector.tuple_nxv32i8_2t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 32 x i8>, 2), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i32> @llvm.riscv.tuple.extract.nxv8i32.triscv.vector.tuple_nxv32i8_2t(target("riscv.vector.tuple", <vscale x 32 x i8>, 2), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg3.load.mask.v4i32.p0.i64(ptr captures(none), <4 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 3) @llvm.riscv.vlseg3.mask.triscv.vector.tuple_nxv8i8_3t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 3), ptr captures(none), <vscale x 2 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_3t(target("riscv.vector.tuple", <vscale x 8 x i8>, 3), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg4.load.mask.v4i32.p0.i64(ptr captures(none), <4 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.vlseg4.mask.triscv.vector.tuple_nxv16i8_4t.p0.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 16 x i8>, 4), ptr captures(none), <vscale x 4 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.riscv.tuple.extract.nxv4i32.triscv.vector.tuple_nxv16i8_4t(target("riscv.vector.tuple", <vscale x 16 x i8>, 4), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg5.load.mask.v4i32.p0.i64(ptr captures(none), <4 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv8i8_5t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5), ptr captures(none), <vscale x 2 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_5t(target("riscv.vector.tuple", <vscale x 8 x i8>, 5), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg6.load.mask.v4i32.p0.i64(ptr captures(none), <4 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.vlseg6.mask.triscv.vector.tuple_nxv8i8_6t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 6), ptr captures(none), <vscale x 2 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_6t(target("riscv.vector.tuple", <vscale x 8 x i8>, 6), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg7.load.mask.v4i32.p0.i64(ptr captures(none), <4 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.vlseg7.mask.triscv.vector.tuple_nxv8i8_7t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7), ptr captures(none), <vscale x 2 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_7t(target("riscv.vector.tuple", <vscale x 8 x i8>, 7), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg8.load.mask.v4i32.p0.i64(ptr captures(none), <4 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.vlseg8.mask.triscv.vector.tuple_nxv8i8_8t.p0.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 8), ptr captures(none), <vscale x 2 x i1>, i64, i64 immarg, i64 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 2 x i32> @llvm.riscv.tuple.extract.nxv2i32.triscv.vector.tuple_nxv8i8_8t(target("riscv.vector.tuple", <vscale x 8 x i8>, 8), i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.riscv.seg2.store.mask.v8i8.p0.i64(<8 x i8>, <8 x i8>, ptr captures(none), <8 x i1>, i64) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 2) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_2t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 2), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg2.mask.triscv.vector.tuple_nxv8i8_2t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 2), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.riscv.seg3.store.mask.v4i32.p0.i64(<4 x i32>, <4 x i32>, <4 x i32>, ptr captures(none), <4 x i1>, i64) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 3) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_3t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 3), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg3.mask.triscv.vector.tuple_nxv8i8_3t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 3), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.riscv.seg4.store.mask.v4i32.p0.i64(<4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, ptr captures(none), <4 x i1>, i64) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_4t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 4), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg4.mask.triscv.vector.tuple_nxv8i8_4t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 4), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_5t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 5), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv8i8_5t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.riscv.seg2.store.mask.v8i32.p0.i64(<8 x i32>, <8 x i32>, ptr captures(none), <8 x i1>, i64) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.riscv.seg3.store.mask.v8i32.p0.i64(<8 x i32>, <8 x i32>, <8 x i32>, ptr captures(none), <8 x i1>, i64) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.riscv.seg4.store.mask.v8i32.p0.i64(<8 x i32>, <8 x i32>, <8 x i32>, <8 x i32>, ptr captures(none), <8 x i1>, i64) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 6) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_6t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 6), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg6.mask.triscv.vector.tuple_nxv8i8_6t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 6), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 7) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_7t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 7), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg7.mask.triscv.vector.tuple_nxv8i8_7t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare target("riscv.vector.tuple", <vscale x 8 x i8>, 8) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv8i8_8t.nxv8i8(target("riscv.vector.tuple", <vscale x 8 x i8>, 8), <vscale x 8 x i8>, i32 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.vsseg8.mask.triscv.vector.tuple_nxv8i8_8t.p0.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 8), ptr captures(none), <vscale x 8 x i1>, i64, i64 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <8 x float>, <8 x float> } @llvm.riscv.seg2.load.mask.v8f32.p0.i64(ptr captures(none), <8 x i1>, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare { <8 x double>, <8 x double> } @llvm.riscv.seg2.load.mask.v8f64.p0.i64(ptr captures(none), <8 x i1>, i64) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(write) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
