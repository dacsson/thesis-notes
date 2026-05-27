# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: reduce_add_after_mul
# src = pre-opt (reduce_add_after_mul), tgt = post-opt (reduce_add_after_mul)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	lw	a1, 8(a1)
	slliw	a3, a0, 1
	slliw	a0, a0, 3
	addw	a0, a0, a3
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	slliw	a3, a1, 1
	slliw	a1, a1, 3
	addw	a1, a1, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 3, e32, m1, tu, ma
	vle32.v	v8, (a0)
	li	a0, 10
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, ta, ma
	vmul.vx	v9, v8, a0
	vmset.m	v0
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetivli	zero, 3, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10, v0.t
	vmv.x.s	a0, v8
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
