# Source: LoopVectorize/first-order-recurrence-scalable-vf1.ll
# Function: pr97452_scalable_vf1_for
# src = pre-opt (pr97452_scalable_vf1_for), tgt = post-opt (pr97452_scalable_vf1_for)
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
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	addi	a3, a0, 1
	slli	a5, a0, 3
	add	a4, a4, a5
	ld	a4, 0(a4)
	add	a1, a1, a5
	sd	a2, 0(a1)
	li	a1, 22
	sd	a4, 32(sp)                      # 8-byte Folded Spill
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 4 * vlenb
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	csrr	a0, vlenb
	srli	a0, a0, 2
	addiw	a1, a0, -1
	li	a2, 0
                                        # implicit-def: $v8
	vsetvli	a3, zero, e64, m1, tu, ma
	vmv.s.x	v8, a2
                                        # implicit-def: $v10m2
	vmv1r.v	v10, v8
	slli	a1, a1, 32
	srli	a1, a1, 32
	addi	a3, a1, 1
                                        # implicit-def: $v8m2
	vmv1r.v	v11, v12
	vsetvli	zero, a3, e64, m2, ta, ma
	vslideup.vx	v8, v10, a1
	li	a1, 23
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 80
	vl2r.v	v12, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf4, ta, ma
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a4, a2, 3
	add	a6, a6, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a1, e64, m2, tu, ma
	vle64.v	v8, (a6)
	slli	a5, a5, 32
	srli	a5, a5, 32
	addi	a5, a5, -1
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e64, m2, ta, ma
	vslidedown.vx	v10, v12, a5
	vsetvli	zero, a1, e64, m2, ta, ma
	vslideup.vi	v10, v8, 1
	addi	a5, sp, 80
	vs2r.v	v10, (a5)                       # vscale x 16-byte Folded Spill
	add	a3, a3, a4
	vsetvli	zero, a1, e64, m2, ta, ma
	vse64.v	v10, (a3)
	mv	a3, a1
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	add	a2, a1, a2
	sub	a0, a0, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 80
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	addi	a0, a0, -1
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vx	v8, v10, a0
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
