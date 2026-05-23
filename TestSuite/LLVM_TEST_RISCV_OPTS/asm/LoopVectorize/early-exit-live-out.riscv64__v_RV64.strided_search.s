# Source: LoopVectorize/early-exit-live-out.riscv64__v_RV64.ll
# Function: strided_search
# src = pre-opt (strided_search), tgt = post-opt (strided_search)
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
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	ld	a0, 88(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %latch
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 112
	li	a2, -1
	lui	a1, 4
	addi	a1, a1, -1600
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_3
.LBB1_3:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x07, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 7 * vlenb
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 3
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
# %bb.1:                                # %entry
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 136(sp)                     # 8-byte Folded Spill
.LBB1_2:                                # %entry
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 132
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_10
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
	csrr	a1, vlenb
	srli	a2, a1, 2
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a2, a0, a2
	andi	a2, a2, 132
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 4
	slli	a2, a2, 7
	sub	a2, a2, a3
	sd	a2, 96(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vid.v	v10
	li	a2, 112
                                        # implicit-def: $v8m2
	vmul.vx	v8, v10, a2
	slli	a2, a1, 2
	slli	a1, a1, 5
	sub	a1, a1, a2
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v10, a1
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 144
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 144
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a5, a4, 1
	add	a4, a5, a4
	add	a4, sp, a4
	addi	a4, a4, 144
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	csrr	a4, vlenb
	slli	a5, a4, 2
	add	a4, a5, a4
	add	a4, sp, a4
	addi	a4, a4, 144
	vl2r.v	v10, (a4)                       # vscale x 16-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	addi	a3, a3, 88
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vluxei64.v	v14, (a3), v10
	vsetvli	zero, zero, e64, m2, ta, ma
	vmseq.vi	v8, v14, 0
	addi	a3, sp, 144
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	vcpop.m	a0, v8
	xor	a1, a1, a2
	seqz	a1, a1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 144
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	bnez	a0, .LBB1_7
	j	.LBB1_5
.LBB1_5:                                # %vector.body.interim
                                        #   in Loop: Header=BB1_4 Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 144
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 144
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	beqz	a0, .LBB1_4
	j	.LBB1_6
.LBB1_6:                                # %middle.block
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	li	a2, -1
	li	a1, 132
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB1_13
	j	.LBB1_10
.LBB1_7:                                # %vector.early.exit
	addi	a0, sp, 144
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 2
	vfirst.m	a0, v8
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bltz	a0, .LBB1_9
# %bb.8:                                # %vector.early.exit
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB1_9:                                # %vector.early.exit
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	add	a0, a0, a1
	slli	a1, a0, 4
	slli	a0, a0, 7
	sub	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_13
.LBB1_10:                               # %scalar.ph
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_11:                               # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	add	a0, a0, a1
	ld	a0, 88(a0)
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB1_13
	j	.LBB1_12
.LBB1_12:                               # %latch
                                        #   in Loop: Header=BB1_11 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 112
	li	a2, -1
	lui	a1, 4
	addi	a1, a1, -1600
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_11
	j	.LBB1_13
.LBB1_13:                               # %exit
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	add	sp, sp, a1
	.cfi_def_cfa sp, 144
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
