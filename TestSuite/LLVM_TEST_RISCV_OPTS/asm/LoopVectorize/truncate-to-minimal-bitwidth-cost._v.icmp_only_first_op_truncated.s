# Source: LoopVectorize/truncate-to-minimal-bitwidth-cost._v.ll
# Function: icmp_only_first_op_truncated
# src = pre-opt (icmp_only_first_op_truncated), tgt = post-opt (icmp_only_first_op_truncated)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sext.w	a0, a0
	sext.w	a1, a1
	bne	a0, a1, .LBB4_3
	j	.LBB4_2
.LBB4_2:                                # %then
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	slli	a2, a2, 32
	srli	a2, a2, 29
	add	a1, a1, a2
	fld	fa5, 0(a1)
	fsd	fa5, 0(a0)
	j	.LBB4_3
.LBB4_3:                                # %loop.latch
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addi	a2, a0, 1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_4
.LBB4_4:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a5, vlenb
	slli	a6, a5, 2
	add	a5, a6, a5
	sub	sp, sp, a5
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x05, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 5 * vlenb
	sd	a4, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	addi	a0, a3, 1
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a5, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	a6, zero, e32, m1, tu, ma
	vmv.v.x	v8, a5
	vsetvli	zero, zero, e32, m1, ta, ma
	vmseq.vx	v8, v8, a4
	addi	a4, sp, 80
	vs1r.v	v8, (a4)                        # vscale x 8-byte Folded Spill
	slli	a3, a3, 32
	srli	a3, a3, 29
	add	a2, a2, a3
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v8, a2
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 80
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	addi	a1, sp, 80
	vl1r.v	v0, (a1)                        # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 80
	vl2r.v	v12, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf4, ta, ma
	li	a2, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, a1, e64, m2, ta, mu
	vluxei64.v	v8, (a2), v12, v0.t
	addi	a3, sp, 80
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
	vsetvli	zero, a1, e64, m2, ta, ma
	vsoxei64.v	v8, (a2), v10, v0.t
	sub	a0, a0, a1
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
