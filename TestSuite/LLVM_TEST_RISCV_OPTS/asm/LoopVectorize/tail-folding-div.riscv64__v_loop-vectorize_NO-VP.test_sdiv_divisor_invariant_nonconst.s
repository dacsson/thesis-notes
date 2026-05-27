# Source: LoopVectorize/tail-folding-div.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_sdiv_divisor_invariant_nonconst
# src = pre-opt (test_sdiv_divisor_invariant_nonconst), tgt = post-opt (test_sdiv_divisor_invariant_nonconst)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a2
	ld	a0, 0(a0)
	call	__divdi3
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
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
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 2 * vlenb
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
# %bb.1:                                # %loop.preheader
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
.LBB1_2:                                # %loop.preheader
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_6
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a2, a0, 2
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a2, a0, a2
	andi	a2, a2, 1024
	sd	a2, 56(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 128
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 96(sp)                      # 8-byte Folded Reload
	addi	a4, sp, 128
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 3
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vle64.v	v10, (a5)
                                        # implicit-def: $v8m2
	vdiv.vv	v8, v10, v12
	add	a3, a3, a4
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_4
	j	.LBB1_5
.LBB1_5:                                # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB1_8
	j	.LBB1_6
.LBB1_6:                                # %scalar.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_7
.LBB1_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 3
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	ld	a0, 0(a0)
	call	__divdi3
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_7
	j	.LBB1_8
.LBB1_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 144
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
