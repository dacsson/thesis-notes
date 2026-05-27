# Source: SLPVectorizer/smin-signed-zextended.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	not	a1, a1
	lui	a2, 1048560
	or	a1, a1, a2
	slli	a0, a0, 48
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	srai	a0, a0, 48
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	lui	a2, 16
	addi	a2, a2, -1
	and	a1, a1, a2
	srai	a0, a0, 63
	or	a0, a0, a3
	and	a0, a0, a2
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a1
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv.v.i	v9, 0
	vmv.s.x	v9, a1
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 7
                                        # implicit-def: $v8
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmerge.vxm	v8, v9, a1, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v9, v8
	slli	a0, a0, 48
	srai	a0, a0, 48
                                        # implicit-def: $v8
	vnot.v	v8, v9
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.v.x	v9, a0
	li	a1, 0
	vmv.s.x	v9, a1
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 14
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vxm	v10, v9, a0, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vmax.vv	v9, v8, v10
	lui	a0, 16
	addi	a0, a0, -1
                                        # implicit-def: $v8
	vand.vx	v8, v9, a0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
