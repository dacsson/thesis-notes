# Source: LoopVectorize/mask-index-type.riscv64-linux-gnu__v__f_loop-vectorize_VLENUNK.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	li	a2, 0
	li	a0, 511
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %do_load
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addw	a1, a1, a3
	slli	a3, a0, 2
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %for.end
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
	slli	a4, a3, 3
	sub	a3, a4, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x07, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 7 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.x	v8, a0
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	li	a0, 1024
	li	a1, 0
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 1
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl4r.v	v12, (a2)                       # vscale x 32-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	li	a4, 512
	vsetvli	a6, zero, e64, m4, ta, ma
	vmsltu.vx	v0, v12, a4
	addi	a4, sp, 64
	vs1r.v	v0, (a4)                        # vscale x 8-byte Folded Spill
	slli	a4, a1, 2
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v8, (a5), v0.t
	addi	a5, sp, 64
	vl1r.v	v0, (a5)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v16m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vadd.vv	v16, v10, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v8, v10, v16, v0
	add	a3, a3, a4
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	a3, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
