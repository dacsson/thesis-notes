# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fadd_fast_half_zvfhmin
# src = pre-opt (fadd_fast_half_zvfhmin), tgt = post-opt (fadd_fast_half_zvfhmin)
# Triple: riscv64, Attrs: +v
#

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
	li	a1, 0
	mv	a0, a1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 20(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %for.end
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -384
	.cfi_def_cfa_offset 384
	sd	ra, 376(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	mv	a3, a2
	slli	a2, a2, 1
	add	a3, a3, a2
	slli	a2, a2, 2
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x03, 0x22, 0x11, 0x0b, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 384 + 11 * vlenb
	sd	a1, 328(sp)                     # 8-byte Folded Spill
	sd	a0, 336(sp)                     # 8-byte Folded Spill
	li	a3, 0
	mv	a2, a3
	li	a0, 32
	sd	a3, 344(sp)                     # 8-byte Folded Spill
	sd	a2, 352(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB10_4
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	ld	a0, 328(sp)                     # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vmv.v.i	v8, 0
	andi	a0, a0, -32
	sd	a0, 312(sp)                     # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 320(sp)                     # 8-byte Folded Spill
	vmv2r.v	v10, v8
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 368
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 368
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 312(sp)                     # 8-byte Folded Reload
	ld	a0, 320(sp)                     # 8-byte Folded Reload
	ld	a2, 336(sp)                     # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 3
	add	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 368
	vl2r.v	v8, (a3)                        # vscale x 16-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 3
	sub	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 368
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	slli	a3, a0, 1
	add	a3, a2, a3
	addi	a2, a3, 32
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vle16.v	v14, (a3)
                                        # implicit-def: $v12m2
	vle16.v	v12, (a2)
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e16, m2, ta, ma
	vfwcvt.f.f.v	v20, v14
                                        # implicit-def: $v24m4
	vfwcvt.f.f.v	v24, v10
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v16, v20, v24
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v10, v16
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 368
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
                                        # implicit-def: $v16m4
	vfwcvt.f.f.v	v16, v12
                                        # implicit-def: $v20m4
	vfwcvt.f.f.v	v20, v8
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v16, v20
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v8, v12
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 368
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 32
	mv	a2, a0
	sd	a2, 320(sp)                     # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 368
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 368
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 368
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 368
	vl2r.v	v8, (a0)                        # vscale x 16-byte Folded Reload
                                        # implicit-def: $v16m4
	vfwcvt.f.f.v	v16, v8
                                        # implicit-def: $v8m4
	vfwcvt.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v8, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v8, v12
	addi	a0, sp, 368
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetivli	zero, 1, e16, m2, ta, ma
	vslidedown.vi	v10, v8, 15
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 288(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 14
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 272(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 13
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 256(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 12
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 240(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 11
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 224(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 10
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 208(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 9
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 192(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 8
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 176(sp)                     # 8-byte Folded Spill
	vmv1r.v	v9, v8
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 368
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e16, m1, ta, ma
	vslidedown.vi	v8, v9, 7
	vmv.x.s	a0, v8
	sd	a0, 160(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 6
	vmv.x.s	a0, v8
	sd	a0, 144(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 5
	vmv.x.s	a0, v8
	sd	a0, 128(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 4
	vmv.x.s	a0, v8
	sd	a0, 112(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	sd	a0, 96(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	vmv.x.s	a0, v9
	sd	a0, 64(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	fsw	fa0, 76(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 76(sp)                     # 4-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	fadd.s	fa5, fa0, fa5
	fsw	fa5, 92(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 92(sp)                     # 4-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 108(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 108(sp)                    # 4-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 124(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 124(sp)                    # 4-byte Folded Reload
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 140(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 140(sp)                    # 4-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 156(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 156(sp)                    # 4-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 172(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 172(sp)                    # 4-byte Folded Reload
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 188(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 188(sp)                    # 4-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 204(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 204(sp)                    # 4-byte Folded Reload
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 220(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 220(sp)                    # 4-byte Folded Reload
	ld	a0, 224(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 236(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 236(sp)                    # 4-byte Folded Reload
	ld	a0, 240(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 252(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 252(sp)                    # 4-byte Folded Reload
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 268(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 268(sp)                    # 4-byte Folded Reload
	ld	a0, 272(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 284(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 284(sp)                    # 4-byte Folded Reload
	ld	a0, 288(sp)                     # 8-byte Folded Reload
	fadd.s	fa5, fa5, fa0
	fsw	fa5, 300(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 300(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa5, fa0
	call	__truncsfhf2
	ld	a1, 312(sp)                     # 8-byte Folded Reload
	ld	a0, 328(sp)                     # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	mv	a3, a1
	sd	a3, 344(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 352(sp)                     # 8-byte Folded Spill
	sd	a2, 304(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB10_6
	j	.LBB10_4
.LBB10_4:                               # %scalar.ph
	ld	a1, 344(sp)                     # 8-byte Folded Reload
	ld	a0, 352(sp)                     # 8-byte Folded Reload
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB10_5
.LBB10_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 336(sp)                     # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 36(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 328(sp)                     # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 304(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB10_5
	j	.LBB10_6
.LBB10_6:                               # %for.end
	ld	a0, 304(sp)                     # 8-byte Folded Reload
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 2
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 384
	ld	ra, 376(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 384
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
