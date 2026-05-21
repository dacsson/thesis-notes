# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop-idiom-vectorize_MASKED.ll
# Function: compare_bytes_cleanup_block
# src = pre-opt (compare_bytes_cleanup_block), tgt = post-opt (compare_bytes_cleanup_block)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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
	.cfi_remember_state
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB4_3
	j	.LBB4_2
.LBB4_2:                                # %while.body
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_1
	j	.LBB4_4
.LBB4_3:                                # %cleanup.thread
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB4_4:                                # %if.end
	.cfi_restore_state
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 3 * vlenb
	.cfi_remember_state
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %mismatch_min_it_check
	li	a0, 1
	bnez	a0, .LBB4_8
	j	.LBB4_2
.LBB4_2:                                # %mismatch_mem_check
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	addi	a0, a1, 1
	addi	a3, a2, 1
	srli	a0, a0, 12
	srli	a1, a1, 12
	srli	a3, a3, 12
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	srli	a2, a2, 12
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB4_8
	j	.LBB4_3
.LBB4_3:                                # %mismatch_mem_check
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	bne	a0, a1, .LBB4_8
	j	.LBB4_4
.LBB4_4:                                # %mismatch_vec_loop_preheader
	vsetvli	a0, zero, e8, m2, ta, ma
	vmclr.m	v8
	csrr	a0, vlenb
	slli	a0, a0, 1
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	li	a0, 1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 128
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %mismatch_vec_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a2, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 128
	vl1r.v	v8, (a3)                        # vscale x 8-byte Folded Reload
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	add	a2, a2, a1
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e8, m2, tu, ma
	vmv.v.i	v12, 0
	vmv1r.v	v0, v8
	vmv2r.v	v10, v12
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v10, (a2), v0.t
	add	a0, a0, a1
	vmv1r.v	v0, v8
	vle8.v	v12, (a0), v0.t
	vmsne.vv	v9, v10, v12
	vmand.mm	v9, v8, v9
	vcpop.m	a0, v9
	addi	a2, sp, 128
	vs1r.v	v9, (a2)                        # vscale x 8-byte Folded Spill
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 128
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_7
	j	.LBB4_6
.LBB4_6:                                # %mismatch_vec_loop_inc
                                        #   in Loop: Header=BB4_5 Depth=1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	add	a2, a0, a1
	vmclr.m	v8
	li	a0, 0
	mv	a1, a0
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 128
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_5
	j	.LBB4_11
.LBB4_7:                                # %mismatch_vec_loop_found
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 128
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 128
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	vmand.mm	v8, v8, v9
	vfirst.m	a1, v8
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a0, a0, a1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB4_11
.LBB4_8:                                # %mismatch_loop_pre
	li	a0, 1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_9:                                # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_11
	j	.LBB4_10
.LBB4_10:                               # %mismatch_loop_inc
                                        #   in Loop: Header=BB4_9 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	li	a1, 0
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_9
	j	.LBB4_11
.LBB4_11:                               # %mismatch_end
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a1, 0
	li	a0, 1
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_14
	j	.LBB4_12
.LBB4_12:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	beqz	a0, .LBB4_15
	j	.LBB4_13
.LBB4_13:                               # %while.body
                                        #   in Loop: Header=BB4_12 Depth=1
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_12
	j	.LBB4_16
.LBB4_14:                               # %byte.compare
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	bnez	a0, .LBB4_16
	j	.LBB4_15
.LBB4_15:                               # %cleanup.thread
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.LBB4_16:                               # %if.end
	.cfi_restore_state
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
