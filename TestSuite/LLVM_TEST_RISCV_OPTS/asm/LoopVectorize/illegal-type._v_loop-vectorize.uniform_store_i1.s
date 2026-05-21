# Source: LoopVectorize/illegal-type._v_loop-vectorize.ll
# Function: uniform_store_i1
# src = pre-opt (uniform_store_i1), tgt = post-opt (uniform_store_i1)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	addi	a2, a0, 1
	addi	a3, a3, 8
	xor	a4, a3, a4
	seqz	a4, a4
	sb	a4, 0(a5)
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %end
	addi	sp, sp, 48
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
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xf0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 112 + 8 * vlenb
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	mv	a3, a1
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	addi	a0, a2, 1
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a1, 32
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_4
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	andi	a1, a1, -32
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 3
	add	a1, a0, a1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m8
	vsetivli	zero, 16, e64, m8, tu, ma
	vmv.v.x	v8, a0
	vmv8r.v	v16, v8
	addi	a1, sp, 112
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	li	a1, 0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	addi	a3, sp, 112
	vl8r.v	v24, (a3)                       # vscale x 64-byte Folded Reload
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vid.v	v8
                                        # implicit-def: $v16m8
	vsll.vi	v16, v8, 3
	li	a3, 136
                                        # implicit-def: $v8m8
	vadd.vx	v8, v16, a3
                                        # implicit-def: $v16m8
	vadd.vx	v16, v8, a2
	vmseq.vv	v8, v16, v24
	vsetvli	zero, zero, e16, m2, ta, ma
	vmv.x.s	a3, v8
	srli	a3, a3, 63
	sb	a3, 0(a4)
	addi	a0, a0, 32
	addi	a2, a2, 256
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB3_6
	j	.LBB3_4
.LBB3_4:                                # %scalar.ph
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_5
.LBB3_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	addi	a2, a0, 1
	addi	a3, a3, 8
	xor	a4, a3, a4
	seqz	a4, a4
	sb	a4, 0(a5)
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_5
	j	.LBB3_6
.LBB3_6:                                # %end
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 112
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
