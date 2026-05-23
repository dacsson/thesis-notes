# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test18
# src = pre-opt (test18), tgt = post-opt (test18)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sext.w	a0, a1
	bnez	a0, .LBB17_2
	j	.LBB17_1
.LBB17_1:                               # %if.true
	li	a0, 3
	slli	a0, a0, 30
	lw	a0, 32(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB17_3
.LBB17_2:                               # %if.false
	li	a0, 3
	slli	a0, a0, 30
	lw	a0, 32(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB17_3
.LBB17_3:                               # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end17:
	.size	src, .Lfunc_end17-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sext.w	a0, a1
	lui	a1, 786432
	addi	a1, a1, 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB17_2
	j	.LBB17_1
.LBB17_1:                               # %if.true
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a0, a0, 32
	lw	a0, 0(a0)
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB17_3
.LBB17_2:                               # %if.false
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a0, a0, 32
	lw	a0, 0(a0)
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB17_3
.LBB17_3:                               # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end17:
	.size	tgt, .Lfunc_end17-tgt
                                        # -- End function
