# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: rt_stride_mul_scev
# src = pre-opt (rt_stride_mul_scev), tgt = post-opt (rt_stride_mul_scev)
# Triple: riscv64, Attrs: +m,+v,+unaligned-vector-mem
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	t0, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a7, a0, 1
	slli	a6, a0, 2
	add	a5, a6, a7
	slli	a4, a0, 3
	add	a3, a4, a7
	add	a1, a4, a6
	slli	a0, a0, 4
	sub	a0, a0, a7
	add	a7, t0, a7
	add	a6, t0, a6
	add	a5, t0, a5
	add	a4, t0, a4
	add	a3, t0, a3
	add	a1, t0, a1
	add	a0, t0, a0
	lbu	t0, 0(t0)
	lbu	a7, 0(a7)
	lbu	a6, 0(a6)
	lbu	a5, 0(a5)
	lbu	a4, 0(a4)
	lbu	a3, 0(a3)
	lbu	a1, 0(a1)
	lbu	a0, 0(a0)
	sb	t0, 0(a2)
	sb	a7, 1(a2)
	sb	a6, 2(a2)
	sb	a5, 3(a2)
	sb	a4, 4(a2)
	sb	a3, 5(a2)
	sb	a1, 6(a2)
	sb	a0, 7(a2)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	slli	a1, a1, 1
                                        # implicit-def: $v8m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vid.v	v8
                                        # implicit-def: $v12m4
	vmul.vx	v12, v8, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vluxei64.v	v8, (a0), v12
	vse8.v	v8, (a2)
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
