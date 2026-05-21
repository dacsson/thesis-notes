# Source: SimplifyCFG/switch_to_lookup_table-rv64._f_simplifycfg_no-keep-loops_switch-to-lookup_.ll
# Function: h
# src = pre-opt (h), tgt = post-opt (h)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	mv	a2, a0
	sext.w	a0, a2
	li	a1, 42
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	lui	a2, 263311
	addi	a2, a2, 1475
	fmv.w.x	fa5, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB2_8
	j	.LBB2_1
.LBB2_1:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 1
	beq	a0, a1, .LBB2_4
	j	.LBB2_2
.LBB2_2:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 2
	beq	a0, a1, .LBB2_5
	j	.LBB2_3
.LBB2_3:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 3
	beq	a0, a1, .LBB2_6
	j	.LBB2_7
.LBB2_4:                                # %sw.bb1
	li	a0, 9
	lui	a1, 260575
	addi	a1, a1, 950
	fmv.w.x	fa5, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB2_8
.LBB2_5:                                # %sw.bb2
	li	a0, 88
	lui	a1, 264482
	addi	a1, a1, 1245
	fmv.w.x	fa5, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB2_8
.LBB2_6:                                # %sw.bb3
	li	a0, 5
	lui	a1, 262359
	addi	a1, a1, 164
	fmv.w.x	fa5, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB2_8
.LBB2_7:                                # %sw.default
	li	a0, 7
	lui	a1, 266749
	addi	a1, a1, 1802
	fmv.w.x	fa5, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB2_8
.LBB2_8:                                # %sw.epilog
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa0, 20(sp)                     # 4-byte Folded Reload
	slli	a0, a0, 56
	srai	a0, a0, 56
	call	dummy
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sext.w	a1, a0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a2, 7
	lui	a0, 266749
	addi	a0, a0, 1802
	fmv.w.x	fa5, a0
	li	a0, 3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	bltu	a0, a1, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %switch.lookup
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slliw	a2, a1, 3
	lui	a0, 21889
	addi	a0, a0, -1750
	srlw	a0, a0, a2
	sext.w	a1, a1
	slli	a2, a1, 2
	lui	a1, %hi(.Lswitch.table.h)
	addi	a1, a1, %lo(.Lswitch.table.h)
	add	a1, a1, a2
	flw	fa5, 0(a1)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %sw.epilog
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa0, 20(sp)                     # 4-byte Folded Reload
	slli	a0, a0, 56
	srai	a0, a0, 56
	call	dummy
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
