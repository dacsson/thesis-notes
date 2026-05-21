# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test8
# src = pre-opt (test8), tgt = post-opt (test8)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a5, a0
	addiw	a4, a3, 5
	sext.w	a0, a3
	slli	a0, a0, 2
	add	a5, a0, a5
	sw	a4, 20(a5)
	add	a1, a0, a1
	sw	a3, 24(a1)
	add	a0, a0, a2
	sw	a3, 140(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a5, a0
	addiw	a4, a3, 5
	sext.w	a0, a3
	slli	a0, a0, 2
	add	a5, a5, a0
	sw	a4, 20(a5)
	add	a1, a1, a0
	sw	a3, 24(a1)
	add	a0, a2, a0
	sw	a3, 140(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
