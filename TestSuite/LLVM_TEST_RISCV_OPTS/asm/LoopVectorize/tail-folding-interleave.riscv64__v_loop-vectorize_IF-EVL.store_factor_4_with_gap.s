# Source: LoopVectorize/tail-folding-interleave.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: store_factor_4_with_gap
# src = pre-opt (store_factor_4_with_gap), tgt = post-opt (store_factor_4_with_gap)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 4
	add	a2, a2, a3
	sw	a0, 0(a2)
	sw	a0, 4(a2)
	sw	a0, 12(a2)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 32
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a2, a2, 1
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 2 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, ta, ma
	vid.v	v8
	addi	a1, sp, 48
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 48
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	vsetvli	a1, a1, e8, mf2, ta, ma
                                        # implicit-def: $v12m4
	vsetvli	a3, zero, e64, m4, tu, ma
	vmv.v.x	v12, a2
	li	a3, 16
	vsetvli	zero, zero, e32, m2, ta, ma
	vwmaccus.vx	v12, a3, v10
                                        # implicit-def: $v16m4
	vwmulsu.vx	v16, v10, a3
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v10, (a2), v16
	li	a2, 4
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v10, (a2), v12
	li	a2, 12
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v10, (a2), v12
	subw	a0, a0, a1
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e32, m2, ta, ma
	vadd.vx	v8, v10, a1
	addi	a1, sp, 48
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
