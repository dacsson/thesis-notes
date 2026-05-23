# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize_FIXED.ll
# Function: predicated_sdiv_by_minus_one
# src = pre-opt (predicated_sdiv_by_minus_one), tgt = post-opt (predicated_sdiv_by_minus_one)
# Triple: riscv64-linux-gnu, Attrs: +v,+f,+m
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
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lbu	a0, 0(a0)
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a1, 128
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB8_3
	j	.LBB8_2
.LBB8_2:                                # %do_op
                                        #   in Loop: Header=BB8_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	li	a0, 0
	sub	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_3
.LBB8_3:                                # %latch
                                        #   in Loop: Header=BB8_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sb	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_4
.LBB8_4:                                # %for.end
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 1 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB8_2
.LBB8_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	add	a1, a1, a0
	li	a2, 32
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e8, m2, tu, ma
	vle8.v	v8, (a1)
	vsetvli	zero, a2, e8, m2, tu, ma
	vmv2r.v	v10, v8
	li	a3, -128
	vsetvli	zero, a2, e8, m2, ta, ma
	vmsne.vx	v0, v8, a3
	addi	a3, sp, 32
	vs1r.v	v0, (a3)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e8, m2, tu, ma
	vmv.v.i	v12, -1
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e8, m2, ta, mu
	vdiv.vv	v8, v10, v12, v0.t
	addi	a3, sp, 32
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
	vsetvli	zero, a2, e8, m2, ta, ma
	vse8.v	v8, (a1), v0.t
	addi	a0, a0, 32
	li	a1, 1024
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_2
	j	.LBB8_3
.LBB8_3:                                # %middle.block
	j	.LBB8_4
.LBB8_4:                                # %for.end
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
