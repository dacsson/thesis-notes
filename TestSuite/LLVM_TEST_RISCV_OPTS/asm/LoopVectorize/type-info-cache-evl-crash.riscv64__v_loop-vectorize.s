# Source: LoopVectorize/type-info-cache-evl-crash.riscv64__v_loop-vectorize.ll
# Function: type_info_cache_clobber
# src = pre-opt (type_info_cache_clobber), tgt = post-opt (type_info_cache_clobber)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sb	a2, 0(a3)
	sh	a2, 0(zero)
	addi	a2, a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 8 * vlenb
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	addi	a0, a2, 1
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	addi	a3, a0, 1
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	add	a1, a1, a2
	addi	a1, a1, 1
	bgeu	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 80
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 80
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	add	a3, a3, a1
                                        # implicit-def: $v8
	vsetvli	zero, a2, e8, m1, tu, ma
	vle8.v	v8, (a3)
                                        # implicit-def: $v8
	vsetvli	a3, zero, e8, m1, tu, ma
	vmv.v.i	v8, 0
	li	a3, 0
	vsetvli	zero, a2, e8, m1, ta, ma
	vsoxei64.v	v8, (a3), v16
                                        # implicit-def: $v16m8
	vsetvli	a4, zero, e64, m8, tu, ma
	vmv.v.i	v16, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e16, m2, ta, ma
	vsoxei64.v	v8, (a3), v16
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	j	.LBB0_8
.LBB0_6:                                # %scalar.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sb	a2, 0(a3)
	sh	a2, 0(zero)
	addi	a2, a0, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
