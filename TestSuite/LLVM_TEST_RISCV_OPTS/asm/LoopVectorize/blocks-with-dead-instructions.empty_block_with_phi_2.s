# Source: LoopVectorize/blocks-with-dead-instructions.ll
# Function: empty_block_with_phi_2
# src = pre-opt (empty_block_with_phi_2), tgt = post-opt (empty_block_with_phi_2)
# Triple: riscv64, Attrs: v
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
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	li	a2, 0
	slli	a1, a1, 1
	add	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lhu	a0, 0(a0)
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                # %else
                                        #   in Loop: Header=BB7_1 Depth=1
	li	a0, 99
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB7_3
.LBB7_3:                                # %loop.latch
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	sh	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_4
.LBB7_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.ph
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB7_2
.LBB7_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a4, a1, 1
	add	a3, a3, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v12, (a3)
	vsetvli	a4, zero, e16, m2, ta, ma
	vmseq.vi	v0, v12, 0
	li	a4, 99
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.v.x	v10, a4
                                        # implicit-def: $v8m2
	vmerge.vvm	v8, v10, v12, v0
	vsetvli	zero, a2, e16, m2, ta, ma
	vse16.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB7_2
	j	.LBB7_3
.LBB7_3:                                # %middle.block
	j	.LBB7_4
.LBB7_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
