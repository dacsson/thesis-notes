# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f4
# src = pre-opt (f4), tgt = post-opt (f4)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %foo
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_2 Depth 2
	call	g
	call	g
	call	g
	j	.LBB5_2
.LBB5_2:                                # %bar
                                        #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a1)
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB5_4
	j	.LBB5_3
.LBB5_3:                                # %baz
                                        #   in Loop: Header=BB5_2 Depth=2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addi	a1, a1, 1
	addi	a0, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB5_4
.LBB5_4:                                # %qux
                                        #   in Loop: Header=BB5_2 Depth=2
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 0(a2)
	sd	a1, 8(a2)
	andi	a0, a0, 1
	bnez	a0, .LBB5_1
	j	.LBB5_2
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a4, vlenb
	slli	a4, a4, 1
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 2 * vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %foo
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_2 Depth 2
	call	g
	call	g
	call	g
	j	.LBB5_2
.LBB5_2:                                # %bar
                                        #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vle64.v	v8, (a1)
	addi	a1, sp, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	andi	a0, a0, 1
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	beqz	a0, .LBB5_4
	j	.LBB5_3
.LBB5_3:                                # %baz
                                        #   in Loop: Header=BB5_2 Depth=2
	addi	a0, sp, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vadd.vi	v8, v9, 1
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB5_4
.LBB5_4:                                # %qux
                                        #   in Loop: Header=BB5_2 Depth=2
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vl1r.v	v8, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	zero, zero, e64, m1, ta, ma
	vse64.v	v8, (a1)
	andi	a0, a0, 1
	bnez	a0, .LBB5_1
	j	.LBB5_2
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
