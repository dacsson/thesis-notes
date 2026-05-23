# Source: LoopVectorize/uniform-load-store.riscv64-linux-gnu__v__f_loop-vectorize_TF-SCALABLE.ll
# Function: uniform_store_of_loop_varying
# src = pre-opt (uniform_store_of_loop_varying), tgt = post-opt (uniform_store_of_loop_varying)
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
	j	.LBB5_1
.LBB5_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 0(a3)
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1025
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
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
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 6 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vmv.v.x	v8, a0
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	li	a0, 1025
	li	a1, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vid.v	v8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	addi	a2, sp, 64
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	li	a4, 0
	vsetvli	zero, a2, e64, m2, ta, ma
	vsoxei64.v	v10, (a4), v12
	slli	a4, a1, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_3
.LBB5_3:                                # %middle.block
	j	.LBB5_4
.LBB5_4:                                # %for.end
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
