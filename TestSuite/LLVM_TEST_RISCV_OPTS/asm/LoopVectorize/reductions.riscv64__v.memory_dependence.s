# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: memory_dependence
# src = pre-opt (memory_dependence), tgt = post-opt (memory_dependence)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 2
	li	a1, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB19_1
.LBB19_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	slli	a4, a3, 2
	add	a3, a2, a4
	lw	a2, 0(a3)
	add	a0, a0, a4
	lw	a0, 0(a0)
	addw	a2, a0, a2
	sw	a2, 128(a3)
	call	__muldi3
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB19_1
	j	.LBB19_2
.LBB19_2:                               # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end19:
	.size	src, .Lfunc_end19-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 4 * vlenb
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	li	a1, 2
	li	a3, 0
	li	a0, 8
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	bltu	a2, a0, .LBB19_4
	j	.LBB19_1
.LBB19_1:                               # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v10
	vsetivli	zero, 8, e8, mf2, tu, ma
	vmv.v.i	v10, 1
	li	a1, 2
	vmv.s.x	v10, a1
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vsext.vf4	v8, v10
	andi	a0, a0, -8
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 112
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB19_2
.LBB19_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 112
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vle32.v	v14, (a2)
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vle32.v	v10, (a3)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v14
	addi	a2, a2, 128
	vse32.v	v8, (a2)
                                        # implicit-def: $v8m2
	vmul.vv	v8, v10, v12
	addi	a2, sp, 112
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 8
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 112
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB19_2
	j	.LBB19_3
.LBB19_3:                               # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 112
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v12m2
	vslidedown.vi	v12, v10, 4
                                        # implicit-def: $v8m2
	vmul.vv	v8, v10, v12
                                        # implicit-def: $v12m2
	vslidedown.vi	v12, v8, 2
                                        # implicit-def: $v10m2
	vmul.vv	v10, v8, v12
                                        # implicit-def: $v12m2
	vrgather.vi	v12, v10, 1
                                        # implicit-def: $v8m2
	vmul.vv	v8, v10, v12
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a2, v8
	mv	a3, a1
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB19_6
	j	.LBB19_4
.LBB19_4:                               # %scalar.ph
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB19_5
.LBB19_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	slli	a4, a3, 2
	add	a3, a2, a4
	lw	a2, 0(a3)
	add	a0, a0, a4
	lw	a0, 0(a0)
	addw	a2, a0, a2
	sw	a2, 128(a3)
	call	__muldi3
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB19_5
	j	.LBB19_6
.LBB19_6:                               # %for.end
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end19:
	.size	tgt, .Lfunc_end19-tgt
	.cfi_endproc
                                        # -- End function
