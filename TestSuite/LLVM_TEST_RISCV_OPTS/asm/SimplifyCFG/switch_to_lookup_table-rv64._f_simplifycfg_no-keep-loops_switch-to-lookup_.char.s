# Source: SimplifyCFG/switch_to_lookup_table-rv64._f_simplifycfg_no-keep-loops_switch-to-lookup_.ll
# Function: char
# src = pre-opt (char), tgt = post-opt (char)
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
	li	a0, 8
	bltu	a0, a1, .LBB1_10
# %bb.1:                                # %entry
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 2
	lui	a0, %hi(.LJTI1_0)
	addi	a0, a0, %lo(.LJTI1_0)
	add	a0, a0, a2
	lw	a0, 0(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	jr	a0
.LBB1_2:                                # %sw.bb1
	li	a0, 123
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_3:                                # %sw.bb2
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_4:                                # %sw.bb3
	li	a0, 255
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_5:                                # %sw.bb4
	li	a0, 27
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_6:                                # %sw.bb5
	li	a0, 62
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_7:                                # %sw.bb6
	li	a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_8:                                # %sw.bb7
	li	a0, 33
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_9:                                # %sw.bb8
	li	a0, 84
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_10:                               # %sw.default
	li	a0, 15
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_11:                               # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI1_0:

                                        # -- End function
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
	li	a0, 8
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %switch.lookup
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a1, a0
	lui	a0, %hi(.Lswitch.table.char)
	addi	a0, a0, %lo(.Lswitch.table.char)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
