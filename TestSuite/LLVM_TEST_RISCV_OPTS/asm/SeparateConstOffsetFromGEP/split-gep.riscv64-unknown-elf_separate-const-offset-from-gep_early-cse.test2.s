# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a3, a0
	addiw	a0, a1, 5
	sext.w	a1, a1
	slli	a1, a1, 2
	add	a1, a1, a3
	sw	a2, 20(a1)
	sw	a2, 24(a1)
	sw	a0, 140(a1)
                                        # implicit-def: $x10
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a3, a1
	mv	a1, a0
	addiw	a0, a3, 5
	sext.w	a3, a3
	slli	a3, a3, 2
	add	a1, a1, a3
	sw	a2, 20(a1)
	sw	a2, 24(a1)
	sw	a0, 140(a1)
                                        # implicit-def: $x10
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
