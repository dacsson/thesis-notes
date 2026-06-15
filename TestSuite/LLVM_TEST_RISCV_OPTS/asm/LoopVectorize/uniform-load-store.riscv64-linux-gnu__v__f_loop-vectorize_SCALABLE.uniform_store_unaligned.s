# Source: LoopVectorize/uniform-load-store.riscv64-linux-gnu__v__f_loop-vectorize_SCALABLE.ll
# Function: uniform_store_unaligned
# src = pre-opt (uniform_store_unaligned), tgt = post-opt (uniform_store_unaligned)
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
	j	.LBB7_1
.LBB7_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	srli	a3, a1, 56
	sb	a3, 7(a4)
	srli	a3, a1, 48
	sb	a3, 6(a4)
	srli	a3, a1, 40
	sb	a3, 5(a4)
	srli	a3, a1, 32
	sb	a3, 4(a4)
	srli	a3, a1, 24
	sb	a3, 3(a4)
	srli	a3, a1, 16
	sb	a3, 2(a4)
	sb	a1, 0(a4)
	srli	a3, a1, 8
	sb	a3, 1(a4)
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1025
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_2
.LBB7_2:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
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
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 2 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 64
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	li	a0, 1025
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB7_2
.LBB7_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	srli	a6, a4, 56
	sb	a6, 7(a5)
	srli	a6, a4, 48
	sb	a6, 6(a5)
	srli	a6, a4, 40
	sb	a6, 5(a5)
	srli	a6, a4, 32
	sb	a6, 4(a5)
	srli	a6, a4, 24
	sb	a6, 3(a5)
	srli	a6, a4, 16
	sb	a6, 2(a5)
	sb	a4, 0(a5)
	srli	a4, a4, 8
	sb	a4, 1(a5)
	slli	a4, a1, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB7_2
	j	.LBB7_3
.LBB7_3:                                # %middle.block
	j	.LBB7_4
.LBB7_4:                                # %for.end
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
