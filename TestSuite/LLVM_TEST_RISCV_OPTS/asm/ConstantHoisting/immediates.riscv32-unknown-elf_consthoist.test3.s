# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	lui	a2, 8
	addi	a2, a2, -2
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	li	a3, 0
	call	__muldi3
	mv	a2, a0
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	lui	a2, 8
	addi	a2, a2, -2
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	li	a3, 0
	call	__muldi3
	mv	a2, a0
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
                                        # -- End function
