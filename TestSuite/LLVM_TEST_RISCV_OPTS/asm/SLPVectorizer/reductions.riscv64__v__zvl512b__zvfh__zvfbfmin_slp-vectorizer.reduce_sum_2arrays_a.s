# Source: SLPVectorizer/reductions.riscv64__v__zvl512b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: reduce_sum_2arrays_a
# src = pre-opt (reduce_sum_2arrays_a), tgt = post-opt (reduce_sum_2arrays_a)
# Triple: riscv64, Attrs: +v,+zvl512b,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a0
	lbu	a0, 0(a2)
	lbu	a3, 0(a1)
	addw	a0, a0, a3
	lbu	a4, 1(a2)
	lbu	a3, 1(a1)
	addw	a0, a0, a4
	addw	a0, a0, a3
	lbu	a4, 2(a2)
	lbu	a3, 2(a1)
	addw	a0, a0, a4
	addw	a0, a0, a3
	lbu	a2, 3(a2)
	lbu	a1, 3(a1)
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end19:
	.size	src, .Lfunc_end19-src
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
	vsetivli	zero, 4, e8, mf8, tu, ma
	vle8.v	v8, (a0)
                                        # implicit-def: $v9
	vle8.v	v9, (a1)
	vsetivli	zero, 8, e8, mf8, ta, ma
	vslideup.vi	v8, v9, 4
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, ta, ma
	vzext.vf4	v9, v8
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end19:
	.size	tgt, .Lfunc_end19-tgt
	.cfi_endproc
                                        # -- End function
