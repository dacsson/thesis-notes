# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test21
# src = pre-opt (test21), tgt = post-opt (test21)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a5, a0
	li	a3, 0
	sb	a3, 3(a5)
	li	a2, -26
	sb	a2, 2(a5)
	li	a0, 147
	sb	a0, 1(a5)
	li	a4, 199
	sb	a4, 0(a5)
	sb	a3, 3(a1)
	sb	a2, 2(a1)
	sb	a0, 1(a1)
	li	a0, 200
	sb	a0, 0(a1)
	ret
.Lfunc_end20:
	.size	src, .Lfunc_end20-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a5, a0
	li	a3, 0
	sb	a3, 3(a5)
	li	a2, -26
	sb	a2, 2(a5)
	li	a0, 147
	sb	a0, 1(a5)
	li	a4, 199
	sb	a4, 0(a5)
	sb	a3, 3(a1)
	sb	a2, 2(a1)
	sb	a0, 1(a1)
	li	a0, 200
	sb	a0, 0(a1)
	ret
.Lfunc_end20:
	.size	tgt, .Lfunc_end20-tgt
	.cfi_endproc
                                        # -- End function
