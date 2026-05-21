# Source: SLPVectorizer/revec-getGatherCost.riscv64_slp-vectorizer.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -448
	.cfi_def_cfa_offset 448
	sd	ra, 440(sp)                     # 8-byte Folded Spill
	sd	s0, 432(sp)                     # 8-byte Folded Spill
	sd	s1, 424(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	sd	a6, 408(sp)                     # 8-byte Folded Spill
	ld	a6, 56(a2)
	ld	a6, 48(a2)
	ld	a6, 40(a2)
	ld	a6, 32(a2)
	ld	a6, 24(a0)
	ld	a6, 16(a0)
	ld	a6, 8(a0)
	ld	a6, 0(a0)
	ld	a6, 56(a5)
	sd	a6, 304(sp)                     # 8-byte Folded Spill
	ld	a6, 24(a2)
	sd	a6, 296(sp)                     # 8-byte Folded Spill
	ld	a6, 48(a5)
	sd	a6, 280(sp)                     # 8-byte Folded Spill
	ld	a6, 16(a2)
	sd	a6, 272(sp)                     # 8-byte Folded Spill
	ld	a6, 40(a5)
	sd	a6, 256(sp)                     # 8-byte Folded Spill
	ld	a6, 8(a2)
	sd	a6, 248(sp)                     # 8-byte Folded Spill
	ld	a6, 32(a5)
	sd	a6, 232(sp)                     # 8-byte Folded Spill
	ld	a2, 0(a2)
	sd	a2, 224(sp)                     # 8-byte Folded Spill
	ld	a2, 24(a5)
	sd	a2, 208(sp)                     # 8-byte Folded Spill
	ld	a2, 56(a1)
	sd	a2, 200(sp)                     # 8-byte Folded Spill
	ld	a2, 16(a5)
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	ld	a2, 48(a1)
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	ld	a2, 8(a5)
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	ld	a2, 40(a1)
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	ld	a2, 0(a5)
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	ld	a2, 32(a1)
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	ld	a2, 56(a4)
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	ld	a2, 56(a3)
	sd	a2, 288(sp)                     # 8-byte Folded Spill
	ld	a2, 24(a1)
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	ld	a2, 48(a4)
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	ld	a2, 48(a3)
	sd	a2, 264(sp)                     # 8-byte Folded Spill
	ld	a2, 16(a1)
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	ld	a2, 40(a4)
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	ld	a2, 40(a3)
	sd	a2, 240(sp)                     # 8-byte Folded Spill
	ld	a2, 8(a1)
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	ld	a2, 32(a4)
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	ld	a2, 32(a3)
	sd	a2, 216(sp)                     # 8-byte Folded Spill
	ld	a1, 0(a1)
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	ld	a1, 24(a4)
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	ld	a1, 24(a3)
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	ld	a1, 56(a0)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	ld	a1, 16(a4)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	ld	a1, 16(a3)
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	ld	a1, 48(a0)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a4)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a3)
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	ld	a1, 40(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a4)
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a3)
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	ld	a0, 32(a0)
	call	__mulsf3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 352(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 344(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 336(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 216(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 328(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 320(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 264(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a2, 312(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 288(sp)                     # 8-byte Folded Reload
	mv	s0, a0
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	call	__mulsf3
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	mv	s1, a0
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	call	__mulsf3
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	sd	a2, 416(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	sd	a2, 400(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 184(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	sd	a2, 392(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 208(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 216(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 224(sp)                     # 8-byte Folded Reload
	sd	a2, 384(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 232(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 248(sp)                     # 8-byte Folded Reload
	sd	a2, 376(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 256(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 264(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 272(sp)                     # 8-byte Folded Reload
	sd	a2, 368(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 280(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	a1, 288(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 296(sp)                     # 8-byte Folded Reload
	sd	a2, 360(sp)                     # 8-byte Folded Spill
	call	__mulsf3
	ld	a1, 304(sp)                     # 8-byte Folded Reload
	call	__addsf3
	ld	t6, 312(sp)                     # 8-byte Folded Reload
	ld	t5, 320(sp)                     # 8-byte Folded Reload
	ld	t4, 328(sp)                     # 8-byte Folded Reload
	ld	t3, 336(sp)                     # 8-byte Folded Reload
	ld	t2, 344(sp)                     # 8-byte Folded Reload
	ld	t1, 352(sp)                     # 8-byte Folded Reload
	ld	a7, 360(sp)                     # 8-byte Folded Reload
	ld	a5, 368(sp)                     # 8-byte Folded Reload
	ld	a4, 376(sp)                     # 8-byte Folded Reload
	ld	a3, 384(sp)                     # 8-byte Folded Reload
	ld	a2, 392(sp)                     # 8-byte Folded Reload
	ld	a1, 400(sp)                     # 8-byte Folded Reload
	ld	a6, 408(sp)                     # 8-byte Folded Reload
	mv	t0, a0
	ld	a0, 416(sp)                     # 8-byte Folded Reload
	sw	s1, 28(a6)
	sw	s0, 24(a6)
	sw	t6, 20(a6)
	sw	t5, 16(a6)
	sw	t4, 12(a6)
	sw	t3, 8(a6)
	sw	t2, 4(a6)
	sw	t1, 0(a6)
	sw	t0, 60(a6)
	sw	a7, 56(a6)
	sw	a5, 52(a6)
	sw	a4, 48(a6)
	sw	a3, 44(a6)
	sw	a2, 40(a6)
	sw	a1, 36(a6)
	sw	a0, 32(a6)
	ld	ra, 440(sp)                     # 8-byte Folded Reload
	ld	s0, 432(sp)                     # 8-byte Folded Reload
	ld	s1, 424(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 448
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 8, e32, mf2, ta, ma
	vmv1r.v	v14, v9
                                        # kill: def $v19 killed $v13 killed $vtype
                                        # kill: def $v18 killed $v12 killed $vtype
                                        # kill: def $v17 killed $v11 killed $vtype
                                        # kill: def $v16 killed $v10 killed $vtype
                                        # kill: def $v15 killed $v14 killed $vtype
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 4
	vslideup.vi	v9, v14, 4
                                        # implicit-def: $v8
	vslidedown.vi	v8, v14, 4
	vslideup.vi	v8, v10, 4
	vsetivli	zero, 16, e32, m1, ta, ma
	vslideup.vi	v9, v8, 8
	vmv1r.v	v8, v11
	vslideup.vi	v8, v11, 8
	vslideup.vi	v12, v13, 8
	vfmadd.vv	v8, v9, v12
	vse32.v	v8, (a0)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
