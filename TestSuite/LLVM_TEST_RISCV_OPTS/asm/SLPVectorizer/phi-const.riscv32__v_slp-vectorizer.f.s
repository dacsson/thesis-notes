# Source: SLPVectorizer/phi-const.riscv32__v_slp-vectorizer.ll
# Function: f
# src = pre-opt (f), tgt = post-opt (f)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	mv	a2, a1
	mv	a1, a0
	andi	a0, a2, 1
	mv	a2, a1
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	addi	a1, a1, 1
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %a
	li	a0, 255
	li	a1, 1
	sw	a1, 0(sp)                       # 4-byte Folded Spill
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	j	.LBB0_3
.LBB0_2:                                # %b
	li	a0, 1
	li	a1, 255
	sw	a1, 0(sp)                       # 4-byte Folded Spill
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %d
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	lw	a3, 8(sp)                       # 4-byte Folded Reload
	lw	a2, 0(sp)                       # 4-byte Folded Reload
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	sb	a2, 0(a3)
	sb	a0, 0(a1)
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
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a2, vlenb
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	mv	a2, a1
	mv	a1, a0
	andi	a0, a2, 1
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %a
                                        # implicit-def: $v8
	vsetivli	zero, 2, e8, mf8, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v8
	vrsub.vi	v8, v9, 1
	addi	a0, sp, 16
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB0_3
.LBB0_2:                                # %b
                                        # implicit-def: $v8
	vsetivli	zero, 2, e8, mf8, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v8
	vadd.vi	v8, v9, -1
	addi	a0, sp, 16
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %d
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	addi	a1, sp, 16
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
