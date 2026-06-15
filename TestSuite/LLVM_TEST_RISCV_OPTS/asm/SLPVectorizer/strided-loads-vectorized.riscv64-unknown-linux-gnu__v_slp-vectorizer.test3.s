# Source: SLPVectorizer/strided-loads-vectorized.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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
	flw	fa4, 16(a0)
	flw	fa5, 116(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 4(a1)
	flw	fa4, 32(a0)
	flw	fa5, 112(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 8(a1)
	flw	fa4, 48(a0)
	flw	fa5, 108(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 12(a1)
	flw	fa4, 64(a0)
	flw	fa5, 104(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 16(a1)
	flw	fa4, 80(a0)
	flw	fa5, 100(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 20(a1)
	li	a2, 0
	sw	a2, 24(a1)
	flw	fa4, 112(a0)
	flw	fa5, 92(a0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, 28(a1)
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a0
	addi	a0, a2, 120
	li	a3, 16
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vlse32.v	v12, (a2), a3
	li	a2, -4
                                        # implicit-def: $v10m2
	vlse32.v	v10, (a0), a2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfsub.vv	v8, v10, v12
	vse32.v	v8, (a1)
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
