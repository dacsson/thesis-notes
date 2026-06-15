# Source: SLPVectorizer/init-ext-node-not-truncable.riscv64-unknown-linux-gnu___v__slp-vectorizer.ll
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
	lui	a1, %hi(h)
	li	a0, -1
	srli	a0, a0, 32
	sd	a0, %lo(h)(a1)
	li	a0, 0
	sd	a0, %lo(h+8)(a1)
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
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.i	v8, 0
	li	a0, -1
	srli	a0, a0, 32
	vmv.s.x	v8, a0
	lui	a0, %hi(h)
	addi	a0, a0, %lo(h)
	vse64.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
