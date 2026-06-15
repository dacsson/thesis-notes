# Source: SLPVectorizer/ctpop.riscv32__v__zvbb_slp-vectorizer.ll
# Function: ctpop_v4i16
# src = pre-opt (ctpop_v4i16), tgt = post-opt (ctpop_v4i16)
# Triple: riscv32, Attrs: +v,+zvbb
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vle16.v	v9, (a0)
	vmv.x.s	a0, v9
	srli	a1, a0, 1
	lui	a2, 5
	addi	a6, a2, 1365
	and	a1, a1, a6
	sub	a1, a0, a1
	lui	a0, 3
	addi	a5, a0, 819
	and	a0, a1, a5
	srli	a1, a1, 2
	and	a1, a1, a5
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a1, a0, a1
	andi	a0, a1, 15
	slli	a1, a1, 20
	srli	a1, a1, 28
	add	a3, a0, a1
                                        # implicit-def: $v8
	vsetivli	zero, 1, e16, mf2, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, a6
	sub	a1, a0, a1
	and	a0, a1, a5
	srli	a1, a1, 2
	and	a1, a1, a5
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a1, a0, a1
	andi	a0, a1, 15
	slli	a1, a1, 20
	srli	a1, a1, 28
	add	a2, a0, a1
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, a6
	sub	a1, a0, a1
	and	a0, a1, a5
	srli	a1, a1, 2
	and	a1, a1, a5
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a1, a0, a1
	andi	a0, a1, 15
	slli	a1, a1, 20
	srli	a1, a1, 28
	add	a1, a0, a1
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	srli	a4, a0, 1
	and	a4, a4, a6
	sub	a4, a0, a4
	and	a0, a4, a5
	srli	a4, a4, 2
	and	a4, a4, a5
	add	a0, a0, a4
	srli	a4, a0, 4
	add	a4, a0, a4
	andi	a0, a4, 15
	slli	a4, a4, 20
	srli	a4, a4, 28
	add	a0, a0, a4
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv.v.x	v9, a3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vle16.v	v9, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vcpop.v	v8, v9
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
