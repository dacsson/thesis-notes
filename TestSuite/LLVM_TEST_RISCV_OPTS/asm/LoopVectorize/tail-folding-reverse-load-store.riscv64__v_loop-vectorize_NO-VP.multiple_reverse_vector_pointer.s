# Source: LoopVectorize/tail-folding-reverse-load-store.riscv64__v_loop-vectorize_NO-VP.ll
# Function: multiple_reverse_vector_pointer
# src = pre-opt (multiple_reverse_vector_pointer), tgt = post-opt (multiple_reverse_vector_pointer)
# Triple: riscv64, Attrs: +v
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
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	add	a4, a4, a0
	lb	a4, 0(a4)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	add	a3, a3, a0
	sb	a1, 0(a3)
	add	a2, a2, a0
	sb	a1, 0(a2)
	addi	a1, a0, -1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
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
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	ld	a6, 40(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	sub	a3, a1, a0
	add	a6, a6, a3
	addi	a6, a6, -15
                                        # implicit-def: $v9
	vsetivli	zero, 16, e8, m1, tu, ma
	vle8.v	v9, (a6)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, ta, ma
	vid.v	v8
                                        # implicit-def: $v10
	vrsub.vi	v10, v8, 15
                                        # implicit-def: $v8
	vrgather.vv	v8, v9, v10
                                        # implicit-def: $v16m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vsext.vf8	v16, v8
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, m1, tu, ma
	vluxei64.v	v9, (a5), v16
	add	a4, a4, a3
	addi	a4, a4, -15
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, ta, ma
	vrgather.vv	v8, v9, v10
	vse8.v	v8, (a4)
	add	a2, a2, a3
	addi	a2, a2, -15
	vse8.v	v8, (a2)
	addi	a0, a0, 16
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %scalar.ph
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_5
.LBB2_5:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	add	a4, a4, a0
	lb	a4, 0(a4)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	add	a3, a3, a0
	sb	a1, 0(a3)
	add	a2, a2, a0
	sb	a1, 0(a2)
	addi	a1, a0, -1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB2_5
	j	.LBB2_6
.LBB2_6:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
