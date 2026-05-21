# Source: LoopVectorize/tail-folding-masked-loadstore.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: masked_loadstore
# src = pre-opt (masked_loadstore), tgt = post-opt (masked_loadstore)
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a2, 0(a1)
	addw	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB0_3
.LBB0_3:                                # %for.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
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
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v10, (a5)
	vsetvli	a5, zero, e32, m2, ta, ma
	vmsne.vi	v0, v10, 0
	addi	a5, sp, 64
	vs1r.v	v0, (a5)                        # vscale x 8-byte Folded Spill
	add	a3, a3, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v12, (a3), v0.t
	addi	a4, sp, 64
	vl1r.v	v0, (a4)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v12
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3), v0.t
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
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
