# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test9
# src = pre-opt (test9), tgt = post-opt (test9)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a0
	addiw	a3, a1, 5
	sext.w	a5, a1
	slli	a0, a5, 2
	add	a4, a0, a2
	sw	a3, 20(a4)
	addiw	a4, a1, 6
	slli	a6, a5, 6
	slli	a3, a5, 3
	sub	a3, a3, a6
	slli	a5, a5, 8
	add	a3, a3, a5
	add	a3, a2, a3
	slli	a5, a4, 2
	add	a3, a3, a5
	sw	a1, 0(a3)
	slli	a5, a4, 6
	slli	a3, a4, 3
	sub	a3, a3, a5
	slli	a4, a4, 8
	add	a3, a3, a4
	add	a2, a2, a3
	add	a0, a0, a2
	sw	a1, 140(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addiw	a2, a1, 5
	sext.w	a3, a1
	slli	a4, a3, 2
	add	a0, a0, a4
	sw	a2, 20(a0)
	slli	a4, a3, 6
	slli	a2, a3, 3
	sub	a2, a2, a4
	slli	a3, a3, 8
	add	a2, a2, a3
	add	a0, a0, a2
	sw	a1, 24(a0)
	sw	a1, 1340(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
