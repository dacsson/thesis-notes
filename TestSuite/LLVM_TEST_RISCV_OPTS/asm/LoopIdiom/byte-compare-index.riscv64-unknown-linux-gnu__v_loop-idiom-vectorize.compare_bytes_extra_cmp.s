# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop-idiom-vectorize.ll
# Function: compare_bytes_extra_cmp
# src = pre-opt (compare_bytes_extra_cmp), tgt = post-opt (compare_bytes_extra_cmp)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sext.w	a1, a4
	sext.w	a0, a3
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	bgeu	a0, a1, .LBB3_4
	j	.LBB3_1
.LBB3_1:                                # %ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:                                # %while.body
                                        #   in Loop: Header=BB3_2 Depth=1
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB3_2
	j	.LBB3_4
.LBB3_4:                                # %while.end
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
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
	addi	sp, sp, -192
	.cfi_def_cfa_offset 192
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	sd	a0, 160(sp)                     # 8-byte Folded Spill
	sext.w	a1, a4
	sext.w	a0, a3
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	sd	a4, 184(sp)                     # 8-byte Folded Spill
	bgeu	a0, a1, .LBB3_19
	j	.LBB3_1
.LBB3_1:                                # %ph
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %mismatch_min_it_check
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	slli	a2, a1, 32
	srli	a2, a2, 32
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sext.w	a1, a1
	slli	a2, a0, 32
	srli	a2, a2, 32
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	sext.w	a0, a0
	bltu	a0, a1, .LBB3_11
	j	.LBB3_3
.LBB3_3:                                # %mismatch_mem_check
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	ld	a4, 136(sp)                     # 8-byte Folded Reload
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	add	a0, a1, a3
	add	a3, a2, a3
	add	a1, a1, a4
	add	a2, a2, a4
	srli	a0, a0, 12
	srli	a1, a1, 12
	srli	a3, a3, 12
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	srli	a2, a2, 12
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB3_11
	j	.LBB3_4
.LBB3_4:                                # %mismatch_mem_check
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	bne	a0, a1, .LBB3_11
	j	.LBB3_5
.LBB3_5:                                # %mismatch_vec_loop_preheader
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	j	.LBB3_6
.LBB3_6:                                # %mismatch_vec_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sub	a1, a1, a2
	vsetvli	a1, a1, e8, m2, ta, ma
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	add	a3, a3, a2
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e8, m2, tu, ma
	vle8.v	v10, (a3)
	add	a0, a0, a2
                                        # implicit-def: $v12m2
	vsetvli	zero, a1, e8, m2, tu, ma
	vle8.v	v12, (a0)
	vsetvli	a0, zero, e8, m2, ta, ma
	vmsne.vv	v8, v10, v12
	vsetvli	zero, a1, e8, m2, ta, ma
	vfirst.m	a0, v8
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	bltz	a0, .LBB3_8
# %bb.7:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB3_6 Depth=1
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB3_8:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB3_6 Depth=1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	sext.w	a0, a3
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_10
	j	.LBB3_9
.LBB3_9:                                # %mismatch_vec_loop_inc
                                        #   in Loop: Header=BB3_6 Depth=1
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	slli	a3, a3, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_6
	j	.LBB3_14
.LBB3_10:                               # %mismatch_vec_loop_found
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB3_14
.LBB3_11:                               # %mismatch_loop_pre
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_12
.LBB3_12:                               # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_14
	j	.LBB3_13
.LBB3_13:                               # %mismatch_loop_inc
                                        #   in Loop: Header=BB3_12 Depth=1
	ld	a2, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sext.w	a1, a2
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_12
	j	.LBB3_14
.LBB3_14:                               # %mismatch_end
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_17
	j	.LBB3_15
.LBB3_15:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sext.w	a1, a0
	sext.w	a0, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB3_18
	j	.LBB3_16
.LBB3_16:                               # %while.body
                                        #   in Loop: Header=BB3_15 Depth=1
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB3_15
	j	.LBB3_18
.LBB3_17:                               # %byte.compare
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_18
.LBB3_18:                               # %while.end.loopexit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	j	.LBB3_19
.LBB3_19:                               # %while.end
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
