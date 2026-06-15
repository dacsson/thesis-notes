# Source: SLPVectorizer/ctpop.riscv64__m__v_slp-vectorizer.ll
# Function: ctpop_v4i32
# src = pre-opt (ctpop_v4i32), tgt = post-opt (ctpop_v4i32)
# Triple: riscv64, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a0)
	vmv.x.s	a0, v9
	srli	a1, a0, 1
	lui	a2, 349525
	addi	t0, a2, 1365
	and	a1, a1, t0
	sub	a1, a0, a1
	lui	a0, 209715
	addi	a7, a0, 819
	and	a0, a1, a7
	srli	a1, a1, 2
	and	a1, a1, a7
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	lui	a1, 61681
	addi	a5, a1, -241
	and	a0, a0, a5
	lui	a1, 4112
	addi	a4, a1, 257
	mulw	a0, a0, a4
	srliw	a3, a0, 24
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, t0
	sub	a1, a0, a1
	and	a0, a1, a7
	srli	a1, a1, 2
	and	a1, a1, a7
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	and	a0, a0, a5
	mulw	a0, a0, a4
	srliw	a2, a0, 24
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, t0
	sub	a1, a0, a1
	and	a0, a1, a7
	srli	a1, a1, 2
	and	a1, a1, a7
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	and	a0, a0, a5
	mulw	a0, a0, a4
	srliw	a1, a0, 24
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	srli	a6, a0, 1
	and	a6, a6, t0
	sub	a6, a0, a6
	and	a0, a6, a7
	srli	a6, a6, 2
	and	a6, a6, a7
	add	a0, a0, a6
	srli	a6, a0, 4
	addw	a0, a0, a6
	and	a0, a0, a5
	mulw	a0, a0, a4
	srliw	a0, a0, 24
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.x	v9, a3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a0)
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vsrl.vi	v10, v8, 1
	lui	a0, 349525
	addi	a0, a0, 1365
                                        # implicit-def: $v9
	vand.vx	v9, v10, a0
                                        # implicit-def: $v10
	vsub.vv	v10, v8, v9
	lui	a0, 209715
	addi	a0, a0, 819
                                        # implicit-def: $v9
	vand.vx	v9, v10, a0
                                        # implicit-def: $v8
	vsrl.vi	v8, v10, 2
                                        # implicit-def: $v10
	vand.vx	v10, v8, a0
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v10
                                        # implicit-def: $v10
	vsrl.vi	v10, v8, 4
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	lui	a0, 61681
	addi	a0, a0, -241
                                        # implicit-def: $v8
	vand.vx	v8, v9, a0
	lui	a0, 4112
	addi	a0, a0, 257
                                        # implicit-def: $v9
	vmul.vx	v9, v8, a0
                                        # implicit-def: $v8
	vsrl.vi	v8, v9, 24
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
