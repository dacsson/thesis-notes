# Source: LoopVectorize/tail-folding-div.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_sdiv_both_invariant_nonconst
# src = pre-opt (test_sdiv_both_invariant_nonconst), tgt = post-opt (test_sdiv_both_invariant_nonconst)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	slli	a3, a3, 3
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	add	a2, a2, a3
	ld	a2, 0(a2)
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	call	__divdi3
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	add	a1, a1, a4
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
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
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a4, vlenb
	slli	a4, a4, 1
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 2 * vlenb
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_2
# %bb.1:                                # %loop.preheader
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB2_2:                                # %loop.preheader
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_6
	j	.LBB2_3
.LBB2_3:                                # %vector.ph
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	csrr	a2, vlenb
	srli	a3, a2, 2
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	subw	a2, a2, a3
	andi	a2, a2, 1024
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	call	__divdi3
	mv	a1, a0
	ld	a0, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 144
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB2_4
.LBB2_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	ld	a5, 112(sp)                     # 8-byte Folded Reload
	addi	a4, sp, 144
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 3
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vle64.v	v10, (a5)
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	add	a3, a3, a4
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_4
	j	.LBB2_5
.LBB2_5:                                # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB2_8
	j	.LBB2_6
.LBB2_6:                                # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_7
.LBB2_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	slli	a3, a3, 3
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	add	a2, a2, a3
	ld	a2, 0(a2)
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	call	__divdi3
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	add	a1, a1, a4
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_7
	j	.LBB2_8
.LBB2_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
