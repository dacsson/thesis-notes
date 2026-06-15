# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize_FIXED.ll
# Function: udiv_sdiv_with_invariant_divisors
# src = pre-opt (udiv_sdiv_with_invariant_divisors), tgt = post-opt (udiv_sdiv_with_invariant_divisors)
# Triple: riscv64-linux-gnu, Attrs: +v,+f,+m
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	mv	a2, a1
	mv	a1, a0
	li	a0, 244
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	lui	a1, 16
	addi	a1, a1, -12
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB9_1
.LBB9_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a1, 0
	andi	a0, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB9_3
	j	.LBB9_2
.LBB9_2:                                # %then
                                        #   in Loop: Header=BB9_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	zext.b	a2, a2
	zext.b	a0, a0
	divuw	a0, a0, a2
	slli	a1, a1, 48
	srai	a1, a1, 48
	divw	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB9_3
.LBB9_3:                                # %loop.latch
                                        #   in Loop: Header=BB9_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sw	a1, 0(a2)
	addi	a2, a0, 1
	mv	a1, a2
	slli	a0, a2, 48
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB9_1
	j	.LBB9_4
.LBB9_4:                                # %exit
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

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
	slli	a4, a4, 2
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB9_1
.LBB9_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	andi	a2, a2, 1
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.x	v8, a2
	vsetvli	zero, zero, e8, mf4, ta, ma
	vmsne.vi	v8, v8, 0
	vmnot.m	v8, v8
	addi	a2, sp, 64
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vid.v	v9
                                        # implicit-def: $v8
	vadd.vi	v8, v9, -12
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, tu, ma
	vmv.v.x	v9, a0
	li	a0, 0
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 64
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB9_2
.LBB9_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 1
	add	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 64
	vl1r.v	v9, (a3)                        # vscale x 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 64
	vl1r.v	v11, (a3)                       # vscale x 8-byte Folded Reload
	addi	a3, sp, 64
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 64
	vl1r.v	v8, (a3)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, ta, mu
	vdivu.vv	v10, v9, v8, v0.t
	addi	a3, sp, 64
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, mu
	vzext.vf2	v8, v10
                                        # implicit-def: $v10
	vdiv.vv	v10, v8, v11, v0.t
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vsext.vf2	v8, v10
	andi	a2, a2, 1
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.x	v10, a2
	vsetvli	zero, zero, e8, mf4, ta, ma
	vmsne.vi	v0, v10, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vim	v10, v8, 0, v0
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v10, 3
	vse32.v	v8, (a1)
	addiw	a0, a0, 4
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, ta, ma
	vadd.vi	v8, v9, 4
	li	a1, 12
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	bne	a0, a1, .LBB9_2
	j	.LBB9_3
.LBB9_3:                                # %middle.block
	j	.LBB9_4
.LBB9_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
