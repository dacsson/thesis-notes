# Source: SLPVectorizer/reduction-extension-after-bitwidth.riscv64-unknown-linux-gnu___v__slp-vectorizer.ll
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
	lwu	a0, 0(a1)
	andi	a0, a0, 1
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
	lw	a1, 0(a1)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.i	v9, 1
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vredand.vs	v8, v9, v10
	vmv.x.s	a0, v8
	and	a0, a0, a1
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
