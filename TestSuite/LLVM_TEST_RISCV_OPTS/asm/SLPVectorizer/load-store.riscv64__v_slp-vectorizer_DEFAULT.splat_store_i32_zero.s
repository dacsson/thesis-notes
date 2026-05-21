# Source: SLPVectorizer/load-store.riscv64__v_slp-vectorizer_DEFAULT.ll
# Function: splat_store_i32_zero
# src = pre-opt (splat_store_i32_zero), tgt = post-opt (splat_store_i32_zero)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	li	a0, 0
	sw	a0, 0(a1)
	sh	a0, 6(a1)
	sh	a0, 4(a1)
	sh	a0, 10(a1)
	sh	a0, 8(a1)
	sh	a0, 14(a1)
	sh	a0, 12(a1)
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
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
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v8, 0
	vse32.v	v8, (a0)
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
