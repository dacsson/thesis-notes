# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fmuladd_bf16
# src = pre-opt (fmuladd_bf16), tgt = post-opt (fmuladd_bf16)
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
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa5, zero
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	fsw	fa5, 68(sp)                     # 4-byte Folded Spill
	j	.LBB23_1
.LBB23_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	flw	fa5, 68(sp)                     # 4-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	fsw	fa5, 8(sp)                      # 4-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a0, a0, a2
	lhu	a0, 0(a0)
	add	a1, a1, a2
	lhu	a1, 0(a1)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa5, fa4
	call	__truncsfbf2
	fmv.s	fa5, fa0
	flw	fa0, 8(sp)                      # 4-byte Folded Reload
	fmv.x.w	a0, fa5
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	call	__truncsfbf2
	flw	fa5, 12(sp)                     # 4-byte Folded Reload
	fmv.x.w	a0, fa0
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	fsw	fa5, 68(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB23_1
	j	.LBB23_2
.LBB23_2:                               # %for.end
	flw	fa0, 28(sp)                     # 4-byte Folded Reload
	call	__truncsfbf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end23:
	.size	src, .Lfunc_end23-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -256
	.cfi_def_cfa_offset 256
	sd	ra, 248(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	mv	a4, a3
	slli	a3, a3, 1
	add	a4, a4, a3
	slli	a3, a3, 2
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x02, 0x22, 0x11, 0x0b, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 256 + 11 * vlenb
	sd	a2, 192(sp)                     # 8-byte Folded Spill
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	sd	a0, 208(sp)                     # 8-byte Folded Spill
	fmv.w.x	fa5, zero
	li	a1, 0
	li	a0, 32
	sd	a1, 216(sp)                     # 8-byte Folded Spill
	fsw	fa5, 228(sp)                    # 4-byte Folded Spill
	bltu	a2, a0, .LBB23_4
	j	.LBB23_1
.LBB23_1:                               # %vector.ph
	ld	a1, 192(sp)                     # 8-byte Folded Reload
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
	sd	a1, 176(sp)                     # 8-byte Folded Spill
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 240
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 240
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB23_2
.LBB23_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	ld	a2, 200(sp)                     # 8-byte Folded Reload
	ld	a4, 208(sp)                     # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a5, a3, 3
	add	a3, a5, a3
	add	a3, sp, a3
	addi	a3, a3, 240
	vl2r.v	v8, (a3)                        # vscale x 16-byte Folded Reload
	csrr	a3, vlenb
	slli	a5, a3, 3
	sub	a3, a5, a3
	add	a3, sp, a3
	addi	a3, a3, 240
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
	vfwcvtbf16.f.f.v	v28, v18
                                        # implicit-def: $v24m4
	vfwcvtbf16.f.f.v	v24, v14
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfmul.vv	v20, v24, v28
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v14, v20
                                        # implicit-def: $v24m4
	vfwcvtbf16.f.f.v	v24, v14
                                        # implicit-def: $v28m4
	vfwcvtbf16.f.f.v	v28, v10
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v20, v24, v28
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v10, v20
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 240
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
                                        # implicit-def: $v20m4
	vfwcvtbf16.f.f.v	v20, v12
                                        # implicit-def: $v12m4
	vfwcvtbf16.f.f.v	v12, v16
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfmul.vv	v16, v12, v20
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v12, v16
                                        # implicit-def: $v16m4
	vfwcvtbf16.f.f.v	v16, v12
                                        # implicit-def: $v20m4
	vfwcvtbf16.f.f.v	v20, v8
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v16, v20
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v8, v12
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 240
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 32
	mv	a2, a0
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 240
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 240
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB23_2
	j	.LBB23_3
.LBB23_3:                               # %middle.block
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 240
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 240
	vl2r.v	v8, (a0)                        # vscale x 16-byte Folded Reload
                                        # implicit-def: $v16m4
	vfwcvtbf16.f.f.v	v16, v8
                                        # implicit-def: $v8m4
	vfwcvtbf16.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v8, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v8, v12
	addi	a0, sp, 240
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetivli	zero, 1, e16, m2, ta, ma
	vslidedown.vi	v10, v8, 15
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 160(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 14
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 152(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 13
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 144(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 12
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 136(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 11
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 128(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 10
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 120(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 9
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 112(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 8
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 240
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetivli	zero, 1, e16, m1, ta, ma
	vslidedown.vi	v9, v8, 7
	vmv.x.s	a0, v9
	sd	a0, 96(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 6
	vmv.x.s	a0, v9
	sd	a0, 88(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 5
	vmv.x.s	a0, v9
	sd	a0, 80(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 4
	vmv.x.s	a0, v9
	sd	a0, 72(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 3
	vmv.x.s	a0, v9
	sd	a0, 64(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 2
	vmv.x.s	a0, v9
	sd	a0, 56(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 1
	vmv.x.s	a0, v9
	vmv.x.s	a1, v8
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	slliw	a1, a1, 16
	fmv.w.x	fa5, a1
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	mv	a2, a1
	sd	a2, 216(sp)                     # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 228(sp)                    # 4-byte Folded Spill
	fsw	fa5, 172(sp)                    # 4-byte Folded Spill
	beq	a0, a1, .LBB23_6
	j	.LBB23_4
.LBB23_4:                               # %scalar.ph
	ld	a0, 216(sp)                     # 8-byte Folded Reload
	flw	fa5, 228(sp)                    # 4-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	fsw	fa5, 52(sp)                     # 4-byte Folded Spill
	j	.LBB23_5
.LBB23_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	flw	fa5, 52(sp)                     # 4-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 200(sp)                     # 8-byte Folded Reload
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a0, a0, a2
	lhu	a0, 0(a0)
	add	a1, a1, a2
	lhu	a1, 0(a1)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa5, fa4
	call	__truncsfbf2
	fmv.s	fa5, fa0
	flw	fa0, 24(sp)                     # 4-byte Folded Reload
	fmv.x.w	a0, fa5
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	call	__truncsfbf2
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	fmv.x.w	a0, fa0
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 52(sp)                     # 4-byte Folded Spill
	fsw	fa5, 172(sp)                    # 4-byte Folded Spill
	bne	a0, a1, .LBB23_5
	j	.LBB23_6
.LBB23_6:                               # %for.end
	flw	fa0, 172(sp)                    # 4-byte Folded Reload
	call	__truncsfbf2
	fmv.x.w	a0, fa0
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
	.cfi_def_cfa sp, 256
	ld	ra, 248(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 256
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end23:
	.size	tgt, .Lfunc_end23-tgt
	.cfi_endproc
                                        # -- End function
