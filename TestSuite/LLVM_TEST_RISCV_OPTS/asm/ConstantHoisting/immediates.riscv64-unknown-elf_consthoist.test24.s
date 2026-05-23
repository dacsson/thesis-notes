# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test24
# src = pre-opt (test24), tgt = post-opt (test24)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a4, a0
	li	a2, 0
	sw	a2, 12(a4)
	sw	a2, 8(a4)
	sw	a2, 4(a4)
	lui	a0, 3689
	addi	a3, a0, 967
	sw	a3, 0(a4)
	sw	a2, 12(a1)
	sw	a2, 8(a1)
	sw	a2, 4(a1)
	addi	a0, a0, 968
	sw	a0, 0(a1)
	ret
.Lfunc_end23:
	.size	src, .Lfunc_end23-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a4, a0
	li	a2, 0
	sw	a2, 12(a4)
	sw	a2, 8(a4)
	sw	a2, 4(a4)
	lui	a0, 3689
	addi	a3, a0, 967
	sw	a3, 0(a4)
	sw	a2, 12(a1)
	sw	a2, 8(a1)
	sw	a2, 4(a1)
	addi	a0, a0, 968
	sw	a0, 0(a1)
	ret
.Lfunc_end23:
	.size	tgt, .Lfunc_end23-tgt
	.cfi_endproc
                                        # -- End function
