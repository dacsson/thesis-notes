# Source: LoopVectorize/dead-ops-cost.riscv64-linux-gnu__v__f.ll
# Function: test_phi_in_latch_redundant
# src = pre-opt (test_phi_in_latch_redundant), tgt = post-opt (test_phi_in_latch_redundant)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_3
	j	.LBB3_2
.LBB3_2:                                # %then
                                        #   in Loop: Header=BB3_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	not	a0, a0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB3_3
.LBB3_3:                                # %loop.latch
                                        #   in Loop: Header=BB3_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a2, a0, 9
	li	a1, 322
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB3_1
	j	.LBB3_4
.LBB3_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 6 * vlenb
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	not	a0, a0
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 48
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v12
	li	a0, 9
                                        # implicit-def: $v8m4
	vmul.vx	v8, v12, a0
	li	a0, 37
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	addi	a1, sp, 48
	vl2r.v	v8, (a1)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a1, a2, 3
	add	a1, a1, a2
                                        # implicit-def: $v16m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vsll.vi	v16, v12, 2
	vsetvli	zero, a2, e32, m2, ta, ma
	vsoxei64.v	v8, (a3), v16
	sub	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	j	.LBB3_4
.LBB3_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
