# Source: LoopVectorize/low-trip-count.riscv64__v_loop-vectorize.ll
# Function: trip16_i8
# src = pre-opt (trip16_i8), tgt = post-opt (trip16_i8)
# Triple: riscv64, Attrs: +v
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
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a0
	lbu	a1, 0(a1)
	slliw	a1, a1, 1
	add	a2, a2, a0
	lbu	a3, 0(a2)
	addw	a1, a1, a3
	sb	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 16
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
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
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	j	.LBB4_2
.LBB4_2:                                # %vector.body
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetivli	zero, 16, e8, m1, tu, ma
	vle8.v	v8, (a1)
                                        # implicit-def: $v9
	vsetvli	a1, zero, e8, m1, ta, ma
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v10
	vsetivli	zero, 16, e8, m1, tu, ma
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vsetvli	a1, zero, e8, m1, ta, ma
	vadd.vv	v8, v9, v10
	vsetivli	zero, 16, e8, m1, ta, ma
	vse8.v	v8, (a0)
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %for.end
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
