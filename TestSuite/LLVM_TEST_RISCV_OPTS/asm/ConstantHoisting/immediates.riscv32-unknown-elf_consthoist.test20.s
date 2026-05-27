# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test20
# src = pre-opt (test20), tgt = post-opt (test20)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a3, a0
	lui	a0, 3689
	addi	a2, a0, 967
	sw	a2, 0(a3)
	addi	a0, a0, 968
	sw	a0, 0(a1)
	ret
.Lfunc_end19:
	.size	src, .Lfunc_end19-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a2, a0
	lui	a0, 3689
	addi	a0, a0, 967
	sw	a0, 0(a2)
	addi	a0, a0, 1
	sw	a0, 0(a1)
	ret
.Lfunc_end19:
	.size	tgt, .Lfunc_end19-tgt
	.cfi_endproc
                                        # -- End function
