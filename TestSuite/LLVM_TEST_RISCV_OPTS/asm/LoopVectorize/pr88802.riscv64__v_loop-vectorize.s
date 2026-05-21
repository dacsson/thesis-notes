# Source: LoopVectorize/pr88802.riscv64__v_loop-vectorize.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	addiw	a2, a1, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	slli	a0, a0, 48
	srai	a2, a0, 52
	li	a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %cond.false
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	zext.b	a0, a0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sb	a1, 0(a3)
	sext.w	a0, a0
	li	a1, 8
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 64
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a3, vlenb
	slli	a4, a3, 1
	add	a3, a4, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 3 * vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetvli	a3, zero, e8, mf4, tu, ma
	vmv.v.x	v9, a2
	slli	a1, a1, 48
	srai	a1, a1, 52
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.v.x	v8, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v8, v9
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 48
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	li	a0, 9
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vid.v	v8
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	addi	a1, sp, 48
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	vsetvli	a1, a1, e8, mf4, ta, ma
                                        # implicit-def: $v8
	vsetvli	a2, zero, e8, mf4, tu, ma
	vmv.v.i	v8, 0
	li	a2, 0
	vsetvli	zero, a1, e8, mf4, ta, ma
	vsoxei64.v	v8, (a2), v10
	subw	a0, a0, a1
                                        # implicit-def: $v8
	vsetvli	a2, zero, e32, m1, ta, ma
	vadd.vx	v8, v9, a1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
