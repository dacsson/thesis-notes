# Source: CodeGenPrepare/and-mask-sink.riscv64_zbs_require_profile-summary__function_codegenprepare_.ll
# Function: and_sink1
# src = pre-opt (and_sink1), tgt = post-opt (and_sink1)
# Triple: riscv64, Attrs: zbs
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	bseti	a1, zero, 11
	and	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %bb0
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
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
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %bb0
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lui	a2, %hi(A)
	li	a1, 0
	sw	a1, %lo(A)(a2)
	slli	a0, a0, 52
	bgez	a0, .LBB0_1
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
