# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fmuladd_f16_zvfhmin
# src = pre-opt (fmuladd_f16_zvfhmin), tgt = post-opt (fmuladd_f16_zvfhmin)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	j	.LBB22_1
.LBB22_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a2, a2, a1
	lhu	a2, 0(a2)
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	fsw	fa0, 12(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 12(sp)                     # 4-byte Folded Reload
	fmul.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	fsw	fa0, 28(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 28(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB22_1
	j	.LBB22_2
.LBB22_2:                               # %for.end
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end22:
	.size	src, .Lfunc_end22-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -400
	.cfi_def_cfa_offset 400
	sd	ra, 392(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	mv	a4, a3
	slli	a3, a3, 1
	add	a4, a4, a3
	slli	a3, a3, 2
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x03, 0x22, 0x11, 0x0b, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 400 + 11 * vlenb
	sd	a2, 336(sp)                     # 8-byte Folded Spill
	sd	a1, 344(sp)                     # 8-byte Folded Spill
	sd	a0, 352(sp)                     # 8-byte Folded Spill
	li	a3, 0
	mv	a1, a3
	li	a0, 32
	sd	a3, 360(sp)                     # 8-byte Folded Spill
	sd	a1, 368(sp)                     # 8-byte Folded Spill
	bltu	a2, a0, .LBB22_4
	j	.LBB22_1
.LBB22_1:                               # %vector.ph
	ld	a1, 336(sp)                     # 8-byte Folded Reload
	lui	a0, 1048568
                                        # implicit-def: $v8m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vmv.v.x	v8, a0
	vmv1r.v	v12, v8
	li	a0, 0
	vmv.s.x	v12, a0
	vmv2r.v	v10, v8
	vmv1r.v	v10, v12
	andi	a1, a1, -32
	sd	a1, 320(sp)                     # 8-byte Folded Spill
	sd	a0, 328(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 384
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 384
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB22_2
.LBB22_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 320(sp)                     # 8-byte Folded Reload
	ld	a0, 328(sp)                     # 8-byte Folded Reload
	ld	a2, 344(sp)                     # 8-byte Folded Reload
	ld	a4, 352(sp)                     # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a5, a3, 3
	add	a3, a5, a3
	add	a3, sp, a3
	addi	a3, a3, 384
	vl2r.v	v8, (a3)                        # vscale x 16-byte Folded Reload
	csrr	a3, vlenb
	slli	a5, a3, 3
	sub	a3, a5, a3
	add	a3, sp, a3
	addi	a3, a3, 384
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	slli	a3, a0, 1
	add	a5, a4, a3
	addi	a4, a5, 32
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vle16.v	v14, (a5)
                                        # implicit-def: $v16m2
	vle16.v	v16, (a4)
	add	a3, a2, a3
	addi	a2, a3, 32
                                        # implicit-def: $v18m2
	vle16.v	v18, (a3)
                                        # implicit-def: $v12m2
	vle16.v	v12, (a2)
                                        # implicit-def: $v28m4
	vsetvli	zero, zero, e16, m2, ta, ma
	vfwcvt.f.f.v	v28, v18
                                        # implicit-def: $v24m4
	vfwcvt.f.f.v	v24, v14
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfmul.vv	v20, v24, v28
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v14, v20
                                        # implicit-def: $v24m4
	vfwcvt.f.f.v	v24, v14
                                        # implicit-def: $v28m4
	vfwcvt.f.f.v	v28, v10
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v20, v24, v28
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v10, v20
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 384
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
                                        # implicit-def: $v20m4
	vfwcvt.f.f.v	v20, v12
                                        # implicit-def: $v12m4
	vfwcvt.f.f.v	v12, v16
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfmul.vv	v16, v12, v20
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v12, v16
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
	addi	a2, a2, 384
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 32
	mv	a2, a0
	sd	a2, 328(sp)                     # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 384
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 384
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB22_2
	j	.LBB22_3
.LBB22_3:                               # %middle.block
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 384
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 384
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
	addi	a0, sp, 384
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetivli	zero, 1, e16, m2, ta, ma
	vslidedown.vi	v10, v8, 15
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 296(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 14
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 280(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 13
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 264(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 12
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 248(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 11
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 232(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 10
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 216(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 9
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 200(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 8
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	vmv1r.v	v9, v8
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 384
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e16, m1, ta, ma
	vslidedown.vi	v8, v9, 7
	vmv.x.s	a0, v8
	sd	a0, 168(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 6
	vmv.x.s	a0, v8
	sd	a0, 152(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 5
	vmv.x.s	a0, v8
	sd	a0, 136(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 4
	vmv.x.s	a0, v8
	sd	a0, 120(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	sd	a0, 104(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	vmv.x.s	a0, v9
	sd	a0, 72(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	fsw	fa0, 84(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 84(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	fsw	fa0, 100(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 100(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	fsw	fa0, 116(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 116(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	fsw	fa0, 132(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 132(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	fsw	fa0, 148(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 148(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	fsw	fa0, 164(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 164(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	fsw	fa0, 180(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 180(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	fsw	fa0, 196(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 196(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	fsw	fa0, 212(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 212(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 216(sp)                     # 8-byte Folded Reload
	fsw	fa0, 228(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 228(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 232(sp)                     # 8-byte Folded Reload
	fsw	fa0, 244(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 244(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 248(sp)                     # 8-byte Folded Reload
	fsw	fa0, 260(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 260(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 264(sp)                     # 8-byte Folded Reload
	fsw	fa0, 276(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 276(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 280(sp)                     # 8-byte Folded Reload
	fsw	fa0, 292(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 292(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 296(sp)                     # 8-byte Folded Reload
	fsw	fa0, 308(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 308(sp)                    # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 320(sp)                     # 8-byte Folded Reload
	ld	a0, 336(sp)                     # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	mv	a3, a1
	sd	a3, 360(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 368(sp)                     # 8-byte Folded Spill
	sd	a2, 312(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB22_6
	j	.LBB22_4
.LBB22_4:                               # %scalar.ph
	ld	a1, 360(sp)                     # 8-byte Folded Reload
	ld	a0, 368(sp)                     # 8-byte Folded Reload
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB22_5
.LBB22_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 344(sp)                     # 8-byte Folded Reload
	ld	a2, 352(sp)                     # 8-byte Folded Reload
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a2, a2, a1
	lhu	a2, 0(a2)
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	fsw	fa0, 28(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	fmul.s	fa0, fa0, fa5
	call	__truncsfhf2
	call	__extendhfsf2
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	fsw	fa0, 44(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	fmv.s	fa5, fa0
	flw	fa0, 44(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 336(sp)                     # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 312(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB22_5
	j	.LBB22_6
.LBB22_6:                               # %for.end
	ld	a0, 312(sp)                     # 8-byte Folded Reload
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
	.cfi_def_cfa sp, 400
	ld	ra, 392(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 400
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end22:
	.size	tgt, .Lfunc_end22-tgt
	.cfi_endproc
                                        # -- End function
