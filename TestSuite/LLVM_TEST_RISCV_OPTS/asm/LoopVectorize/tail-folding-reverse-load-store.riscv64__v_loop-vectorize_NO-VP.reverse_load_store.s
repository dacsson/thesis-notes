# Source: LoopVectorize/tail-folding-reverse-load-store.riscv64__v_loop-vectorize_NO-VP.ll
# Function: reverse_load_store
# src = pre-opt (reverse_load_store), tgt = post-opt (reverse_load_store)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addi	a2, a2, -1
	slli	a4, a2, 2
	add	a1, a1, a4
	lw	a1, 0(a1)
	add	a3, a3, a4
	sw	a1, 0(a3)
	addiw	a0, a0, 1
	li	a1, 1024
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %loopend
	addi	sp, sp, 32
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
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 104(sp)                     # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sub	a2, a2, a1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 88(sp)                      # 8-byte Folded Reload
	sub	a5, a5, a0
	slli	a5, a5, 2
	addi	a5, a5, -4
	add	a6, a4, a5
	slli	a4, a2, 2
	addi	a4, a4, -4
	sub	a6, a6, a4
                                        # implicit-def: $v8m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vle32.v	v8, (a6)
	vmv1r.v	v10, v9
	vmv1r.v	v11, v8
	csrr	a6, vlenb
	srli	a6, a6, 2
	addiw	a6, a6, -1
                                        # implicit-def: $v8
	vsetvli	a7, zero, e32, m1, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vrsub.vx	v9, v8, a6
                                        # implicit-def: $v8
	vrgather.vv	v8, v11, v9
                                        # implicit-def: $v11
	vrgather.vv	v11, v10, v9
	add	a3, a3, a5
	sub	a3, a3, a4
                                        # implicit-def: $v10
	vrgather.vv	v10, v11, v9
                                        # implicit-def: $v11
	vrgather.vv	v11, v8, v9
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v11
	vmv.v.v	v9, v10
	vsetvli	a4, zero, e32, m2, ta, ma
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_8
	j	.LBB0_6
.LBB0_6:                                # %scalar.ph
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	addi	a2, a2, -1
	slli	a4, a2, 2
	add	a1, a1, a4
	lw	a1, 0(a1)
	add	a3, a3, a4
	sw	a1, 0(a3)
	addiw	a0, a0, 1
	li	a1, 1024
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %loopend
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
