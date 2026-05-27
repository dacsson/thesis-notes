# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: v3_load_i32_udiv_by_constant_store
# src = pre-opt (v3_load_i32_udiv_by_constant_store), tgt = post-opt (v3_load_i32_udiv_by_constant_store)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a4, a0
	lw	a2, 0(a4)
	li	a0, 10
	divuw	a3, a0, a2
	lw	a2, 4(a4)
	divuw	a2, a0, a2
	lw	a4, 8(a4)
	divuw	a0, a0, a4
	sw	a3, 0(a1)
	sw	a2, 4(a1)
	sw	a0, 8(a1)
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
                                        # implicit-def: $v10
	vsetivli	zero, 3, e32, m1, tu, ma
	vle32.v	v10, (a0)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v9, 10
                                        # implicit-def: $v8
	vsetivli	zero, 3, e32, m1, ta, ma
	vdivu.vv	v8, v9, v10
	vse32.v	v8, (a1)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
