# Source: SLPVectorizer/reversed-strided-node-with-external-ptr.riscv64__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %bb
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	fld	fa3, 0(a1)
	slli	a0, a0, 3
	add	a0, a1, a0
	fld	fa5, 8(a0)
	fld	fa2, 8(a1)
	fsub.d	fa4, fa3, fa3
	fsub.d	fa2, fa2, fa2
	fsub.d	fa3, fa3, fa2
	fsd	fa3, 0(a0)
	fsub.d	fa5, fa5, fa4
	fsd	fa5, 8(a0)
	j	.LBB0_1
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a2, vlenb
	slli	a2, a2, 1
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vmv.v.x	v9, a1
	li	a0, 0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %bb
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	addi	a0, sp, 32
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vsetvli	zero, zero, e64, m1, ta, ma
	vsll.vi	v10, v9, 3
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
                                        # implicit-def: $v10
	vid.v	v10
                                        # implicit-def: $v8
	vsll.vi	v8, v10, 3
                                        # implicit-def: $v10
	vrsub.vi	v10, v8, 8
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v10
	vmv.x.s	a0, v8
	li	a2, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e64, m1, tu, ma
	vluxei64.v	v9, (a2), v8
                                        # implicit-def: $v8
	vle64.v	v8, (a1)
                                        # implicit-def: $v10
	vsetvli	zero, zero, e64, m1, ta, ma
	vfsub.vv	v10, v8, v8
                                        # implicit-def: $v8
	vfsub.vv	v8, v9, v10
	li	a1, -8
	vsse64.v	v8, (a0), a1
	j	.LBB0_1
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
