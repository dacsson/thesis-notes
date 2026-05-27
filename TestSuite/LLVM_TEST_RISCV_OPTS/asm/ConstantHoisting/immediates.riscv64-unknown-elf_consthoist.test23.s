# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test23
# src = pre-opt (test23), tgt = post-opt (test23)
# Triple: riscv64-unknown-elf, Attrs: none
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
	sd	a0, 8(a2)
	sd	a0, 0(a2)
	li	a0, -1
	srli	a2, a0, 1
	sd	a2, 8(a1)
	sd	a0, 0(a1)
	ret
.Lfunc_end22:
	.size	src, .Lfunc_end22-src
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
	sd	a0, 8(a2)
	sd	a0, 0(a2)
	li	a0, -1
	srli	a2, a0, 1
	sd	a2, 8(a1)
	sd	a0, 0(a1)
	ret
.Lfunc_end22:
	.size	tgt, .Lfunc_end22-tgt
	.cfi_endproc
                                        # -- End function
