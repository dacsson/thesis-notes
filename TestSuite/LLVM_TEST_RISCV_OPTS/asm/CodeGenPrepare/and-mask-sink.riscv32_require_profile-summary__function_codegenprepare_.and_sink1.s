# Source: CodeGenPrepare/and-mask-sink.riscv32_require_profile-summary__function_codegenprepare_.ll
# Function: and_sink1
# src = pre-opt (and_sink1), tgt = post-opt (and_sink1)
# Triple: riscv32, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a1, 1
	slli	a1, a1, 11
	and	a0, a0, a1
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %bb0
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lui	a2, %hi(A)
	li	a1, 0
	sw	a1, %lo(A)(a2)
	beqz	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %bb2
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a1, 1
	slli	a1, a1, 11
	and	a0, a0, a1
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %bb0
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lui	a2, %hi(A)
	li	a1, 0
	sw	a1, %lo(A)(a2)
	beqz	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %bb2
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
