# Source: SLPVectorizer/reductions.riscv64__v__zvl512b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: red_strided_ld_16xi64
# src = pre-opt (red_strided_ld_16xi64), tgt = post-opt (red_strided_ld_16xi64)
# Triple: riscv64, Attrs: +v,+zvl512b,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	ld	a0, 0(a1)
	ld	a2, 16(a1)
	add	a0, a0, a2
	ld	a2, 32(a1)
	add	a0, a0, a2
	ld	a2, 48(a1)
	add	a0, a0, a2
	ld	a2, 64(a1)
	add	a0, a0, a2
	ld	a2, 80(a1)
	add	a0, a0, a2
	ld	a2, 96(a1)
	add	a0, a0, a2
	ld	a2, 112(a1)
	add	a0, a0, a2
	ld	a2, 128(a1)
	add	a0, a0, a2
	ld	a2, 144(a1)
	add	a0, a0, a2
	ld	a2, 160(a1)
	add	a0, a0, a2
	ld	a2, 176(a1)
	add	a0, a0, a2
	ld	a2, 192(a1)
	add	a0, a0, a2
	ld	a2, 208(a1)
	add	a0, a0, a2
	ld	a2, 224(a1)
	add	a0, a0, a2
	ld	a1, 240(a1)
	add	a0, a0, a1
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	li	a1, 16
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e64, m2, tu, ma
	vlse64.v	v10, (a0), a1
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
