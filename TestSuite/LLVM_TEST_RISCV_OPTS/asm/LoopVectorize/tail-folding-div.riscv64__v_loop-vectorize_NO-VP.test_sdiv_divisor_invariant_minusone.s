# Source: LoopVectorize/tail-folding-div.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_sdiv_divisor_invariant_minusone
# src = pre-opt (test_sdiv_divisor_invariant_minusone), tgt = post-opt (test_sdiv_divisor_invariant_minusone)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a1, a1, a3
	ld	a4, 0(a1)
	li	a1, 0
	sub	a1, a1, a4
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
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
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_2
# %bb.1:                                # %loop.preheader
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB3_2:                                # %loop.preheader
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_6
	j	.LBB3_3
.LBB3_3:                                # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB3_4
.LBB3_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 3
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vle64.v	v10, (a5)
                                        # implicit-def: $v8m2
	vrsub.vi	v8, v10, 0
	add	a3, a3, a4
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_4
	j	.LBB3_5
.LBB3_5:                                # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB3_8
	j	.LBB3_6
.LBB3_6:                                # %scalar.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_7
.LBB3_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a1, a1, a3
	ld	a4, 0(a1)
	li	a1, 0
	sub	a1, a1, a4
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB3_7
	j	.LBB3_8
.LBB3_8:                                # %exit
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
