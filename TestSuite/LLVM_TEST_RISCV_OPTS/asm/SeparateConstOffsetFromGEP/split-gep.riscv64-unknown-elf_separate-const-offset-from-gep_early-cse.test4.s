# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test4
# src = pre-opt (test4), tgt = post-opt (test4)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addiw	a2, a1, 5
	slli	a4, a2, 6
	slli	a3, a2, 3
	sub	a3, a3, a4
	slli	a4, a2, 8
	add	a3, a3, a4
	add	a3, a0, a3
	slli	a0, a2, 2
	add	a0, a3, a0
	sw	a1, 0(a0)
	sext.w	a0, a1
	slli	a0, a0, 2
	add	a0, a0, a3
	sw	a2, 24(a0)
	sw	a1, 140(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
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
	slli	a5, a3, 6
	slli	a4, a3, 3
	sub	a4, a4, a5
	slli	a5, a3, 8
	add	a4, a4, a5
	add	a0, a0, a4
	slli	a3, a3, 2
	add	a0, a0, a3
	sw	a1, 1020(a0)
	sw	a2, 1024(a0)
	sw	a1, 1140(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
