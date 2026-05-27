# Source: SLPVectorizer/reductions.riscv64__v__zvl256b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: reduce_and
# src = pre-opt (reduce_and), tgt = post-opt (reduce_and)
# Triple: riscv64, Attrs: +v,+zvl256b,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a0
	lbu	a3, 0(a2)
	lbu	a0, 0(a1)
	xor	a0, a0, a3
	lbu	a4, 1(a2)
	lbu	a3, 1(a1)
	xor	a3, a3, a4
	and	a0, a0, a3
	lbu	a4, 2(a2)
	lbu	a3, 2(a1)
	xor	a3, a3, a4
	and	a0, a0, a3
	lbu	a4, 3(a2)
	lbu	a3, 3(a1)
	xor	a3, a3, a4
	and	a0, a0, a3
	lbu	a4, 4(a2)
	lbu	a3, 4(a1)
	xor	a3, a3, a4
	and	a0, a0, a3
	lbu	a4, 5(a2)
	lbu	a3, 5(a1)
	xor	a3, a3, a4
	and	a0, a0, a3
	lbu	a4, 6(a2)
	lbu	a3, 6(a1)
	xor	a3, a3, a4
	and	a0, a0, a3
	lbu	a2, 7(a2)
	lbu	a1, 7(a1)
	xor	a1, a1, a2
	and	a0, a0, a1
	andi	a0, a0, 1
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10
	vsetivli	zero, 8, e8, mf4, tu, ma
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vxor.vv	v9, v8, v10
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 1
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
