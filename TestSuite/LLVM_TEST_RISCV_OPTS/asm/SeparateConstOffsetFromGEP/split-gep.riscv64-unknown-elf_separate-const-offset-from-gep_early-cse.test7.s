# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test7
# src = pre-opt (test7), tgt = post-opt (test7)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addiw	a4, a1, 5
	sext.w	a5, a1
	slli	a5, a5, 2
	add	a5, a5, a2
	sw	a4, 20(a5)
	sext.w	a3, a3
	slli	a3, a3, 2
	add	a3, a3, a2
	sw	a1, 24(a3)
	sext.w	a0, a0
	slli	a0, a0, 2
	add	a0, a0, a2
	sw	a1, 140(a0)
                                        # implicit-def: $x10
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addiw	a4, a1, 5
	sext.w	a5, a1
	slli	a5, a5, 2
	add	a5, a0, a5
	sw	a4, 20(a5)
	sext.w	a3, a3
	slli	a3, a3, 2
	add	a3, a0, a3
	sw	a1, 24(a3)
	sext.w	a2, a2
	slli	a2, a2, 2
	add	a0, a0, a2
	sw	a1, 140(a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
