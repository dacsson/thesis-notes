# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON.ll
# Function: single_constant_stride_int_iv
# src = pre-opt (single_constant_stride_int_iv), tgt = post-opt (single_constant_stride_int_iv)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a1, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	addiw	a2, a2, 1
	sw	a2, 0(a3)
	addi	a2, a1, 64
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	slli	a1, a1, 2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 4 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
                                        # implicit-def: $v12m4
	vsetvli	a0, zero, e64, m4, ta, ma
	vid.v	v12
                                        # implicit-def: $v8m4
	vsll.vi	v8, v12, 6
	li	a0, 1024
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a1, a2, 6
                                        # implicit-def: $v16m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vsll.vi	v16, v12, 2
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vluxei64.v	v10, (a3), v16
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	vsetvli	zero, a2, e32, m2, ta, ma
	vsoxei64.v	v8, (a3), v16
	sub	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a1
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
