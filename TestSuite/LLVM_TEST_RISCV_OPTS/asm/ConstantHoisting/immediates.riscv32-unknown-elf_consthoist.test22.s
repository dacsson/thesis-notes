# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test22
# src = pre-opt (test22), tgt = post-opt (test22)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a2, a0
	li	a0, 0
	sw	a0, 4(a2)
	sw	a0, 0(a2)
	li	a0, -1
	sw	a0, 4(a1)
	sw	a0, 0(a1)
	ret
.Lfunc_end21:
	.size	src, .Lfunc_end21-src
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
	li	a0, 0
	sw	a0, 4(a2)
	sw	a0, 0(a2)
	li	a0, -1
	sw	a0, 4(a1)
	sw	a0, 0(a1)
	ret
.Lfunc_end21:
	.size	tgt, .Lfunc_end21-tgt
	.cfi_endproc
                                        # -- End function
