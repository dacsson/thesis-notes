# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_2.ll
# Function: single_constant_stride_int_scaled
# src = pre-opt (single_constant_stride_int_scaled), tgt = post-opt (single_constant_stride_int_scaled)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 5
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	slli	a1, a1, 2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 4 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	li	a0, 1024
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v8
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	vsetvli	a1, a0, e8, mf2, ta, ma
                                        # implicit-def: $v16m4
	vsetvli	a3, zero, e64, m4, ta, ma
	vsll.vi	v16, v12, 5
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e32, m2, tu, ma
	vluxei64.v	v10, (a2), v16
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v8, (a2), v16
	sub	a0, a0, a1
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a1
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
