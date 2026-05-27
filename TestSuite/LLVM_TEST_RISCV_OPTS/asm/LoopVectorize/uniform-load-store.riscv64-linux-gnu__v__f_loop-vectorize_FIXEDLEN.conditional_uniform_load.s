# Source: LoopVectorize/uniform-load-store.riscv64-linux-gnu__v__f_loop-vectorize_FIXEDLEN.ll
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 6 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v10, a0
	li	a0, 0
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 64
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, ta, mu
	vadd.vi	v14, v10, 4
	vmsgtu.vi	v0, v10, 10
	addi	a2, sp, 64
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
	vmsgtu.vi	v8, v14, 10
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	li	a2, 0
                                        # implicit-def: $v8m2
	vluxei64.v	v8, (a2), v12, v0.t
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 64
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v16m2
	vluxei64.v	v16, (a2), v12, v0.t
	addi	a2, sp, 64
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.i	v14, 0
                                        # implicit-def: $v12m2
	vmerge.vvm	v12, v14, v8, v0
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vmerge.vvm	v8, v14, v16, v0
	slli	a2, a0, 3
	add	a2, a1, a2
	addi	a1, a2, 32
	vse64.v	v12, (a2)
	vse64.v	v8, (a1)
	addi	a0, a0, 8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vadd.vi	v8, v10, 8
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %scalar.ph
	li	a0, 1024
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_5
.LBB2_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a1, 11
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_7
	j	.LBB2_6
.LBB2_6:                                # %do_load
                                        #   in Loop: Header=BB2_5 Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 0(a0)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_7
.LBB2_7:                                # %latch
                                        #   in Loop: Header=BB2_5 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1025
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_5
	j	.LBB2_8
.LBB2_8:                                # %for.end
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
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
