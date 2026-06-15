# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f5
# src = pre-opt (f5), tgt = post-opt (f5)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %foo
                                        # =>This Inner Loop Header: Depth=1
	call	g
	call	g
	call	g
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a1)
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB6_4
	j	.LBB6_2
.LBB6_2:                                # %bar
                                        #   in Loop: Header=BB6_1 Depth=1
	j	.LBB6_3
.LBB6_3:                                # %baz
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addi	a1, a1, 1
	addi	a0, a0, 1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB6_5
.LBB6_4:                                # %foobar
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addi	a1, a1, 2
	addi	a0, a0, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB6_5
.LBB6_5:                                # %barfoo
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	j	.LBB6_1
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
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
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 2 * vlenb
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %foo
                                        # =>This Inner Loop Header: Depth=1
	call	g
	call	g
	call	g
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vle64.v	v8, (a1)
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB6_4
	j	.LBB6_2
.LBB6_2:                                # %bar
                                        #   in Loop: Header=BB6_1 Depth=1
	j	.LBB6_3
.LBB6_3:                                # %baz
                                        #   in Loop: Header=BB6_1 Depth=1
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vadd.vi	v8, v9, 1
	addi	a0, sp, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB6_5
.LBB6_4:                                # %foobar
                                        #   in Loop: Header=BB6_1 Depth=1
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vadd.vi	v8, v9, 2
	addi	a0, sp, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB6_5
.LBB6_5:                                # %barfoo
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 48
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	vse64.v	v8, (a0)
	j	.LBB6_1
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
