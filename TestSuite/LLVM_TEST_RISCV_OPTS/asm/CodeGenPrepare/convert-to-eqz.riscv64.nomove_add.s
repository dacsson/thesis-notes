# Source: CodeGenPrepare/convert-to-eqz.riscv64.ll
# Function: nomove_add
# src = pre-opt (nomove_add), tgt = post-opt (nomove_add)
# Triple: riscv64, Attrs: none
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
	mv	a1, a0
	zext.b	a0, a1
	addi	a1, a1, 1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	li	a1, 255
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %if.then
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	addi	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	zext.b	a0, a0
	li	a1, 255
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %if.then
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
