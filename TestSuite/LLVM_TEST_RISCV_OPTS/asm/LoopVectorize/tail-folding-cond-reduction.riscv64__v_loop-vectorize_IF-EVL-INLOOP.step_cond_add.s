# Source: LoopVectorize/tail-folding-cond-reduction.riscv64__v_loop-vectorize_IF-EVL-INLOOP.ll
# Function: step_cond_add
# src = pre-opt (step_cond_add), tgt = post-opt (step_cond_add)
# Triple: riscv64, Attrs: +v
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
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a4, 0(a2)
	sext.w	a2, a0
	slt	a5, a2, a4
	li	a2, 0
	subw	a2, a2, a5
	and	a2, a2, a4
	addw	a2, a2, a3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a3, vlenb
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 2 * vlenb
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	li	a2, 0
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vid.v	v8
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	addi	a1, sp, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	addi	a3, sp, 80
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	vsetvli	a3, a0, e8, mf2, ta, ma
	slli	a5, a2, 2
	add	a1, a1, a5
                                        # implicit-def: $v14m2
	vsetvli	zero, a3, e32, m2, tu, ma
	vle32.v	v14, (a1)
	vsetvli	a1, zero, e32, m2, ta, ma
	vmslt.vv	v0, v10, v14
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v12m2
	vmerge.vvm	v12, v8, v14, v0
	li	a1, 0
                                        # implicit-def: $v8
	vmv.s.x	v8, a1
	vsetvli	zero, a3, e32, m2, ta, ma
	vredsum.vs	v8, v12, v8
	vsetvli	a1, zero, e32, m2, ta, ma
	vmv.x.s	a1, v8
	addw	a1, a1, a4
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a2, a3, a2
	sub	a0, a0, a3
                                        # implicit-def: $v8m2
	vadd.vx	v8, v10, a3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	addi	a1, sp, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %for.end
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
