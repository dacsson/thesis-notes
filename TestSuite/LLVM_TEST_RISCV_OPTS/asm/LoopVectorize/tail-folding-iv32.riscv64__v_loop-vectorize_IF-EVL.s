# Source: LoopVectorize/tail-folding-iv32.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: iv32
# src = pre-opt (iv32), tgt = post-opt (iv32)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	sext.w	a4, a0
	slli	a4, a4, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	add	a3, a3, a4
	sw	a2, 0(a3)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.cond.cleanup
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 32
	srli	a2, a2, 32
	vsetvli	a2, a2, e8, mf2, ta, ma
	sext.w	a4, a1
	slli	a4, a4, 2
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v8, (a5)
	add	a3, a3, a4
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3)
	addw	a1, a2, a1
	subw	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %for.cond.cleanup
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
