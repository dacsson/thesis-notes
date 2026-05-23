# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize_FIXED.ll
# Function: predicated_udiv
# src = pre-opt (predicated_udiv), tgt = post-opt (predicated_udiv)
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
	j	.LBB4_1
.LBB4_1:                                # %for.body
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
	beqz	a0, .LBB4_3
	j	.LBB4_2
.LBB4_2:                                # %do_op
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	divu	a0, a0, a1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB4_3
.LBB4_3:                                # %latch
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_4
.LBB4_4:                                # %for.end
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 3 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.x	v10, a0
	vmv2r.v	v8, v10
	addi	a0, sp, 48
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	vsetvli	zero, zero, e64, m2, ta, ma
	vmsne.vi	v8, v10, 0
	li	a0, 0
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 48
	vl1r.v	v8, (a2)                        # vscale x 8-byte Folded Reload
	addi	a2, sp, 48
	vl2r.v	v16, (a2)                       # vscale x 16-byte Folded Reload
	slli	a2, a0, 3
	add	a1, a1, a2
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vle64.v	v10, (a1)
	vmv2r.v	v14, v10
	vmv1r.v	v0, v8
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, ta, mu
	vdivu.vv	v12, v14, v16, v0.t
	vfirst.m	a2, v8
	seqz	a2, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.x	v8, a2
	vsetvli	zero, zero, e8, mf4, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmerge.vvm	v8, v10, v12, v0
	vse64.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
