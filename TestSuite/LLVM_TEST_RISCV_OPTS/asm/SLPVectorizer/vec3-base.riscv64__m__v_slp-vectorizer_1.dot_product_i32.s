# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer_1.ll
# Function: dot_product_i32
# src = pre-opt (dot_product_i32), tgt = post-opt (dot_product_i32)
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
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	lw	a1, 8(a1)
	lw	a5, 0(a3)
	lw	a4, 4(a3)
	lw	a3, 8(a3)
	mulw	a0, a0, a5
	mulw	a2, a2, a4
	mulw	a1, a1, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end12:
	.size	src, .Lfunc_end12-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a2, a1
	mv	a3, a0
	lw	a0, 8(a3)
	lw	a1, 8(a2)
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, tu, ma
	vle32.v	v8, (a3)
                                        # implicit-def: $v10
	vle32.v	v10, (a2)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, ta, ma
	vmul.vv	v9, v8, v10
	mulw	a0, a0, a1
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end12:
	.size	tgt, .Lfunc_end12-tgt
	.cfi_endproc
                                        # -- End function
