# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: dot_product_i32_reorder
# src = pre-opt (dot_product_i32_reorder), tgt = post-opt (dot_product_i32_reorder)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a3, a1
	mv	a1, a0
	lw	a2, 0(a1)
	lw	a0, 4(a1)
	lw	a1, 8(a1)
	lw	a5, 0(a3)
	lw	a4, 4(a3)
	lw	a3, 8(a3)
	mulw	a2, a2, a5
	mulw	a0, a0, a4
	mulw	a1, a1, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end13:
	.size	src, .Lfunc_end13-src
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
                                        # implicit-def: $v10
	vle32.v	v10, (a1)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, ta, ma
	vmul.vv	v9, v8, v10
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
.Lfunc_end13:
	.size	tgt, .Lfunc_end13-tgt
	.cfi_endproc
                                        # -- End function
