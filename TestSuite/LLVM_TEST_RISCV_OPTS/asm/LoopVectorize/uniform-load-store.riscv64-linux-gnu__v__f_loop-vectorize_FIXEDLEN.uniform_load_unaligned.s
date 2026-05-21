# Source: LoopVectorize/uniform-load-store.riscv64-linux-gnu__v__f_loop-vectorize_FIXEDLEN.ll
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
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	lbu	a4, 0(a2)
	lbu	a3, 1(a2)
	slli	a3, a3, 8
	or	a4, a3, a4
	lbu	a3, 2(a2)
	slli	a5, a3, 16
	lbu	a3, 3(a2)
	slli	a3, a3, 24
	or	a3, a3, a5
	or	a3, a3, a4
	lbu	a5, 4(a2)
	lbu	a4, 5(a2)
	slliw	a4, a4, 8
	or	a4, a4, a5
	lbu	a5, 6(a2)
	slliw	a5, a5, 16
	lbu	a2, 7(a2)
	slliw	a2, a2, 24
	or	a2, a2, a5
	or	a2, a2, a4
	slli	a2, a2, 32
	or	a2, a2, a3
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.x	v8, a2
	slli	a2, a0, 3
	add	a2, a1, a2
	addi	a1, a2, 32
	vse64.v	v8, (a2)
	vse64.v	v8, (a1)
	addi	a0, a0, 8
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	j	.LBB3_4
.LBB3_4:                                # %scalar.ph
	li	a0, 1024
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB3_5
.LBB3_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
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
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB3_5
	j	.LBB3_6
.LBB3_6:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
