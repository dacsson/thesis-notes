# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v2i16
# src = pre-opt (shuffle_v2i16), tgt = post-opt (shuffle_v2i16)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	mv	a3, a1
	mv	a1, a0
	andi	a0, a2, 1
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB5_2
	j	.LBB5_1
.LBB5_1:                                # %then
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	func0
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_3
.LBB5_2:                                # %else
	call	func1
                                        # implicit-def: $x10
                                        # implicit-def: $x10
	j	.LBB5_3
.LBB5_3:                                # %finally
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	mv	a3, a1
	mv	a1, a0
	andi	a0, a2, 1
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB5_2
	j	.LBB5_1
.LBB5_1:                                # %then
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	func0
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_3
.LBB5_2:                                # %else
	call	func1
                                        # implicit-def: $x10
                                        # implicit-def: $x10
	j	.LBB5_3
.LBB5_3:                                # %finally
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
