# Source: SimplifyCFG/switch_to_lookup_table-rv64._f_simplifycfg.ll
# Function: foostring
# src = pre-opt (foostring), tgt = post-opt (foostring)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	mv	a2, a0
	sext.w	a0, a2
	lui	a1, %hi(.L.str)
	addi	a1, a1, %lo(.L.str)
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB3_8
	j	.LBB3_1
.LBB3_1:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 1
	beq	a0, a1, .LBB3_4
	j	.LBB3_2
.LBB3_2:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 2
	beq	a0, a1, .LBB3_5
	j	.LBB3_3
.LBB3_3:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 3
	beq	a0, a1, .LBB3_6
	j	.LBB3_7
.LBB3_4:                                # %sw.bb1
	lui	a0, %hi(.L.str1)
	addi	a0, a0, %lo(.L.str1)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_5:                                # %sw.bb2
	lui	a0, %hi(.L.str2)
	addi	a0, a0, %lo(.L.str2)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_6:                                # %sw.bb3
	lui	a0, %hi(.L.str3)
	addi	a0, a0, %lo(.L.str3)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_7:                                # %sw.default
	lui	a0, %hi(.L.str4)
	addi	a0, a0, %lo(.L.str4)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_8:                                # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sext.w	a1, a0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	lui	a2, %hi(.L.str4)
	addi	a2, a2, %lo(.L.str4)
	li	a0, 3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %switch.lookup
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	slli	a1, a0, 3
	lui	a0, %hi(.Lswitch.table.foostring)
	addi	a0, a0, %lo(.Lswitch.table.foostring)
	add	a0, a0, a1
	ld	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
