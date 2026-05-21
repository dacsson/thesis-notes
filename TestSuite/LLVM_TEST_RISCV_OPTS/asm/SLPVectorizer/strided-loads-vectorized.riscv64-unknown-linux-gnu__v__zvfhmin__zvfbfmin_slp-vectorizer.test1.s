# Source: SLPVectorizer/strided-loads-vectorized.riscv64-unknown-linux-gnu__v__zvfhmin__zvfbfmin_slp-vectorizer.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v,+zvfhmin,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	flw	fa4, 0(a0)
	flw	fa5, 120(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	slli	a2, a2, 32
	srli	a3, a2, 30
	add	a4, a0, a3
	flw	fa4, 0(a4)
	flw	fa5, 104(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 4(a1)
	srli	a5, a2, 29
	add	a4, a0, a5
	flw	fa4, 0(a4)
	flw	fa5, 88(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 8(a1)
	add	a4, a5, a3
	add	a4, a0, a4
	flw	fa4, 0(a4)
	flw	fa5, 72(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 12(a1)
	srli	a4, a2, 28
	add	a6, a0, a4
	flw	fa4, 0(a6)
	flw	fa5, 56(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 16(a1)
	add	a6, a4, a3
	add	a6, a0, a6
	flw	fa4, 0(a6)
	flw	fa5, 40(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 20(a1)
	add	a4, a4, a5
	add	a4, a0, a4
	flw	fa4, 0(a4)
	flw	fa5, 24(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 24(a1)
	srli	a2, a2, 27
	sub	a2, a2, a3
	add	a2, a0, a2
	flw	fa4, 0(a2)
	flw	fa5, 8(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 28(a1)
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	mv	a2, a0
	addi	a0, a2, 120
	slli	a3, a3, 32
	srli	a3, a3, 30
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vlse32.v	v12, (a2), a3
	li	a2, -16
                                        # implicit-def: $v10m2
	vlse32.v	v10, (a0), a2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfsub.vv	v8, v10, v12
	vse32.v	v8, (a1)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
