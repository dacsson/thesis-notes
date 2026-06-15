# Source: SLPVectorizer/getpointerschaincost.riscv64__v_slp-vectorizer.ll
# Function: g
# src = pre-opt (g), tgt = post-opt (g)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a1, 2
	add	a1, a0, a1
	li	a0, 1
	sw	a0, 0(a1)
	sw	a0, 4(a1)
	sw	a0, 8(a1)
	sw	a0, 12(a1)
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
	lui	a1, 2
	add	a0, a0, a1
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v8, 1
	vse32.v	v8, (a0)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
