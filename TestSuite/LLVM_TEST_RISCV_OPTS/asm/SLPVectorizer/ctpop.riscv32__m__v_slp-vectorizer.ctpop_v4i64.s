# Source: SLPVectorizer/ctpop.riscv32__m__v_slp-vectorizer.ll
# Function: ctpop_v4i64
# src = pre-opt (ctpop_v4i64), tgt = post-opt (ctpop_v4i64)
# Triple: riscv32, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v10, (a0)
	vmv1r.v	v8, v10
	li	a1, 32
                                        # implicit-def: $v12m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vsrl.vx	v12, v10, a1
	vmv1r.v	v9, v12
	vmv.x.s	a2, v9
	vmv.x.s	a0, v8
	srli	a3, a2, 1
	lui	a4, 349525
	addi	t1, a4, 1365
	and	a3, a3, t1
	sub	a3, a2, a3
	lui	a2, 209715
	addi	t0, a2, 819
	and	a2, a3, t0
	srli	a3, a3, 2
	and	a3, a3, t0
	add	a2, a2, a3
	srli	a3, a2, 4
	add	a2, a2, a3
	lui	a3, 61681
	addi	a6, a3, -241
	and	a2, a2, a6
	lui	a3, 4112
	addi	a5, a3, 257
	mul	a2, a2, a5
	srli	a2, a2, 24
	srli	a3, a0, 1
	and	a3, a3, t1
	sub	a3, a0, a3
	and	a0, a3, t0
	srli	a3, a3, 2
	and	a3, a3, t0
	add	a0, a0, a3
	srli	a3, a0, 4
	add	a0, a0, a3
	and	a0, a0, a6
	mul	a0, a0, a5
	srli	a0, a0, 24
	add	a0, a0, a2
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 1
                                        # implicit-def: $v12m2
	vsrl.vx	v12, v8, a1
                                        # kill: def $v12 killed $v12 killed $v12m2 killed $vtype
	vmv.x.s	a3, v12
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a2, v8
	srli	a4, a3, 1
	and	a4, a4, t1
	sub	a4, a3, a4
	and	a3, a4, t0
	srli	a4, a4, 2
	and	a4, a4, t0
	add	a3, a3, a4
	srli	a4, a3, 4
	add	a3, a3, a4
	and	a3, a3, a6
	mul	a3, a3, a5
	srli	a3, a3, 24
	srli	a4, a2, 1
	and	a4, a4, t1
	sub	a4, a2, a4
	and	a2, a4, t0
	srli	a4, a4, 2
	and	a4, a4, t0
	add	a2, a2, a4
	srli	a4, a2, 4
	add	a2, a2, a4
	and	a2, a2, a6
	mul	a2, a2, a5
	srli	a2, a2, 24
	add	a3, a2, a3
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 2
                                        # implicit-def: $v12m2
	vsrl.vx	v12, v8, a1
                                        # kill: def $v12 killed $v12 killed $v12m2 killed $vtype
	vmv.x.s	a4, v12
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a2, v8
	srli	a7, a4, 1
	and	a7, a7, t1
	sub	a7, a4, a7
	and	a4, a7, t0
	srli	a7, a7, 2
	and	a7, a7, t0
	add	a4, a4, a7
	srli	a7, a4, 4
	add	a4, a4, a7
	and	a4, a4, a6
	mul	a4, a4, a5
	srli	a4, a4, 24
	srli	a7, a2, 1
	and	a7, a7, t1
	sub	a7, a2, a7
	and	a2, a7, t0
	srli	a7, a7, 2
	and	a7, a7, t0
	add	a2, a2, a7
	srli	a7, a2, 4
	add	a2, a2, a7
	and	a2, a2, a6
	mul	a2, a2, a5
	srli	a2, a2, 24
	add	a2, a2, a4
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 3
                                        # implicit-def: $v10m2
	vsrl.vx	v10, v8, a1
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a4, v10
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a1, v8
	srli	a7, a4, 1
	and	a7, a7, t1
	sub	a7, a4, a7
	and	a4, a7, t0
	srli	a7, a7, 2
	and	a7, a7, t0
	add	a4, a4, a7
	srli	a7, a4, 4
	add	a4, a4, a7
	and	a4, a4, a6
	mul	a4, a4, a5
	srli	a4, a4, 24
	srli	a7, a1, 1
	and	a7, a7, t1
	sub	a7, a1, a7
	and	a1, a7, t0
	srli	a7, a7, 2
	and	a7, a7, t0
	add	a1, a1, a7
	srli	a7, a1, 4
	add	a1, a1, a7
	and	a1, a1, a6
	mul	a1, a1, a5
	srli	a1, a1, 24
	add	a1, a1, a4
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v10, a0
	li	a0, 0
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a0
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a3
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a0
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a2
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a0
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
	lui	a0, 349525
	addi	a0, a0, 1365
                                        # implicit-def: $v14m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v14, a0
                                        # implicit-def: $v12m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vsrl.vi	v12, v8, 1
                                        # implicit-def: $v10m2
	vand.vv	v10, v12, v14
                                        # implicit-def: $v12m2
	vsub.vv	v12, v8, v10
	lui	a0, 209715
	addi	a0, a0, 819
                                        # implicit-def: $v14m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v14, a0
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vand.vv	v10, v12, v14
                                        # implicit-def: $v8m2
	vsrl.vi	v8, v12, 2
                                        # implicit-def: $v12m2
	vand.vv	v12, v8, v14
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
                                        # implicit-def: $v12m2
	vsrl.vi	v12, v8, 4
                                        # implicit-def: $v10m2
	vadd.vv	v10, v8, v12
	lui	a0, 61681
	addi	a0, a0, -241
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v12, a0
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vand.vv	v8, v10, v12
	lui	a0, 4112
	addi	a0, a0, 257
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v12, a0
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vmul.vv	v10, v8, v12
	li	a0, 56
                                        # implicit-def: $v8m2
	vsrl.vx	v8, v10, a0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
