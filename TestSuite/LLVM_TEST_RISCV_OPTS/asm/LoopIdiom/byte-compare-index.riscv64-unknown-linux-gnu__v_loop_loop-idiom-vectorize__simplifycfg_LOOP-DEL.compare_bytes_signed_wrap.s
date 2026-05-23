# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop_loop-idiom-vectorize__simplifycfg_LOOP-DEL.ll
# Function: compare_bytes_signed_wrap
# src = pre-opt (compare_bytes_signed_wrap), tgt = post-opt (compare_bytes_signed_wrap)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
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
	beq	a0, a1, .LBB1_1
	j	.LBB1_3
.LBB1_3:                                # %while.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
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
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	sext.w	a0, a3
	mv	a1, a3
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	addiw	a1, a2, 1
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	slli	a2, a1, 32
	srli	a2, a2, 32
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	slli	a2, a3, 32
	srli	a2, a2, 32
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_8
	j	.LBB1_1
.LBB1_1:                                # %mismatch_mem_check
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a4, 136(sp)                     # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	add	a0, a1, a3
	add	a3, a2, a3
	add	a1, a1, a4
	add	a2, a2, a4
	srli	a0, a0, 12
	srli	a1, a1, 12
	srli	a3, a3, 12
	sd	a3, 80(sp)                      # 8-byte Folded Spill
	srli	a2, a2, 12
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_8
	j	.LBB1_2
.LBB1_2:                                # %mismatch_mem_check
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_8
	j	.LBB1_3
.LBB1_3:                                # %mismatch_vec_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sub	a1, a1, a2
	vsetvli	a1, a1, e8, m2, ta, ma
	sd	a1, 48(sp)                      # 8-byte Folded Spill
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
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	bltz	a0, .LBB1_5
# %bb.4:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB1_3 Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
.LBB1_5:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB1_3 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	sext.w	a0, a3
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_7
	j	.LBB1_6
.LBB1_6:                                # %mismatch_vec_loop_inc
                                        #   in Loop: Header=BB1_3 Depth=1
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	slli	a3, a3, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_3
	j	.LBB1_11
.LBB1_7:                                # %mismatch_vec_loop_found
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a0, a0, a1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_8:                                # %mismatch_loop_pre
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_9
.LBB1_9:                                # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_11
	j	.LBB1_10
.LBB1_10:                               # %mismatch_loop_inc
                                        #   in Loop: Header=BB1_9 Depth=1
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a0, a0, 1
	sext.w	a1, a2
	mv	a3, a0
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_9
	j	.LBB1_11
.LBB1_11:                               # %while.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
