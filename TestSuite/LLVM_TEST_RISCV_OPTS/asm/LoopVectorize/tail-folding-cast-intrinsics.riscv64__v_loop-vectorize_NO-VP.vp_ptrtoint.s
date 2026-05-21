# Source: LoopVectorize/tail-folding-cast-intrinsics.riscv64__v_loop-vectorize_NO-VP.ll
# Function: vp_ptrtoint
# src = pre-opt (vp_ptrtoint), tgt = post-opt (vp_ptrtoint)
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
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	slli	a4, a0, 3
	add	a3, a3, a4
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 4 * vlenb
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB10_2
# %bb.1:                                # %entry
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB10_2:                               # %entry
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB10_6
	j	.LBB10_3
.LBB10_3:                               # %vector.ph
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sub	a3, a0, a1
	and	a2, a2, a3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v10, a1
	addi	a1, sp, 96
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 96
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB10_4
.LBB10_4:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	csrr	a5, vlenb
	slli	a5, a5, 1
	add	a5, sp, a5
	addi	a5, a5, 96
	vl2r.v	v10, (a5)                       # vscale x 16-byte Folded Reload
	addi	a5, sp, 96
	vl2r.v	v12, (a5)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vsll.vi	v14, v10, 2
                                        # implicit-def: $v8m2
	vadd.vx	v8, v14, a4
	slli	a4, a0, 3
	add	a3, a3, a4
	vse64.v	v8, (a3)
	add	a0, a0, a2
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB10_4
	j	.LBB10_5
.LBB10_5:                               # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB10_8
	j	.LBB10_6
.LBB10_6:                               # %scalar.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB10_7
.LBB10_7:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	slli	a4, a0, 3
	add	a3, a3, a4
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_7
	j	.LBB10_8
.LBB10_8:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 96
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
