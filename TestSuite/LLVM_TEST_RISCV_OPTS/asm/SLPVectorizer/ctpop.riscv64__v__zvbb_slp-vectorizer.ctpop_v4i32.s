# Source: SLPVectorizer/ctpop.riscv64__v__zvbb_slp-vectorizer.ll
# Function: ctpop_v4i32
# src = pre-opt (ctpop_v4i32), tgt = post-opt (ctpop_v4i32)
# Triple: riscv64, Attrs: +v,+zvbb
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
	addi	a7, a2, 1365
	and	a1, a1, a7
	sub	a1, a0, a1
	lui	a0, 209715
	addi	a6, a0, 819
	and	a0, a1, a6
	srli	a1, a1, 2
	and	a1, a1, a6
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	lui	a1, 61681
	addi	a4, a1, -241
	and	a0, a0, a4
	slliw	a1, a0, 8
	addw	a0, a0, a1
	slliw	a1, a0, 16
	addw	a0, a0, a1
	srliw	a3, a0, 24
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, a7
	sub	a1, a0, a1
	and	a0, a1, a6
	srli	a1, a1, 2
	and	a1, a1, a6
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	and	a0, a0, a4
	slliw	a1, a0, 8
	addw	a0, a0, a1
	slliw	a1, a0, 16
	addw	a0, a0, a1
	srliw	a2, a0, 24
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, a7
	sub	a1, a0, a1
	and	a0, a1, a6
	srli	a1, a1, 2
	and	a1, a1, a6
	add	a0, a0, a1
	srli	a1, a0, 4
	addw	a0, a0, a1
	and	a0, a0, a4
	slliw	a1, a0, 8
	addw	a0, a0, a1
	slliw	a1, a0, 16
	addw	a0, a0, a1
	srliw	a1, a0, 24
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	srli	a5, a0, 1
	and	a5, a5, a7
	sub	a5, a0, a5
	and	a0, a5, a6
	srli	a5, a5, 2
	and	a5, a5, a6
	add	a0, a0, a5
	srli	a5, a0, 4
	addw	a0, a0, a5
	and	a0, a0, a4
	slliw	a4, a0, 8
	addw	a0, a0, a4
	slliw	a4, a0, 16
	addw	a0, a0, a4
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
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vcpop.v	v8, v9
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
