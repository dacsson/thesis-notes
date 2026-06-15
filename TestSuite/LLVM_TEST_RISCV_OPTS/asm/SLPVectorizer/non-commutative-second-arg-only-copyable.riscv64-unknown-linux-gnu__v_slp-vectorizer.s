# Source: SLPVectorizer/non-commutative-second-arg-only-copyable.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: main
# src = pre-opt (main), tgt = post-opt (main)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lb	a0, 0(a0)
	slli	a2, a2, 56
	srai	a2, a2, 56
	sllw	a2, a2, a2
	sh	a2, 0(a1)
	addiw	a2, a0, 1
	li	a0, 1
	sllw	a0, a0, a2
	sh	a0, 2(a1)
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
	lbu	a0, 0(a0)
                                        # implicit-def: $v9
	vsetivli	zero, 2, e8, mf8, tu, ma
	vmv.v.x	v9, a2
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, ta, ma
	vsext.vf4	v9, v8
                                        # implicit-def: $v8
	vid.v	v8
                                        # implicit-def: $v10
	vadd.vv	v10, v9, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.v.i	v8, 1
	vsetivli	zero, 1, e32, mf2, tu, ma
	vmv.v.v	v8, v9
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, ta, ma
	vsll.vv	v9, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, ta, ma
	vnsrl.wi	v8, v9, 0
	vse16.v	v8, (a1)
	li	a0, 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
