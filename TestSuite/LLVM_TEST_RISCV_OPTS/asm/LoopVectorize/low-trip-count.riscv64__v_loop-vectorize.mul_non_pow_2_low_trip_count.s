# Source: LoopVectorize/low-trip-count.riscv64__v_loop-vectorize.ll
# Function: mul_non_pow_2_low_trip_count
# src = pre-opt (mul_non_pow_2_low_trip_count), tgt = post-opt (mul_non_pow_2_low_trip_count)
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
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 2
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a2
	lbu	a0, 0(a0)
	call	__muldi3
	mv	a2, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	li	a1, 10
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 1 * vlenb
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %vector.ph
	j	.LBB8_2
.LBB8_2:                                # %vector.body
	ld	a0, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v9, (a0)
                                        # implicit-def: $v10
	vmv.v.i	v10, 0
	li	a0, 1
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vsll.vv	v8, v9, v10
	addi	a0, sp, 80
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB8_3
.LBB8_3:                                # %middle.block
	addi	a0, sp, 80
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vslidedown.vi	v10, v9, 4
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
                                        # implicit-def: $v10
	vslidedown.vi	v10, v8, 2
                                        # implicit-def: $v9
	vmul.vv	v9, v8, v10
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 1
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
	vmv.x.s	a0, v8
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB8_4
.LBB8_4:                                # %scalar.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 8
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB8_5
.LBB8_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lbu	a0, 0(a0)
	call	__muldi3
	mv	a2, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 10
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_5
	j	.LBB8_6
.LBB8_6:                                # %for.end
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 96
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
