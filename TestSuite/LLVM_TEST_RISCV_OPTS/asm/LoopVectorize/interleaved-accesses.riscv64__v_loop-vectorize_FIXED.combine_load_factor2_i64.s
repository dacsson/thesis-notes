# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: combine_load_factor2_i64
# src = pre-opt (combine_load_factor2_i64), tgt = post-opt (combine_load_factor2_i64)
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
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a3, a1, a3
	ld	a1, 0(a3)
	ld	a3, 8(a3)
	add	a1, a1, a3
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
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
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 2 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
                                        # implicit-def: $v16m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vle64.v	v16, (a2)
	vmv2r.v	v14, v16
                                        # implicit-def: $v8m4
	vsetivli	zero, 4, e64, m4, ta, ma
	vslidedown.vi	v8, v16, 4
	vmv2r.v	v12, v8
                                        # implicit-def: $v16m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vslideup.vi	v16, v12, 2
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
	vsetivli	zero, 4, e64, m2, ta, mu
	vslideup.vi	v16, v12, 1, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 2
	addi	a2, sp, 48
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
	vmv2r.v	v8, v14
	vsetivli	zero, 4, e64, m2, ta, mu
	vslidedown.vi	v8, v8, 1, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 12
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 48
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmerge.vvm	v10, v8, v16, v0
	addi	a2, sp, 48
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, mu
	vslidedown.vi	v8, v14, 1
	vslidedown.vi	v8, v14, 2, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 4
	vmv2r.v	v14, v12
	vsetivli	zero, 4, e64, m2, ta, mu
	vslideup.vi	v14, v12, 1, v0.t
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 48
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmerge.vvm	v12, v8, v14, v0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vadd.vv	v8, v10, v12
	slli	a2, a0, 3
	add	a1, a1, a2
	vse64.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	j	.LBB10_4
.LBB10_4:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
