# Source: SLPVectorizer/getpointerschaincost.riscv64__v_slp-vectorizer.ll
# Function: f
# src = pre-opt (f), tgt = post-opt (f)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	li	a0, 1
	sw	a0, 0(a1)
	sw	a0, 4(a1)
	sw	a0, 8(a1)
	sw	a0, 12(a1)
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v8, 1
	vse32.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
