; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/VectorCombine/RISCV/narrow-phi-of-shuffles.ll
; Variant: riscv64_vector-combine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -passes=vector-combine -S
; Original: RUN: opt -mtriple=riscv64 -passes=vector-combine -S %s | FileCheck %s --check-prefixes=CHECK

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define <2 x i8> @shuffle_v2i8(<2 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <2 x i8> %arg0, <2 x i8> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <2 x i8> %arg0, <2 x i8> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <2 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <2 x i8> %val3
}

define <4 x i8> @shuffle_v4i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <4 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <4 x i8> %val3
}

define <8 x i8> @shuffle_v8i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <8 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <8 x i8> %val3
}

define <16 x i8> @shuffle_v16i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <16 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <16 x i8> %val3
}

define <32 x i8> @shuffle_v32i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <32 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <32 x i8> %val3
}

define <2 x i16> @shuffle_v2i16(<2 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <2 x i16> %arg0, <2 x i16> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <2 x i16> %arg0, <2 x i16> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <2 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <2 x i16> %val3
}

define <4 x i16> @shuffle_v4i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <4 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <4 x i16> %val3
}

define <8 x i16> @shuffle_v8i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <8 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <8 x i16> %val3
}

define <16 x i16> @shuffle_v16i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <16 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <16 x i16> %val3
}

define <32 x i16> @shuffle_v32i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <32 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <32 x i16> %val3
}

define <2 x i32> @shuffle_v2i32(<2 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <2 x i32> %arg0, <2 x i32> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <2 x i32> %arg0, <2 x i32> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <2 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <2 x i32> %val3
}

define <4 x i32> @shuffle_v4i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <4 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <4 x i32> %val3
}

define <8 x i32> @shuffle_v8i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <8 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <8 x i32> %val3
}

define <16 x i32> @shuffle_v16i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <16 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <16 x i32> %val3
}

define <32 x i32> @shuffle_v32i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <32 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <32 x i32> %val3
}

define <2 x bfloat> @shuffle_v2bf16(<2 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <2 x bfloat> %arg0, <2 x bfloat> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <2 x bfloat> %arg0, <2 x bfloat> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <2 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <2 x bfloat> %val3
}

define <3 x bfloat> @shuffle_v3bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <3 x i32> <i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <3 x i32> <i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <3 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <3 x bfloat> %val3
}

define <4 x bfloat> @shuffle_v4bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <4 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <4 x bfloat> %val3
}

define <6 x bfloat> @shuffle_v6bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <6 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <6 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <6 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <6 x bfloat> %val3
}

define <8 x bfloat> @shuffle_v8bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <8 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <8 x bfloat> %val3
}

define <16 x bfloat> @shuffle_v16bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <16 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <16 x bfloat> %val3
}

define <32 x bfloat> @shuffle_v32bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <32 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <32 x bfloat> %val3
}

define <2 x half> @shuffle_v2f16(<2 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <2 x half> %arg0, <2 x half> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <2 x half> %arg0, <2 x half> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <2 x half> [ %val1, %then ], [ %val2, %else ]
  ret <2 x half> %val3
}

define <3 x half> @shuffle_v3f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <3 x i32> <i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <3 x i32> <i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <3 x half> [ %val1, %then ], [ %val2, %else ]
  ret <3 x half> %val3
}

define <4 x half> @shuffle_v4f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <4 x half> [ %val1, %then ], [ %val2, %else ]
  ret <4 x half> %val3
}

define <6 x half> @shuffle_v6f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <6 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <6 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <6 x half> [ %val1, %then ], [ %val2, %else ]
  ret <6 x half> %val3
}

define <8 x half> @shuffle_v8f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <8 x half> [ %val1, %then ], [ %val2, %else ]
  ret <8 x half> %val3
}

define <16 x half> @shuffle_v16f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <16 x half> [ %val1, %then ], [ %val2, %else ]
  ret <16 x half> %val3
}

define <32 x half> @shuffle_v32f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <32 x half> [ %val1, %then ], [ %val2, %else ]
  ret <32 x half> %val3
}

define <2 x float> @shuffle_v2f32(<2 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <2 x float> %arg0, <2 x float> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <2 x float> %arg0, <2 x float> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <2 x float> [ %val1, %then ], [ %val2, %else ]
  ret <2 x float> %val3
}

define <3 x float> @shuffle_v3f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <3 x i32> <i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <3 x i32> <i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <3 x float> [ %val1, %then ], [ %val2, %else ]
  ret <3 x float> %val3
}

define <4 x float> @shuffle_v4f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <4 x float> [ %val1, %then ], [ %val2, %else ]
  ret <4 x float> %val3
}

define <6 x float> @shuffle_v6f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <6 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <6 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <6 x float> [ %val1, %then ], [ %val2, %else ]
  ret <6 x float> %val3
}

define <8 x float> @shuffle_v8f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <8 x float> [ %val1, %then ], [ %val2, %else ]
  ret <8 x float> %val3
}

define <16 x float> @shuffle_v16f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <16 x float> [ %val1, %then ], [ %val2, %else ]
  ret <16 x float> %val3
}

define <32 x float> @shuffle_v32f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:
  %val3 = phi <32 x float> [ %val1, %then ], [ %val2, %else ]
  ret <32 x float> %val3
}

declare void @func0() local_unnamed_addr

declare void @func1() local_unnamed_addr

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp4yvetx0d.ll'
source_filename = "/tmp/tmp4yvetx0d.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define <2 x i8> @shuffle_v2i8(<2 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <2 x i8> %arg0, <2 x i8> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <2 x i8> %arg0, <2 x i8> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <2 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <2 x i8> %val3
}

define <4 x i8> @shuffle_v4i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <4 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <4 x i8> %val3
}

define <8 x i8> @shuffle_v8i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <8 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <8 x i8> %val3
}

define <16 x i8> @shuffle_v16i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <16 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <16 x i8> %val3
}

define <32 x i8> @shuffle_v32i8(<3 x i8> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i8> %arg0, <3 x i8> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <32 x i8> [ %val1, %then ], [ %val2, %else ]
  ret <32 x i8> %val3
}

define <2 x i16> @shuffle_v2i16(<2 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <2 x i16> %arg0, <2 x i16> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <2 x i16> %arg0, <2 x i16> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <2 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <2 x i16> %val3
}

define <4 x i16> @shuffle_v4i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <4 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <4 x i16> %val3
}

define <8 x i16> @shuffle_v8i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <8 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <8 x i16> %val3
}

define <16 x i16> @shuffle_v16i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <16 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <16 x i16> %val3
}

define <32 x i16> @shuffle_v32i16(<3 x i16> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i16> %arg0, <3 x i16> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <32 x i16> [ %val1, %then ], [ %val2, %else ]
  ret <32 x i16> %val3
}

define <2 x i32> @shuffle_v2i32(<2 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <2 x i32> %arg0, <2 x i32> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <2 x i32> %arg0, <2 x i32> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <2 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <2 x i32> %val3
}

define <4 x i32> @shuffle_v4i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <4 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <4 x i32> %val3
}

define <8 x i32> @shuffle_v8i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <8 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <8 x i32> %val3
}

define <16 x i32> @shuffle_v16i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <16 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <16 x i32> %val3
}

define <32 x i32> @shuffle_v32i32(<3 x i32> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x i32> %arg0, <3 x i32> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <32 x i32> [ %val1, %then ], [ %val2, %else ]
  ret <32 x i32> %val3
}

define <2 x bfloat> @shuffle_v2bf16(<2 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <2 x bfloat> %arg0, <2 x bfloat> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <2 x bfloat> %arg0, <2 x bfloat> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <2 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <2 x bfloat> %val3
}

define <3 x bfloat> @shuffle_v3bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <3 x i32> <i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <3 x i32> <i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <3 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <3 x bfloat> %val3
}

define <4 x bfloat> @shuffle_v4bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <4 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <4 x bfloat> %val3
}

define <6 x bfloat> @shuffle_v6bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <6 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <6 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <6 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <6 x bfloat> %val3
}

define <8 x bfloat> @shuffle_v8bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <8 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <8 x bfloat> %val3
}

define <16 x bfloat> @shuffle_v16bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <16 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <16 x bfloat> %val3
}

define <32 x bfloat> @shuffle_v32bf16(<3 x bfloat> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x bfloat> %arg0, <3 x bfloat> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <32 x bfloat> [ %val1, %then ], [ %val2, %else ]
  ret <32 x bfloat> %val3
}

define <2 x half> @shuffle_v2f16(<2 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <2 x half> %arg0, <2 x half> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <2 x half> %arg0, <2 x half> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <2 x half> [ %val1, %then ], [ %val2, %else ]
  ret <2 x half> %val3
}

define <3 x half> @shuffle_v3f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <3 x i32> <i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <3 x i32> <i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <3 x half> [ %val1, %then ], [ %val2, %else ]
  ret <3 x half> %val3
}

define <4 x half> @shuffle_v4f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <4 x half> [ %val1, %then ], [ %val2, %else ]
  ret <4 x half> %val3
}

define <6 x half> @shuffle_v6f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <6 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <6 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <6 x half> [ %val1, %then ], [ %val2, %else ]
  ret <6 x half> %val3
}

define <8 x half> @shuffle_v8f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <8 x half> [ %val1, %then ], [ %val2, %else ]
  ret <8 x half> %val3
}

define <16 x half> @shuffle_v16f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <16 x half> [ %val1, %then ], [ %val2, %else ]
  ret <16 x half> %val3
}

define <32 x half> @shuffle_v32f16(<3 x half> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x half> %arg0, <3 x half> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x half> %arg0, <3 x half> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <32 x half> [ %val1, %then ], [ %val2, %else ]
  ret <32 x half> %val3
}

define <2 x float> @shuffle_v2f32(<2 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <2 x float> %arg0, <2 x float> poison, <2 x i32> <i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <2 x float> %arg0, <2 x float> poison, <2 x i32> <i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <2 x float> [ %val1, %then ], [ %val2, %else ]
  ret <2 x float> %val3
}

define <3 x float> @shuffle_v3f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <3 x i32> <i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <3 x i32> <i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <3 x float> [ %val1, %then ], [ %val2, %else ]
  ret <3 x float> %val3
}

define <4 x float> @shuffle_v4f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <4 x float> [ %val1, %then ], [ %val2, %else ]
  ret <4 x float> %val3
}

define <6 x float> @shuffle_v6f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <6 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <6 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <6 x float> [ %val1, %then ], [ %val2, %else ]
  ret <6 x float> %val3
}

define <8 x float> @shuffle_v8f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <8 x float> [ %val1, %then ], [ %val2, %else ]
  ret <8 x float> %val3
}

define <16 x float> @shuffle_v16f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <16 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <16 x float> [ %val1, %then ], [ %val2, %else ]
  ret <16 x float> %val3
}

define <32 x float> @shuffle_v32f32(<3 x float> %arg0, i1 %cond) {
entry:
  br i1 %cond, label %then, label %else

then:                                             ; preds = %entry
  %val1 = shufflevector <3 x float> %arg0, <3 x float> poison, <32 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  tail call void @func0()
  br label %finally

else:                                             ; preds = %entry
  %val2 = shufflevector <3 x float> %arg0, <3 x float> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  tail call void @func1()
  br label %finally

finally:                                          ; preds = %else, %then
  %val3 = phi <32 x float> [ %val1, %then ], [ %val2, %else ]
  ret <32 x float> %val3
}

declare void @func0() local_unnamed_addr

declare void @func1() local_unnamed_addr
