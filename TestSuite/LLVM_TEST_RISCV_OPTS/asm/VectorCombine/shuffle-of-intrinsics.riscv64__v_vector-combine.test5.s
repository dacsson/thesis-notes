# Source: VectorCombine/shuffle-of-intrinsics.riscv64__v_vector-combine.ll
# Function: test5
# src = pre-opt (test5), tgt = post-opt (test5)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 3 * vlenb
	vsetivli	zero, 1, e32, m1, ta, ma
	vmv1r.v	v11, v10
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v11, (a1)                       # vscale x 8-byte Folded Spill
	vmv1r.v	v10, v9
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	vmv1r.v	v9, v8
	addi	a1, sp, 64
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
                                        # kill: def $v8 killed $v9 killed $vtype
	sext.w	a0, a0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	__powisf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 40(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	__powisf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	__powisf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 32(sp)                     # 4-byte Folded Spill
	vsetivli	zero, 1, e32, m1, ta, ma
	vfmv.f.s	fa0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 28(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v10, 3
	vmv.x.s	a0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 52(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v10, 2
	vmv.x.s	a0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 48(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v10, 1
	vmv.x.s	a0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 44(sp)                     # 4-byte Folded Spill
	vsetivli	zero, 1, e32, m1, ta, ma
	vfmv.f.s	fa0, v9
	vmv.x.s	a0, v10
	call	__powisf2
	flw	ft1, 28(sp)                     # 4-byte Folded Reload
	flw	ft0, 32(sp)                     # 4-byte Folded Reload
	flw	fa1, 36(sp)                     # 4-byte Folded Reload
	flw	fa2, 40(sp)                     # 4-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	flw	fa5, 48(sp)                     # 4-byte Folded Reload
	fmv.s	fa3, fa0
	flw	fa0, 52(sp)                     # 4-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vfmv.v.f	v10, ft1
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, ft0
                                        # implicit-def: $v10m2
	vfslide1down.vf	v10, v8, fa1
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, fa2
                                        # implicit-def: $v10m2
	vfslide1down.vf	v10, v8, fa3
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, fa4
                                        # implicit-def: $v10m2
	vfslide1down.vf	v10, v8, fa5
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, fa0
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 3 * vlenb
	vsetivli	zero, 1, e32, m1, ta, ma
	vmv1r.v	v11, v10
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v11, (a1)                       # vscale x 8-byte Folded Spill
	vmv1r.v	v10, v9
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	vmv1r.v	v9, v8
	addi	a1, sp, 64
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
                                        # kill: def $v8 killed $v9 killed $vtype
	sext.w	a0, a0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	__powisf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 40(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	__powisf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	__powisf2
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 32(sp)                     # 4-byte Folded Spill
	vsetivli	zero, 1, e32, m1, ta, ma
	vfmv.f.s	fa0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 28(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v10, 3
	vmv.x.s	a0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 52(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v10, 2
	vmv.x.s	a0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 48(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
                                        # implicit-def: $v8
	vslidedown.vi	v8, v10, 1
	vmv.x.s	a0, v8
	call	__powisf2
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 64
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	fsw	fa0, 44(sp)                     # 4-byte Folded Spill
	vsetivli	zero, 1, e32, m1, ta, ma
	vfmv.f.s	fa0, v9
	vmv.x.s	a0, v10
	call	__powisf2
	flw	ft1, 28(sp)                     # 4-byte Folded Reload
	flw	ft0, 32(sp)                     # 4-byte Folded Reload
	flw	fa1, 36(sp)                     # 4-byte Folded Reload
	flw	fa2, 40(sp)                     # 4-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	flw	fa5, 48(sp)                     # 4-byte Folded Reload
	fmv.s	fa3, fa0
	flw	fa0, 52(sp)                     # 4-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vfmv.v.f	v10, ft1
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, ft0
                                        # implicit-def: $v10m2
	vfslide1down.vf	v10, v8, fa1
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, fa2
                                        # implicit-def: $v10m2
	vfslide1down.vf	v10, v8, fa3
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, fa4
                                        # implicit-def: $v10m2
	vfslide1down.vf	v10, v8, fa5
                                        # implicit-def: $v8m2
	vfslide1down.vf	v8, v10, fa0
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
