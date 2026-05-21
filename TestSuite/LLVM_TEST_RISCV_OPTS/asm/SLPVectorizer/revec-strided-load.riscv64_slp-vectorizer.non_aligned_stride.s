# Source: SLPVectorizer/revec-strided-load.riscv64_slp-vectorizer.ll
# Function: non_aligned_stride
# src = pre-opt (non_aligned_stride), tgt = post-opt (non_aligned_stride)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a0
	lbu	a3, 0(a2)
	lbu	a4, 1(a2)
	lbu	a0, 3(a2)
	lbu	a2, 4(a2)
	sb	a4, 1(a1)
	sb	a3, 0(a1)
	sb	a2, 3(a1)
	sb	a0, 2(a1)
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	a2, a0, 3
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.x	v8, a2
	vmv1r.v	v10, v8
	vmv.s.x	v10, a0
	csrr	a0, vlenb
	srli	a0, a0, 3
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vid.v	v8
                                        # implicit-def: $v11
	vsrl.vi	v11, v8, 1
                                        # implicit-def: $v9
	vslidedown.vx	v9, v11, a0
                                        # implicit-def: $v8
	vsetvli	a0, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v10, v9
                                        # implicit-def: $v9
	vrgatherei16.vv	v9, v10, v11
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v9
	vmv.v.v	v11, v8
	lui	a0, 4096
	addi	a0, a0, 256
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, ta, ma
	vsext.vf4	v8, v9
	vwadd.wv	v10, v10, v8
	li	a0, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vluxei64.v	v8, (a0), v10
	vse8.v	v8, (a1)
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
