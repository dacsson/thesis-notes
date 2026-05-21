# Source: LoopVectorize/induction-costs.ll
# Function: redundant_iv_trunc_for_cse
# src = pre-opt (redundant_iv_trunc_for_cse), tgt = post-opt (redundant_iv_trunc_for_cse)
# Triple: riscv64, Attrs: v
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
	j	.LBB2_1
.LBB2_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a1, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %then
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	slliw	a0, a0, 16
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_3:                                # %loop.latch
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	add	a3, a3, a0
	sb	a2, 0(a3)
	addi	a2, a0, 1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_4
.LBB2_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
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
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	addi	a0, a2, 1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 0
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e32, m2, ta, ma
	vid.v	v8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	vmv.v.v	v10, v8
	addi	a1, sp, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
	addi	a2, sp, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a5, a1, 2
	add	a4, a4, a5
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v10, (a4)
	vsetvli	a4, zero, e32, m2, ta, ma
	vmseq.vi	v0, v10, 0
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vim	v14, v8, 0, v0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e16, m1, ta, ma
	vnsrl.wi	v11, v14, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, ta, ma
	vnsrl.wi	v10, v11, 0
	add	a3, a3, a1
	vsetvli	zero, a2, e8, mf2, ta, ma
	vse8.v	v10, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v10m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vx	v10, v8, a2
                                        # implicit-def: $v8m2
	vadd.vx	v8, v12, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	addi	a1, sp, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
