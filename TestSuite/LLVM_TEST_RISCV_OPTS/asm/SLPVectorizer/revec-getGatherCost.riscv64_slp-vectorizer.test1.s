# Source: SLPVectorizer/revec-getGatherCost.riscv64_slp-vectorizer.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -224
	.cfi_def_cfa_offset 224
	sd	ra, 216(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a6, 200(sp)                     # 8-byte Folded Spill
	ld	a6, 24(a2)
	ld	a6, 16(a2)
	ld	a6, 8(a0)
	ld	a6, 0(a0)
	ld	a6, 24(a5)
	sd	a6, 144(sp)                     # 8-byte Folded Spill
	ld	a6, 8(a2)
	sd	a6, 136(sp)                     # 8-byte Folded Spill
	ld	a6, 16(a5)
	sd	a6, 120(sp)                     # 8-byte Folded Spill
	ld	a2, 0(a2)
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	ld	a2, 8(a5)
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	ld	a2, 24(a1)
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	ld	a2, 0(a5)
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	ld	a2, 16(a1)
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	ld	a2, 24(a4)
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	ld	a2, 24(a3)
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	ld	a2, 8(a1)
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	ld	a2, 16(a4)
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	ld	a2, 16(a3)
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	ld	a1, 0(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a4)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a3)
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	ld	a1, 24(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a4)
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a3)
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	ld	a0, 16(a0)
	call	__mulsf3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 168(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a2, 208(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a2, 192(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	t0, 152(sp)                     # 8-byte Folded Reload
	ld	a7, 160(sp)                     # 8-byte Folded Reload
	ld	a5, 168(sp)                     # 8-byte Folded Reload
	ld	a4, 176(sp)                     # 8-byte Folded Reload
	ld	a2, 184(sp)                     # 8-byte Folded Reload
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	ld	a6, 200(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	sw	t0, 12(a6)
	sw	a7, 8(a6)
	sw	a5, 4(a6)
	sw	a4, 0(a6)
	sw	a3, 28(a6)
	sw	a2, 24(a6)
	sw	a1, 20(a6)
	sw	a0, 16(a6)
	ld	ra, 216(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 224
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 4, e32, mf2, ta, ma
	vmv1r.v	v14, v9
                                        # kill: def $v19 killed $v13 killed $vtype
                                        # kill: def $v18 killed $v12 killed $vtype
                                        # kill: def $v17 killed $v11 killed $vtype
                                        # kill: def $v16 killed $v10 killed $vtype
                                        # kill: def $v15 killed $v14 killed $vtype
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 2
	vslideup.vi	v9, v14, 2
                                        # implicit-def: $v8
	vslidedown.vi	v8, v14, 2
	vslideup.vi	v8, v10, 2
	vsetivli	zero, 8, e32, mf2, ta, ma
	vslideup.vi	v9, v8, 4
	vmv1r.v	v8, v11
	vslideup.vi	v8, v11, 4
	vslideup.vi	v12, v13, 4
	vfmadd.vv	v8, v9, v12
	vse32.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
