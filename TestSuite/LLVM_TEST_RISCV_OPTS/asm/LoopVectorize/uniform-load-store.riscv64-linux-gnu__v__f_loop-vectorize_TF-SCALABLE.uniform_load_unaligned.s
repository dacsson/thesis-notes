# Source: LoopVectorize/uniform-load-store.riscv64-linux-gnu__v__f_loop-vectorize_TF-SCALABLE.ll
# Function: uniform_load_unaligned
# src = pre-opt (uniform_load_unaligned), tgt = post-opt (uniform_load_unaligned)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	lbu	a4, 0(a1)
	lbu	a3, 1(a1)
	slli	a3, a3, 8
	or	a4, a3, a4
	lbu	a3, 2(a1)
	slli	a5, a3, 16
	lbu	a3, 3(a1)
	slli	a3, a3, 24
	or	a3, a3, a5
	or	a3, a3, a4
	lbu	a5, 4(a1)
	lbu	a4, 5(a1)
	slliw	a4, a4, 8
	or	a4, a4, a5
	lbu	a5, 6(a1)
	slliw	a5, a5, 16
	lbu	a1, 7(a1)
	slliw	a1, a1, 24
	or	a1, a1, a5
	or	a1, a1, a4
	slli	a1, a1, 32
	or	a1, a1, a3
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1025
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %for.end
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
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	li	a0, 1025
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	lbu	a6, 0(a4)
	lbu	a5, 1(a4)
	slli	a5, a5, 8
	or	a6, a5, a6
	lbu	a5, 2(a4)
	slli	a7, a5, 16
	lbu	a5, 3(a4)
	slli	a5, a5, 24
	or	a5, a5, a7
	or	a5, a5, a6
	lbu	a7, 4(a4)
	lbu	a6, 5(a4)
	slliw	a6, a6, 8
	or	a6, a6, a7
	lbu	a7, 6(a4)
	slliw	a7, a7, 16
	lbu	a4, 7(a4)
	slliw	a4, a4, 24
	or	a4, a4, a7
	or	a4, a4, a6
	slli	a4, a4, 32
	or	a4, a4, a5
                                        # implicit-def: $v8m2
	vsetvli	a5, zero, e64, m2, tu, ma
	vmv.v.x	v8, a4
	slli	a4, a1, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	j	.LBB3_4
.LBB3_4:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
