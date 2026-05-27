# Source: CodeGenPrepare/and-mask-sink.riscv32_require_profile-summary__function_codegenprepare_.ll
# Function: and_sink3
# src = pre-opt (and_sink3), tgt = post-opt (and_sink3)
# Triple: riscv32, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	andi	a0, a0, 1024
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %bb0
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lui	a2, %hi(A)
	li	a1, 0
	sw	a1, %lo(A)(a2)
	beqz	a0, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %bb2
	li	a0, 0
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
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	andi	a0, a0, 1024
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %bb0
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lui	a2, %hi(A)
	li	a1, 0
	sw	a1, %lo(A)(a2)
	beqz	a0, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %bb2
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
