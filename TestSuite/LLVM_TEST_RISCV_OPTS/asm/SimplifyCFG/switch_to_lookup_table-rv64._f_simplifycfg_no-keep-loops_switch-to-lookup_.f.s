# Source: SimplifyCFG/switch_to_lookup_table-rv64._f_simplifycfg_no-keep-loops_switch-to-lookup_.ll
# Function: f
# src = pre-opt (f), tgt = post-opt (f)
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
	li	a1, 55
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	addiw	a1, a0, -42
	slli	a0, a1, 32
	srli	a0, a0, 32
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 6
	bltu	a0, a1, .LBB0_8
# %bb.1:                                # %entry
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 2
	lui	a0, %hi(.LJTI0_0)
	addi	a0, a0, %lo(.LJTI0_0)
	add	a0, a0, a2
	lw	a0, 0(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	jr	a0
.LBB0_2:                                # %sw.bb1
	li	a0, 123
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_3:                                # %sw.bb2
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_4:                                # %sw.bb3
	li	a0, -1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_5:                                # %sw.bb4
	li	a0, 27
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_6:                                # %sw.bb5
	li	a0, 62
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_7:                                # %sw.bb6
	li	a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_8:                                # %sw.default
	li	a0, 15
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI0_0:

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	addiw	a1, a0, -42
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	li	a2, 15
	li	a0, 6
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %switch.lookup
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	slli	a1, a0, 2
	lui	a0, %hi(.Lswitch.table.f)
	addi	a0, a0, %lo(.Lswitch.table.f)
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
