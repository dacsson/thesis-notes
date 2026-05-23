# Source: LoopVectorize/ordered-reduction.loop-vectorize_CHECK-UNORDERED.ll
# Function: fadd
# src = pre-opt (fadd), tgt = post-opt (fadd)
# Triple: riscv64, Attrs: v
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
	fmv.w.x	fa5, zero
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.end
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
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
	slli	a2, a2, 1
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 2 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa5, zero
	li	a2, 0
	li	a0, 4
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	fsw	fa5, 76(sp)                     # 4-byte Folded Spill
	bltu	a1, a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	andi	a0, a0, -4
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	lui	a0, 524288
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.x	v8, a0
	vmv.s.x	v8, zero
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 80
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 80
	vl1r.v	v10, (a3)                       # vscale x 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, tu, ma
	vle32.v	v9, (a2)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vfadd.vv	v8, v9, v10
	addi	a2, sp, 80
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	addi	a0, a0, 4
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 80
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 80
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	lui	a2, 524288
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vfredosum.vs	v8, v9, v10
	vfmv.f.s	fa5, v8
	mv	a2, a1
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 76(sp)                     # 4-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB0_6
	j	.LBB0_4
.LBB0_4:                                # %scalar.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	flw	fa5, 76(sp)                     # 4-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	flw	fa4, 24(sp)                     # 4-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fadd.s	fa5, fa5, fa4
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB0_5
	j	.LBB0_6
.LBB0_6:                                # %for.end
	flw	fa0, 28(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
