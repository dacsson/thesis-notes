# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test10
# src = pre-opt (test10), tgt = post-opt (test10)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	slli	a0, a0, 56
	srli	a0, a0, 48
	slli	a1, a1, 56
	srli	a1, a1, 48
	call	__muldi3
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	slli	a0, a0, 56
	srli	a0, a0, 48
	slli	a1, a1, 56
	srli	a1, a1, 48
	call	__muldi3
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
                                        # -- End function
