# Source: LoopVectorize/riscv-vector-reverse.riscv64__v_loop-vectorize_RV64-UF2.ll
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	s0, 72(sp)                      # 8-byte Folded Spill
	sd	s1, 64(sp)                      # 8-byte Folded Spill
	sd	s2, 56(sp)                      # 8-byte Folded Spill
	sd	s3, 48(sp)                      # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	.cfi_offset s2, -24
	.cfi_offset s3, -32
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a1, 1022
	sub	s2, a1, a0
	li	a1, 1021
	sub	s0, a1, a0
	li	a1, 1020
	sub	t5, a1, a0
	li	a1, 1019
	sub	t3, a1, a0
	li	a1, 1018
	sub	t1, a1, a0
	li	a1, 1017
	sub	a7, a1, a0
	li	a1, 1016
	sub	a5, a1, a0
	li	a4, 1015
	sub	s3, a4, a0
	add	s1, a2, s2
	add	t6, a2, s0
	add	t4, a2, t5
	add	t2, a2, t3
	add	t0, a2, t1
	add	a6, a2, a7
	add	a4, a2, a5
	add	a2, a2, s3
	lbu	s1, 0(s1)
	lbu	t6, 0(t6)
	lbu	t4, 0(t4)
	lbu	t2, 0(t2)
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.x	v8, s1
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, t6
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, t4
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, t2
	lbu	t0, 0(t0)
	lbu	a6, 0(a6)
	lbu	a4, 0(a4)
	lbu	a2, 0(a2)
                                        # implicit-def: $v10
	vmv.v.x	v10, t0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v10, a6
                                        # implicit-def: $v10
	vslide1down.vx	v10, v8, a4
                                        # implicit-def: $v8
	vslide1down.vx	v8, v10, a2
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, ta, ma
	vadd.vi	v10, v9, 1
	vmv.x.s	s1, v10
                                        # implicit-def: $v9
	vsetivli	zero, 1, e8, mf4, ta, ma
	vslidedown.vi	v9, v10, 1
	vmv.x.s	t6, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v10, 2
	vmv.x.s	t4, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v10, 3
	vmv.x.s	t2, v9
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, ta, ma
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
	add	s2, a3, s2
	add	s0, a3, s0
	add	t5, a3, t5
	add	t3, a3, t3
	add	t1, a3, t1
	add	a7, a3, a7
	add	a5, a3, a5
	add	a3, a3, s3
	andi	s1, s1, 127
	sb	s1, 0(s2)
	andi	t6, t6, 127
	sb	t6, 0(s0)
	andi	t4, t4, 127
	sb	t4, 0(t5)
	andi	t2, t2, 127
	sb	t2, 0(t3)
	andi	t0, t0, 127
	sb	t0, 0(t1)
	andi	a6, a6, 127
	sb	a6, 0(a7)
	andi	a4, a4, 127
	sb	a4, 0(a5)
	andi	a2, a2, 127
	sb	a2, 0(a3)
	addi	a0, a0, 8
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %scalar.ph
	li	a0, 7
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	addi	a2, a1, -1
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a2
	andi	a0, a0, 127
	sb	a0, 0(a3)
	li	a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_5
	j	.LBB4_6
.LBB4_6:                                # %exit
	ld	s0, 72(sp)                      # 8-byte Folded Reload
	ld	s1, 64(sp)                      # 8-byte Folded Reload
	ld	s2, 56(sp)                      # 8-byte Folded Reload
	ld	s3, 48(sp)                      # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
