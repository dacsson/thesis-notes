# Source: SLPVectorizer/reductions.riscv64__v__zvl512b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: red_zext_ld_8xi64
# src = pre-opt (red_zext_ld_8xi64), tgt = post-opt (red_zext_ld_8xi64)
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
	lbu	a0, 0(a1)
	lbu	a2, 1(a1)
	add	a0, a0, a2
	lbu	a2, 2(a1)
	add	a0, a0, a2
	lbu	a2, 3(a1)
	add	a0, a0, a2
	lbu	a2, 4(a1)
	add	a0, a0, a2
	lbu	a2, 5(a1)
	add	a0, a0, a2
	lbu	a2, 6(a1)
	add	a0, a0, a2
	lbu	a1, 7(a1)
	add	a0, a0, a1
	ret
.Lfunc_end16:
	.size	src, .Lfunc_end16-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf8, tu, ma
	vle8.v	v8, (a0)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e64, m1, ta, ma
	vzext.vf8	v9, v8
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e64, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end16:
	.size	tgt, .Lfunc_end16-tgt
	.cfi_endproc
                                        # -- End function
