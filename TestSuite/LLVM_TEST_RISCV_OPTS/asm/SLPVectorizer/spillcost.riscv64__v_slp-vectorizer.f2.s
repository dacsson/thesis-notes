# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f2
# src = pre-opt (f2), tgt = post-opt (f2)
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
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	andi	a1, a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	call	g
	call	g
	call	g
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	li	a1, 0
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %foo
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(a0)
	ld	a0, 8(a0)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %bar
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
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
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	andi	a1, a0, 1
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	call	g
	call	g
	call	g
	ld	a0, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.i	v8, 0
	addi	a1, sp, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	beqz	a0, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %foo
	ld	a0, 24(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8
	vle64.v	v8, (a0)
	addi	a0, sp, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %bar
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 48
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	vse64.v	v8, (a0)
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
