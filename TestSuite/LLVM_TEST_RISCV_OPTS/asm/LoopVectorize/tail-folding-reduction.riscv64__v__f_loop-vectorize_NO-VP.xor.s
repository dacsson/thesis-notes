# Source: LoopVectorize/tail-folding-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: xor
# src = pre-opt (xor), tgt = post-opt (xor)
# Triple: riscv64, Attrs: +v,+f
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
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	xor	a2, a2, a3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
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
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 4 * vlenb
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB4_4
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sub	a1, a1, a2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	vmv1r.v	v10, v8
	vmv.s.x	v10, a0
	vmv1r.v	v8, v10
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 128
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vle32.v	v10, (a3)
                                        # implicit-def: $v8m2
	vxor.vv	v8, v10, v12
	addi	a3, sp, 128
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 128
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	li	a2, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredxor.vs	v8, v10, v9
	vmv.x.s	a2, v8
	mv	a3, a1
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_6
	j	.LBB4_4
.LBB4_4:                                # %scalar.ph
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	xor	a2, a2, a3
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_5
	j	.LBB4_6
.LBB4_6:                                # %for.end
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 144
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
