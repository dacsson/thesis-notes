# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: v3_load_i32_mul_store
# src = pre-opt (v3_load_i32_mul_store), tgt = post-opt (v3_load_i32_mul_store)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a4, a1
	lw	a1, 0(a0)
	lw	a3, 0(a4)
	mulw	a3, a1, a3
	lw	a1, 4(a0)
	lw	a5, 4(a4)
	mulw	a1, a1, a5
	lw	a0, 8(a0)
	lw	a4, 8(a4)
	mulw	a0, a0, a4
	sw	a3, 0(a2)
	sw	a1, 4(a2)
	sw	a0, 8(a2)
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
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
	vsetivli	zero, 3, e32, m1, tu, ma
	vle32.v	v9, (a0)
                                        # implicit-def: $v10
	vle32.v	v10, (a1)
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, ta, ma
	vmul.vv	v8, v9, v10
	vsetivli	zero, 3, e32, m1, ta, ma
	vse32.v	v8, (a2)
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
