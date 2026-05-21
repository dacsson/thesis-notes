# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize.ll
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
	slli	a4, a4, 3
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 8 * vlenb
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB9_1
.LBB9_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	not	a3, a3
	andi	a3, a3, 1
                                        # implicit-def: $v8
	vsetvli	a4, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a3
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	addi	a3, sp, 64
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a2
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m1, tu, ma
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.x	v8, a0
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 64
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vid.v	v9
                                        # implicit-def: $v8
	vadd.vi	v8, v9, -12
	li	a0, 12
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB9_2
.LBB9_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a3, a1, 3
	sub	a1, a3, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a3, a1, 1
	add	a1, a3, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vl1r.v	v11, (a1)                       # vscale x 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v0, (a1)                        # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vl1r.v	v10, (a1)                       # vscale x 8-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	vsetvli	a1, a1, e8, mf2, ta, ma
                                        # implicit-def: $v8
	vsetvli	zero, a1, e8, mf2, ta, mu
	vdivu.vv	v8, v9, v10, v0.t
	addi	a3, sp, 64
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vsetvli	a3, zero, e16, m1, ta, ma
	vzext.vf2	v10, v8
                                        # implicit-def: $v8
	vsetvli	zero, a1, e16, m1, ta, mu
	vdiv.vv	v8, v10, v11, v0.t
                                        # implicit-def: $v16m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vsext.vf2	v16, v8
	andi	a2, a2, 1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a2
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vim	v10, v16, 0, v0
	li	a2, 0
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v10, (a2), v12
	subw	a0, a0, a1
                                        # implicit-def: $v8
	vsetvli	a2, zero, e8, mf2, ta, ma
	vadd.vx	v8, v9, a1
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB9_2
	j	.LBB9_3
.LBB9_3:                                # %middle.block
	j	.LBB9_4
.LBB9_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
