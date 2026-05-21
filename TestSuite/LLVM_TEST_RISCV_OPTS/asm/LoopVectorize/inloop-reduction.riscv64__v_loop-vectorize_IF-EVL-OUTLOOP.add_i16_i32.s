# Source: LoopVectorize/inloop-reduction.riscv64__v_loop-vectorize_IF-EVL-OUTLOOP.ll
# Function: add_i16_i32
# src = pre-opt (add_i16_i32), tgt = post-opt (add_i16_i32)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	sext.w	a4, a0
	slli	a4, a4, 1
	add	a3, a3, a4
	lh	a3, 0(a3)
	addw	a2, a2, a3
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.cond.cleanup
	ld	a0, 40(sp)                      # 8-byte Folded Reload
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 4 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_6
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	j	.LBB0_2
.LBB0_2:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 80
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	slli	a2, a0, 32
	srli	a2, a2, 32
	vsetvli	a2, a2, e8, mf2, ta, ma
	sext.w	a4, a1
	slli	a4, a4, 1
	add	a3, a3, a4
                                        # implicit-def: $v12
	vsetvli	zero, a2, e16, m1, tu, ma
	vle16.v	v12, (a3)
	vsetvli	a3, zero, e16, m1, ta, ma
	vmv2r.v	v10, v8
	vwadd.wv	v10, v10, v12
	vsetvli	zero, a2, e32, m2, tu, ma
	vmv.v.v	v8, v10
	addi	a3, sp, 80
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	addw	a1, a2, a1
	subw	a0, a0, a2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	addi	a0, sp, 80
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %for.cond.cleanup.loopexit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %for.cond.cleanup
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
