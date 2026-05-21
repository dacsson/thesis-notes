# Source: LoopVectorize/tail-folding-cond-reduction.riscv64__v_loop-vectorize_IF-EVL-OUTLOOP.ll
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a3, vlenb
	slli	a3, a3, 1
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 6 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e32, m2, tu, ma
	vmv.v.i	v10, 0
	vmv1r.v	v8, v10
	vmv.s.x	v8, a1
	vmv1r.v	v10, v8
	li	a1, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vid.v	v8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v8, (a3)
	vsetvli	a3, zero, e32, m2, ta, ma
	vmslt.vv	v0, v12, v8
                                        # implicit-def: $v14m2
	vadd.vv	v14, v10, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v8, v10, v14, v0
	vsetvli	zero, a2, e32, m2, tu, ma
	vmv.v.v	v10, v8
	addi	a3, sp, 64
	vs2r.v	v10, (a3)                       # vscale x 16-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vx	v8, v12, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	addi	a0, sp, 64
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_4
.LBB2_4:                                # %for.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	sp, sp, a1
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
