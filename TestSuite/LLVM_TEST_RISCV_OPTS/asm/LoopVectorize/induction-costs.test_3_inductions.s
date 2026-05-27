# Source: LoopVectorize/induction-costs.ll
# Function: test_3_inductions
# src = pre-opt (test_3_inductions), tgt = post-opt (test_3_inductions)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	li	a2, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a5, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	or	a6, a2, a3
	sext.w	a6, a6
	add	a4, a4, a6
	sd	a4, 0(a5)
	addiw	a4, a3, 2
	addi	a3, a0, 1
	addiw	a2, a2, 2
	sd	a4, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 4 * vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	addi	a0, a2, 1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 48
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vid.v	v9
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v9
                                        # implicit-def: $v9
	vor.vi	v9, v8, 1
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 48
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
	csrr	a1, vlenb
	sh1add	a1, a1, a1
	add	a1, a1, sp
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	sh1add	a1, a1, a1
	add	a1, a1, sp
	addi	a1, a1, 48
	vl1r.v	v10, (a1)                       # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 48
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	addi	a1, sp, 48
	vl2r.v	v14, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slliw	a1, a2, 1
                                        # implicit-def: $v9
	vsetvli	a4, zero, e32, m1, ta, ma
	vor.vv	v9, v10, v8
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v12, a3
	vsetvli	zero, zero, e32, m1, ta, ma
	vwadd.wv	v12, v12, v9
	li	a3, 0
	vsetvli	zero, a2, e64, m2, ta, ma
	vsoxei64.v	v12, (a3), v14
	sub	a0, a0, a2
                                        # implicit-def: $v9
	vsetvli	a2, zero, e32, m1, ta, ma
	vadd.vx	v9, v8, a1
                                        # implicit-def: $v8
	vadd.vx	v8, v10, a1
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 48
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
	csrr	a1, vlenb
	sh1add	a1, a1, a1
	add	a1, a1, sp
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %exit
	csrr	a0, vlenb
	sh2add	sp, a0, sp
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
