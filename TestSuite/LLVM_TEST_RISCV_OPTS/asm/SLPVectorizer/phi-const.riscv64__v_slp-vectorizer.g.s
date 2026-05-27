# Source: SLPVectorizer/phi-const.riscv64__v_slp-vectorizer.ll
# Function: g
# src = pre-opt (g), tgt = post-opt (g)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	mv	a2, a1
	mv	a1, a0
	andi	a0, a2, 1
	mv	a2, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	addi	a1, a1, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %a
	li	a0, 255
	li	a1, 1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_2:                                # %b
	li	a0, 1
	li	a1, 255
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %d
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addiw	a2, a2, 1
	addiw	a0, a0, 1
	sb	a2, 0(a3)
	sb	a0, 0(a1)
	addi	sp, sp, 32
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
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a2, vlenb
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 1 * vlenb
	mv	a2, a1
	mv	a1, a0
	andi	a0, a2, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %a
                                        # implicit-def: $v8
	vsetivli	zero, 2, e8, mf8, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v8
	vrsub.vi	v8, v9, 1
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB1_3
.LBB1_2:                                # %b
                                        # implicit-def: $v8
	vsetivli	zero, 2, e8, mf8, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v8
	vadd.vi	v8, v9, -1
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %d
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vadd.vi	v8, v9, 1
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
