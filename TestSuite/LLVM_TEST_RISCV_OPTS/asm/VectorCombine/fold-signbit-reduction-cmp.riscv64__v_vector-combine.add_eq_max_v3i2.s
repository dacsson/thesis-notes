# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: add_eq_max_v3i2
# src = pre-opt (add_eq_max_v3i2), tgt = post-opt (add_eq_max_v3i2)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	ld	a1, 8(a0)
	ld	a2, 0(a0)
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.x	v8, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
	ld	a0, 16(a0)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vslidedown.vi	v9, v8, 1
                                        # implicit-def: $v8
	vand.vi	v8, v9, 3
	lui	a0, 16
	addi	a0, a0, 257
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vsrl.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.s.x	v10, a0
	vsetvli	zero, zero, e8, mf4, ta, ma
	vslideup.vi	v9, v10, 3
                                        # implicit-def: $v8
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 3
	addi	a0, a0, -3
	seqz	a0, a0
	ret
.Lfunc_end39:
	.size	src, .Lfunc_end39-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	ld	a1, 8(a0)
	ld	a2, 0(a0)
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.x	v8, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
	ld	a0, 16(a0)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vslidedown.vi	v9, v8, 1
                                        # implicit-def: $v8
	vand.vi	v8, v9, 3
	lui	a0, 16
	addi	a0, a0, 257
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vsrl.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.s.x	v10, a0
	vsetvli	zero, zero, e8, mf4, ta, ma
	vslideup.vi	v9, v10, 3
                                        # implicit-def: $v8
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 3
	addi	a0, a0, -3
	seqz	a0, a0
	ret
.Lfunc_end39:
	.size	tgt, .Lfunc_end39-tgt
	.cfi_endproc
                                        # -- End function
