# Source: SLPVectorizer/repeated-address-store.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	li	a2, 0
	sh	a2, 14(a1)
	li	a0, 1
	sh	a0, 12(a1)
	sw	a0, 0(a1)
	sh	a2, 6(a1)
	sh	a0, 4(a1)
	sh	a2, 10(a1)
	sh	a0, 8(a1)
	sh	a2, 2(a1)
	li	a3, 2
	sh	a3, 0(a1)
	sh	a2, 14(a1)
	sh	a0, 12(a1)
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
	mv	a1, a0
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v8, 1
	vse32.v	v8, (a1)
	li	a0, 0
	sh	a0, 2(a1)
	li	a2, 2
	sh	a2, 0(a1)
	sh	a0, 14(a1)
	li	a0, 1
	sh	a0, 12(a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
