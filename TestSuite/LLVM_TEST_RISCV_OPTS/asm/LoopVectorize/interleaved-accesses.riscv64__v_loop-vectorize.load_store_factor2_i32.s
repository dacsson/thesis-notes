# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize.ll
# Function: load_store_factor2_i32
# src = pre-opt (load_store_factor2_i32), tgt = post-opt (load_store_factor2_i32)
# Triple: riscv64, Attrs: +v
#

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
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	lw	a1, 4(a2)
	addiw	a1, a1, 2
	sw	a1, 4(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
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
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 3
	add	a3, a3, a4
	slli	a4, a2, 1
                                        # implicit-def: $v16m4
	vsetvli	zero, a4, e32, m4, tu, ma
	vle32.v	v16, (a3)
	li	a5, 32
                                        # implicit-def: $v12m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vnsrl.wx	v12, v16, a5
                                        # implicit-def: $v8m2
	vnsrl.wi	v8, v16, 0
                                        # implicit-def: $v10m2
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v12, 2
                                        # implicit-def: $v12m4
	vwaddu.vv	v12, v10, v8
	li	a5, -1
	vwmaccu.vx	v12, a5, v8
	vmv2r.v	v16, v12
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v16
	vmv2r.v	v12, v14
	vmv2r.v	v10, v12
	vsetvli	zero, a4, e32, m4, ta, ma
	vse32.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
