# Source: SLPVectorizer/gather-node-with-no-users.riscv64-unknown-linux-gnu__v__zvl512b_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v,+zvl512b
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	s0, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset s0, -8
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	lbu	a1, 222(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lbu	a1, 228(a0)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	lbu	a1, 276(a0)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	lbu	a1, 279(a0)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	lbu	a1, 282(a0)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	lbu	a1, 285(a0)
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	lbu	a1, 288(a0)
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	lbu	a1, 0(a0)
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	lbu	a1, 345(a0)
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	lbu	a1, 348(a0)
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	lbu	a1, 351(a0)
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	lbu	a1, 354(a0)
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	lbu	a1, 357(a0)
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	lbu	a1, 360(a0)
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	lbu	a0, 363(a0)
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a2, 120(sp)                     # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	ld	a4, 104(sp)                     # 8-byte Folded Reload
	ld	a5, 96(sp)                      # 8-byte Folded Reload
	ld	a6, 88(sp)                      # 8-byte Folded Reload
	ld	a7, 80(sp)                      # 8-byte Folded Reload
	ld	t0, 72(sp)                      # 8-byte Folded Reload
	ld	t1, 64(sp)                      # 8-byte Folded Reload
	ld	t2, 56(sp)                      # 8-byte Folded Reload
	ld	t3, 48(sp)                      # 8-byte Folded Reload
	ld	t4, 40(sp)                      # 8-byte Folded Reload
	ld	t5, 32(sp)                      # 8-byte Folded Reload
	ld	t6, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	or	a0, a0, s0
	or	a0, a0, t6
	or	a0, a0, t5
	or	a0, a0, t4
	or	a0, a0, t3
	or	a0, a0, t2
	or	a0, a0, t1
	or	a0, a0, t0
	or	a0, a0, a7
	or	a0, a0, a6
	or	a0, a0, a5
	or	a0, a0, a4
	or	a0, a0, a3
	or	a0, a0, a2
	or	a0, a0, a1
	j	.LBB0_1
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	lui	a1, %hi(.LCPI0_0)
	addi	a1, a1, %lo(.LCPI0_0)
                                        # implicit-def: $v9
	vsetivli	zero, 8, e8, mf8, tu, ma
	vle16.v	v9, (a1)
	lui	a1, %hi(.LCPI0_1)
	addi	a1, a1, %lo(.LCPI0_1)
                                        # implicit-def: $v10
	vle16.v	v10, (a1)
                                        # implicit-def: $v8
	vluxei16.v	v8, (a0), v9
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vluxei16.v	v9, (a0), v10
	vsetivli	zero, 16, e8, mf4, ta, ma
	vslideup.vi	v8, v9, 8
	addi	a0, sp, 16
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	addi	a0, sp, 16
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	j	.LBB0_1
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
