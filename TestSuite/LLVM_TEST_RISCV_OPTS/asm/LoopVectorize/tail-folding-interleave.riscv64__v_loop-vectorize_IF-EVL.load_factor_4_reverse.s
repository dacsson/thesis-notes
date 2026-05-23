# Source: LoopVectorize/tail-folding-interleave.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: load_factor_4_reverse
# src = pre-opt (load_factor_4_reverse), tgt = post-opt (load_factor_4_reverse)
# Triple: riscv64, Attrs: +v
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
	lw	a3, 0(a2)
	addw	a1, a1, a3
	lw	a3, 4(a2)
	addw	a1, a1, a3
	lw	a3, 8(a2)
	addw	a1, a1, a3
	lw	a2, 12(a2)
	addw	a2, a1, a2
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a1, a0, -1
	li	a0, 0
	mv	a3, a1
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
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
	csrr	a2, vlenb
	slli	a2, a2, 3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 8 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	addi	a2, a0, -1
	srai	a1, a2, 63
	and	a1, a1, a2
	sub	a0, a0, a1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v12
	li	a1, -1
	vmadd.vx	v12, a1, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs4r.v	v12, (a1)                       # vscale x 32-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vl2r.v	v8, (a1)                        # vscale x 16-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vl4r.v	v16, (a1)                       # vscale x 32-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	li	a1, 0
	sub	a1, a1, a2
                                        # implicit-def: $v12m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vsll.vi	v12, v16, 4
                                        # implicit-def: $v20m4
	vadd.vx	v20, v12, a3
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vluxei64.v	v10, (a3), v12
                                        # implicit-def: $v12m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vv	v12, v8, v10
	li	a3, 4
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vluxei64.v	v14, (a3), v20
                                        # implicit-def: $v10m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vv	v10, v12, v14
	li	a3, 8
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vluxei64.v	v14, (a3), v20
                                        # implicit-def: $v12m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vv	v12, v10, v14
	li	a3, 12
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vluxei64.v	v14, (a3), v20
                                        # implicit-def: $v10m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vv	v10, v12, v14
	vsetvli	zero, a2, e32, m2, tu, ma
	vmv.v.v	v8, v10
	addi	a3, sp, 64
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	sub	a0, a0, a2
                                        # implicit-def: $v12m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v12, v16, a1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs4r.v	v12, (a1)                       # vscale x 32-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_3
.LBB5_3:                                # %middle.block
	addi	a0, sp, 64
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_4
.LBB5_4:                                # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 3
	add	sp, sp, a1
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
