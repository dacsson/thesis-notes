# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize.ll
# Function: load_store_factor2_i64
# src = pre-opt (load_store_factor2_i64), tgt = post-opt (load_store_factor2_i64)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 4
	add	a2, a1, a2
	ld	a1, 0(a2)
	addi	a1, a1, 1
	sd	a1, 0(a2)
	ld	a1, 8(a2)
	addi	a1, a1, 2
	sd	a1, 8(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 4
	add	a3, a3, a4
	slli	a4, a2, 1
                                        # implicit-def: $v16m4
	vsetvli	zero, a4, e64, m4, tu, ma
	vle64.v	v16, (a3)
	li	a5, 170
                                        # implicit-def: $v12
	vsetvli	a6, zero, e8, m1, tu, ma
	vmv.v.x	v12, a5
                                        # implicit-def: $v8m4
	vsetvli	a5, zero, e64, m4, tu, ma
	vcompress.vm	v8, v16, v12
	vmv2r.v	v10, v8
	li	a5, 85
                                        # implicit-def: $v8
	vsetvli	a6, zero, e8, m1, tu, ma
	vmv.v.x	v8, a5
                                        # implicit-def: $v12m4
	vsetvli	a5, zero, e64, m4, tu, ma
	vcompress.vm	v12, v16, v8
                                        # kill: def $v12m2 killed $v12m2 killed $v12m4 killed $vtype
                                        # implicit-def: $v8m2
	vsetvli	a5, zero, e64, m2, ta, ma
	vadd.vi	v8, v12, 1
                                        # implicit-def: $v12m4
	vmv.v.v	v12, v8
                                        # implicit-def: $v8m2
	vadd.vi	v8, v10, 2
	vmv.v.v	v14, v8
	csrr	a5, vlenb
	srli	a5, a5, 2
                                        # implicit-def: $v9
	vsetvli	a6, zero, e16, m1, ta, mu
	vid.v	v9
                                        # implicit-def: $v16
	vsrl.vi	v16, v9, 1
                                        # implicit-def: $v8
	vand.vi	v8, v9, 1
	vmsne.vi	v0, v8, 0
	vadd.vx	v16, v16, a5, v0.t
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vrgatherei16.vv	v8, v12, v16
	vsetvli	zero, a4, e64, m4, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
