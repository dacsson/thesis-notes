# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test6
# src = pre-opt (test6), tgt = post-opt (test6)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a3, a2
	addi	a2, a1, 5
	slli	a3, a3, 3
	add	a3, a0, a3
	sd	a2, 0(a3)
	slli	a2, a1, 3
	add	a0, a0, a2
	sd	a1, 48(a0)
	sd	a1, 0(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a3, a2
	addi	a2, a1, 5
	slli	a3, a3, 3
	add	a3, a0, a3
	sd	a2, 0(a3)
	slli	a2, a1, 3
	add	a0, a0, a2
	sd	a1, 48(a0)
	sd	a1, 0(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
