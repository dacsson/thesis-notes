# Source: LoopVectorize/gather-scatter-cost.riscv64__rva23u64_loop-vectorize.ll
# Function: store_to_addr_generated_from_invariant_addr
# src = pre-opt (store_to_addr_generated_from_invariant_addr), tgt = post-opt (store_to_addr_generated_from_invariant_addr)
# Triple: riscv64, Attrs: +rva23u64
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a4, 0(sp)                       # 8-byte Folded Spill
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	sh2add	a5, a0, a5
	sd	a4, 0(a5)
	lwu	a4, 0(a3)
	lwu	a3, 4(a3)
	slli	a3, a3, 32
	or	a3, a3, a4
	add	a3, a3, a2
	li	a2, 0
	sw	a2, 0(a3)
	sw	a2, 0(a3)
	sb	a2, 0(a3)
	addi	a2, a0, 1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a5, vlenb
	slli	a5, a5, 2
	sub	sp, sp, a5
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	addi	a0, a4, 1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vid.v	v8
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 64
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	addi	a1, sp, 64
	vl2r.v	v8, (a1)                        # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf4, ta, ma
                                        # implicit-def: $v12m2
	vsetvli	a5, zero, e64, m2, ta, ma
	vsll.vi	v12, v10, 2
	vsetvli	zero, a1, e64, m2, ta, ma
	vsoxei64.v	v8, (a4), v12
	lwu	a4, 0(a3)
	lwu	a3, 4(a3)
	slli	a3, a3, 32
	or	a3, a3, a4
	add	a2, a2, a3
                                        # implicit-def: $v8
	vsetvli	a3, zero, e32, m1, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.i	v12, 0
	vsetvli	zero, a1, e32, m1, ta, ma
	vsoxei64.v	v8, (a2), v12
	vsetvli	zero, a1, e32, m1, ta, ma
	vsoxei64.v	v8, (a2), v12
                                        # implicit-def: $v8
	vsetvli	a3, zero, e8, mf4, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a1, e8, mf4, ta, ma
	vsoxei64.v	v8, (a2), v12
	sub	a0, a0, a1
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a1
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	csrr	a0, vlenb
	sh2add	sp, a0, sp
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
