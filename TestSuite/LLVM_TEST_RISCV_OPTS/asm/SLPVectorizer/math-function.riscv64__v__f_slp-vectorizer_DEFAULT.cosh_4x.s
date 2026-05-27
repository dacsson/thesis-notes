# Source: SLPVectorizer/math-function.riscv64__v__f_slp-vectorizer_DEFAULT.ll
# Function: cosh_4x
# src = pre-opt (cosh_4x), tgt = post-opt (cosh_4x)
# Triple: riscv64, Attrs: +v,+f
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a0)
	addi	a0, sp, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	vfmv.f.s	fa0, v8
	call	coshf
	addi	a0, sp, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 28(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	coshf
	addi	a0, sp, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 32(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	coshf
	addi	a0, sp, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	coshf
	flw	fa3, 28(sp)                     # 4-byte Folded Reload
	flw	fa4, 32(sp)                     # 4-byte Folded Reload
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v9, fa3
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa4
                                        # implicit-def: $v9
	vfslide1down.vf	v9, v8, fa5
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa0
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end24:
	.size	src, .Lfunc_end24-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a0)
	addi	a0, sp, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	vfmv.f.s	fa0, v8
	call	coshf
	addi	a0, sp, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 28(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	coshf
	addi	a0, sp, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 32(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	coshf
	addi	a0, sp, 48
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	coshf
	flw	fa3, 28(sp)                     # 4-byte Folded Reload
	flw	fa4, 32(sp)                     # 4-byte Folded Reload
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v9, fa3
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa4
                                        # implicit-def: $v9
	vfslide1down.vf	v9, v8, fa5
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa0
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end24:
	.size	tgt, .Lfunc_end24-tgt
	.cfi_endproc
                                        # -- End function
