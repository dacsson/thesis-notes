# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop_loop-idiom-vectorize__simplifycfg_LOOP-DEL.ll
# Function: compare_bytes_simple_end_ne_found
# src = pre-opt (compare_bytes_simple_end_ne_found), tgt = post-opt (compare_bytes_simple_end_ne_found)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	sd	a5, 96(sp)                      # 8-byte Folded Spill
	sd	a4, 104(sp)                     # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sext.w	a1, a3
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB2_4
	j	.LBB2_2
.LBB2_2:                                # %while.body
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	slli	a4, a3, 32
	srli	a4, a4, 32
	add	a0, a0, a4
	lbu	a0, 0(a0)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	mv	a4, a3
	sd	a4, 104(sp)                     # 8-byte Folded Spill
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB2_1
	j	.LBB2_3
.LBB2_3:                                # %while.found
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_5
.LBB2_4:                                # %while.end
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_5
.LBB2_5:                                # %end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sw	a0, 0(a1)
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
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
	sd	a3, 128(sp)                     # 8-byte Folded Spill
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	sext.w	a0, a5
	mv	a1, a5
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	addiw	a1, a4, 1
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	slli	a2, a1, 32
	srli	a2, a2, 32
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	slli	a2, a5, 32
	srli	a2, a2, 32
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_8
	j	.LBB2_1
.LBB2_1:                                # %mismatch_mem_check
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	ld	a4, 184(sp)                     # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a3, 176(sp)                     # 8-byte Folded Reload
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
	bne	a0, a1, .LBB2_8
	j	.LBB2_2
.LBB2_2:                                # %mismatch_mem_check
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 176(sp)                     # 8-byte Folded Reload
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB2_8
	j	.LBB2_3
.LBB2_3:                                # %mismatch_vec_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	ld	a3, 152(sp)                     # 8-byte Folded Reload
	ld	a1, 184(sp)                     # 8-byte Folded Reload
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
	bltz	a0, .LBB2_5
# %bb.4:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB2_5:                                # %mismatch_vec_loop
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	sext.w	a0, a3
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_7
	j	.LBB2_6
.LBB2_6:                                # %mismatch_vec_loop_inc
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a1, 184(sp)                     # 8-byte Folded Reload
	ld	a2, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	slli	a3, a3, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_3
	j	.LBB2_11
.LBB2_7:                                # %mismatch_vec_loop_found
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_8:                                # %mismatch_loop_pre
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_9
.LBB2_9:                                # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_11
	j	.LBB2_10
.LBB2_10:                               # %mismatch_loop_inc
                                        #   in Loop: Header=BB2_9 Depth=1
	ld	a2, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sext.w	a1, a2
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_9
	j	.LBB2_11
.LBB2_11:                               # %byte.compare
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a3
	sext.w	a0, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB2_13
# %bb.12:                               # %byte.compare
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB2_13:                               # %byte.compare
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sw	a0, 0(a1)
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
