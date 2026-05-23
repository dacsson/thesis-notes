# Source: SLPVectorizer/reductions.riscv64__v__zvfhmin__zvfbfmin_slp-vectorizer.ll
# Function: red_ld_8xi64
# src = pre-opt (red_ld_8xi64), tgt = post-opt (red_ld_8xi64)
# Triple: riscv64, Attrs: +v,+zvfhmin,+zvfbfmin
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
	ld	a2, 8(a1)
	add	a0, a0, a2
	ld	a2, 16(a1)
	add	a0, a0, a2
	ld	a2, 24(a1)
	add	a0, a0, a2
	ld	a2, 32(a1)
	add	a0, a0, a2
	ld	a2, 40(a1)
	add	a0, a0, a2
	ld	a2, 48(a1)
	add	a0, a0, a2
	ld	a1, 56(a1)
	add	a0, a0, a1
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v12m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vle64.v	v12, (a0)
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m4, ta, ma
	vredsum.vs	v8, v12, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
