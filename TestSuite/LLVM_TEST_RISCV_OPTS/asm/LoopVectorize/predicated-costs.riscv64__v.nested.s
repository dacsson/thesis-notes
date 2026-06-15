# Source: LoopVectorize/predicated-costs.riscv64__v.ll
# Function: nested
# src = pre-opt (nested), tgt = post-opt (nested)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB0_4
	j	.LBB0_2
.LBB0_2:                                # %then.0
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB0_4
	j	.LBB0_3
.LBB0_3:                                # %then.1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	sext.w	a2, a2
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	slli	a1, a1, 2
	add	a1, a0, a1
	li	a0, 0
	sw	a0, 0(a1)
	j	.LBB0_4
.LBB0_4:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_5
.LBB0_5:                                # %exit
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a4, vlenb
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	and	a0, a0, a1
	andi	a0, a0, 1
                                        # implicit-def: $v8
	vsetvli	a1, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a0
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	addi	a0, sp, 64
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	li	a0, 1024
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 64
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	slli	a2, a0, 32
	srli	a2, a2, 32
	vsetvli	a2, a2, e8, mf2, ta, ma
	sext.w	a5, a1
	slli	a5, a5, 2
	add	a4, a4, a5
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v8, (a4), v0.t
	addi	a4, sp, 64
	vl1r.v	v0, (a4)                        # vscale x 8-byte Folded Reload
	li	a4, 4
                                        # implicit-def: $v12m4
	vsetvli	a5, zero, e32, m2, ta, ma
	vwmulsu.vx	v12, v8, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e32, m2, ta, ma
	vsoxei64.v	v8, (a3), v12, v0.t
	addw	a1, a2, a1
	subw	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
