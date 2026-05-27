# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test17
# src = pre-opt (test17), tgt = post-opt (test17)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	sext.w	a0, a1
	bnez	a0, .LBB16_2
	j	.LBB16_1
.LBB16_1:                               # %if.true
	li	a0, 3
	slli	a1, a0, 30
	li	a0, 20
	sw	a0, 32(a1)
	j	.LBB16_2
.LBB16_2:                               # %exit
	li	a0, 3
	slli	a1, a0, 30
	li	a0, 10
	sw	a0, 32(a1)
	ret
.Lfunc_end16:
	.size	src, .Lfunc_end16-src
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
	bnez	a0, .LBB16_2
	j	.LBB16_1
.LBB16_1:                               # %if.true
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a1, a0, 32
	li	a0, 20
	sw	a0, 0(a1)
	j	.LBB16_2
.LBB16_2:                               # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a1, a0, 32
	li	a0, 10
	sw	a0, 0(a1)
	addi	sp, sp, 16
	ret
.Lfunc_end16:
	.size	tgt, .Lfunc_end16-tgt
                                        # -- End function
