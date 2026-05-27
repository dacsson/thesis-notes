# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize.ll
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a5, a1, 4
	add	a4, a4, a5
	slli	a5, a2, 1
                                        # implicit-def: $v16m4
	vsetvli	zero, a5, e64, m4, tu, ma
	vle64.v	v16, (a4)
	li	a4, 170
                                        # implicit-def: $v12
	vsetvli	a5, zero, e8, m1, tu, ma
	vmv.v.x	v12, a4
                                        # implicit-def: $v8m4
	vsetvli	a4, zero, e64, m4, tu, ma
	vcompress.vm	v8, v16, v12
	vmv2r.v	v12, v8
	li	a4, 85
                                        # implicit-def: $v14
	vsetvli	a5, zero, e8, m1, tu, ma
	vmv.v.x	v14, a4
                                        # implicit-def: $v8m4
	vsetvli	a4, zero, e64, m4, tu, ma
	vcompress.vm	v8, v16, v14
	vmv2r.v	v10, v8
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vadd.vv	v8, v10, v12
	slli	a4, a1, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	j	.LBB10_4
.LBB10_4:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
