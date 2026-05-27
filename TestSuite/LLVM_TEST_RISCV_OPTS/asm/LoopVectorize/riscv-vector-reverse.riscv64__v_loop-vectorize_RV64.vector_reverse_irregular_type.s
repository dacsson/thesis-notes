# Source: LoopVectorize/riscv-vector-reverse.riscv64__v_loop-vectorize_RV64.ll
# Function: vector_reverse_irregular_type
# src = pre-opt (vector_reverse_irregular_type), tgt = post-opt (vector_reverse_irregular_type)
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
	li	a0, 1023
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a2, a1, -1
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a2
	andi	a0, a0, 127
	sb	a0, 0(a3)
	li	a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	li	a1, 1022
	sub	t1, a1, a0
	li	a1, 1021
	sub	a7, a1, a0
	li	a1, 1020
	sub	a5, a1, a0
	li	a4, 1019
	sub	t2, a4, a0
	add	t0, a2, t1
	add	a6, a2, a7
	add	a4, a2, a5
	add	a2, a2, t2
	lbu	t0, 0(t0)
	lbu	a6, 0(a6)
	lbu	a4, 0(a4)
	lbu	a2, 0(a2)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.x	v9, t0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a6
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a4
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vadd.vi	v9, v8, 1
	vmv.x.s	t0, v9
                                        # implicit-def: $v8
	vsetivli	zero, 1, e8, mf4, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a6, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a4, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a2, v8
	add	t1, a3, t1
	add	a7, a3, a7
	add	a5, a3, a5
	add	a3, a3, t2
	andi	t0, t0, 127
	sb	t0, 0(t1)
	andi	a6, a6, 127
	sb	a6, 0(a7)
	andi	a4, a4, 127
	sb	a4, 0(a5)
	andi	a2, a2, 127
	sb	a2, 0(a3)
	addi	a0, a0, 4
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %scalar.ph
	li	a0, 3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a2, a1, -1
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a2
	andi	a0, a0, 127
	sb	a0, 0(a3)
	li	a0, 1
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_5
	j	.LBB4_6
.LBB4_6:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
