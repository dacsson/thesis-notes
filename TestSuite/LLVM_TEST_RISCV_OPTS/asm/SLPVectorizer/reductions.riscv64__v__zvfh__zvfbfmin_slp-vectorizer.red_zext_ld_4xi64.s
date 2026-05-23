# Source: SLPVectorizer/reductions.riscv64__v__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: red_zext_ld_4xi64
# src = pre-opt (red_zext_ld_4xi64), tgt = post-opt (red_zext_ld_4xi64)
# Triple: riscv64, Attrs: +v,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	lbu	a0, 0(a1)
	lbu	a2, 1(a1)
	add	a0, a0, a2
	lbu	a2, 2(a1)
	add	a0, a0, a2
	lbu	a1, 3(a1)
	add	a0, a0, a1
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vle8.v	v9, (a0)
	li	a0, 0
                                        # implicit-def: $v10
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwredsumu.vs	v8, v9, v10
	vsetvli	zero, zero, e16, mf2, ta, ma
	vmv.x.s	a0, v8
	slli	a0, a0, 48
	srli	a0, a0, 48
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
