# Source: SeparateConstOffsetFromGEP/split-gep.riscv64-unknown-elf_separate-const-offset-from-gep_early-cse.ll
# Function: test_inbounds1
# src = pre-opt (test_inbounds1), tgt = post-opt (test_inbounds1)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 4
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a1, a0, .LBB9_2
# %bb.1:                                # %entry
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB9_2:                                # %entry
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	not	a0, a0
	slli	a0, a0, 2
	andi	a0, a0, -8
	add	a0, a0, a1
	ld	a0, 40(a0)
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 4
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a1, a0, .LBB9_2
# %bb.1:                                # %entry
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB9_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	not	a1, a1
	slli	a1, a1, 2
	andi	a1, a1, -8
	add	a0, a0, a1
	ld	a0, 40(a0)
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
