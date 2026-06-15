# Source: SLPVectorizer/shuffled-gather-casted.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
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
	lhu	a0, 0(a0)
	slti	a0, a0, 1
	slli	a0, a0, 1
	seqz	a1, a0
	or	a0, a0, a1
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
	lh	a0, 0(a0)
                                        # implicit-def: $v8
	vsetivli	zero, 4, e16, m1, tu, ma
	vmv.s.x	v8, a0
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, ta, ma
	vzext.vf2	v9, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.v.i	v8, 0
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.v.v	v8, v9
	vsetivli	zero, 4, e32, m1, ta, ma
	vmsgt.vi	v0, v8, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.v.i	v9, 2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vsext.vf2	v8, v9
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, tu, ma
	vmerge.vim	v9, v8, 0, v0
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vredmaxu.vs	v8, v9, v10
	vmv.x.s	a0, v8
	slli	a1, a0, 48
	srli	a0, a1, 48
	seqz	a1, a1
	add	a0, a0, a1
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
