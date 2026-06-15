# Source: SLPVectorizer/ctpop.riscv64__m__v_slp-vectorizer.ll
# Function: ctpop_v4i8
# src = pre-opt (ctpop_v4i8), tgt = post-opt (ctpop_v4i8)
# Triple: riscv64, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v9, (a0)
	vmv.x.s	a0, v9
	srli	a1, a0, 1
	andi	a1, a1, 85
	subw	a1, a0, a1
	andi	a0, a1, 51
	srli	a1, a1, 2
	andi	a1, a1, 51
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	andi	a3, a0, 15
                                        # implicit-def: $v8
	vsetivli	zero, 1, e8, mf4, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	andi	a1, a1, 85
	subw	a1, a0, a1
	andi	a0, a1, 51
	srli	a1, a1, 2
	andi	a1, a1, 51
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	andi	a2, a0, 15
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	andi	a1, a1, 85
	subw	a1, a0, a1
	andi	a0, a1, 51
	srli	a1, a1, 2
	andi	a1, a1, 51
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	andi	a1, a0, 15
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	srli	a4, a0, 1
	andi	a4, a4, 85
	subw	a4, a0, a4
	andi	a0, a4, 51
	srli	a4, a4, 2
	andi	a4, a4, 51
	add	a0, a0, a4
	srli	a4, a0, 4
	addw	a0, a0, a4
	andi	a0, a0, 15
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.x	v9, a3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v8, (a0)
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, ta, ma
	vsrl.vi	v10, v8, 1
	li	a0, 85
                                        # implicit-def: $v9
	vand.vx	v9, v10, a0
                                        # implicit-def: $v10
	vsub.vv	v10, v8, v9
	li	a0, 51
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
                                        # implicit-def: $v8
	vand.vi	v8, v9, 15
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
