# Source: LoopVectorize/dead-ops-cost.riscv64-linux-gnu__v__f.ll
# Function: gather_interleave_group_with_dead_insert_pos
# src = pre-opt (gather_interleave_group_with_dead_insert_pos), tgt = post-opt (gather_interleave_group_with_dead_insert_pos)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
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
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a0
	lbu	a2, 1(a2)
	slli	a4, a0, 2
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a2, a0, 2
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 32
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	slt	a2, a0, a1
	sub	a0, a0, a2
	and	a0, a0, a1
	addi	a0, a0, 1
	srli	a0, a0, 1
	addi	a0, a0, 1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v12m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v12
                                        # implicit-def: $v8m4
	vadd.vv	v8, v12, v12
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	addi	a1, sp, 64
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a6, 48(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 64
	vl4r.v	v12, (a2)                       # vscale x 32-byte Folded Reload
	vsetvli	a3, a0, e8, mf2, ta, ma
	slli	a2, a3, 1
	slli	a5, a1, 1
	add	a5, a5, a6
	addi	a5, a5, 1
                                        # implicit-def: $v16m4
	vsetvli	a6, zero, e64, m4, tu, ma
	vmv.v.i	v16, 0
                                        # implicit-def: $v10
	vsetvli	zero, a3, e8, mf2, tu, ma
	vluxei64.v	v10, (a5), v16
                                        # implicit-def: $v8m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vzext.vf4	v8, v10
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vsll.vi	v16, v12, 2
	vsetvli	zero, a3, e32, m2, ta, ma
	vsoxei64.v	v8, (a4), v16
	add	a1, a3, a1
	sub	a0, a0, a3
                                        # implicit-def: $v8m4
	vsetvli	a3, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	addi	a1, sp, 64
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
