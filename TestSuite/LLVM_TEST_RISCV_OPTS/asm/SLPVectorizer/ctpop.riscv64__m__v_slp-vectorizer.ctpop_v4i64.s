# Source: SLPVectorizer/ctpop.riscv64__m__v_slp-vectorizer.ll
# Function: ctpop_v4i64
# src = pre-opt (ctpop_v4i64), tgt = post-opt (ctpop_v4i64)
# Triple: riscv64, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v10, (a0)
	vmv1r.v	v9, v10
	vmv.x.s	a0, v9
	srli	a1, a0, 1
	lui	a2, 349525
	addi	a2, a2, 1365
	slli	a3, a2, 32
	add	t0, a2, a3
	and	a1, a1, t0
	sub	a1, a0, a1
	lui	a0, 209715
	addi	a0, a0, 819
	slli	a2, a0, 32
	add	a7, a0, a2
	and	a0, a1, a7
	srli	a1, a1, 2
	and	a1, a1, a7
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a0, a0, a1
	lui	a1, 61681
	addi	a1, a1, -241
	slli	a2, a1, 32
	add	a5, a1, a2
	and	a0, a0, a5
	lui	a1, 4112
	addi	a1, a1, 257
	slli	a2, a1, 32
	add	a4, a1, a2
	mul	a0, a0, a4
	srli	a3, a0, 56
                                        # implicit-def: $v8
	vsetivli	zero, 1, e64, m1, ta, ma
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
	add	a0, a0, a1
	and	a0, a0, a5
	mul	a0, a0, a4
	srli	a2, a0, 56
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v10, 2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, t0
	sub	a1, a0, a1
	and	a0, a1, a7
	srli	a1, a1, 2
	and	a1, a1, a7
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a0, a0, a1
	and	a0, a0, a5
	mul	a0, a0, a4
	srli	a1, a0, 56
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 3
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	srli	a6, a0, 1
	and	a6, a6, t0
	sub	a6, a0, a6
	and	a0, a6, a7
	srli	a6, a6, 2
	and	a6, a6, a7
	add	a0, a0, a6
	srli	a6, a0, 4
	add	a0, a0, a6
	and	a0, a0, a5
	mul	a0, a0, a4
	srli	a0, a0, 56
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.x	v10, a3
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a2
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a1
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v8, (a0)
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vsrl.vi	v12, v8, 1
	lui	a0, 349525
	addi	a0, a0, 1365
	slli	a1, a0, 32
	add	a0, a0, a1
                                        # implicit-def: $v10m2
	vand.vx	v10, v12, a0
                                        # implicit-def: $v12m2
	vsub.vv	v12, v8, v10
	lui	a0, 209715
	addi	a0, a0, 819
	slli	a1, a0, 32
	add	a0, a0, a1
                                        # implicit-def: $v10m2
	vand.vx	v10, v12, a0
                                        # implicit-def: $v8m2
	vsrl.vi	v8, v12, 2
                                        # implicit-def: $v12m2
	vand.vx	v12, v8, a0
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
                                        # implicit-def: $v12m2
	vsrl.vi	v12, v8, 4
                                        # implicit-def: $v10m2
	vadd.vv	v10, v8, v12
	lui	a0, 61681
	addi	a0, a0, -241
	slli	a1, a0, 32
	add	a0, a0, a1
                                        # implicit-def: $v8m2
	vand.vx	v8, v10, a0
	lui	a0, 4112
	addi	a0, a0, 257
	slli	a1, a0, 32
	add	a0, a0, a1
                                        # implicit-def: $v10m2
	vmul.vx	v10, v8, a0
	li	a0, 56
                                        # implicit-def: $v8m2
	vsrl.vx	v8, v10, a0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
