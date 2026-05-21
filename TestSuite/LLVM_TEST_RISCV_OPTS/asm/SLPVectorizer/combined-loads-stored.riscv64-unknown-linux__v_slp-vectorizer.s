# Source: SLPVectorizer/combined-loads-stored.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	lh	a4, 0(a0)
	lh	a3, 2(a0)
	lh	a2, 16(a0)
	lh	a0, 18(a0)
	sh	a4, 0(a1)
	sh	a3, 2(a1)
	sh	a2, 4(a1)
	sh	a0, 6(a1)
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
# %bb.0:
	mv	a2, a0
	addi	a0, a2, 16
                                        # implicit-def: $v8
	vsetivli	zero, 2, e16, mf4, tu, ma
	vle16.v	v8, (a2)
                                        # implicit-def: $v9
	vle16.v	v9, (a0)
	vsetivli	zero, 4, e16, mf2, ta, ma
	vslideup.vi	v8, v9, 2
	vse16.v	v8, (a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
