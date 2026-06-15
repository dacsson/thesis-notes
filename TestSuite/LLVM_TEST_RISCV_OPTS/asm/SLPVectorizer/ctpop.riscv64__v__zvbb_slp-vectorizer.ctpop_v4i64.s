# Source: SLPVectorizer/ctpop.riscv64__v__zvbb_slp-vectorizer.ll
# Function: ctpop_v4i64
# src = pre-opt (ctpop_v4i64), tgt = post-opt (ctpop_v4i64)
# Triple: riscv64, Attrs: +v,+zvbb
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
	add	a7, a2, a3
	and	a1, a1, a7
	sub	a1, a0, a1
	lui	a0, 209715
	addi	a0, a0, 819
	slli	a2, a0, 32
	add	a6, a0, a2
	and	a0, a1, a6
	srli	a1, a1, 2
	and	a1, a1, a6
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a0, a0, a1
	lui	a1, 61681
	addi	a1, a1, -241
	slli	a2, a1, 32
	add	a4, a1, a2
	and	a0, a0, a4
	slli	a1, a0, 8
	add	a0, a0, a1
	slli	a1, a0, 16
	add	a0, a0, a1
	slli	a1, a0, 32
	add	a0, a0, a1
	srli	a3, a0, 56
                                        # implicit-def: $v8
	vsetivli	zero, 1, e64, m1, ta, ma
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
	add	a0, a0, a1
	and	a0, a0, a4
	slli	a1, a0, 8
	add	a0, a0, a1
	slli	a1, a0, 16
	add	a0, a0, a1
	slli	a1, a0, 32
	add	a0, a0, a1
	srli	a2, a0, 56
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v10, 2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	srli	a1, a0, 1
	and	a1, a1, a7
	sub	a1, a0, a1
	and	a0, a1, a6
	srli	a1, a1, 2
	and	a1, a1, a6
	add	a0, a0, a1
	srli	a1, a0, 4
	add	a0, a0, a1
	and	a0, a0, a4
	slli	a1, a0, 8
	add	a0, a0, a1
	slli	a1, a0, 16
	add	a0, a0, a1
	slli	a1, a0, 32
	add	a0, a0, a1
	srli	a1, a0, 56
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 3
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	srli	a5, a0, 1
	and	a5, a5, a7
	sub	a5, a0, a5
	and	a0, a5, a6
	srli	a5, a5, 2
	and	a5, a5, a6
	add	a0, a0, a5
	srli	a5, a0, 4
	add	a0, a0, a5
	and	a0, a0, a4
	slli	a4, a0, 8
	add	a0, a0, a4
	slli	a4, a0, 16
	add	a0, a0, a4
	slli	a4, a0, 32
	add	a0, a0, a4
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
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v10, (a0)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vcpop.v	v8, v10
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
