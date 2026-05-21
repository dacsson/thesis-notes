# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: combine_load_factor2_i32
# src = pre-opt (combine_load_factor2_i32), tgt = post-opt (combine_load_factor2_i32)
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
	j	.LBB9_1
.LBB9_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a3, a1, a3
	lw	a1, 0(a3)
	lw	a3, 4(a3)
	addw	a1, a1, a3
	slli	a3, a0, 2
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB9_1
	j	.LBB9_2
.LBB9_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
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
	j	.LBB9_1
.LBB9_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB9_2
.LBB9_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a2, a2, a3
                                        # implicit-def: $v16m4
	vsetivli	zero, 16, e32, m4, tu, ma
	vle32.v	v16, (a2)
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, ta, ma
	vnsrl.wi	v10, v16, 0
	li	a2, 32
                                        # implicit-def: $v12m2
	vnsrl.wx	v12, v16, a2
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	slli	a2, a0, 2
	add	a1, a1, a2
	vse32.v	v8, (a1)
	addi	a0, a0, 8
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB9_2
	j	.LBB9_3
.LBB9_3:                                # %middle.block
	j	.LBB9_4
.LBB9_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
