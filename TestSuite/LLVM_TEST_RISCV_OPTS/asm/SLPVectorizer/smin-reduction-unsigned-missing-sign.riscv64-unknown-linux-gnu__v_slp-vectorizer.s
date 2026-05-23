# Source: SLPVectorizer/smin-reduction-unsigned-missing-sign.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	li	a0, 0
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
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.i	v8, 0
	vmv1r.v	v9, v8
	vmv.s.x	v9, a0
	vsetvli	zero, zero, e8, mf4, ta, ma
	vmsne.vi	v0, v9, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v9, v8, 1, v0
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vredmin.vs	v8, v9, v10
	vmv.x.s	a0, v8
	zext.b	a0, a0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
