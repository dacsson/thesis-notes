# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON.ll
# Function: single_constant_stride_ptr_iv
# src = pre-opt (single_constant_stride_ptr_iv), tgt = post-opt (single_constant_stride_ptr_iv)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a2, 0(a1)
	addiw	a2, a2, 1
	sw	a2, 0(a1)
	addi	a2, a1, 8
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	li	a0, 1024
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vid.v	v8
                                        # implicit-def: $v12m4
	vsll.vi	v12, v8, 3
	vsetvli	a2, a0, e8, mf2, ta, ma
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vluxei64.v	v10, (a1), v12
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	vsetvli	zero, a2, e32, m2, ta, ma
	vsoxei64.v	v8, (a1), v12
	sub	a0, a0, a2
	slli	a2, a2, 3
	add	a1, a1, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
