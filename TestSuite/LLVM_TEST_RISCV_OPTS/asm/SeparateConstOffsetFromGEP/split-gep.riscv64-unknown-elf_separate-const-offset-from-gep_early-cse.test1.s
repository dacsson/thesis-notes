# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a3, a0
	addi	a0, a1, 5
	slli	a1, a1, 3
	add	a1, a1, a3
	sd	a2, 40(a1)
	sd	a2, 48(a1)
	sd	a0, 280(a1)
                                        # implicit-def: $x10
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a3, a1
	mv	a1, a0
	addi	a0, a3, 5
	slli	a3, a3, 3
	add	a1, a1, a3
	sd	a2, 40(a1)
	sd	a2, 48(a1)
	sd	a0, 280(a1)
                                        # implicit-def: $x10
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
