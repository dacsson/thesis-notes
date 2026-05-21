# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a3, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addiw	a2, a0, 5
	sext.w	a1, a0
	slli	a1, a1, 2
	add	a1, a1, a3
	sw	a2, 20(a1)
	addiw	a2, a0, 6
	sw	a2, 24(a1)
	addiw	a0, a0, 35
	sw	a0, 140(a1)
                                        # implicit-def: $x10
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addiw	a2, a0, 5
	sext.w	a3, a0
	slli	a3, a3, 2
	add	a1, a1, a3
	sw	a2, 20(a1)
	addiw	a2, a0, 6
	sw	a2, 24(a1)
	addiw	a0, a0, 35
	sw	a0, 140(a1)
                                        # implicit-def: $x10
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
