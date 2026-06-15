# Source: SLPVectorizer/strided-loads-vectorized.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	flw	fa4, 8(a0)
	slli	a3, a2, 32
	srli	a4, a3, 27
	srli	a2, a3, 30
	sub	a4, a4, a2
	add	a4, a0, a4
	flw	fa5, 0(a4)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 24(a0)
	srli	a4, a3, 28
	srli	a3, a3, 29
	add	a5, a4, a3
	add	a5, a0, a5
	flw	fa5, 0(a5)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 4(a1)
	flw	fa4, 40(a0)
	add	a5, a4, a2
	add	a5, a0, a5
	flw	fa5, 0(a5)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 8(a1)
	flw	fa4, 56(a0)
	add	a4, a0, a4
	flw	fa5, 0(a4)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 12(a1)
	flw	fa4, 72(a0)
	add	a4, a3, a2
	add	a4, a0, a4
	flw	fa5, 0(a4)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 16(a1)
	flw	fa4, 88(a0)
	add	a3, a0, a3
	flw	fa5, 0(a3)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 20(a1)
	flw	fa4, 104(a0)
	add	a2, a0, a2
	flw	fa5, 0(a2)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 24(a1)
	flw	fa4, 120(a0)
	flw	fa5, 0(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 28(a1)
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
	mv	a3, a2
	addi	a2, a0, 8
	slli	a3, a3, 32
	srli	a4, a3, 27
	srli	a3, a3, 30
	sub	a4, a4, a3
	add	a0, a0, a4
	li	a4, 16
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vlse32.v	v12, (a2), a4
	li	a2, 0
	sub	a2, a2, a3
                                        # implicit-def: $v10m2
	vlse32.v	v10, (a0), a2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfsub.vv	v8, v10, v12
	vse32.v	v8, (a1)
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
