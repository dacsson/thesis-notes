# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f1
# src = pre-opt (f1), tgt = post-opt (f1)
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %foo
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	addi	a1, a1, 1
	addi	a0, a0, 1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_2:                                # %bar
	call	g
	call	g
	call	g
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %baz
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 2 * vlenb
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vle64.v	v8, (a1)
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 32
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %foo
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vadd.vi	v8, v9, 1
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB1_3
.LBB1_2:                                # %bar
	call	g
	call	g
	call	g
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %baz
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	vsetivli	zero, 2, e64, m1, ta, ma
	vse64.v	v8, (a0)
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
