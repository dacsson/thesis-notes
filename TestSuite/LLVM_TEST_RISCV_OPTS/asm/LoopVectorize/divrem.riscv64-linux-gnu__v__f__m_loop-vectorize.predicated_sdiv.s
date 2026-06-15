# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize.ll
# Function: predicated_sdiv
# src = pre-opt (predicated_sdiv), tgt = post-opt (predicated_sdiv)
# Triple: riscv64-linux-gnu, Attrs: +v,+f,+m
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
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 3
	add	a1, a1, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	ld	a1, 0(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB5_3
	j	.LBB5_2
.LBB5_2:                                # %do_op
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	div	a0, a0, a1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB5_3
.LBB5_3:                                # %latch
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_4
.LBB5_4:                                # %for.end
	addi	sp, sp, 64
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 3 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetvli	a1, zero, e64, m2, tu, ma
	vmv.v.x	v10, a0
	addi	a0, sp, 48
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	vsetvli	zero, zero, e64, m2, ta, ma
	vmsne.vi	v8, v10, 0
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	li	a0, 1024
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 48
	vl1r.v	v8, (a2)                        # vscale x 8-byte Folded Reload
	addi	a2, sp, 48
	vl2r.v	v14, (a2)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 3
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vle64.v	v10, (a3)
	vsetvli	zero, a2, e64, m2, tu, ma
	vmv1r.v	v0, v8
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e64, m2, ta, mu
	vdiv.vv	v12, v10, v14, v0.t
	vsetvli	a4, zero, e8, mf4, ta, ma
	vfirst.m	a4, v8
	seqz	a4, a4
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.x	v8, a4
	vsetvli	zero, zero, e8, mf4, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmerge.vvm	v8, v10, v12, v0
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_3
.LBB5_3:                                # %middle.block
	j	.LBB5_4
.LBB5_4:                                # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
