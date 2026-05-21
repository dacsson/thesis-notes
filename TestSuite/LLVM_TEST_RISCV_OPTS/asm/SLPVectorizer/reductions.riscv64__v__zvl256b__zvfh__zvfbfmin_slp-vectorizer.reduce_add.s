# Source: SLPVectorizer/reductions.riscv64__v__zvl256b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: reduce_add
# src = pre-opt (reduce_add), tgt = post-opt (reduce_add)
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
	and	a0, a0, a3
	lbu	a4, 1(a2)
	lbu	a3, 1(a1)
	and	a3, a3, a4
	add	a0, a0, a3
	lbu	a4, 2(a2)
	lbu	a3, 2(a1)
	and	a3, a3, a4
	add	a0, a0, a3
	lbu	a4, 3(a2)
	lbu	a3, 3(a1)
	and	a3, a3, a4
	add	a0, a0, a3
	lbu	a4, 4(a2)
	lbu	a3, 4(a1)
	and	a3, a3, a4
	add	a0, a0, a3
	lbu	a4, 5(a2)
	lbu	a3, 5(a1)
	and	a3, a3, a4
	add	a0, a0, a3
	lbu	a4, 6(a2)
	lbu	a3, 6(a1)
	and	a3, a3, a4
	add	a0, a0, a3
	lbu	a2, 7(a2)
	lbu	a1, 7(a1)
	and	a1, a1, a2
	add	a0, a0, a1
	addi	a0, a0, 1
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
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
	vand.vv	v9, v8, v10
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.i	v10, 1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
