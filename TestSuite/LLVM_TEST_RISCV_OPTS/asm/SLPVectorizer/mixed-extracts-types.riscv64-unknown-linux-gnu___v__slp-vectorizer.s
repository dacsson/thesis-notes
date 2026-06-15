# Source: SLPVectorizer/mixed-extracts-types.riscv64-unknown-linux-gnu___v__slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: "+v"
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lb	a1, -13(zero)
	snez	a0, a1
	sh	a0, -28(zero)
	li	a0, 0
	sw	a0, -56(zero)
	lbu	a2, -12(zero)
	snez	a2, a2
	sh	a2, -26(zero)
	sw	a1, -52(zero)
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
	li	a0, -13
                                        # implicit-def: $v8
	vsetivli	zero, 2, e8, mf8, tu, ma
	vle8.v	v8, (a0)
	lbu	a0, -13(zero)
	vsetvli	zero, zero, e8, mf8, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf8, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e16, mf4, tu, ma
	vmv.v.i	v10, 0
                                        # implicit-def: $v9
	vmerge.vim	v9, v10, 1, v0
	li	a1, -28
	vse16.v	v9, (a1)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf8, tu, ma
	vslide1down.vx	v9, v8, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vsext.vf4	v8, v9
	li	a0, -56
	vse32.v	v8, (a0)
	li	a0, 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
