# Source: SLPVectorizer/revec.riscv64_slp-vectorizer_1.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_remember_state
	j	.LBB2_1
.LBB2_1:                                # %for.body.lr.ph
	li	a0, 1
	bnez	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.cond.cleanup
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.LBB2_3:                                # %for.body
	.cfi_restore_state
	lw	a0, 4(zero)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lw	a0, 0(zero)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	call	__gtsf2
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slt	a2, a1, a2
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	call	__gtsf2
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	slt	a3, a0, a3
	sub	a3, a0, a3
	and	a3, a3, a4
	sub	a0, a0, a2
	and	a0, a0, a1
	j	.LBB2_2
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	j	.LBB2_1
.LBB2_1:                                # %for.body.lr.ph
	li	a0, 1
	bnez	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.cond.cleanup
	ret
.LBB2_3:                                # %for.body
	li	a0, 0
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, tu, ma
	vle32.v	v8, (a0)
	fmv.w.x	fa5, zero
	vsetvli	zero, zero, e32, mf2, ta, ma
	vmfgt.vf	v0, v8, fa5
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf8, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v10
	vmerge.vim	v10, v9, 1, v0
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf8, ta, ma
	vid.v	v9
                                        # implicit-def: $v11
	vsrl.vi	v11, v9, 1
                                        # implicit-def: $v9
	vrsub.vi	v9, v11, 1
	vslideup.vi	v9, v10, 2
	vmsne.vi	v0, v9, 0
	vmv1r.v	v10, v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vslideup.vi	v10, v8, 2
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vvm	v8, v9, v10, v0
	j	.LBB2_2
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
