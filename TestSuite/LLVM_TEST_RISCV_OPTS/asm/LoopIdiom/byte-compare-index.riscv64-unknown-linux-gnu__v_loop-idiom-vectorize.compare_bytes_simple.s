# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop-idiom-vectorize.ll
# Function: compare_bytes_simple
# src = pre-opt (compare_bytes_simple), tgt = post-opt (compare_bytes_simple)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %while.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
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
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	sd	a3, 152(sp)                     # 8-byte Folded Spill
	mv	a0, a2
	sd	a0, 160(sp)                     # 8-byte Folded Spill
	addiw	a0, a2, 1
	sd	a0, 168(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %mismatch_min_it_check
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	slli	a2, a1, 32
	srli	a2, a2, 32
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	sext.w	a1, a1
	slli	a2, a0, 32
	srli	a2, a2, 32
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sext.w	a0, a0
	bltu	a0, a1, .LBB0_10
	j	.LBB0_2
.LBB0_2:                                # %mismatch_mem_check
	ld	a2, 136(sp)                     # 8-byte Folded Reload
	ld	a4, 128(sp)                     # 8-byte Folded Reload
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	ld	a3, 120(sp)                     # 8-byte Folded Reload
	add	a0, a1, a3
	add	a3, a2, a3
	add	a1, a1, a4
	add	a2, a2, a4
	srli	a0, a0, 12
	srli	a1, a1, 12
	srli	a3, a3, 12
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	srli	a2, a2, 12
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB0_10
	j	.LBB0_3
.LBB0_3:                                # %mismatch_mem_check
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	bne	a0, a1, .LBB0_10
	j	.LBB0_4
.LBB0_4:                                # %mismatch_vec_loop_preheader
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %mismatch_vec_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a3, 144(sp)                     # 8-byte Folded Reload
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sub	a1, a1, a2
	vsetvli	a1, a1, e8, m2, ta, ma
	sd	a1, 72(sp)                      # 8-byte Folded Spill
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
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	bltz	a0, .LBB0_7
# %bb.6:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB0_5 Depth=1
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB0_7:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB0_5 Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	sext.w	a0, a3
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_9
	j	.LBB0_8
.LBB0_8:                                # %mismatch_vec_loop_inc
                                        #   in Loop: Header=BB0_5 Depth=1
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a3, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_5
	j	.LBB0_13
.LBB0_9:                                # %mismatch_vec_loop_found
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_13
.LBB0_10:                               # %mismatch_loop_pre
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_11:                               # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_13
	j	.LBB0_12
.LBB0_12:                               # %mismatch_loop_inc
                                        #   in Loop: Header=BB0_11 Depth=1
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sext.w	a1, a2
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_11
	j	.LBB0_13
.LBB0_13:                               # %mismatch_end
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_16
	j	.LBB0_14
.LBB0_14:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sext.w	a1, a0
	sext.w	a0, a2
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB0_17
	j	.LBB0_15
.LBB0_15:                               # %while.body
                                        #   in Loop: Header=BB0_14 Depth=1
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB0_14
	j	.LBB0_17
.LBB0_16:                               # %byte.compare
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_17
.LBB0_17:                               # %while.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
