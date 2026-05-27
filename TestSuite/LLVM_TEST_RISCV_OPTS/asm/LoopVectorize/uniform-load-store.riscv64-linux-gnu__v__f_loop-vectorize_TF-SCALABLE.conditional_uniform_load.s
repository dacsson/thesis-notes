# Source: LoopVectorize/uniform-load-store.riscv64-linux-gnu__v__f_loop-vectorize_TF-SCALABLE.ll
# Function: conditional_uniform_load
# src = pre-opt (conditional_uniform_load), tgt = post-opt (conditional_uniform_load)
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
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a2, 0
	li	a1, 11
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %do_load
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 0(a0)
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_3:                                # %latch
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1025
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_4
.LBB2_4:                                # %for.end
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
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
	slli	a3, a2, 3
	add	a2, a3, a2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x09, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 9 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, tu, ma
	vmv.v.x	v8, a0
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 48
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	li	a0, 1025
	li	a1, 0
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 2
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 48
	vl4r.v	v12, (a2)                       # vscale x 32-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 48
	vl4r.v	v8, (a2)                        # vscale x 32-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	vsetvli	a4, zero, e64, m4, ta, ma
	vmsgtu.vi	v0, v12, 10
	addi	a4, sp, 48
	vs1r.v	v0, (a4)                        # vscale x 8-byte Folded Spill
	li	a4, 0
                                        # implicit-def: $v20m4
	vsetvli	zero, a2, e64, m4, ta, mu
	vluxei64.v	v20, (a4), v8, v0.t
	addi	a4, sp, 48
	vl1r.v	v0, (a4)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v16m4
	vsetvli	a4, zero, e64, m4, tu, ma
	vmv.v.i	v16, 0
                                        # implicit-def: $v8m4
	vmerge.vvm	v8, v16, v20, v0
	slli	a4, a1, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m4, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	a3, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 3
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
