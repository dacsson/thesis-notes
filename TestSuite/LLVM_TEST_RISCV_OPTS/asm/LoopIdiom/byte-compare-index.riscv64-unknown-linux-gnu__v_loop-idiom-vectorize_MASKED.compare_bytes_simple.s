# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop-idiom-vectorize_MASKED.ll
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
	csrr	a4, vlenb
	slli	a5, a4, 1
	add	a4, a5, a4
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x01, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 176 + 3 * vlenb
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
	bltu	a0, a1, .LBB0_8
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
	bne	a0, a1, .LBB0_8
	j	.LBB0_3
.LBB0_3:                                # %mismatch_mem_check
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	bne	a0, a1, .LBB0_8
	j	.LBB0_4
.LBB0_4:                                # %mismatch_vec_loop_preheader
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 128(sp)                     # 8-byte Folded Reload
                                        # implicit-def: $v16m8
	vsetvli	a1, zero, e64, m8, ta, ma
	vid.v	v16
                                        # implicit-def: $v24m8
	vsaddu.vx	v24, v16, a0
	vmsltu.vx	v8, v24, a2
	csrr	a1, vlenb
                                        # implicit-def: $v24m8
	vadd.vx	v24, v16, a1
                                        # implicit-def: $v16m8
	vsaddu.vx	v16, v24, a0
	vmsltu.vx	v9, v16, a2
	srli	a3, a1, 2
	srli	a2, a1, 3
	vsetvli	zero, a3, e8, mf4, ta, ma
	vslideup.vx	v8, v9, a2
	slli	a1, a1, 1
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 176
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %mismatch_vec_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 176
	vl1r.v	v8, (a3)                        # vscale x 8-byte Folded Reload
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	add	a2, a2, a1
                                        # implicit-def: $v12m2
	vsetvli	a3, zero, e8, m2, tu, ma
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
	addi	a2, sp, 176
	vs1r.v	v9, (a2)                        # vscale x 8-byte Folded Spill
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 176
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_7
	j	.LBB0_6
.LBB0_6:                                # %mismatch_vec_loop_inc
                                        #   in Loop: Header=BB0_5 Depth=1
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	add	a2, a0, a2
	csrr	a0, vlenb
                                        # implicit-def: $v24m8
	vsetvli	a4, zero, e64, m8, ta, ma
	vid.v	v24
                                        # implicit-def: $v8m8
	vadd.vx	v8, v24, a0
                                        # implicit-def: $v16m8
	vsaddu.vx	v16, v8, a2
	vmsltu.vx	v9, v16, a3
                                        # implicit-def: $v16m8
	vsaddu.vx	v16, v24, a2
	vmsltu.vx	v8, v16, a3
	srli	a3, a0, 2
	srli	a0, a0, 3
	vsetvli	zero, a3, e8, mf4, ta, ma
	vslideup.vx	v8, v9, a0
	vsetvli	a0, zero, e8, m2, ta, ma
	vfirst.m	a0, v8
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 176
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_5
	j	.LBB0_11
.LBB0_7:                                # %mismatch_vec_loop_found
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 176
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 176
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	vmand.mm	v8, v8, v9
	vfirst.m	a1, v8
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a0, a0, a1
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_8:                                # %mismatch_loop_pre
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_11
	j	.LBB0_10
.LBB0_10:                               # %mismatch_loop_inc
                                        #   in Loop: Header=BB0_9 Depth=1
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sext.w	a1, a2
	mv	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_9
	j	.LBB0_11
.LBB0_11:                               # %mismatch_end
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_14
	j	.LBB0_12
.LBB0_12:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sext.w	a1, a0
	sext.w	a0, a2
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_15
	j	.LBB0_13
.LBB0_13:                               # %while.body
                                        #   in Loop: Header=BB0_12 Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_12
	j	.LBB0_15
.LBB0_14:                               # %byte.compare
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_15
.LBB0_15:                               # %while.end
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	sp, sp, a1
	.cfi_def_cfa sp, 176
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
