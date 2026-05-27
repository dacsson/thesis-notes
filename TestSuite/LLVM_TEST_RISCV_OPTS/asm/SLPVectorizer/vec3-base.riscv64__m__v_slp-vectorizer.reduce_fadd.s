# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: reduce_fadd
# src = pre-opt (reduce_fadd), tgt = post-opt (reduce_fadd)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	flw	fa5, 0(a0)
	flw	fa3, 4(a0)
	flw	fa4, 8(a0)
	fadd.s	fa5, fa5, fa3
	fadd.s	fa0, fa5, fa4
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e8, mf4, ta, ma
	vmset.m	v0
                                        # implicit-def: $v9
	vsetivli	zero, 3, e32, m1, tu, ma
	vle32.v	v9, (a0)
                                        # implicit-def: $v10
	vmv.s.x	v10, zero
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vfredusum.vs	v8, v9, v10, v0.t
	vfmv.f.s	fa0, v8
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
