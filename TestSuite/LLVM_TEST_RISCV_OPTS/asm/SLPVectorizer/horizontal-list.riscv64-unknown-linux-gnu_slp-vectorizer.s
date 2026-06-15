# Source: SLPVectorizer/horizontal-list.riscv64-unknown-linux-gnu_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	lw	a1, 4(a0)
	lw	a0, 8(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 12(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 16(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 20(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 24(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 28(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 32(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 36(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 40(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 44(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 48(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 52(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 56(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 60(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 64(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 68(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 72(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 76(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 80(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 84(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 88(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 92(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 96(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 100(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 104(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 108(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 112(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 116(a0)
	call	__addsf3
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a0, 120(a0)
	call	__addsf3
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	a1, a0, 4
                                        # implicit-def: $v12m4
	vsetivli	zero, 16, e32, m4, tu, ma
	vle32.v	v12, (a1)
	vmv2r.v	v16, v12
	addi	a1, a0, 68
                                        # implicit-def: $v18m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v18, (a1)
	addi	a1, a0, 100
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a1)
	flw	fa5, 116(a0)
	flw	fa4, 120(a0)
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, ta, ma
	vfadd.vv	v10, v16, v18
	vmv1r.v	v8, v10
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v10
	vsetivli	zero, 8, e32, m4, tu, ma
	vmv.v.v	v12, v16
                                        # implicit-def: $v16
	vsetivli	zero, 4, e32, m1, ta, ma
	vfadd.vv	v16, v8, v9
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v16
	vsetivli	zero, 4, e32, m4, tu, ma
	vmv.v.v	v12, v8
                                        # implicit-def: $v9
	vfmv.s.f	v9, fa5
                                        # implicit-def: $v8
	vsetivli	zero, 16, e32, m4, ta, ma
	vfredusum.vs	v8, v12, v9
	vfmv.f.s	fa5, v8
	fadd.s	fa0, fa5, fa4
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
